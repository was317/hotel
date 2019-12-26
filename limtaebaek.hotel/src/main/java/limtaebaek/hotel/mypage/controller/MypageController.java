
package limtaebaek.hotel.mypage.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.common.service.PageService;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.mypage.service.MyBookingService;
import limtaebaek.hotel.mypage.service.MyCommentService;
import limtaebaek.hotel.mypage.service.MyInquiryService;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.point.service.PointService;
import limtaebaek.hotel.user.domain.User;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired private MyInquiryService myInqService;
	@Autowired private MyCommentService myCommentService;
	@Autowired private MyBookingService myBookingService;
	@Autowired private PageService pageService;
	
	@RequestMapping("/myPage")
	public String myPage(Model model, HttpSession session){
		User user = (User) session.getAttribute("user");
		int userNum = user.getUserNum();
		
		List<Inquiry> inqList = myInqService.getInquirys(userNum);
		if(inqList.size() < 10)
			inqList.subList(0, inqList.size());
		else
			inqList.subList(0, 10);
		
		model.addAttribute("inqCount", myInqService.getCount(userNum));
		model.addAttribute("inqList", inqList);
		
		return "mypage/myPage";
	}
	@RequestMapping("/myPoint")
	public String myPoint(){
		return "mypage/myPoint";
	}
	@RequestMapping("/myComment")
	public String myComment(){
		return "mypage/myComment";
	}
	@RequestMapping("/myBooking")
	public String myBooking(){
		return "mypage/myBooking";
	}
	@RequestMapping("/myInfo")
	public String myInfo(){
		return "mypage/myInfo";
	}
	@RequestMapping("/myInfoChange")
	public String myInfoChange(){
		return "mypage/myInfoChange";
	}
	@RequestMapping("/mySecede")
	public String mySecede(){
		return "mypage/mySecede";
	}
	

	@RequestMapping("/myCommentList")
	@ResponseBody
	@Transactional
	public HashMap<String, Object> getMyComments(Comment comment, HttpServletRequest request) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		int dataSize = myCommentService.getMyCommentsCount(comment);
		int nowPage = 1;
		
		String paramNowPage = request.getParameter("page");
		if(!(paramNowPage.equals("null"))) nowPage = Integer.parseInt(paramNowPage);
		Page page = pageService.paging(nowPage, dataSize);
		page.setSearchType(comment);
		System.out.println(page);
		result.put("commnetList", myCommentService.getMyComments(comment));
		result.put("page", page);
		
		return result;
	}
	
	@RequestMapping("/myBookingList")
	@ResponseBody
	@Transactional
	public HashMap<String, Object> myBookingList(Booking booking, HttpServletRequest request) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		int dataSize = myBookingService.getMyBookingsCount(booking);
		int nowPage = 1;
		
		String paramNowPage = request.getParameter("page");
		if(!(paramNowPage.equals("null"))) nowPage = Integer.parseInt(paramNowPage);
		Page page = pageService.paging(nowPage, dataSize);
		page.setSearchType(booking);
		System.out.println(page);
		
		result.put("inquiryList", myInqService.getInquirys(booking.getUserNum()));
		result.put("bookingList", myBookingService.getMyBookings(booking));
		
		return result;
	}
	
	
	
	
	
	@Transactional
	@RequestMapping("/boardInq")
	public String boardInq(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		int userNum = user.getUserNum();
		model.addAttribute("inqCount", myInqService.getCount(userNum));
		model.addAttribute("inqList", myInqService.getInquirys(userNum));
		return "mypage/boardInq";
	}
	
	@RequestMapping("/myInquiry")
	public String myInquiry(@RequestParam("inqNumber")int inqNum,
			Model model, HttpSession session) throws Exception {
		User user = (User) session.getAttribute("user");
		int userNum = user.getUserNum();
		model.addAttribute("inq", myInqService.getInquiry(inqNum, userNum));
		return "mypage/myInq";
	}
	
	@RequestMapping("/modifyInquiry")
	public String modifyInquiry(@RequestParam("inqNumber")int inqNum,
		Model model, HttpSession session) throws Exception {
		User user = (User) session.getAttribute("user");
		int userNum = user.getUserNum();
		model.addAttribute("inq", myInqService.getInquiry(inqNum, userNum));
		return "mypage/modInq";
	}
	
	@ResponseBody
	@RequestMapping("/submitModInq")
	public Inquiry submitModInq(Model model, Inquiry inquiry) {
		myInqService.modInquiry(inquiry);
		return inquiry;
	}
	
	//답변 보기 페이지
	@ResponseBody
	@RequestMapping("/getAnswer")
	public InquiryComment getAnswer(Model model, Inquiry inquiry, User user) {
		int userNum = user.getUserNum();
		model.addAttribute("inq", myInqService.getInquiry(inquiry.getInqNum(), userNum));
		myInqService.getInquiryAnswer(inquiry.getInqNum());
		return myInqService.getInquiryAnswer(inquiry.getInqNum());
	}
	
	//답변 모달 불러오기
/*	@Transactional
	@RequestMapping("/myInqAns")
	public String myInqAns(Model model, Inquiry inquiry) throws Exception {
		model.addAttribute("inq", myInqService.getInquiryAnswer(inquiry.getInqNum()));
		return "mypage/myInqAns";
	}*/
}
