package limtaebaek.hotel.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.user.dao.UserDao;
import limtaebaek.hotel.user.domain.User;

@Service
public class UserServiceImpl implements UserService{
	@Autowired private UserDao userDao;

	@Override
	@Transactional
	public List<User> listUsers(Page page) {
		return userDao.getUsers(page);
	}

	@Override
	@Transactional
	public List<User> searchListUsers(User user) {
		return userDao.searchUser(user);
	}

	@Override
	@Transactional
	public int countUsers() {
		return userDao.countUser();
	}
	
	@Override
	@Transactional
	public User getEmail(User user) {
		return userDao.getEmail(user);
	}
	
	@Override
	@Transactional
	public User getUser(User user) {
		return userDao.getUser(user);
	}

	@Override
	@Transactional
	public boolean join(User user) {
		return userDao.addUser(user)>0;
	}

	@Override
	@Transactional
	public boolean cerrectUser(User user) {
		return userDao.updateUser(user) > 0;
	}

	@Override
	@Transactional
	public boolean secede(User user) {
		return userDao.delUser(user) > 0;
	}

	@Override
	public int countUserToday() {
		return userDao.countUserToday();
	}
}
