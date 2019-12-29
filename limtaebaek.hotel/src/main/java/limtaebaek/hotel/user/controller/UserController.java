package limtaebaek.hotel.user.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.common.service.PageService;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.point.service.PointService;
import limtaebaek.hotel.user.domain.User;
import limtaebaek.hotel.user.service.LoginService;
import limtaebaek.hotel.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired private LoginService loginService;
	@Autowired private UserService userService;
	@Autowired private PageService pageService;
	@Autowired private PointService pointService;
	
	
	@RequestMapping("/userTerms")
	public String userTerms() {
		return "user/terms";
	}
	@RequestMapping("/userJoin")
	public String userJoin() {
		return "user/join";
	}
	@RequestMapping("/userComplete")
	public String userComplete() {
		return "user/complete";
	}
	@RequestMapping("/userList")
	public String userList() {
		return "user/userList";
	}
	@RequestMapping("/userData")
	public String userData() {
		return "user/userData";
	}
	
	
	@Transactional
	@RequestMapping("/join")
	public void join(User user) {
		userService.join(user);
	}
	@Transactional
	@ResponseBody
	@RequestMapping("/checkEmail")
	public boolean checkDuplicationUserEmail(User user) {
		boolean result = false;
		if(userService.getEmail(user) == null) result = true;
		return result;
	}
	
	@RequestMapping("/listUsers")
	@ResponseBody
	@Transactional
	public HashMap<String, Object> listUsers(HttpServletRequest request) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		int dataSize = userService.countUsers();
		int nowPage = 1;
		
		String paramNowPage = request.getParameter("page");
		if(!(paramNowPage.equals("null"))) nowPage = Integer.parseInt(paramNowPage);
		Page page = pageService.paging(nowPage, dataSize);
		result.put("userList", userService.listUsers(page));
		result.put("page", page);
		
		return result;
	}
	
	@RequestMapping("/searchListUsers")
	@ResponseBody
	@Transactional
	public List<User> searchListUsers(User user) {
		return userService.searchListUsers(user);
	}
	
	@RequestMapping("/getUser")
	@ResponseBody
	@Transactional
	public User getUser(User user) {
		return userService.getUser(user);
	}
	
	@RequestMapping("/cerrect")
	@ResponseBody
	@Transactional
	public boolean cerrectUser(User user, HttpSession session) {
		Boolean result = false;
		result = userService.cerrectUser(user);
		
		
		User memUser = loginService.logInVaildate(user);
		if(memUser != null) {
			result = true;
			session.removeAttribute("user");
			session.setAttribute("user", memUser);
			}
		
		return result;
	}
	
	@RequestMapping("/secede")
	@ResponseBody
	@Transactional
	public boolean secede(User user) {
		return userService.secede(user);
	}
	
	@RequestMapping("/todayJoinUser")
	@ResponseBody
	@Transactional
	public int todayJoinUser() {
		return userService.countUserToday();
	}
}

