package kr.ac.inhatc.mvc.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.ac.inhatc.mvc.mapper.LoginMapper;

@Service
public class LoginService {
	private boolean login = false; //로그인 여부
	private String login_id = ""; //로그인 한 아이디
	
	public boolean login_check() {
		return login; //로그인 여부를 알려줌 (false - 비회원 / true - 회원)
	}
	public String id_check() {
		return login_id; //로그인 한 아이디를 알려줌
	}
	
	@Autowired
	LoginMapper Login; //*Mapper.java와 연결 (얘는 *mapper.xml을 연결함)
	

	/*-----------------------------------------사용자에게 보여주는 주소-----------------------------------------*/
	
	public HashMap<String,String> selectmember(String id) throws Exception {
		return Login.selectmember(id);
	}//로그인한 회원의 마이페이지 (로그인한 회원의 모든 가입 정보를 넘김)
	
	
	
	
	
	/*-----------------------------------------중복검사 GET mapping--------------------------------------------------*/
	
	public int getidover(String id) throws Exception{
		return Login.getidover(id);
	}	 //아이디 중복 검사 (id가 있는 수를 반환) 
	public int getemailover(String email) throws Exception{
		return Login.getemailover(email);
	}	 //이메일 중복 검사 (email이 있는 수를 반환) 
	public int getphoneover(String phone) throws Exception{
		return Login.getphoneover(phone);
	}	 //전화번호 중복 검사 (phone이 있는 수를 반환)

	
	
	

	/*-----------------------------------------나머지 GET mapping-------------------------------------------------*/
	
	public int withdrawl(String id) throws Exception {
		login = false; //회원탈퇴를 하면 회원이 사라진다 >> 유지하고 있는 로그인을 풀어야 함
		login_id=""; //따라서 로그인 여부를 false로 로그인 한 아이디를 빈 문자열로 변경
		return Login.withdrawl(id);
	} //회원탈퇴
	public boolean logout() {
		//로그인 여부를 확인하는 변수가 있다 >> 굳이 Mapper.java를 안가도됨
		login = false; //로그인 여부를  안했음(false)로 변경
		login_id=""; //로그인 한 아이디도 빈문자열로 변경
		return true;
	} //로그아웃

	
	
	

	/*-----------------------------------------POST mapping---------------------------------------------------------*/
	
	public int logindo(HashMap<String,String> map) throws Exception{
		int result = Login.logindo(map);//
		if(result >= 1) {
			login = true;
			login_id=map.get("id");
		}return result;
	} //로그인
	public int updateinfo(HashMap<String,String> map) throws Exception{
		return Login.updateinfo(map);
	} //회원 정보 수정
	public int signup(HashMap<String,String> map) throws Exception{
		return Login.signup(map);
	} //회원가입	
	public String findid(HashMap<String, String> map) throws Exception {
		return Login.findid(map);
	}//아아디 찾기 (이메일, 전화번호가 일치하는 회원의 아이디를 찾음)
	public String findpw(HashMap<String, String> map) throws Exception {
		return Login.findpw(map);
	}//비밀번호 찾기 (아이디, 이메일, 전화번호가 일치하는 회원의 비밀번호를 찾음)
}
