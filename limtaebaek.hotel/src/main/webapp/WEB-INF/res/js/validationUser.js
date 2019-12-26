var regUserKorName 			= /[가-힣ㄱ-ㅎ]{2,5}/;
var regUserEngFirst 		= /[a-zA-Z]{2,20}/;
var regUserEngLast 			= /[a-zA-Z]{2,10}/;
var regUserPhoneNumSecond 	= /[0-9]{3,4}/;
var regUserPhoneNumThird 	= /[0-9]{4}/;
var regUserCallNumSecond 	= /[0-9]{3,4}/;
var regUserCallNumThird 	= /[0-9]{4}/;
var regUserEmailDomain 		= /(?=.*[a-z])\.(?=.*[a-z])/;
var regUserPw 				= /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z!@#$%^&+=]).*$/;

var msgUserKorName 			= "이름[국문]은 2~5글자의 한글로만 작성해 주세요.";
var msgUserEngFirst 		= "이름[영문] 이름은 2~20글자의 영어로만 작성해 주세요.";
var msgUserEngLast 			= "이름[영문] 성은 2~10글자의 영어로만 작성해 주세요.";
var msgUserPhoneNumSecond 	= "핸드폰 번호의 가운데 숫자는 3~4글자의 숫자로만 작성해 주세요.";
var msgUserPhoneNumThird 	= "핸드폰 번호의 끝 숫자는 4글자의 숫자로만 작성해 주세요.";
var msgUserCallNumSecond 	= "자택 전화번호의 가운데 숫자는 3~4글자의 숫자로만 작성해 주세요.";
var msgUserCallNumThird 	= "자택 전화번호의 끝 숫자는 4글자의 숫자로만 작성해 주세요.";
var msgUserEmailDomain 		= "도메인은 영어와 사이 '.'으로만 작성해주세요.";
var msgUserPw 				= "비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.";