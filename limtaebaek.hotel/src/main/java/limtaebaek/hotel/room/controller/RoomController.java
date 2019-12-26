package limtaebaek.hotel.room.controller;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;
import limtaebaek.hotel.room.service.RoomService;

@Controller
@RequestMapping("/room")
public class RoomController {
	@Value("${room_uploadDir}") private String uploadDir;
	@Autowired private RoomService roomService;
	

   @Transactional
   @ResponseBody
   @RequestMapping("/roomList")
   public List<Room> roomList() {
      return roomService.getRooms();
   }
	
	@Transactional
	@RequestMapping("/roomManager")
	public String roomManager(Model model) {
	  model.addAttribute("roomList", roomService.getRooms());   
		return "room/manager";
	}
	@Transactional
	@RequestMapping("/roomReservation")
	public String roomReservation(Model model) {
	  model.addAttribute("roomList", roomService.getRooms());   
		return "room/reservation";
	}
	
/*	@Transactional
	@RequestMapping("/roomData")
	public String roomData(Model model){
		model.addAttribute("roomdata", roomService.getRoom(roomNum));
	}
	*/
/*	@RequestMapping("/myInquiry")
	public String myInquiry(Model model, HttpServletRequest request) throws Exception {
		int inqNum = Integer.parseInt(request.getParameter("inqNumber"));
		model.addAttribute("inq", myInqService.getInquiry(inqNum));
		return "mypage/myInq";
	}*/

	@RequestMapping("/roomData")
	public String roomData(@RequestParam("roomNum") int roomNum , Model model) throws Exception{
		//int roomNum = Integer.parseInt(request.getParameter("roomNum"));
		model.addAttribute("room", roomService.getRoom(roomNum));
		System.out.println(model);
		 return "room/data";
	}

	@RequestMapping("/getData")
	@ResponseBody
	@Transactional
	public Room getData(Model model, Room room) {
		Room roomDate = roomService.getRoom(room.getRoomNum());
		roomDate.setOption(roomService.getOption(roomDate));
		return roomDate;
	}
	

	
	@Transactional
	@RequestMapping("/roomAdd")
	public String roomAdd() {
		return "room/add";
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping("/add")
	public boolean join(Room room , HttpServletRequest request) {
	
		String optNoReq =  request.getParameter("optNo");
		List<String> optNo = new ArrayList<String>();
		
		for(String option:optNoReq.split("&")){
			optNo.add(option.replace("option=", ""));
		}
		
		 List<Option> options = new ArrayList<Option>();
		 for(int i = 0; i< optNo.size(); i++){
		 Option option = new Option();
		 option.setOptNo(Integer.parseInt(optNo.get(i)));
		
		 options.add(option);}
	
		return roomService.join(room,  options);
	}
	
	//111111111111111
	
	@RequestMapping("/addImage")
	@ResponseBody
	public boolean upload(MultipartFile file, HttpServletRequest request){
		boolean isStored = true;
		String dir = request.getServletContext().getRealPath(uploadDir);
		System.out.println("dir: " + dir);
		String fileName = file.getOriginalFilename();
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
	@RequestMapping("/delete")
	public  boolean delRoom(int roomNum) {
			roomService.delRoom(roomNum);
			return true;
		 
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping("/updateRoom")
	public  boolean updateRoom(Room room) {
			System.out.println(room);
			System.out.println(room);
			System.out.println(room);
			return  roomService.updateRoom(room);
			
		 
	}
	
	
	
	

}
