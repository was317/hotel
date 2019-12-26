package limtaebaek.hotel.promotion.service;

import java.util.List;

import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.PromotionDetail;
import limtaebaek.hotel.promotion.domain.Search;

public interface PromotionService {
	
	//프로모션 게시판 - 일반
	List<Promotion> listPros(Search search);
	
	//프로모션 상세보기 - 일반
	Promotion listPro(int proNum);
	
	//프로모션 게시판 - 관리자
	List<Promotion> listBoardPros(Search search);
	
	//프로모션 등록 - 관리자
	boolean addPromotion(Promotion promotion, List<PromotionDetail> prods);
	
	//프로모션 수정 - 관리자
	boolean modPromotion(Promotion promotion, List<PromotionDetail> prods);
	
	//프로모션 삭제 - 관리자
	boolean delPromotion(int proNum);
	
}
