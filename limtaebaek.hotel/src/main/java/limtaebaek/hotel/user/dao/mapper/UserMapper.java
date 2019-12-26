package limtaebaek.hotel.user.dao.mapper;

import java.util.List;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.user.domain.User;

public interface UserMapper {
	User loginUser(User user);
	List<User> findId(User user);
	User findPw(User user);
	int noneUserValidate(NoneUser noneUser);
	
	List<User> getUsers(Page page);
	int countUser();
	List<User> searchUser(User user);
	User getEmail(User user);
	User getUser(User user);
	int addUser(User user);
	int updateUser(User user);
	int delUser(User user);
	
	int countUserToday();
}
