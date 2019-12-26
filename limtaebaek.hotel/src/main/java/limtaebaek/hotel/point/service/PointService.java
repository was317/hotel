package limtaebaek.hotel.point.service;

import java.util.List;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.user.domain.User;

public interface PointService {
	List<Point> getMyPointList(Page page);
	int getMyPointSum(int userNum);
	boolean addPoint(Point point);
	boolean resetPoint(Point point);
	int countPoints(Point point);
}
