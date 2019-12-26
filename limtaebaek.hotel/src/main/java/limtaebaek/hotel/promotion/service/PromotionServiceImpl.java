package limtaebaek.hotel.promotion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import limtaebaek.hotel.promotion.dao.PromotionDao;
import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.PromotionDetail;
import limtaebaek.hotel.promotion.domain.Search;

@Service
public class PromotionServiceImpl implements PromotionService{
	@Autowired private PromotionDao promotionDao;
	
	@Override
	@Transactional
	public List<Promotion> listPros(Search search) {
		return promotionDao.getPros(search);
	}

	@Override
	@Transactional
	public Promotion listPro(int proNum) {
		return promotionDao.getPro(proNum);
	}

	@Override
	@Transactional
	public List<Promotion> listBoardPros(Search search) {
		return promotionDao.getBoardPros(search);
	}

	@Override
	@Transactional
	public boolean addPromotion(Promotion promotion, List<PromotionDetail> prods) {
		int length = 1 + prods.size();
		int a = promotionDao.addpro(promotion);
		int cnt = 0;
		
		for(PromotionDetail prod:prods){
			cnt += promotionDao.addprod(prod);
		}
		
		return (a + cnt) > (length - 1);
	}
	
	@Override
	@Transactional
	public boolean modPromotion(Promotion promotion, List<PromotionDetail> prods) {
		int length = 1 + prods.size();
		int a = promotionDao.updatePro(promotion);
		int cnt = 0;
		
		for(PromotionDetail prod:prods){
			cnt += promotionDao.updateProd(prod);
		}
		
		return (a + cnt) > (length - 1);
	}

	@Override
	@Transactional
	public boolean delPromotion(int proNum) {
		return promotionDao.delPro(proNum) > 0;
	}

}
