package limtaebaek.hotel.comment.domain;

import java.sql.Date;

import limtaebaek.hotel.user.domain.User;

public class Comment {
/*	-- 후기

-- 후기
CREATE TABLE "REVIEWS" (
	"REV_NUM"     NUMBER         NOT NULL, -- 후기번호
	"USER_NUM"    NUMBER         NULL,     -- 회원번호
	"REV_TITLE"   VARCHAR2(200)  NULL,     -- 후기제목
	"REV_CONTENT" VARCHAR2(4000) NULL,     -- 후기내용
	"ROOM_TYPE"   VARCHAR2(50)   NULL,     -- 방타입
	"RATE"        DATE           NULL,     -- 후기작성일
	"REV_DATE"    NUMBER         NULL,     -- 평점
	"REV_PIC"     VARCHAR2(255)  NULL,     -- 사진1
	"REV_PIC2"    VARCHAR2(255)  NULL,     -- 사진2
	"REV_PIC3"    VARCHAR2(255)  NULL      -- 사진3
);
	);*/
	
	private int revNum;
	private int userNum;
	private String revTitle;
	private String revContent;
	private String roomType;
	private Date revDate;
	private int rate;
	private String revImage1;
	private String revImage2;
	private String revImage3;
	private User user;
	
	public int getRevNum() {
		return revNum;
	}
	public void setRevNum(int revNum) {
		this.revNum = revNum;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public String getRevTitle() {
		return revTitle;
	}
	public void setRevTitle(String revTitle) {
		this.revTitle = revTitle;
	}
	public String getRevContent() {
		return revContent;
	}
	public void setRevContent(String revContent) {
		this.revContent = revContent;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	
	public Date getRevDate() {
		return revDate;
	}
	public void setRevDate(Date revDate) {
		this.revDate = revDate;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}

	public String getRevImage1() {
		return revImage1;
	}
	public void setRevImage1(String revImage1) {
		this.revImage1 = revImage1;
	}
	public String getRevImage2() {
		return revImage2;
	}
	public void setRevImage2(String revImage2) {
		this.revImage2 = revImage2;
	}
	public String getRevImage3() {
		return revImage3;
	}
	public void setRevImage3(String revImage3) {
		this.revImage3 = revImage3;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Override
	public String toString() {
		return String
				.format("Comment [revNum=%s, userNum=%s, revTitle=%s, revContent=%s, roomType=%s, revDate=%s, rate=%s, revImage1=%s, revImage2=%s, revImage3=%s, user=%s]",
						revNum, userNum, revTitle, revContent, roomType,
						revDate, rate, revImage1, revImage2, revImage3, user);
	}
	
	
	
}
