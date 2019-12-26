package limtaebaek.hotel.user.service;

import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.user.dao.UserDao;
import limtaebaek.hotel.user.domain.User;

@Service
public class LoginServiceImpl implements LoginService{
	@Autowired private JavaMailSender mailSender;
	@Autowired private UserDao userDao;

	@Override
	@Transactional
	public User logInVaildate(User user) {
		return userDao.loginUser(user);
	}

	@Override
	public List<User> findId(User user) {
		return userDao.findId(user);
	}

	@Override
	public User findPw(User user) {
		return userDao.findPw(user);
	}

	@Override
	public boolean noneUserValidate(NoneUser noneUser) {
		return userDao.noneUserValidate(noneUser)>0;
	}

	@Override
	public void send(User user, String temporaryPw) {
		String from ="SeoulHotel";
		String title = "[서울호텔] "+ user.getUserName() +"님의 임시비밀번호입니다.";	
		
		String content = "<div class='panel panel-default'>" 
				+ "<div class='container'>"
				+ "<div>"
				+ "<h4 style='width: 60%; margin: 20px auto; border: double 3px black;padding: 2%;'>"
				+ "" + user.getUserName() + "님의 비밀번호 입니다.\n"
				+ "</h4>"
				+ "<h2 style='width: 60%; margin: 20px auto; border: dashed 3px black;padding: 2%;'>"
				+ "" + temporaryPw + ""
				+ "</h2>"
				+ "<div style='width: 60%; margin: 20px auto; border: solid 1px black; padding: 2%;'>"
				+ "<ul>"
				+ "<li>임시번호를 이용하여 서울호텔의 비밀번호를 변경하세요</li>"
				+ "<li><a href='http://localhost:8082/hotel/'>http://www.seoulhote.com/</a></li>"
				+ "</ul>"
				+ "</div>"
				+ "</div>"
				+ "</div>"
				+ "</div>";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from); // 보내는사람
			messageHelper.setTo(user.getUserEmail()); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목
			messageHelper.setText(content, true); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
