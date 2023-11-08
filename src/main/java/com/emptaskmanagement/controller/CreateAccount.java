package com.emptaskmanagement.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emptaskmanagement.dao.TaskDao;
import com.emptaskmanagement.entity.Task;
import com.emptaskmanagement.entity.User;
import com.emptaskmanagement.service.UserService;

@WebServlet("/create-account")
public class CreateAccount extends HttpServlet {

	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private UserService userService = new UserService(em, et);
	private TaskDao taskDao = new TaskDao(em, et);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		String name = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");

		if (session.getAttribute("current_user") != null)
			role="employee";

		if (name == null || email == null || password == null)
			return;

		if (role.equals("manager") && userService.isManagerPresent()) {
			resp.getWriter().print(
					"<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Manager already exist!</p>");
			req.getRequestDispatcher("CreateAccount.html").include(req, resp);
			return;
		}

		if (!userService.checkUserAvailibility(email)) {
			resp.getWriter().print(
					"<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Email already exist!</p>");

			if (session.getAttribute("current_user") == null)
				req.getRequestDispatcher("CreateAccount.html").include(req, resp);
			else
				req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		}

		User user = new User();
		user.setEmail(email);
		user.setName(name);
		user.setPassword(password);
		user.setRole(role);
		List<Task> tasks = new ArrayList<>();
		user.setTasks(tasks);
		user = userService.saveUser(user);

		resp.getWriter().print("<p id='msg' onclick='closeMsg()' style='background-color:rgb(144, 238, 144); display:block'>Account has been created successfully!</p>");

		if (session.getAttribute("current_user") == null)
			req.getRequestDispatcher("LoginAccount.html").include(req, resp);
		else {
			List<User> emplist = (List<User>)session.getAttribute("emp_list"); 
			emplist.add(user);
			session.setAttribute("emp_list", emplist);
			
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);	
		}
		return;
	}
}
