package limtaebaek.hotel.booking.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.booking.dao.BookingDao;
import limtaebaek.hotel.booking.domain.Account;
import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.booking.domain.Card;
import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.service.RoomService;
import limtaebaek.hotel.user.domain.User;

@Service
public class BookingServiceImpl implements BookingService{
	@Autowired private BookingDao bookingDao;
	@Autowired private RoomService roomService;
	
	@Override
	public Booking getBooking(int bookingNum) {
		return bookingDao.getBooking(bookingNum);
	}

	@Override
	public List<Booking> BookingList(Page page) {
		return bookingDao.getBookings(page);
	}

	@Override
	public int delBooking(int bookingNum) {
		return bookingDao.delBooking(bookingNum);
	}

	@Override
	public int changeBooking(Booking booking) {
		return bookingDao.changeBooking(booking);
	}
	@Override
	public int addBooking(Booking booking) {
		booking.setBookingNum(bookingNum(booking));
		
		if(booking.getPaytype().equals("card"))
			booking.setPaytype("카드결제");
		else if(booking.getPaytype().equals("account"))
			booking.setPaytype("계좌이체");
		else {
			booking.setPaytype("null");
		}
		
		return bookingDao.addBooking(booking);
	}

	@Override
	public int addNoneUser(NoneUser nuser) {
		return bookingDao.addNoneUser(nuser);
	}

	@Override
	public int addCard(Card card) {
		return bookingDao.addCard(card);
	}

	@Override
	public int addAccount(Account account) {
		return bookingDao.addAccount(account);
	}
	
	//예약번호 생성 -> 예약날짜+객실번호+랜덤2자리수
	public int bookingNum(Booking booking) {
		String roomNum = Integer.toString(booking.getRoomNum());
		java.util.Date today = new java.util.Date();
		Random rand = new Random();
		String bookingNum = new SimpleDateFormat("yyMMdd").format(today);
		if(booking.getRoomNum() < 10)
			roomNum = "0" + booking.getRoomNum();
		bookingNum = bookingNum + roomNum + (rand.nextInt(89) + 10);
		
		return Integer.parseInt(bookingNum);
	}
	
	//두 날짜 차이
	public long days(Date start, Date end){
	    // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
		long diff = end.getTime() - start.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000);
 
		return diffDays;
	}

	@Override
	public List<User> getNames(int userNum) {
		return bookingDao.getNames(userNum);
	}
	
	@Override
	public String getOption(Booking booking) {
		String roomOption="";
		int roomNum = booking.getRoomNum();
		List<Option> list = roomService.getRoom(roomNum).getOptions();
		String[] option = {"조식", "스파", "야외수영장", "엑스트라베드"};
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getOptNo() == 0) continue;
			else
				roomOption = roomOption + option[list.get(i).getOptNo() - 1] + " ";
		}
		return roomOption;
	}

	@Override
	public List<Booking> getMyBookings(int userNum) {
		return bookingDao.getMyBookings(userNum);
	}

	@Override
	public List<Booking> getNoneUserBookings(int bookingNum) {
		return bookingDao.getNoneUserBookings(bookingNum);
	}
	

	@Override
	public int countBookingToday() {
		return bookingDao.countBookingToday();
	}

	@Override
	public int countBooking() {
		return bookingDao.countBooking();
	}

	@Override
	public List<Booking> searchBooking(int num) {
		return bookingDao.searchBooking(num);
	}
}
