package limtaebaek.hotel.user.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.user.dao.mapper.UserMapper;
import limtaebaek.hotel.user.domain.User;

@Repository
public class UserDaoImpl implements UserDao{
	@Autowired private UserMapper mapper = null;
	
	@Override
	public User loginUser(User user) {
		return mapper.loginUser(user);
	}

	@Override
	public List<User> findId(User user) {
		return mapper.findId(user);
	}

	@Override
	public User findPw(User user) {
		return mapper.findPw(user);
	}
	
	@Override
	public List<User> getUsers(Page page) {
		return mapper.getUsers(page);
	}

	@Override
	public List<User> searchUser(User user) {
		return mapper.searchUser(user);
	}

	@Override
	public int countUser() {
		return mapper.countUser();
	}

	@Override
	public User getEmail(User user) {
		return mapper.getEmail(user);
	}
	@Override
	public User getUser(User user){
		return mapper.getUser(user);
	}
	
	@Override
	public int addUser(User user) {
		return mapper.addUser(user);
	}

	@Override
	public int updateUser(User user) {
		return mapper.updateUser(user);
	}
	
	@Override
	public int delUser(User user) {
		return mapper.delUser(user);
	}

	@Override
	public int countUserToday() {
		return mapper.countUserToday();
	}

	@Override
	public int noneUserValidate(NoneUser noneUser) {
		return mapper.noneUserValidate(noneUser);
	}

}
