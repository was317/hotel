package limtaebaek.hotel.intro.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import limtaebaek.hotel.intro.domain.Intro;
import limtaebaek.hotel.intro.service.IntroService;

@Controller
@RequestMapping("/intro")
public class IntroController {
	@Value("${intro_uploadDir}") private String uploadDir;
	@Autowired private IntroService introService;
	
	@RequestMapping("/")
	public String mainIntro(){		
		return "intro/intro";
	}
	
	@RequestMapping("/road")
	public String road(){		
		return "intro/road";
	}

	@RequestMapping("/introImgLoad")
	@ResponseBody
	@Transactional
	public Intro introImgLoad() {
		Intro intro = introService.getIntroImg();
		
		if(intro == null) return null;
		else return intro;
	}
	

	@RequestMapping("/addintroImgLoad")
	@ResponseBody
	@Transactional
	public boolean addintroImgLoad(MultipartFile file, HttpServletRequest request) {
		boolean result = false;
		
		String dir = request.getServletContext().getRealPath(uploadDir);
		String fileName = file.getOriginalFilename();
		
		try{
			save(dir + "/" + fileName, file);
			result = true;
		} catch (IOException e){
			result = false;
		}
		
		if(result == true){
			Intro intro = new Intro();
			intro.setIntroImg("intro/" + fileName);
			result = introService.addIntroImg(intro);
		}
		
		return result;
	}
	
	private void save(String fileFullName, MultipartFile uploadFile) throws IOException{
		uploadFile.transferTo(new File(fileFullName));
	}

}
