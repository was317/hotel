package limtaebaek.hotel.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.comment.dao.CommentDao;
import limtaebaek.hotel.comment.domain.Comment;

@Service
public class CommentServiceImpl implements CommentService{
	@Autowired private CommentDao commentDao;
	@Override
	public boolean join(Comment comment) {
		return commentDao.addComment(comment)>0;
	}
	@Override
	public List<Comment> getComments() {
		return commentDao.getComments();
	}
	@Override
	public Comment getReview(int revNum) {
		return commentDao.getReview(revNum);
	}
	@Override
	public boolean delReview(int revNum) {
		return commentDao.delReview(revNum)>0;
	}
	@Override
	public boolean updateReview(Comment comment) {
		return commentDao.updateReview(comment)>0;
	}
	
	
}
