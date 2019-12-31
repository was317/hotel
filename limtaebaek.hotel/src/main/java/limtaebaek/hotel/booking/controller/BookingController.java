package limtaebaek.hotel.booking.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import limtaebaek.hotel.booking.domain.Account;
import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.booking.domain.Card;
import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.booking.service.BookingService;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.common.service.PageService;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.point.service.PointService;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;
import limtaebaek.hotel.room.service.RoomService;
import limtaebaek.hotel.user.domain.User;
import limtaebaek.hotel.user.service.UserService;

@Controller
@RequestMapping("/booking")
public class BookingController {
	@Autowired private BookingService bookingService;
	@Autowired private RoomService roomService;
	@Autowired private PointService pointService;
	@Autowired private PageService pageService;
	
	//예약정보 기입 페이지
	@Transactional
	@RequestMapping("/bookingForm")
	public String bookingForm(Booking booking, Room room, HttpSession session,
						Model model, HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		
		model.addAttribute("point", pointService.getMyPointSum(user.getUserNum()));
		model.addAttribute("booking", booking);
		model.addAttribute("room", room);
		model.addAttribute("optionList", roomService.getRoom(booking.getRoomNum()).getOptions());
		model.addAttribute("days", bookingService.days(booking.getCheckIn(), booking.getCheckOut()));
		
		return "booking/form";
	}
	
	//예약정보 저장
	@Transactional
	@ResponseBody
	@RequestMapping("/proceedBooking")
	public Booking proceedBooking(Model model, Booking booking, Card card, HttpSession session,
						Account account, String paytype, String cardExp, NoneUser noneUser) throws ParseException {
		
		booking.setPaytype(paytype);
		bookingService.addBooking(booking);
		
		if(booking.getUserNum()==0){
			noneUser.setBookingNum(booking.getBookingNum());
			noneUser.setNuserKname(booking.getUserName());
			bookingService.addNoneUser(noneUser);
		}
		
		if(paytype.equals("card")) {
			card.setCardExp(cardExp);
			card.setBookingNum(booking.getBookingNum());
			bookingService.addCard(card);
		}
		else if(paytype.equals("account")) {
			account.setBookingNum(booking.getBookingNum());
			bookingService.addAccount(account);
		}
		
		if (booking.getBookingPoint() != 0){
			Point point = new Point();
			point.setPointChange(booking.getBookingPoint() * (-1));
			model.addAttribute("point", booking.getBookingPoint());
			point.setPointContent("포인트 사용 (객실예약)");
			point.setUserNum(booking.getUserNum());
			pointService.addPoint(point);
		}
		
		Point point = new Point();
		point.setPointChange(booking.getPayment() / 20);
		point.setPointContent("포인트 적립 (결제금액 5%)");
		point.setUserNum(booking.getUserNum());
		pointService.addPoint(point);
		
		return booking;
	}
	
	//예약완료 페이지
	@Transactional
	@RequestMapping("/completeBooking")
	public String completeBooking(Model model, Room room, int bookingNum, String userName) {
		Booking booking = bookingService.getBooking(bookingNum);
		booking.setUserName(userName);
		booking.setRoomType(roomService.getRoom(booking.getRoomNum()).getRoomType());
		model.addAttribute("optionList", roomService.getRoom(booking.getRoomNum()).getOptions());
		model.addAttribute("booking", booking);
		model.addAttribute("days", bookingService.days(booking.getCheckIn(), booking.getCheckOut()));
		return "booking/completion";
	}
	
	//예약조회 페이지
	@Transactional
	@RequestMapping("/myBooking")
	public String myBooking(Model model, HttpSession session, @RequestParam("bookingNum")int bookingNum) {
		User user = (User) session.getAttribute("user");
		int userNum = user.getUserNum();
		Booking booking = bookingService.getBooking(bookingNum);
		model.addAttribute("optionList", roomService.getRoom(booking.getRoomNum()).getOptions());
		model.addAttribute("days", bookingService.days(booking.getCheckIn(), booking.getCheckOut()));
		if(userNum == 0){
			model.addAttribute("nUserBooking", bookingService.getNoneUserBookings(booking.getBookingNum()));
			return "booking/noneUserBooking";
		}
		else{
			model.addAttribute("myBookingList", bookingService.getMyBookings(bookingNum));
			return "booking/myBooking";
		}
	}
	
	//예약관리 페이지
	@Transactional
	@RequestMapping("/bookingManage")
	public String bookingManage(Model model, @RequestParam(value="page",required=false) String pageNo){
		int dataSize = bookingService.countBooking();
		int nowPage = 1;

		if(pageNo != null) nowPage = Integer.parseInt(pageNo);
		Page page = pageService.paging(nowPage, dataSize);
		model.addAttribute("bookingList", bookingService.BookingList(page));
		model.addAttribute("page", page);
		return "booking/manage";
	}
	
	//예약관리 페이지 -> 검색
	@Transactional
	@ResponseBody
	@RequestMapping("/searchBooking")
	public List<Booking> searchBooking(Model model, @RequestParam(value="num",required=false) String num){
		if(num == "") num = "1";
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(num);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		//model.addAttribute("searchBooking", bookingService.searchBooking(Integer.parseInt(num)));
		return bookingService.searchBooking(Integer.parseInt(num));
	}
	
	//예약관리 -> 예약정보 페이지
	@Transactional
	@RequestMapping("/bookingInformation")
	public String bookingInformation(Model model, int bookingNum, String roomType, String name) {
		Booking booking = bookingService.getBooking(bookingNum);
		String optionList = bookingService.getOption(booking);
		long days = bookingService.days(booking.getCheckIn(), booking.getCheckOut());
		model.addAttribute("optionList", optionList);
		model.addAttribute("booking", booking);
		model.addAttribute("name", name);
		model.addAttribute("roomType", roomType);
		model.addAttribute("days", days);
		
		return "/booking/information";
	}
	
	//예약정보 페이지 -> 예약수정 페이지
	@Transactional
	@RequestMapping("/modBooking")
	public String modBooking(Model model, int bookingNum, String roomType, String name) {
		Booking booking = bookingService.getBooking(bookingNum);
		String optionList = bookingService.getOption(booking);
		long days = bookingService.days(booking.getCheckIn(), booking.getCheckOut());
		model.addAttribute("optionList", optionList);
		model.addAttribute("booking", booking);
		model.addAttribute("name", name);
		model.addAttribute("roomType", roomType);
		model.addAttribute("days", days);
		
		return "/booking/modification";
	}
	
	//예약정보 페이지 -> 예약삭제
	@Transactional
	@ResponseBody
	@RequestMapping("/delBooking")
	public String delBooking(Model model, int bookingNum) {
		Booking booking = bookingService.getBooking(bookingNum);
		Point point = new Point();
		point.setPointChange(booking.getBookingPoint());
		point.setPointContent("포인트 환불 (예약취소)");
		point.setUserNum(booking.getUserNum());
		pointService.addPoint(point);
		bookingService.delBooking(bookingNum);
		return "del";
	}
	
	//예약정보 수정페이지 -> 예약수정
	@Transactional
	@ResponseBody
	@RequestMapping("/changeBooking")
	public boolean changeBooking(Model model, Booking booking) {
		bookingService.changeBooking(booking);
		return true;
	}
	
	@RequestMapping("/todayBookingUser")
	@ResponseBody
	@Transactional
	public int todayJoinUser() {
		return bookingService.countBookingToday();
	}
}
