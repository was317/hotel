
package limtaebaek.hotel.point.domain;

import java.sql.Date;

public class Point {
	private int pointNum;
	private Date pointDate;
	private int pointChange;
	private String pointContent;
	private int userNum;
	
	public int getPointNum() {
		return pointNum;
	}
	public void setPointNum(int pointNum) {
		this.pointNum = pointNum;
	}
	public Date getPointDate() {
		return pointDate;
	}
	public void setPointDate(Date pointDate) {
		this.pointDate = pointDate;
	}
	public int getPointChange() {
		return pointChange;
	}
	public void setPointChange(int pointChange) {
		this.pointChange = pointChange;
	}
	public String getPointContent() {
		return pointContent;
	}
	public void setPointContent(String pointContent) {
		this.pointContent = pointContent;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	@Override
	public String toString() {
		return String
				.format("Point [pointNum=%s, pointDate=%s, pointChange=%s, pointContent=%s, userNum=%s]",
						pointNum, pointDate, pointChange, pointContent, userNum);
	}
}
