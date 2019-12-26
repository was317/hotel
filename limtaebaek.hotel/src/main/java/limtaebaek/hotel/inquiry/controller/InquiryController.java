package limtaebaek.hotel.inquiry.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.inquiry.service.InquiryService;
import limtaebaek.hotel.mypage.service.MyInquiryServiceImpl;
import limtaebaek.hotel.user.domain.User;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	@Autowired private InquiryService inquiryService;
	//문의관리 페이지
	@Transactional
	@RequestMapping("/inquiryManage")
	public String inquiryManage(Model model) {
		model.addAttribute("inquiryList", inquiryService.getInquirys());
		model.addAttribute("inquiryCount", inquiryService.getCount());
		return "inquiry/manage";
	}

/*	//문의보기 모달 페이지
	@Transactional
	@RequestMapping("/viewInquiry")
	public String viewInquiry(Model model, Inquiry inquiry) {
		return "inquiry/view";
	}*/
	
	//문의 보기
	@RequestMapping("/getInquiry")
	@ResponseBody
	@Transactional
	public Inquiry getInquiry(Inquiry inquiry) {
		return inquiryService.getInquiry(inquiry.getInqNum());
	}
	
	//문의 답변 보기
	@ResponseBody
	@RequestMapping("/getAnswer")
	public InquiryComment getAnswer(Model model, Inquiry inquiry) {
		model.addAttribute("inquiry", inquiryService.getInquiry(inquiry.getInqNum()));
		inquiryService.getInquiryAnswer(inquiry.getInqNum());
		return inquiryService.getInquiryAnswer(inquiry.getInqNum());
	}
	
/*	//문의답변 모달 페이지
	@Transactional
	@RequestMapping("/inquiryAnswer")
	public String inquiryAnswer(Inquiry inquiry) {
		return "inquiry/answer";
	}*/
	
	//답변 등록 페이지
	@Transactional
	@ResponseBody
	@RequestMapping("/writeComment")
	public Inquiry writeComment(Inquiry inquiry, Model model) {
		model.addAttribute("inquiry", inquiryService.getInquiry(inquiry.getInqNum()));
		return inquiryService.getInquiry(inquiry.getInqNum());
	}
		
	//답변 등록 
	@Transactional
	@ResponseBody
	@RequestMapping("/submitComment")
	public boolean submitComment(Inquiry inquiry, InquiryComment comment) {
		inquiryService.changeStatus(inquiry.getInqNum());
		return inquiryService.writeComment(comment);
	}
	
	//문의등록 페이지
	@Transactional
	@RequestMapping("/inquiryForm")
	public String customerInquiry() {
		return "inquiry/form";
	}
	
	//문의 등록
	@Transactional
	@ResponseBody
	@RequestMapping("/writeInquiry")
	public boolean writeInquiry(Inquiry inquiry) {
		inquiryService.writeInquiry(inquiry);
		return true;
	}
	
	//문의 삭제
	@Transactional
	@ResponseBody
	@RequestMapping("/deleteInquiry")
	public boolean deleteInquiry(Inquiry inquiry) {
		inquiryService.deleteInquiry(inquiry.getInqNum());
		return true;
	}
	
	

	@RequestMapping("/todayInquiry")
	@ResponseBody
	@Transactional
	public int todayInquiry() {
		return inquiryService.countInquiryToday();
	}

	@RequestMapping("/todayInquiryNoComent")
	@ResponseBody
	@Transactional
	public int todayInquiryNoComent() {
		return inquiryService.countInquiryTodayNoComent();
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping("/inquiryMainList")
	public List<Inquiry> inquiryManage() {
		List<Inquiry> inqList = inquiryService.getInquirys();
		if(inqList.size() < 10)
			inqList.subList(0, inqList.size());
		else
			inqList.subList(0, 10);
		
		return inqList;
	}

}
