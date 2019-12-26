package limtaebaek.hotel;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import oracle.net.aso.s;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.Search;
import limtaebaek.hotel.promotion.service.PromotionService;
import limtaebaek.hotel.user.domain.User;

@Controller
public class Main{
	@Autowired private PromotionService promotionService;
	
	@RequestMapping("/")
	public String main(HttpSession session, Model model,
			@RequestParam(required=false) String keyword,
			@RequestParam(required=false) Date schStartDate,
			@RequestParam(required=false) Date schEndDate){

		User user = new User();
		user.setUserNum(0);
		if(session.getAttribute("user") == null)
			session.setAttribute("user", user);
		
		Search search = new Search();
		search.setKeyword(keyword);
		search.setSchStartDate(schStartDate);
		search.setSchEndDate(schEndDate);

		List<Promotion> listPros = promotionService.listPros(search);

		if(listPros.size() < 8)
			listPros = listPros.subList(0, listPros.size());
		else
			listPros = listPros.subList(0, 8);
		
		model.addAttribute("listPros", listPros);
	
		return "main";
	}
	
	@RequestMapping("/switchMain")
	public String switchMain(HttpSession session, Model model,
			@RequestParam(required=false) String keyword,
			@RequestParam(required=false) Date schStartDate,
			@RequestParam(required=false) Date schEndDate){


		User user = new User();
		user.setUserNum(0);
		if(session.getAttribute("user") == null)
			session.setAttribute("user", user);
		
		Search search = new Search();
		search.setKeyword(keyword);
		search.setSchStartDate(schStartDate);
		search.setSchEndDate(schEndDate);

		List<Promotion> listPros = promotionService.listPros(search);

		if(listPros.size() < 8)
			listPros = listPros.subList(0, listPros.size());
		else
			listPros = listPros.subList(0, 8);
		
		model.addAttribute("listPros", listPros);
	
		session.setAttribute("page", "main");
		return "main";
	}
	
	@RequestMapping("/switchAdmin")
	public String switchAdmin(HttpSession session){
		session.setAttribute("page", "admin");
		return "admin";
	}
}
