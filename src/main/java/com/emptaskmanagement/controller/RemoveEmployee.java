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

import com.emptaskmanagement.dao.TaskDao;
import com.emptaskmanagement.entity.User;
import com.emptaskmanagement.service.UserService;

@WebServlet("/remove-emp")
public class RemoveEmployee extends HttpServlet{
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private UserService userService = new UserService(em, et);
	private TaskDao taskDao = new TaskDao(em, et);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String removeId = req.getParameter("removeId");

		if(removeId == null) {
			System.out.println("id == null");
			resp.getWriter().print("<p id='msg' onclick='closeMsg()' style='background-color:orange; display:block>Incorrect Employee ID!</p>");
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		}

		User user = userService.getUserById(Integer.parseInt(removeId));

		if(user == null) {
			System.out.println("user == null");
			resp.getWriter().print("<p id='msg' onclick='closeMsg()' style='background-color:orange; display:block'>Incorrect Employee ID!</p>");
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		}
		
		userService.deleteUser(user);
		
		if(req.getSession().getAttribute("emp_list") instanceof List) {
			List<User> emplist = (List<User>) req.getSession().getAttribute("emp_list");
			emplist.remove(user);
			req.getSession().setAttribute("emp_list", emplist);
		}
		
		resp.getWriter().print("<p id='msg' onclick='closeMsg()' style='background-color:yellow;color:black; display:block'>Employee Removed!</p>");
		req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			
	}
}
