package limtaebaek.hotel.promotion.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.promotion.dao.mapper.PromotionMapper;
import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.PromotionDetail;
import limtaebaek.hotel.promotion.domain.Search;

@Repository
public class PromotionDaoImpl implements PromotionDao{
	@Autowired private PromotionMapper mapper = null;

	@Override
	public List<Promotion> getPros(Search search) {
		return mapper.getPros(search);
	}
	
	@Override
	public int addpro(Promotion promotion) {
		return mapper.addPro(promotion);
	}

	@Override
	public int addprod(PromotionDetail prod) {
		return mapper.addProd(prod);
	}

	@Override
	public Promotion getPro(int proNum) {
		return mapper.getPro(proNum);
	}

	@Override
	public List<Promotion> getBoardPros(Search search) {
		return mapper.getBoardPros(search);
	}

	@Override
	public int updatePro(Promotion promotion) {
		return mapper.updatePro(promotion);
	}

	@Override
	public int updateProd(PromotionDetail prod) {
		return mapper.updateProd(prod);
	}

	@Override
	public int delPro(int proNum) {
		return mapper.delPro(proNum);
	}

}
