package limtaebaek.hotel.booking.service;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.user.domain.User;

public interface BookingMailService {
	void send(Booking booking, String userEmail, String bookingName);
}
