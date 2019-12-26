package limtaebaek.hotel.mypage.service;

import java.util.List;

import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.user.domain.User;

public interface MyCommentService {
	List<Comment> getMyComments(Comment comment);
	int getMyCommentsCount(Comment comment);
}
