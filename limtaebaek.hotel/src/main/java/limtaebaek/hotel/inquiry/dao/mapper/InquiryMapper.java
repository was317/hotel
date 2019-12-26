package limtaebaek.hotel.inquiry.dao.mapper;

import java.util.List;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

public interface InquiryMapper {
	Inquiry getInquiry(int inqNum);
	int addInquiry(Inquiry inquiry);
	List<Inquiry> getInquirys();
	int delInquiry(int inqNum);
	int addComment(InquiryComment comment);
	Inquiry getCount();
	int updateStatus(int inqNum);
	InquiryComment getInquiryAnswer(int inqNum);

	int countInquiryToday();
	int countInquiryTodayNoComent();
}
