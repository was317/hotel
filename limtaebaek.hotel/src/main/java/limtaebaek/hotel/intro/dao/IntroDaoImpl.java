package limtaebaek.hotel.intro.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.intro.dao.mapper.IntroMapper;
import limtaebaek.hotel.intro.domain.Intro;

@Repository
public class IntroDaoImpl implements IntroDao{
	@Autowired private IntroMapper mapper = null;

	@Override
	public Intro getIntroImg() {
		return mapper.getIntroImg();
	}

	@Override
	public int addIntroImg(Intro intro) {
		return mapper.addIntroImg(intro);
	}
}
