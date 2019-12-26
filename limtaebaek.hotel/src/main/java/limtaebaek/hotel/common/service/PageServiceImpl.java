package limtaebaek.hotel.common.service;

import org.springframework.stereotype.Service;

import limtaebaek.hotel.common.domain.Page;

@Service
public class PageServiceImpl implements PageService{	
	private Page pageInfo = null;
	
	public PageServiceImpl() {
		this.pageInfo = new Page();
		this.pageInfo.setLimit(20);	//페이지에 나타날 row 수 설정
	}
	
	@Override
	public Page paging(int nowPage, int dataSize) {                                             
		if(nowPage < 1) nowPage=1;     
		int maxPage = (int)(
				(double) dataSize/this.pageInfo.getLimit() + 0.95);       
		int startPage = (((int)((double) nowPage/10 + 0.9 )) -1)*10 + 1;                        
		int endPage = startPage + 9;                                         
		if(endPage > maxPage) endPage=maxPage;                                                   
		if(nowPage >= endPage) nowPage=endPage;                                                                               
		  
		this.pageInfo.setNowPage(nowPage);
		this.pageInfo.setMaxPage(maxPage);
		this.pageInfo.setStartPage(startPage);
		this.pageInfo.setEndPage(endPage);
		
		return this.pageInfo;
	}
}

