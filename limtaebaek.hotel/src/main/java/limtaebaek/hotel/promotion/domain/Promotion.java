package limtaebaek.hotel.promotion.domain;

import java.sql.Date;
import java.util.List;

public class Promotion {
	private int proNum;
	private String proTitle;
	private String proContent;
	private Date proStartDate;
	private Date proEndDate;
	private String proDetail;
	private Date proRegDate;
	private List<PromotionDetail> promotionDetails;
	
	public int getProNum() {
		return proNum;
	}
	public void setProNum(int proNum) {
		this.proNum = proNum;
	}
	public String getProTitle() {
		return proTitle;
	}
	public void setProTitle(String proTitle) {
		this.proTitle = proTitle;
	}
	public String getProContent() {
		return proContent;
	}
	public void setProContent(String proContent) {
		this.proContent = proContent;
	}
	public Date getProStartDate() {
		return proStartDate;
	}
	public void setProStartDate(Date proStartDate) {
		this.proStartDate = proStartDate;
	}
	public Date getProEndDate() {
		return proEndDate;
	}
	public void setProEndDate(Date proEndDate) {
		this.proEndDate = proEndDate;
	}
	public String getProDetail() {
		return proDetail;
	}
	public void setProDetail(String proDetail) {
		this.proDetail = proDetail;
	}
	public Date getProRegDate() {
		return proRegDate;
	}
	public void setProRegDate(Date proRegDate) {
		this.proRegDate = proRegDate;
	}
	public List<PromotionDetail> getPromotionDetails() {
		return promotionDetails;
	}
	public void setPromotionDetails(List<PromotionDetail> promotionDetails) {
		this.promotionDetails = promotionDetails;
	}
	@Override
	public String toString() {
		return String
				.format("Promotion [proNum=%s, proTitle=%s, proContent=%s, proStartDate=%s, proEndDate=%s, proDetail=%s, proRegDate=%s, promotionDetails=%s]",
						proNum, proTitle, proContent, proStartDate, proEndDate,
						proDetail, proRegDate, promotionDetails);
	}
	
	
	
}
