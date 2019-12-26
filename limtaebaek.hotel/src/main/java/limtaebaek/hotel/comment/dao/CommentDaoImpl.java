package limtaebaek.hotel.comment.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.comment.dao.mapper.CommentMapper;
import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.room.domain.Room;

@Repository
public class CommentDaoImpl implements CommentDao{
	@Autowired private CommentMapper mapper = null;
	
	@Override
	public int addComment(Comment comment) {
		return mapper.addComment(comment);
		
	}

	@Override
	public List<Comment> getComments() {
		return mapper.getComments();
	}



	@Override
	public Comment getReview(int revNum) {
		return mapper.getReview(revNum);
	}

	@Override
	public int delReview(int revNum) {
		return mapper.delReview(revNum);
	}

	@Override
	public int updateReview(Comment comment) {
		return mapper.updateReview(comment);
	}

}
