package limtaebaek.hotel.user.dao;

import java.util.List;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.user.domain.User;

public interface UserDao {
	User loginUser(User user);
	List<User> findId(User user);
	User findPw(User user);
	int noneUserValidate(NoneUser noneUser);
	
	List<User> getUsers(Page page);
	List<User> searchUser(User user);
	int countUser();
	User getEmail(User user);
	User getUser(User user);
	int addUser(User user);
	int updateUser(User user);
	int delUser(User user);
	
	int countUserToday();
}
