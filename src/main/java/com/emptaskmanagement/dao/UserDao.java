package com.emptaskmanagement.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Query;

import com.emptaskmanagement.entity.Task;
import com.emptaskmanagement.entity.User;

public class UserDao {
	private EntityManager em;
	private EntityTransaction et;

	public UserDao(EntityManager em, EntityTransaction et) {
		this.em = em;
		this.et = et;
	}

	public User saveUser(User user) {
		et.begin();
		em.persist(user);
		et.commit();
		return user;
	}

	public User updateUser(User user) {
		et.begin();
		em.merge(user);
		et.commit();
		return user;
	}

	public User deleteUser(User user) {
		et.begin();
		em.remove(user);
		et.commit();
		return user;
	}

	public User deleteUserById(int id) {

		User user = em.find(User.class, id);

		if (user != null) {
			et.begin();
			em.remove(user);
			et.commit();
		}
		return user;
	}

	public User findUserById(int id) {
		return em.find(User.class, id);
	}

	public User findUserByEmail(String email) {
		Query query = em.createQuery("select u from User u where u.email=:email");
		query.setParameter("email", email);

		User user = null;

		try {
			user = (User) query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
		return user;
	}

	public User findUserByEmailAndRole(String email, String role) {
		Query query = em.createQuery("select u from User u where u.email=:email and u.role=:role");
		query.setParameter("email", email);
		query.setParameter("role", role);
		User user = null;
		try {
			user = (User) query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
		return user;
	}

	public User findManager() {
		Query query = em.createQuery("select u from User u where u.role=:manager");
		query.setParameter("manager", "manager");
		User user = null;
		try {
			user = (User) query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
		return user;
	}

	@SuppressWarnings("unchecked")
	public List<User> getAllEmployees() {
		Query query = em.createQuery("select u from User u where u.role=:emp");
		query.setParameter("emp", "employee");
		return query.getResultList();
	}

	public List<Task> getAllTaskByEmpId(int id) {
		User user = em.find(User.class, id);
		if (user == null)
			return null;
		return user.getTasks();
	}

}