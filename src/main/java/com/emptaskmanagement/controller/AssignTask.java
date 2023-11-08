package com.emptaskmanagement.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import com.emptaskmanagement.entity.Task;
import com.emptaskmanagement.entity.User;
import com.emptaskmanagement.service.UserService;

@WebServlet("/assign-task")
public class AssignTask extends HttpServlet {

	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private UserService userService = new UserService(em, et);
	private TaskDao taskDao = new TaskDao(em, et);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String assignId = req.getParameter("assignId");
		String desc = req.getParameter("desc");

		if (assignId != null && desc != null) {
			int id = Integer.parseInt(assignId);
			User user = userService.getUserById(id);

			if (user == null) {
				resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Employee does not exist!</p>");
				req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
				return;
			}

			List<Task> tasks = user.getTasks();

			for(int i=0; i<tasks.size(); i++) {
				if(tasks.get(i).getDesc().equalsIgnoreCase(desc)) {
					resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:orange; display:block'>Similar task already given!</p>");
					req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
					return;
				}
			}

			Task task = new Task();

			task.setDesc(desc);

			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
			String formatDateTime = now.format(format);

			task.setCreatedDateTime(formatDateTime);
			task.setStatus("Assigned");
			task.setUser(user);
			tasks.add(task);

			user.setTasks(tasks);

			userService.updateUser(user);

			if(req.getSession().getAttribute("emp_list") instanceof List) {

				List<User> emplist = (List<User>) req.getSession().getAttribute("emp_list");
				
				for(int i=0; i<emplist.size(); i++)
					if(emplist.get(i).getId() == user.getId()) {
						emplist.remove(i);
						break;
					}

				emplist.add(user);
				req.getSession().setAttribute("emp_list", emplist);
				
			}

			resp.getWriter().print("<p id='msg'  onclick='closeMsg()' style='background-color:rgb(144, 238, 144); display:block'>Task assign to "+user.getName().split(" ")[0]+"!</p>");
			req.getRequestDispatcher("ManagerHome.jsp").include(req, resp);
			return;
		}

	}
}
