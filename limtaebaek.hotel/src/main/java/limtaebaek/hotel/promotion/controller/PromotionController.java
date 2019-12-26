package limtaebaek.hotel.promotion.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
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

import limtaebaek.hotel.promotion.domain.Promotion;
import limtaebaek.hotel.promotion.domain.PromotionDetail;
import limtaebaek.hotel.promotion.domain.Search;
import limtaebaek.hotel.promotion.service.PromotionService;

@Controller
@RequestMapping("/promotion")
public class PromotionController {
	@Value("${promotion_uploadDir}") private String uploadDir;
	@Autowired private PromotionService promotionService;
	
	@Transactional
	@RequestMapping("/addPromotion")
	@ResponseBody
	public boolean addPromotion(Promotion promotion, HttpServletRequest request){
	    String[] prodTitle = request.getParameterValues("prodTitle");
	    String[] location = request.getParameterValues("location");
	    String[] serviceHour = request.getParameterValues("serviceHour");
	    String[] notice = request.getParameterValues("notice");
	    String[] prodPic = request.getParameterValues("prodPic");
	    String[] prodContent = request.getParameterValues("prodContent");
	    
	    List<PromotionDetail> prods = new ArrayList<PromotionDetail>();
	    
	    for(int i = 0; i < prodTitle.length; i++){
	    	PromotionDetail prod = new PromotionDetail();
	    	prod.setProdTitle(prodTitle[i]);
	    	prod.setLocation(location[i]);
	    	prod.setServiceHour(serviceHour[i]);
	    	prod.setNotice(notice[i]);
	    	prod.setProdPic(prodPic[i]);
	    	prod.setProdContent(prodContent[i]);
	    	
	    	prods.add(prod);
	    }
	    
		return promotionService.addPromotion(promotion, prods);
	}
	
	@Transactional
	@RequestMapping("/addImage")
	@ResponseBody
	public boolean upload(MultipartFile file, HttpServletRequest request){
		
		boolean isStored = true;
		String dir = request.getServletContext().getRealPath(uploadDir);
		System.out.println("dir: " + dir);
		String dir2 = request.getServletContext().getRealPath(uploadDir);
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
	
	@Transactional
	@RequestMapping("/addPro")
	public String addPro(){
		return "promotion/addPro";
	}
	
	@Transactional
	@RequestMapping("/modPromotion")
	@ResponseBody
	public boolean modPromotion(Promotion promotion, HttpServletRequest request){
		String[] prodTitle = request.getParameterValues("prodTitle");
	    String[] location = request.getParameterValues("location");
	    String[] serviceHour = request.getParameterValues("serviceHour");
	    String[] notice = request.getParameterValues("notice");
	    String[] prodContent = request.getParameterValues("prodContent");
	    
	    List<PromotionDetail> prods = new ArrayList<PromotionDetail>();
	    for(int i = 0; i < prodTitle.length; i++){
	    	PromotionDetail prod = new PromotionDetail();
	    	prod.setProdTitle(prodTitle[i]);
	    	prod.setLocation(location[i]);
	    	prod.setServiceHour(serviceHour[i]);
	    	prod.setNotice(notice[i]);
	    	prod.setProdContent(prodContent[i]);
	    	
	    	prods.add(prod);
	    }
	    
		return promotionService.modPromotion(promotion, prods);
	}
	
	@Transactional
	@RequestMapping("/modPro")
	public String modPro(Model model, @RequestParam("proNum") int proNum){
		model.addAttribute("modPro", promotionService.listPro(proNum));
		
		return "promotion/modPro";
	}
	
	@Transactional
	@RequestMapping(value="/boardProAdmin", method=RequestMethod.GET)
	public String boardProAdmin(Model model, 
			@RequestParam(required=false) String keyword,
			@RequestParam(required=false) Date schStartDate,
			@RequestParam(required=false) Date schEndDate) {
		Search search = new Search();
		search.setKeyword(keyword);
		search.setSchStartDate(schStartDate);
		search.setSchEndDate(schEndDate);
		
		model.addAttribute("pagination", search);
		model.addAttribute("listProsAdmin", promotionService.listBoardPros(search));
		
		return "promotion/boardProAdmin";
	}
	
	@Transactional
	@RequestMapping(value="/boardPro", method=RequestMethod.GET)
	public String boardPro(Model model,
			@RequestParam(required=false) String keyword,
			@RequestParam(required=false) Date schStartDate,
			@RequestParam(required=false) Date schEndDate){
		Search search = new Search();
		search.setKeyword(keyword);
		search.setSchStartDate(schStartDate);
		search.setSchEndDate(schEndDate);
		
		model.addAttribute("listPros", promotionService.listPros(search));

		return "promotion/boardPro";
	}
	
	@Transactional
	@RequestMapping(value="/detailPro", method=RequestMethod.GET)
	public String detailPro(Model model, @RequestParam("proNum") int proNum){
		model.addAttribute("listPro", promotionService.listPro(proNum));
		
		return "promotion/detailPro";
	}
	
	@Transactional
	@RequestMapping("/delPro")
	@ResponseBody
	public boolean delPromotion(int proNum){
		return promotionService.delPromotion(proNum);
	}
}