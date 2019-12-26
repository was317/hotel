package limtaebaek.hotel.user.comtroller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.inquiry.service.MailService;
import limtaebaek.hotel.user.domain.User;
import limtaebaek.hotel.user.service.LoginService;
import limtaebaek.hotel.user.service.UserService;

@Controller
public class UserLoginController {
	@Autowired private UserService userService;
	@Autowired private LoginService loginService;

	@RequestMapping("/loginUser")
	public String userLogin() {
		return "user/loginUser";
	}
	
	@RequestMapping("/admin")
	public String admin(){
		return "admin";
	}
	
	@RequestMapping("/searchIdNPw")
	public String userSearchIdPw() {
		return "user/searchIdNPw";
	}

	@RequestMapping("user/Noneuser")
	@ResponseBody
	@Transactional
	public Boolean Noneuser(NoneUser noneUser, HttpSession session) {
		return loginService.noneUserValidate(noneUser);
	}
	
	@RequestMapping("user/login")
	@ResponseBody
	@Transactional
	public Boolean login(User user, HttpSession session) {
		Boolean result = false;
		User memUser = loginService.logInVaildate(user);
		if(memUser != null) {
			result = true;
			session.removeAttribute("user");
			session.setAttribute("user", memUser);
			}
		return result;
	}
	
	@RequestMapping("user/adminLogin")
	@ResponseBody
	@Transactional
	public Boolean adminLogin(User user, HttpSession session) { // && user.getUserLevel() > 3
		Boolean result = false;
		User adminUser = loginService.logInVaildate(user);
		if(adminUser != null && adminUser.getUserGrade() >= 2) {
			result = true;
			session.removeAttribute("user");
			session.setAttribute("user", adminUser);
			session.setAttribute("page", "admin");
			}
		return result;
	}
	
	@RequestMapping("user/findId")
	@ResponseBody
	@Transactional
	public List<User> findId(User user) {
		return loginService.findId(user);
	}	
	
	@RequestMapping("user/findPw")
	@ResponseBody
	@Transactional
	public User findPw(User user) {
		User result = loginService.findPw(user);
		if(result != null){
	        String temporaryPw = UUID.randomUUID().toString().replaceAll("-", "");
	        temporaryPw = temporaryPw.substring(0, 15);
	        result.setUserPassword(temporaryPw);
	        userService.cerrectUser(result);
	        loginService.send(user, temporaryPw);
		}
		return result;
	}		
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
