package limtaebaek.hotel.inquiry.domain;

public class InquiryComment {
	private int inqNum;
	private String inqCmtContent;
	private String inqCmtDate;
	
	public int getInqNum() {
		return inqNum;
	}
	public void setInqNum(int inqNum) {
		this.inqNum = inqNum;
	}
	public String getInqCmtContent() {
		return inqCmtContent;
	}
	public void setInqCmtContent(String inqCmtContent) {
		this.inqCmtContent = inqCmtContent;
	}
	public String getInqCmtDate() {
		return inqCmtDate;
	}
	public void setInqCmtDate(String inqCmtDate) {
		this.inqCmtDate = inqCmtDate;
	}
	
	@Override
	public String toString() {
		return "InquiryComment [inqNum=" + inqNum + ", inqCmtContent="
				+ inqCmtContent + ", inqCmtDate=" + inqCmtDate + "]";
	}
}
