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

import com.emptaskmanagement.entity.User;
import com.emptaskmanagement.service.UserService;

@WebServlet("/update-emp")
public class UpdateEmployee extends HttpServlet{	

	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private UserService userService = new UserService(em, et);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		if (name == null || email == null || password == null)
			return;

		if (userService.checkUserAvailibility(email)) {
			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Incorrect employee email!</p>");
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		}

		User employee =userService.getUserByEmail(email);
		
		employee.setName(name);
		employee.setPassword(password);
		
		userService.updateUser(employee);
		
		HttpSession session = req.getSession();

		List<User> emplist = (List<User>) session.getAttribute("emp_list"); 
		
		for(int i=0;i<emplist.size();i++)
			if(emplist.get(i).getId() == employee.getId()) {
				emplist.remove(i);
				break;
			}
		
		emplist.add(employee);
		
		session.setAttribute("emp_list", emplist);
		
		resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:rgb(144, 238, 144); display:block'>Details updated successfully!</p>");
		req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
				
	}
}
