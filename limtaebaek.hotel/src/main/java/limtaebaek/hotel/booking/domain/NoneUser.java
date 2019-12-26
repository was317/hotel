package limtaebaek.hotel.booking.domain;

public class NoneUser {
	private int nuserNum;
	private String nuserEmail;
	private String nuserKname;
	private String nuserLastName;
	private String nuserFirstName;
	private String nuserBirth;
	private String nuserPhone;
	private int bookingNum;
	
	public int getBookingNum() {
		return bookingNum;
	}
	public void setBookingNum(int bookingNum) {
		this.bookingNum = bookingNum;
	}
	public int getNuserNum() {
		return nuserNum;
	}
	public void setNuserNum(int nuserNum) {
		this.nuserNum = nuserNum;
	}
	public String getNuserEmail() {
		return nuserEmail;
	}
	public void setNuserEmail(String nuserEmail) {
		this.nuserEmail = nuserEmail;
	}
	public String getNuserKname() {
		return nuserKname;
	}
	public void setNuserKname(String nuserKname) {
		this.nuserKname = nuserKname;
	}
	public String getNuserLastName() {
		return nuserLastName;
	}
	public void setNuserLastName(String nuserLastName) {
		this.nuserLastName = nuserLastName;
	}
	public String getNuserFirstName() {
		return nuserFirstName;
	}
	public void setNuserFirstName(String nuserFirstName) {
		this.nuserFirstName = nuserFirstName;
	}
	public String getNuserBirth() {
		return nuserBirth;
	}
	public void setNuserBirth(String nuserBirth) {
		this.nuserBirth = nuserBirth;
	}
	public String getNuserPhone() {
		return nuserPhone;
	}
	public void setNuserPhone(String nuserPhone) {
		this.nuserPhone = nuserPhone;
	}
	
	@Override
	public String toString() {
		return "NoneUsers [nuserNum=" + nuserNum + ", nuserEmail=" + nuserEmail + ", nuserKname=" + nuserKname
				+ ", nuserLastName=" + nuserLastName + ", nuserFirstName=" + nuserFirstName + ", nuserBirth="
				+ nuserBirth + ", nuserPhone=" + nuserPhone + ", bookingNum=" + bookingNum + "]";
	}
}
