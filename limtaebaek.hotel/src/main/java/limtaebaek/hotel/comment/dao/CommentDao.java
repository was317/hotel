
package limtaebaek.hotel.comment.dao;

import java.util.List;

import limtaebaek.hotel.comment.domain.Comment;



public interface CommentDao {
	int addComment(Comment comment);
	List<Comment> getComments();
	Comment getReview(int revNum);
	int delReview(int revNum);
	int updateReview(Comment comment);
}
