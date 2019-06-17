package kr.ac.inhatc.mvc.controller;

import java.util.HashMap;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController; 
import org.springframework.web.servlet.ModelAndView;

import kr.ac.inhatc.mvc.service.SharingService;
import kr.ac.inhatc.mvc.service.LoginService;

@RestController
@RequestMapping("/ShareMySpace/*")
public class LoginController {
	@Autowired
	SharingService SharingService;
	
	@Autowired
	LoginService LoginService;

	/*-----------------------------------------사용자에게 보여주는 주소-----------------------------------------*/
	
	@RequestMapping("/login_signup")
	public ModelAndView login() throws Exception {
		ModelAndView mv = new ModelAndView();
		if(LoginService.login_check()) { return mypage(LoginService.id_check()); }
		mv.addObject("logincheck", LoginService.login_check());
		mv.setViewName("login_signup");
		return mv; 
	} //로그인 및 회원가입 페이지
	
	@RequestMapping("/login/forgot")
	public ModelAndView forgot()  throws Exception{
		ModelAndView mv = new ModelAndView();
		if(LoginService.login_check()) {
			return mypage(LoginService.id_check());
		} //로그인을 했는데, 혹시 url로 들어올 경우 대비
		mv.setViewName("forgot");
		return mv; 
	} //아이디 및 비밀번호 찾는 페이지
	
	@RequestMapping("/mypage")
	public ModelAndView mypage(String id)  throws Exception{
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) {
			return login(); //로그인을 안했는데 url로 들어올 경우 대비
		}else if(!id.equals(LoginService.id_check().toString())) {
			return mypage(LoginService.id_check().toString());
		} //로그인한 아이디가 아닌 url로 다른 아이디의 마이페이지를 들어가려하는 것을 방지
		
		mv.addObject("user", LoginService.selectmember(id));
		//로그인한 회원의 모든 가입 정보를 가져옴
		mv.setViewName("mypage");
		return mv; 
	}//로그인한 회원의 마이페이지
	
	
	
	
	
	/*-----------------------------------------중복검사 GET mapping--------------------------------------------------*/
	
	@RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
	public int idCheck(@RequestParam("userId") String user_id) throws Exception {
		return LoginService.getidover(user_id);
	} //아이디 중복 검사 (id가 있는 수를 받음) 
	@RequestMapping(value = "/user/emailCheck", method = RequestMethod.GET)
	public int emailCheck(@RequestParam("useremail") String user_email) throws Exception {
		return LoginService.getemailover(user_email);
	} //이메일 중복 검사 (email이 있는 수를 받음) 
	@RequestMapping(value = "/user/phoneCheck", method = RequestMethod.GET)
	public int phoneCheck(@RequestParam("userphone") String user_phone) throws Exception {
		return LoginService.getphoneover(user_phone);
	} //전화번호 중복 검사 (phone이 있는 수를 받음)

	
	
	

	/*-----------------------------------------나머지 GET mapping-------------------------------------------------*/
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public boolean logout() throws Exception {
		return LoginService.logout();
	}//로그아웃
	@RequestMapping(value = "/mypage/withdrawl", method = RequestMethod.GET)
	public boolean withdrawl(String id)  throws Exception{
		if(!LoginService.login_check()) {
			return false;
		}else if(!id.equals(LoginService.id_check().toString())) {
			return false;
		}
		LoginService.withdrawl(id);
		return true; 
	}//회원탈퇴

	
	
	

	/*-----------------------------------------POST mapping---------------------------------------------------------*/
	
	 @RequestMapping("/signup.do") 
	 public boolean signup(@RequestBody HashMap<String, String> hashMap) throws Exception{
		 LoginService.signup(hashMap); return true;
	 }//회원가입	
	 @RequestMapping("/login.do") 
	 public int logindo(@RequestBody HashMap<String, String> hashMap) throws Exception{
		 return LoginService.logindo(hashMap);
	 }//로그인
	@RequestMapping("/mypage.modify")
	public boolean mymodify(@RequestBody HashMap<String, String> hashMap)  throws Exception{
		LoginService.updateinfo(hashMap);
		return true;
	}//회원 정보 수정
	@RequestMapping("/find.id")
	public String findid(@RequestBody HashMap<String, String> hashMap)  throws Exception{
		return LoginService.findid(hashMap);
	}//회원 아이디찾기 (이메일, 전화번호가 일치하는 회원의 아이디를 찾음)
	@RequestMapping("/find.pw")
	public String findpw(@RequestBody HashMap<String, String> hashMap)  throws Exception{
		return LoginService.findpw(hashMap);
	}//회원 비밀번호찾기 (아이디, 이메일, 전화번호가 일치하는 회원의 비밀번호를 찾음)
}
