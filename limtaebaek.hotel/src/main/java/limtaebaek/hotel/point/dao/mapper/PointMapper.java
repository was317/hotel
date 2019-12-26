package limtaebaek.hotel.point.dao.mapper;

import java.util.List;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.user.domain.User;

public interface PointMapper {
	List<Point> getMyPointList(Page page);
	int getMyPointSum(int userNum);
	int addPoint(Point point);
	int delPoint(Point point);
	int getMyPointCount(Point point);
}
