package limtaebaek.hotel.intro.domain;

public class Intro {
	private int introNum;
	private String introImg;
	public int getIntroNum() {
		return introNum;
	}
	public void setIntroNum(int introNum) {
		this.introNum = introNum;
	}
	public String getIntroImg() {
		return introImg;
	}
	public void setIntroImg(String introImg) {
		this.introImg = introImg;
	}
	@Override
	public String toString() {
		return String.format("Intro [introNum=%s, introImg=%s]", introNum,
				introImg);
	}
}
