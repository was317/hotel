package limtaebaek.hotel.room.domain;

public class Option {
	private int optNo;
	private String optName;
	private int roomNum;
	
	public int getOptNo() {
		return optNo;
	}
	public void setOptNo(int optNo) {
		this.optNo = optNo;
	}
	public String getOptName() {
		return optName;
	}
	public void setOptName(String optName) {
		this.optName = optName;
	}
	
	
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	@Override
	public String toString() {
		return String.format("option [optNo=%s, optName=%s, roomNum=%s]", optNo, optName, roomNum);

	}
	
	


}
