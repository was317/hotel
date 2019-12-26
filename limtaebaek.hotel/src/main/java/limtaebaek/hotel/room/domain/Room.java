package limtaebaek.hotel.room.domain;

import java.sql.Date;
import java.util.List;


public class Room {
	private int roomNum;
	private String roomName;
	private int guests;
	private Date roomRegDate;
	private String roomContent;
	private String roomType;
	private int roomPrice;
	private String roomImage1;
	private String roomImage2;
	private String roomImage3;
	private List<Option> options;
	private String option;

	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public List<Option> getOptions() {
		return options;
	}
	public void setOptions(List<Option> options) {
		this.options = options;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getGuests() {
		return guests;
	}
	public void setGuests(int guests) {
		this.guests = guests;
	}
	public Date getRoomRegDate() {
		return roomRegDate;
	}
	public void setRoomRegDate(Date roomRegDate) {
		this.roomRegDate = roomRegDate;
	}
	public String getRoomContent() {
		return roomContent;
	}
	public void setRoomContent(String roomContent) {
		this.roomContent = roomContent;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	
	
	public String getRoomImage1() {
		return roomImage1;
	}
	public void setRoomImage1(String roomImage1) {
		this.roomImage1 = roomImage1;
	}
	public String getRoomImage2() {
		return roomImage2;
	}
	public void setRoomImage2(String roomImage2) {
		this.roomImage2 = roomImage2;
	}
	public String getRoomImage3() {
		return roomImage3;
	}
	public void setRoomImage3(String roomImage3) {
		this.roomImage3 = roomImage3;
	}
	@Override
	public String toString() {
		return "Room [roomNum=" + roomNum + ", roomName=" + roomName
				+ ", guests=" + guests + ", roomRegDate=" + roomRegDate
				+ ", roomContent=" + roomContent + ", roomType=" + roomType
				+ ", roomPrice=" + roomPrice + ", roomImage1=" + roomImage1
				+ ", roomImage2=" + roomImage2 + ", roomImage3=" + roomImage3
				+ ", options=" + options + ", option=" + option + "]";
	}
	
	
}
