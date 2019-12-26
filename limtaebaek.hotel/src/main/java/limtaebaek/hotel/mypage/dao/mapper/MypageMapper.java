package limtaebaek.hotel.mypage.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.user.domain.User;



public interface MypageMapper {
	List<Inquiry> getInquirys(int userNum);
	Inquiry getInquiry(@Param("inqNum")int inqNum, @Param("userNum")int userNum);
	InquiryComment getComment(int inqNum);
	boolean modInquiry(Inquiry inquiry);
	Inquiry getCount(int userNum);
	
	List<Comment> getMyComments(Comment comment);
	int getMyCommentsCount(Comment comment);

	List<Booking> getMyBookings(Booking booking);
	int getMyBookingsCount(Booking booking);
}
