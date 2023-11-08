package com.emptaskmanagement.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import com.emptaskmanagement.entity.Task;

public class TaskDao {
	private EntityManager em;
	private EntityTransaction et;

	public TaskDao(EntityManager em, EntityTransaction et) {
		this.em = em;
		this.et = et;
	}

	public Task saveTask(Task task) {
		if (task != null) {
			et.begin();
			em.persist(task);
			et.commit();
		}
		return task;
	}

	public Task updateTask(Task task) {
		if (task != null) {
			et.begin();
			em.merge(task);
			et.commit();
		}
		return task;
	}

	public Task deleteTask(Task task) {
		if (task != null) {
			et.begin();
			em.remove(task);
			et.commit();
		}
		return task;
	}

	public Task deleteTaskById(int taskId) {

		Task task = em.find(Task.class, taskId);

		if (task != null) {
			et.begin();
			em.remove(task);
			et.commit();
		}
		return task;
	}

	public Task findTaskById(int id) {
		return em.find(Task.class, id);
	}
}
