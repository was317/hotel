package limtaebaek.hotel.inquiry.service;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

public interface MailService {
	void send(InquiryComment msg, Inquiry to);
}
