package limtaebaek.hotel.inquiry.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.inquiry.dao.mapper.InquiryMapper;
import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

@Repository
public class InquiryDaoImpl implements InquiryDao{
	@Autowired private InquiryMapper mapper = null;
	
	@Override
	public Inquiry getInquiry(int inqNum) {
		return mapper.getInquiry(inqNum);
	}

	@Override
	public int addInquiry(Inquiry inquiry) {
		return mapper.addInquiry(inquiry);
	}

	@Override
	public List<Inquiry> getInquirys() {
		return mapper.getInquirys();
	}

	@Override
	public int delInquiry(int inqNum) {
		return mapper.delInquiry(inqNum);
	}

	@Override
	public int addComment(InquiryComment comment) {
		return mapper.addComment(comment);
	}

	@Override
	public Inquiry getCount() {
		return mapper.getCount();
	}

	@Override
	public int updateStatus(int inqNum) {
		return mapper.updateStatus(inqNum);
	}

	@Override
	public InquiryComment getInquiryAnswer(int inqNum) {
		return mapper.getInquiryAnswer(inqNum);
	}

	@Override
	public int countInquiryToday() {
		return mapper.countInquiryToday();
	}

	@Override
	public int countInquiryTodayNoComent() {
		return mapper.countInquiryTodayNoComent();
	}
}
