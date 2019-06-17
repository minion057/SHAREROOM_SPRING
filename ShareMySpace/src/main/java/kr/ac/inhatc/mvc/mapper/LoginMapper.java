package kr.ac.inhatc.mvc.mapper;

import java.util.HashMap;

public interface LoginMapper {

	/*-----------------------------------------사용자에게 보여주는 주소-----------------------------------------*/
	
	public HashMap<String,String> selectmember(String id) throws Exception; //로그인한 회원의 마이페이지 (로그인한 회원의 모든 가입 정보를 넘김)
	
	
	
	
	
	/*-----------------------------------------중복검사 GET mapping--------------------------------------------------*/
	
	public int getidover(String id) throws Exception; //아이디 중복 검사 (id가 있는 수를 반환) 
	public int getemailover(String email) throws Exception; //이메일 중복 검사 (email이 있는 수를 반환) 
	public int getphoneover(String phone) throws Exception; //전화번호 중복 검사 (phone이 있는 수를 반환)

	
	
	

	/*-----------------------------------------나머지 GET mapping-------------------------------------------------*/
	
	public int withdrawl(String id) throws Exception ; //회원탈퇴

	
	
	

	/*-----------------------------------------POST mapping---------------------------------------------------------*/
	
	public int logindo(HashMap<String,String> map) throws Exception; //로그인
	public int updateinfo(HashMap<String,String> map) throws Exception; //회원 정보 수정
	public int signup(HashMap<String,String> map) throws Exception; //회원가입	
	public String findid(HashMap<String, String> map) throws Exception; //아이디 찾기
	public String findpw(HashMap<String, String> map) throws Exception; //비밀번호 찾기
}
