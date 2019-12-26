package limtaebaek.hotel.comment.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import limtaebaek.hotel.comment.domain.Comment;
import limtaebaek.hotel.comment.service.CommentService;
import limtaebaek.hotel.room.domain.Room;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Value("${comment_uploadDir}") private String uploadDir;
	@Autowired private CommentService commentService;
	
	
	@Transactional
	@RequestMapping("/commentAdd")
	public String commentAdd() {
		return "comment/add";
	}
	
	@Transactional
	@RequestMapping("/commentLookUp")
	public String commentLookUp(Model model) {
		model.addAttribute("commentList", commentService.getComments());
		System.out.println(commentService.getComments());
		return "comment/lookUp";
	}
	

	
	@Transactional
	@ResponseBody
	@RequestMapping("/addC")
	public boolean join(Comment comment) {
		return commentService.join(comment);
	}
	
	@RequestMapping("/commentView")
	public String commentView(@RequestParam("revNum") int revNum , Model model) throws Exception{
		//int roomNum = Integer.parseInt(request.getParameter("roomNum"));
	
		model.addAttribute("comment", commentService.getReview(revNum));

		 return "comment/view";
		 
	}
	@RequestMapping("/commentView2")
	public String commentView2(@RequestParam("revNum") int revNum , Model model) throws Exception{
		//int roomNum = Integer.parseInt(request.getParameter("roomNum"));
	
		model.addAttribute("comment", commentService.getReview(revNum));

		 return "comment/viewUpdate";
		 
	}


	//111111111111111
	
	@RequestMapping("/addImage")
	@ResponseBody
	public boolean upload(MultipartFile file, HttpServletRequest request){
		boolean isStored = true;
		String dir = request.getServletContext().getRealPath(uploadDir);
		System.out.println("dir: " + dir);
		String fileName = file.getOriginalFilename();
		System.out.println("fileName: " + fileName);
		try{
			save(dir + "/" + fileName, file);
		} catch (IOException e){
			isStored = false;
		}
		return isStored;
	}
	
	private void save(String fileFullName, MultipartFile uploadFile) throws IOException{
		uploadFile.transferTo(new File(fileFullName));
	}

	//111111111111111
	
	
	
	@Transactional
	@ResponseBody
	@RequestMapping("/delView")
	public boolean delView(int revNum){
	 return	commentService.delReview(revNum);
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping("/updateView")
	public boolean updateReview(Comment comment){
	 return commentService.updateReview(comment);
	}
}
