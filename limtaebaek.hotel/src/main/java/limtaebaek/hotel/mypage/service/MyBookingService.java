package limtaebaek.hotel.mypage.service;

import java.util.List;

import limtaebaek.hotel.booking.domain.Booking;

public interface MyBookingService {

	List<Booking> getMyBookings(Booking booking);
	int getMyBookingsCount(Booking booking);
}
