package limtaebaek.hotel.user.service;

import java.util.List;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.user.domain.User;

public interface LoginService {
	User logInVaildate(User user);
	List<User> findId(User user);
	User findPw(User user);
	boolean noneUserValidate(NoneUser noneUser);

	public void send(User user, String temporaryPw);
}
