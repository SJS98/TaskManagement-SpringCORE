package com.emptaskmanagement.controller;

import java.io.IOException;
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

@WebServlet("/login-account")
public class LoginAccount extends HttpServlet{
	
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private UserService userService = new UserService(em, et);
	private TaskDao taskDao = new TaskDao(em, et);

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String email= req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");
		
		if(email == null || password == null || role == null)
			return;
		
		if(userService.checkUserAvailibility(email)) {
			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Account does not exist!</p>");
			req.getRequestDispatcher("CreateAccount.html").include(req, resp);
			return;
		}

		User user = userService.getUserByEmail(email);
		
		if(user.getPassword() != null && ! user.getPassword().equals(password)) {
			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Incorrect Password!</p>");
			req.getRequestDispatcher("LoginAccount.html").include(req, resp);
			return;
		}
		
		if(!role.equals(user.getRole())) {
			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Incorrect role selected!</p>");
			req.getRequestDispatcher("LoginAccount.html").include(req, resp);
			return;
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("current_user", user);
		
		if(user.getRole().equals("manager")) {
			List<User> emplist = userService.getAllEmployees();
			session.setAttribute("emp_list", emplist);
			
			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:rgb(144, 238, 144); display:block'>Welcome Back, "+user.getName().split(" ")[0]+"<p>");
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		} else {
			List<Task> tasklist = userService.getAllTaskByEmpId(user.getId());
			session.setAttribute("task_list", tasklist);

			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:rgb(144, 238, 144); display:block'>Welcome Back, "+user.getName().split(" ")[0]+"<p>");
			req.getRequestDispatcher("EmployeeHome.jsp").include(req, resp);
			return;
		}
	}
}
