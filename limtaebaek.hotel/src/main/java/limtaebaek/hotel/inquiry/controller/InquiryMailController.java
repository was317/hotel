package limtaebaek.hotel.inquiry.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.inquiry.service.MailService;

@Controller
@RequestMapping("/inquiry")
public class InquiryMailController {
	@Autowired private MailService mailService;
	
	@RequestMapping("/inquiryMail")
	public String send(InquiryComment msg, Inquiry to){
		mailService.send(msg, to);
		
		return "inquiry/manage";
	}
	
}
