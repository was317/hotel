package limtaebaek.hotel.user.service;

import java.util.List;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.user.domain.User;

public interface UserService {
	List<User> listUsers(Page page);
	List<User> searchListUsers(User user);
	int countUsers();
	User getEmail(User user);
	User getUser(User user);
	boolean join(User user);
	boolean cerrectUser(User user);
	boolean secede(User user);
	
	int countUserToday();
}
