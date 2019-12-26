package limtaebaek.hotel.promotion.dao.mapper;

import java.util.List;

import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.PromotionDetail;
import limtaebaek.hotel.promotion.domain.Search;

public interface PromotionMapper {

	//프로모션 게시판 - 일반
	List<Promotion> getPros(Search search);
	
	//프로모션 상세 보기 - 일반
	Promotion getPro(int proNum);
	
	//프로모션 게시판 - 관리자
	List<Promotion> getBoardPros(Search search);
	
	//프로모션 등록 - 관리자
	int addPro(Promotion promotion);
	int addProd(PromotionDetail prod);
	
	//프로모션 수정 - 관리자
	int updatePro(Promotion promotion);
	int updateProd(PromotionDetail prod);
	
	//프로모션 삭제 - 관리자
	int delPro(int proNum);
	
}
