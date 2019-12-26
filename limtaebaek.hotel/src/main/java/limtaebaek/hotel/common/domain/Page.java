package limtaebaek.hotel.common.domain;

public class Page {
	private int limit; //페이지당 포함 수
	private int maxPage;	
	private int startPage; 
	private int endPage;	
	private int nowPage;	//현재 페이지 번호
	private Object searchType;
	
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public Object getSearchType() {
		return searchType;
	}
	public void setSearchType(Object searchType) {
		this.searchType = searchType;
	}
	@Override
	public String toString() {
		return String
				.format("Page [limit=%s, maxPage=%s, startPage=%s, endPage=%s, nowPage=%s, searchType=%s]",
						limit, maxPage, startPage, endPage, nowPage, searchType);
	}
}
