package limtaebaek.hotel.user.domain;

import java.sql.Date;
import java.util.List;

import limtaebaek.hotel.point.domain.Point;

public class User {
	private int userNum;
	private String userEmail;
	private String userPassword;
	private String userName;
	private String userEngFirstName;
	private String userEngLastName;
	private Date userBirth;
	private String userPhone;
	private String userTel;
	private String userZip;
	private String userAdd;
	private String userAddDetail;
	private Date userRegDate;
	private int userGrade;
	private List<Point> myPoints;
	
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public Date getUserRegDate() {
		return userRegDate;
	}
	public void setUserRegDate(Date userRegDate) {
		this.userRegDate = userRegDate;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public int getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEngFirstName() {
		return userEngFirstName;
	}
	public void setUserEngFirstName(String userEngFirstName) {
		this.userEngFirstName = userEngFirstName;
	}
	public String getUserEngLastName() {
		return userEngLastName;
	}
	public void setUserEngLastName(String userEngLastName) {
		this.userEngLastName = userEngLastName;
	}
	public Date getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserZip() {
		return userZip;
	}
	public void setUserZip(String userZip) {
		this.userZip = userZip;
	}
	public String getUserAdd() {
		return userAdd;
	}
	public void setUserAdd(String userAdd) {
		this.userAdd = userAdd;
	}
	public String getUserAddDetail() {
		return userAddDetail;
	}
	public void setUserAddDetail(String userAddDetail) {
		this.userAddDetail = userAddDetail;
	}
	public List<Point> getMyPoints() {
		return myPoints;
	}
	public void setMyPoints(List<Point> myPoints) {
		this.myPoints = myPoints;
	}
	
	@Override
	public String toString() {
		return String
				.format("User [userNum=%s, userEmail=%s, userPassword=%s, userName=%s, userEngFirstName=%s, userEngLastName=%s, userBirth=%s, userPhone=%s, userTel=%s, userZip=%s, userAdd=%s, userAddDetail=%s, userRegDate=%s, userGrade=%s, myPoints=%s]",
						userNum, userEmail, userPassword, userName,
						userEngFirstName, userEngLastName, userBirth,
						userPhone, userTel, userZip, userAdd, userAddDetail,
						userRegDate, userGrade, myPoints);
	}
}
