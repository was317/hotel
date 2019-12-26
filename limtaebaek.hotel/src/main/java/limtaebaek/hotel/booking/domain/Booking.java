package limtaebaek.hotel.booking.domain;

import java.sql.Date;
import java.util.List;

import limtaebaek.hotel.room.domain.Option;
public class Booking {
	private int bookingNum;
	private int userNum;
	private String userName;
	private int roomNum;
	private String roomType;
	private List<Option> roomOption;
	private Date checkIn;
	private Date checkOut;
	private int payment;
	private int adult;
	private int kid;
	private String paytype;
	private String nuserKname;
	private int bookingPoint;
	
	public int getBookingPoint() {
		return bookingPoint;
	}
	public void setBookingPoint(int bookingPoint) {
		this.bookingPoint = bookingPoint;
	}
	public String getNuserKname() {
		return nuserKname;
	}
	public void setNuserKname(String nuserKname) {
		this.nuserKname = nuserKname;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public List<Option> getRoomOption() {
		return roomOption;
	}
	public void setRoomOption(List<Option> list) {
		this.roomOption = list;
	}
	public int getBookingNum() {
		return bookingNum;
	}
	public void setBookingNum(int bookingNum) {
		this.bookingNum = bookingNum;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public Date getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}
	public Date getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getKid() {
		return kid;
	}
	public void setKid(int kid) {
		this.kid = kid;
	}
	
	@Override
	public String toString() {
		return "Booking [bookingNum=" + bookingNum + ", userNum=" + userNum + ", userName=" + userName + ", roomNum="
				+ roomNum + ", roomType=" + roomType + ", roomOption=" + roomOption + ", checkIn=" + checkIn
				+ ", checkOut=" + checkOut + ", payment=" + payment + ", adult=" + adult + ", kid=" + kid + ", paytype="
				+ paytype + ", nuserKname=" + nuserKname + ", bookingPoint=" + bookingPoint + "]";
	}
}
