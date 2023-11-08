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
import javax.servlet.http.HttpSession;

import com.emptaskmanagement.dao.TaskDao;
import com.emptaskmanagement.entity.Task;
import com.emptaskmanagement.entity.User;

@WebServlet("/update-task")
public class UpdateTask extends HttpServlet{
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("emp_task_manager");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	private TaskDao taskDao = new TaskDao(em, et);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String taskId = req.getParameter("taskid");
		if(taskId != null) {
			Task task = taskDao.findTaskById(Integer.parseInt(taskId));
			task.setStatus("Completed");

			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
			String formatDateTime = now.format(format);
			
			task.setCompletedDateTime(formatDateTime);
			
			taskDao.updateTask(task);
			
			HttpSession session = req.getSession();
			User employee = (User) session.getAttribute("current_user");
			List<Task> tasks = employee.getTasks();
			
			for(int i=0;i<tasks.size();i++)
				if(tasks.get(i).getId() == task.getId()) {
					tasks.remove(i);
					break;
			}
			
			tasks.add(task);
			
			employee.setTasks(tasks);
			
			session.setAttribute("current_user", employee);

			req.getRequestDispatcher("EmployeeHome.jsp").include(req, resp);
			return;
		}
			
	}
}
