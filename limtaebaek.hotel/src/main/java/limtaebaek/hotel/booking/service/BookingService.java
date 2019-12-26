package limtaebaek.hotel.booking.service;

import java.sql.Date;
import java.util.List;

import limtaebaek.hotel.booking.domain.Account;
import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.booking.domain.Card;
import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.user.domain.User;

public interface BookingService {
	Booking getBooking(int bookingNum);
	int addBooking(Booking booking);
	List<Booking> BookingList();
	List<Booking> getMyBookings(int userNum);
	List<Booking> getNoneUserBookings(int bookingNum);
	List<User> getNames(int userNum);
	int delBooking(int bookingNum);
	int changeBooking(Booking booking);
	int addNoneUser(NoneUser nuser);
	int addCard(Card card);
	int addAccount(Account account);
	long days(Date start, Date end);
	String getOption(Booking booking);

	int countBookingToday();
}
