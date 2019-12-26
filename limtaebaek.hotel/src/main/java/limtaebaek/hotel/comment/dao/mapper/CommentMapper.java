package limtaebaek.hotel.comment.dao.mapper;

import java.util.List;

import limtaebaek.hotel.comment.domain.Comment;


public interface CommentMapper {
	int addComment(Comment comment);
	List<Comment> getComments();
	Comment getReview(int revNum);
	int delReview(int revNum);
	int updateReview(Comment comment);
}
