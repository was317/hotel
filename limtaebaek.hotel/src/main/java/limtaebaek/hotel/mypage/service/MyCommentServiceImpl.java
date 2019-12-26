package limtaebaek.hotel.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.mypage.dao.MypageDao;
import limtaebaek.hotel.user.domain.User;

@Service
public class MyCommentServiceImpl implements MyCommentService{
	@Autowired private MypageDao mypageDao;


	@Override
	public List<Comment> getMyComments(Comment comment) {
		return mypageDao.getMyComments(comment);
	}
	
	@Override
	public int getMyCommentsCount(Comment comment) {
		return mypageDao.getMyCommentsCount(comment);
	}
}
