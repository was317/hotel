package limtaebaek.hotel.mypage.service;

import java.util.List;

import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;
import limtaebaek.hotel.user.domain.User;

public interface MyInquiryService {
	List<Inquiry> getInquirys(int userNum);
	Inquiry getInquiry(int inqNum, int userNum);
	InquiryComment getInquiryAnswer(int inqNum);
	boolean modInquiry(Inquiry inquiry);
	Inquiry getCount(int userNum);
}
