package limtaebaek.hotel.inquiry.dao;

import java.util.List;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

public interface InquiryDao {
	Inquiry getInquiry(int inqNum);
	int addInquiry(Inquiry inquiry);
	List<Inquiry> getInquirys(Page page);
	int delInquiry(int inqNum);
	int addComment(InquiryComment comment);
	Inquiry getCount();
	int updateStatus(int inqNum);
	InquiryComment getInquiryAnswer(int inqNum);
	int countInquiry();
	int countInquiryToday();
	int countInquiryTodayNoComent();
}
