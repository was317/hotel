package limtaebaek.hotel.point.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import limtaebaek.hotel.common.domain.Page;
import limtaebaek.hotel.common.service.PageService;
import limtaebaek.hotel.point.domain.Point;
import limtaebaek.hotel.point.service.PointService;
import limtaebaek.hotel.user.domain.User;


@Controller
@RequestMapping("/point")
public class PointController {
	@Autowired private PointService pointService;
	@Autowired private PageService pageService;

	@RequestMapping("/getMyPointList")
	@ResponseBody
	@Transactional
	public HashMap<String, Object> getMyPointList(Point point, HttpServletRequest request) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		int dataSize = pointService.countPoints(point);
		int nowPage = 1;
		
		String paramNowPage = request.getParameter("page");
		if(!(paramNowPage.equals("null"))) nowPage = Integer.parseInt(paramNowPage);
		Page page = pageService.paging(nowPage, dataSize);
		page.setSearchType(point);
		System.out.println(page);
		result.put("pointList", pointService.getMyPointList(page));
		result.put("page", page);
		
		return result;
	}

	@RequestMapping("/getMyPointSum")
	@ResponseBody
	@Transactional
	public int getMyPointSum(int userNum) {
		return pointService.getMyPointSum(userNum);
	}
	
	@RequestMapping("/addPoint")
	@ResponseBody
	@Transactional
	public boolean addPoint(Point point) {
		return pointService.addPoint(point);
	}

	@RequestMapping("/resetPoint")
	@ResponseBody
	@Transactional
	public boolean resetPoint(Point point) {
		return pointService.resetPoint(point);
	}
}
