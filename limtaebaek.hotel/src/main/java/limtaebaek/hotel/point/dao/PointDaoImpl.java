package limtaebaek.hotel.point.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.point.dao.mapper.PointMapper;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.user.domain.User;

@Repository
public class PointDaoImpl implements PointDao{
	@Autowired private PointMapper mapper = null;
	
	@Override
	public List<Point> getMyPointList(Page page) {
		return mapper.getMyPointList(page);
	}

	@Override
	public int getMyPointSum(int userNum) {
		return mapper.getMyPointSum(userNum);
	}
	
	@Override
	public int addPoint(Point point) {
		return mapper.addPoint(point);
	}

	@Override
	public int delPoint(Point point) {
		return mapper.delPoint(point);
	}

	@Override
	public int getMyPointCount(Point point) {
		return mapper.getMyPointCount(point);
	}

}
