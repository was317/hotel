package limtaebaek.hotel.inquiry.domain;

import java.sql.Date;

public class Inquiry {	
	private int inqNum;
	private String inqTitle;
	private String inqContent;
	private Date inqDate;
	private String inqWriter;
	private String inqEmail;
	private String inqPhone;
	private String status;
	private String userNum;
	private int count;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getInqNum() {
		return inqNum;
	}
	public void setInqNum(int inqNum) {
		this.inqNum = inqNum;
	}
	public String getInqTitle() {
		return inqTitle;
	}
	public void setInqTitle(String inqTitle) {
		this.inqTitle = inqTitle;
	}
	public String getInqContent() {
		return inqContent;
	}
	public void setInqContent(String inqContent) {
		this.inqContent = inqContent;
	}
	public Date getInqDate() {
		return inqDate;
	}
	public void setInqDate(Date inqDate) {
		this.inqDate = inqDate;
	}
	public String getInqWriter() {
		return inqWriter;
	}
	public void setInqWriter(String inqWriter) {
		this.inqWriter = inqWriter;
	}
	public String getInqEmail() {
		return inqEmail;
	}
	public void setInqEmail(String inqEmail) {
		this.inqEmail = inqEmail;
	}
	public String getInqPhone() {
		return inqPhone;
	}
	public void setInqPhone(String inqPhone) {
		this.inqPhone = inqPhone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	
	@Override
	public String toString() {
		return "Inquiry [inqNum=" + inqNum + ", inqTitle=" + inqTitle
				+ ", inqContent=" + inqContent + ", inqDate=" + inqDate
				+ ", inqWriter=" + inqWriter + ", inqEmail=" + inqEmail
				+ ", inqPhone=" + inqPhone + ", status=" + status
				+ ", userNum=" + userNum + "]";
	}
}
