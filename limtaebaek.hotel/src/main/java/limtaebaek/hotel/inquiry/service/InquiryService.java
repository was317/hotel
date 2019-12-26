package limtaebaek.hotel.inquiry.service;

import java.util.List;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

public interface InquiryService {
	List<Inquiry> getInquirys();
	Inquiry getInquiry(int inqNum);
	boolean writeInquiry(Inquiry inquiry);
	boolean deleteInquiry(int inqNum);
	boolean writeComment(InquiryComment comment);
	Inquiry getCount();
	boolean changeStatus(int inqNum);
	InquiryComment getInquiryAnswer(int inqNum);

	int countInquiryToday();
	int countInquiryTodayNoComent();
}
