package limtaebaek.hotel.promotion.domain;

public class PromotionDetail {
	private int prodNum;
	private int proNum;
	private String prodTitle;
	private String location;
	private String prodPic;
	private String serviceHour;
	private String notice;
	private String prodContent;
	
	public int getProdNum() {
		return prodNum;
	}
	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}
	public String getProdTitle() {
		return prodTitle;
	}
	public void setProdTitle(String prodTitle) {
		this.prodTitle = prodTitle;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getProdPic() {
		return prodPic;
	}
	public void setProdPic(String prodPic) {
		this.prodPic = prodPic;
	}
	public String getServiceHour() {
		return serviceHour;
	}
	public void setServiceHour(String serviceHour) {
		this.serviceHour = serviceHour;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getProdContent() {
		return prodContent;
	}
	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}
	public int getProNum() {
		return proNum;
	}
	public void setProNum(int proNum) {
		this.proNum = proNum;
	}
	
	@Override
	public String toString() {
		return "PromotionDetail [prodNum=" + prodNum + ", proNum=" + proNum
				+ ", prodTitle=" + prodTitle + ", location=" + location
				+ ", prodPic=" + prodPic + ", serviceHour=" + serviceHour
				+ ", notice=" + notice + ", prodContent=" + prodContent + "]";
	}
}
