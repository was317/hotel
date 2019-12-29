package limtaebaek.hotel.booking.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.service.RoomService;
import limtaebaek.hotel.user.domain.User;

@Service
public class BookingMailServiceImpl implements BookingMailService{
	@Autowired private JavaMailSender mailSender;
	@Autowired private BookingService bookingService;
	@Autowired private RoomService roomService;

	@Override
	public void send(Booking booking, String toMail, String bookingName) {
		
		String option = bookingService.getOption(booking);
		String from ="SeoulHotel";
		String title = "[서울호텔] "+ bookingName +"님의 객실예약 확인서 입니다.";
		String content = "<div class='panel panel-default'>" 
				+ "<div class='panel' style='width: 60%; margin: 0 auto; text-align:center; border: 1px solid #444444;'>"
				+ "<h2 class='text-right'>"
				+ "예약번호: <label id='bookingNum'>" + booking.getBookingNum() + "</label>"
				+ "</h2>"
				+ "</div>"
				+ "<div class='panel-body' style='padding: 40px;'>"
				+ "<table class='table table-bordered confirm' style='width: 60%; margin: 0 auto; border: 1px solid #444444;'>"
				+ "<colgroup>"
				+ "<col class='info' style='background-color: #dff0d8; width: 150px; height: 500px;'>"
				+ "<col class='col' style='width: 250px;'>"
				+ "<col class='info' style='background-color: #dff0d8; width: 150px; height: 500px;'>"
				+ "<col class='col' style='width: 250px;'>"
				+ "</colgroup>"
				+ "<tr>"
				+ "<td style='padding: 10px;'>호텔</td>"
				+ "<td style='padding: 10px;'>서울호텔</td>"
				+ "<td style='padding: 10px;'>성명</td>"
				+ "<td style='padding: 10px;'><label id='name'>" + bookingName + "</label></td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style='padding: 10px;'>체크인</td>"
				+ "<td style='padding: 10px;'><label id='checkIn'>" + booking.getCheckIn() + "</label></td>"
				+ "<td style='padding: 10px;'>체크아웃</td>"
				+ "<td style='padding: 10px;'><label id='checkOut'>" + booking.getCheckOut() + "</label></td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style='padding: 10px;'>숙박일수</td>"
				+ "<td style='padding: 10px;'><label id='days'></label>" + bookingService.days(booking.getCheckIn(), booking.getCheckOut()) + "박</td>"
				+ "<td style='padding: 10px;'>투숙인원</td>"
				+ "<td style='padding: 10px;'>성인: <label id='adult'>" + booking.getAdult() + "</label>"
				+ "/ 어린이: <label id='kid'>" + booking.getKid() + "</label>"
				+ "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style='padding: 10px;'>객실</td>"
				+ "<td style='padding: 10px;'><label id='roomType'>" + roomService.getRoom(booking.getRoomNum()).getRoomType() + "</label></td>"
				+ "<td style='padding: 10px;'>옵션</td>"
				+ "<td style='padding: 10px;'><label id='option'>" + option + "</label></td>"
				+ "</tr>"
				+ "</table>"
				+ "</div>"
				+ "<div class='panel panel-default' style='width: 60%; margin: 0 auto; border: 1px solid #444444;'>"
				+ "<div class='panel-footer'>"
				+ "<h4 class='pointpanel' style='padding: 10px; text-align: right; margin-right:30px;'>요금 합계: <label id='charge'>" + booking.getPayment()
				+ " / 결제 수단: " + booking.getPaytype()
				+ "</h4>"
				+ "</span>"
				+ "</div>"
				+ "</div>"
				+ "</div>";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from); // 보내는사람
			messageHelper.setTo(toMail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목
			messageHelper.setText(content, true); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
