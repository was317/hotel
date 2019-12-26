package limtaebaek.hotel.booking.dao.mapper;

import java.util.List;

import limtaebaek.hotel.booking.domain.Account;
import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.booking.domain.Card;
import limtaebaek.hotel.booking.domain.NoneUser;
import limtaebaek.hotel.room.domain.Room;
import limtaebaek.hotel.user.domain.User;

public interface BookingMapper {
	Booking getBooking(int bookingNum);
	int addBooking(Booking booking);
	List<Booking> getBookings();
	List<Booking> getMyBookings(int userNum);
	List<Booking> getNoneUserBookings(int bookingNum);
	List<User> getNames(int userNum);
	Room getRoom(int roomNum);
	int delBooking(int bookingNum);
	int changeBooking(Booking booking);
	int addNoneUser(NoneUser nuser);
	int addCard(Card card);
	int addAccount(Account account);

	int countBookingToday();
	
}
