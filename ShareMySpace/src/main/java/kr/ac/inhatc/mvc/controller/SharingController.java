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
public class SharingController {
	@Autowired
	SharingService SharingService;
	
	@Autowired
	LoginService LoginService;
	/********************************************home, about us 페이지*************************************************/

	/*--------------사용자에게 보여주는 주소---------------*/
	@RequestMapping("/home")
	public ModelAndView home()  throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		return mv; 
	} //메인 홈페이지
	
	@RequestMapping("/aboutus")
	public ModelAndView aboutus() throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("about_us");
		return mv; 
	}
	/********************************************home, about us 페이지*************************************************/
	

	/********************************************sharing 공간 공유 게시판*************************************************/

	/*--------------사용자에게 보여주는 주소---------------*/	
	@RequestMapping("/sharing")
	public ModelAndView sharing_board(@RequestParam(value="searchKeyword", required=false, defaultValue="") String searchKeyword,
										@RequestParam(value="searchLocation", required=false, defaultValue="") String searchLocation,
										@RequestParam(value="searchType", required=false, defaultValue="") String searchType) throws Exception {
		ModelAndView mv = new ModelAndView();
		searchKeyword= searchKeyword.split(",")[0];
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("searchKeyword", searchKeyword);
		hashMap.put("searchLocation", searchLocation);
		hashMap.put("searchType", searchType);
		mv.addObject("subjectList", SharingService.selectSharingList(hashMap));
		//searchKeyword를 제목 기준으로 공유 게시판에서 검색한 결과 (검색창에 입력을 안하면 seachKeyword의 디폴트값[""] 빈문자열이 검색되어, 공유 게시판 글에 해당하는 것을 가져온다)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("searchKeyword", searchKeyword);
		//검색어 (검색창에 유지시켜주기위함)
		mv.addObject("searchLocation", searchLocation);
		//검색어 (검색창에 유지시켜주기위함)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("sharing_board");
		return mv; 
	} //공유 게시판 페이지
	
	@RequestMapping("/sharing/content")
	public ModelAndView sharing_content(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sharingdetail", SharingService.selectSharingcontentOne(no));
		//글 상세 내용 (글작성자, 작성 날짜 or 수정날짜 등)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("sharing_content");
		return mv; 
	} //공유 게시판 글 페이지
	
	@RequestMapping("/sharing/regist")
	public ModelAndView sharing_regist() throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 등록을 못함)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("sharing_write");
		return mv; 
	} //공간 등록버튼 >> 공간 공유 게시판 글쓰기 페이지
	
	@RequestMapping("/sharing/modify")
	public ModelAndView sharing_modify(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 수정을 못함)
		mv.addObject("sharingdetail", SharingService.selectSharingcontentOne(no));
		//수정할 글 정보 (제목, 내용, 공간 타입 등)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("sharing_modify");
		return mv; 
	} //수정 버튼 >> 등록된 글 수정 페이지
	
	/*--------------POST---------------*/
	@RequestMapping("/sharing/regist.do")
	public String sharing_regist_do(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.registSharingcontent(hashMap);
		//글 등록시키고 글 번호가 넘어옴
	} //글 다쓰고 등록버튼 >> 글 내용을 db에 저장
	
	@RequestMapping("/sharing/modify.do")
	public boolean sharing_modifydo(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.modifySharingcontent(hashMap);
	} //글 수정 버튼 >> 글 내용을 db에서 변경
	
	
	/*--------------GET---------------*/
	@RequestMapping(value = "/sharing/delete", method = RequestMethod.GET)
	public boolean sharing_delete(String no) throws Exception {
		if(!LoginService.login_check()) {
			return false;
		}
		SharingService.deleteSharingcontent(no);
		return true; 
	}
	/********************************************sharing 공간 공유 게시판*************************************************/
	
	

	/********************************************review 공간 후기 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/	
	@RequestMapping("/review")
	public ModelAndView reivew_board(@RequestParam(value="searchKeyword", required=false, defaultValue="") String searchKeyword,
										@RequestParam(value="searchLocation", required=false, defaultValue="") String searchLocation,
										@RequestParam(value="searchType", required=false, defaultValue="") String searchType) throws Exception {
		ModelAndView mv = new ModelAndView();
		searchKeyword= searchKeyword.split(",")[0];
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("searchKeyword", searchKeyword);
		hashMap.put("searchLocation", searchLocation);
		hashMap.put("searchType", searchType);
		mv.addObject("subjectList", SharingService.selectReviewList(hashMap));
		//searchKeyword를 제목 기준으로 공유 게시판에서 검색한 결과 (검색창에 입력을 안하면 seachKeyword의 디폴트값[""] 빈문자열이 검색되어, 공유 게시판 글에 해당하는 것을 가져온다)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("searchKeyword", searchKeyword);
		//검색어 (검색창에 유지시켜주기위함)
		mv.addObject("searchLocation", searchLocation);
		//검색어 (검색창에 유지시켜주기위함)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("review_board");
		return mv; 
	} //공유 게시판 페이지
	
	@RequestMapping("/review/content")
	public ModelAndView reivew_content(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sharingdetail", SharingService.selectReviewcontentOne(no));
		//글 상세 내용 (글작성자, 작성 날짜 or 수정날짜 등)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("review_content");
		return mv; 
	} //공유 게시판 글 페이지
	
	@RequestMapping("/review/regist")
	public ModelAndView reivew_regist() throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 등록을 못함)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("review_write");
		return mv; 
	} //공간 등록버튼 >> 공간 공유 게시판 글쓰기 페이지
	
	@RequestMapping("/review/modify")
	public ModelAndView reivew_modify(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 수정을 못함)
		mv.addObject("sharingdetail", SharingService.selectReviewcontentOne(no));
		//수정할 글 정보 (제목, 내용, 공간 타입 등)
		mv.addObject("addressList", SharingService.addressList());
		//주소 리스트
		mv.addObject("roomtypeList", SharingService.roomtypeList());
		//공간 유형 리스트
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("review_modify");
		return mv; 
	} //수정 버튼 >> 등록된 글 수정 페이지
	
	/*--------------POST---------------*/
	@RequestMapping("/review/regist.do")
	public String reivew_regist_do(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.registReviewcontent(hashMap);
		//글 등록시키고 글 번호가 넘어옴
	} //글 다쓰고 등록버튼 >> 글 내용을 db에 저장
	
	@RequestMapping("/review/modify.do")
	public boolean reivew_modifydo(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.modifyReviewcontent(hashMap);
	} //글 수정 버튼 >> 글 내용을 db에서 변경
	
	
	/*--------------GET---------------*/
	@RequestMapping(value = "/review/delete", method = RequestMethod.GET)
	public boolean reivew_delete(String no) throws Exception {
		if(!LoginService.login_check()) {
			return false;
		}
		SharingService.deleteReviewcontent(no);
		return true; 
	}
	/********************************************review 공간 후기 게시판*************************************************/
	
	
	/********************************************help 문의 / 신고 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/	
	@RequestMapping("/help")
	public ModelAndView help(@RequestParam(value="searchKeyword", required=false, defaultValue="") String searchKeyword) throws Exception {
		ModelAndView mv = new ModelAndView();
		searchKeyword= searchKeyword.split(",")[0];
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("searchKeyword", searchKeyword);
		mv.addObject("subjectList", SharingService.selectContactList(hashMap));
		//searchKeyword를 제목 기준으로 문의 / 신고 게시판에서 검색한 결과 (검색창에 입력을 안하면 seachKeyword의 디폴트값[""] 빈문자열이 검색되어, 문의 / 신고 게시판 글에 해당하는 것을 가져온다)
		mv.addObject("searchKeyword", searchKeyword);
		//검색어 (검색창에 유지시켜주기위함)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("contact_board");
		return mv; 
	} //문의 / 신고 게시판 페이지
	
	@RequestMapping("/help/content")
	public ModelAndView contatc_content(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sharingdetail", SharingService.selectContactcontentOne(no));
		//글 상세 내용 (글작성자, 작성 날짜 or 수정날짜 등)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("contact_content");
		return mv; 
	} //문의 / 신고 게시판 글 페이지
	
	@RequestMapping("/help/regist")
	public ModelAndView contatc_regist() throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 등록을 못함)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 아이디도 넘겨준다
		mv.setViewName("contact_write");
		return mv; 
	} //공간 등록버튼 >> 공간 문의 / 신고 게시판 글쓰기 페이지
	
	@RequestMapping("/help/modify")
	public ModelAndView contatc_modify(String no) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(!LoginService.login_check()) { 
			mv.setViewName("login_signup"); 
			return mv; 
		} //혹시 url로 들어올 경우 대비 (로그인을 안 했으면 글 수정을 못함)
		mv.addObject("sharingdetail", SharingService.selectContactcontentOne(no));
		//수정할 글 정보 (제목, 내용, 공간 타입 등)
		mv.addObject("logincheck", LoginService.login_check());
		//로그인 여부 (로그인에 따라 상당 좌측에 'login/signup'이 보일지 'mypage/logout'이 보일지, 글을 등록할 수 있는지 없는지 등 여러가지를 결정함)
		if(LoginService.login_check()) mv.addObject("user", LoginService.selectmember(LoginService.id_check()));
		//로그인을 했다면 로그인 한 회원의 정보도 넘겨준다
		mv.setViewName("contact_modify");
		return mv; 
	} //수정 버튼 >> 등록된 글 수정 페이지
	
	/*--------------POST---------------*/
	@RequestMapping("/help/regist.do")
	public String contatc_regist_do(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.registContactcontent(hashMap);
		//글 등록시키고 글 번호가 넘어옴
	} //글 다쓰고 등록버튼 >> 글 내용을 db에 저장
	
	@RequestMapping("/help/modify.do")
	public boolean contatc_modifydo(@RequestBody HashMap<String, String> hashMap) throws Exception {
		return SharingService.modifyContactcontent(hashMap);
	} //글 수정 버튼 >> 글 내용을 db에서 변경
	
	
	/*--------------GET---------------*/
	@RequestMapping(value = "/help/delete", method = RequestMethod.GET)
	public boolean contatc_delete(String no) throws Exception {
		if(!LoginService.login_check()) {
			return false;
		}
		SharingService.deleteContactcontent(no);
		return true; 
	}
	@RequestMapping(value = "/help/status", method = RequestMethod.GET)
	public boolean contatc_status(String no) throws Exception {
		if(!LoginService.login_check()) {
			return false;
		}
		SharingService.statusContactcontent(no);
		return true; 
	}
	/********************************************help 문의 / 신고 게시판*************************************************/
}
