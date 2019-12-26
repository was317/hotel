package limtaebaek.hotel.inquiry.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.inquiry.domain.Inquiry;
import limtaebaek.hotel.inquiry.domain.InquiryComment;

@Service
public class MailServiceImpl implements MailService{
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public void send(InquiryComment msg, Inquiry to) {
		String from ="SeoulHotel";
		String toMail = to.getInqEmail();
		String toName = to.getInqWriter();
		String title = "[서울호텔] "+ toName +"님이 작성하신 문의에 대한 답변입니다.";
		String content = "문의 제목: " + to.getInqTitle()
				+ "\n문의내용 :\n" + to.getInqContent()
				+ "\n\n작성일 :" + to.getInqDate()
				+ "\n-------------------------------------------------------------\n"
				+ msg.getInqCmtContent();
		System.out.println(content);
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from); // 보내는사람
			messageHelper.setTo(toMail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
