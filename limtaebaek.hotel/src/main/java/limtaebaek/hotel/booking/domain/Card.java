package limtaebaek.hotel.booking.domain;

import java.sql.Date;

public class Card {
	private int bookingNum;
	private String cardCom;
	private String cardNo;
	private String cardExp;
	private String installment;
	
	public int getBookingNum() {
		return bookingNum;
	}
	public void setBookingNum(int bookingNum) {
		this.bookingNum = bookingNum;
	}
	public String getCardCom() {
		return cardCom;
	}
	public void setCardCom(String cardCom) {
		this.cardCom = cardCom;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardExp() {
		return cardExp;
	}
	public void setCardExp(String cardExp) {
		this.cardExp = cardExp;
	}
	public String getInstallment() {
		return installment;
	}
	public void setInstallment(String installment) {
		this.installment = installment;
	}
	
	@Override
	public String toString() {
		return "Card [userNum=" + bookingNum + ", cardCom=" + cardCom + ", cardNo=" + cardNo + ", cardExp=" + cardExp
				+ ", installment=" + installment + "]";
	}
}
