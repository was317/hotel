package limtaebaek.hotel.intro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import limtaebaek.hotel.intro.dao.IntroDao;
import limtaebaek.hotel.intro.domain.Intro;

@Service
public class IntroServiceImpl implements IntroService{
	@Autowired private IntroDao introDao = null;

	@Override
	public Intro getIntroImg() {
		return introDao.getIntroImg();
	}

	@Override
	public boolean addIntroImg(Intro intro) {
		return introDao.addIntroImg(intro)>0;
	}
}
