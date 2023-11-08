package com.emptaskmanagement.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import com.emptaskmanagement.dao.TaskDao;
import com.emptaskmanagement.dao.UserDao;
import com.emptaskmanagement.entity.Task;
import com.emptaskmanagement.entity.User;

public class UserService {

	private EntityManager em;
	private EntityTransaction et;
	private UserDao userDao;
	private TaskDao taskDao;
	public boolean checkUserAvailibility(String email) {
		if(userDao.findUserByEmail(email) == null)
			return true;
		return false;
	}

	public UserService(EntityManager em, EntityTransaction et) {
		this.em = em;
		this.et = et;
		this.userDao = new UserDao(em, et);
		this.taskDao = new TaskDao(em, et);
	}

	public User saveUser(User user) {
		if (user != null)
			return userDao.saveUser(user);
		return user;
	}
	
	public User updateUser(User user) {
		if (user != null)
			return userDao.updateUser(user);
		return user;
	}
	public User deleteUser(User user) {
		if (user != null)
			return userDao.deleteUser(user);
		return user;
	}

	public boolean assignTask(int userId, Task task) {

		User user = userDao.findUserById(userId);

		if (user == null || task == null)
			return false;

		Task existingTask = taskDao.findTaskById(task.getId());

		if (existingTask != null)
			return false;

		List<Task> tasks = user.getTasks();
		tasks.add(task);

		user.setTasks(tasks);

		userDao.updateUser(user);

		return true;
	}

	public boolean isManagerPresent() {
		if(userDao.findManager() == null) 			
			return false;
		return true;
	}

	public User getUserByEmail(String email) {
		return userDao.findUserByEmail(email);
	}

	public List<User> getAllEmployees() {
		
		return userDao.getAllEmployees();
	}

	public List<Task> getAllTaskByEmpId(int id) {
		return userDao.getAllTaskByEmpId(id);
	}

	public User getUserById(int id) {
		return userDao.findUserById(id);
	}
}