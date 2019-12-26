package limtaebaek.hotel.promotion.domain;

import java.sql.Date;

public class Search {
	private Date schStartDate;
	private Date schEndDate;
	private String keyword;
	
	public Date getSchStartDate() {
		return schStartDate;
	}
	public void setSchStartDate(Date schStartDate) {
		this.schStartDate = schStartDate;
	}
	public Date getSchEndDate() {
		return schEndDate;
	}
	public void setSchEndDate(Date schEndDate) {
		this.schEndDate = schEndDate;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return String.format(
				"Search [schStartDate=%s, schEndDate=%s, keyword=%s]",
				schStartDate, schEndDate, keyword);
	}

}
