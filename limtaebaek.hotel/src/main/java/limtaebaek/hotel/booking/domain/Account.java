package limtaebaek.hotel.booking.domain;

public class Account {
	private int bookingNum;
	private String bank;
	private String account;

	public int getBookingNum() {
		return bookingNum;
	}
	public void setBookingNum(int bookingNum) {
		this.bookingNum = bookingNum;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	
	@Override
	public String toString() {
		return "Accounts [userNum=" + bookingNum + ", bank=" + bank + ", account=" + account + "]";
	}
}
