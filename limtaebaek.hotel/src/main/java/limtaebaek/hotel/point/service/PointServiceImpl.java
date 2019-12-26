package limtaebaek.hotel.point.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.point.dao.PointDao;
import limtaebaek.hotel.point.dao.mapper.PointMapper;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.user.domain.User;

@Service
public class PointServiceImpl implements PointService{
	@Autowired private PointDao pointDao;
	
	@Override
	public List<Point> getMyPointList(Page page) {
		return pointDao.getMyPointList(page);
	}

	@Override
	public int getMyPointSum(int userNum) {
		return pointDao.getMyPointSum(userNum);
	}
	@Override
	public boolean addPoint(Point point) {
		return pointDao.addPoint(point)>0;
	}

	@Override
	public boolean resetPoint(Point point) {
		return pointDao.delPoint(point)>0;
	}

	@Override
	public int countPoints(Point point) {
		return pointDao.getMyPointCount(point);
	}
	
	

}
