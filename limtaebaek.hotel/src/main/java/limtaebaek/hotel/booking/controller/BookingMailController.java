package limtaebaek.hotel.booking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.booking.service.BookingMailService;
import limtaebaek.hotel.booking.service.BookingService;
import limtaebaek.hotel.room.service.RoomService;

@Controller
@RequestMapping("/booking")
public class BookingMailController {
@Autowired private BookingMailService mailService;
@Autowired private BookingService bookingService;
	
	@ResponseBody
	@RequestMapping("/bookingMail")
	public String bookingMail(int bookingNum, String bookingEmail, String bookingName, int roomNum){
		Booking booking = bookingService.getBooking(bookingNum);
		booking.setRoomNum(roomNum);
		mailService.send(booking, bookingEmail, bookingName);
		
		return "mailSuccess";
	}
}
