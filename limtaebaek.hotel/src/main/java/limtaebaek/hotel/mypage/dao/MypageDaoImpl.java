package limtaebaek.hotel.mypage.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.mypage.dao.mapper.MypageMapper;
import limtaebaek.hotel.user.domain.User;

@Repository
public class MypageDaoImpl implements MypageDao{
	@Autowired private MypageMapper mapper = null;

	@Override
	public List<Inquiry> getInquirys(int userNum) {
		return mapper.getInquirys(userNum);
	}

	@Override
	public Inquiry getInquiry(int inqNum, int userNum) {
		return mapper.getInquiry(inqNum, userNum);
	}

	@Override
	public InquiryComment getComment(int inqNum) {
		return mapper.getComment(inqNum);
	}

	@Override
	public boolean modInquiry(Inquiry inquiry) {
		return mapper.modInquiry(inquiry);
	}

	@Override
	public Inquiry getCount(int userNum) {
		return mapper.getCount(userNum);
	}

	

	@Override
	public List<Comment> getMyComments(Comment comment) {
		return mapper.getMyComments(comment);
	}
	
	@Override
	public int getMyCommentsCount(Comment comment) {
		return mapper.getMyCommentsCount(comment);
	}

	@Override
	public List<Booking> getMyBookings(Booking booking) {
		return mapper.getMyBookings(booking);
	}

	@Override
	public int getMyBookingsCount(Booking booking) {
		return mapper.getMyBookingsCount(booking);
	}




}
