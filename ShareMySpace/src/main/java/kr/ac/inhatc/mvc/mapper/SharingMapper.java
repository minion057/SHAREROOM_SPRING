package kr.ac.inhatc.mvc.mapper;

import java.util.HashMap;
import java.util.List;

import kr.ac.inhatc.mvc.dto.SharingDto;

public interface SharingMapper {
	public List<?> addressList() throws Exception ;
	public List<?> roomtypeList() throws Exception;
	public String getnewNO();
	

	/********************************************home, about us 페이지*************************************************/
	
	
	
	
	
	/********************************************sharing 공간 공유 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/
	List<SharingDto> selectSharingList(HashMap<String,String> map) throws Exception;
	public HashMap<String, String> selectSharingcontentOne(String no) throws Exception;

	/*--------------POST---------------*/
	public int registSharingcontent(HashMap<String,String> map) throws Exception;
	public boolean modifySharingcontent(HashMap<String,String> map) throws Exception;
	
	/*--------------GET---------------*/	
	public boolean deleteSharingcontent(String no) throws Exception;

	
	
	
	
	/********************************************review 공간 후기 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/
	List<SharingDto> selectReviewList(HashMap<String,String> map) throws Exception;
	public HashMap<String, String> selectReviewcontentOne(String no) throws Exception;

	/*--------------POST---------------*/
	public int registReviewcontent(HashMap<String,String> map) throws Exception;
	public boolean modifyReviewcontent(HashMap<String,String> map) throws Exception;
	
	/*--------------GET---------------*/	
	public boolean deleteReviewcontent(String no) throws Exception;
	
	
	
	
	/********************************************help 문의 / 신고 게시판*************************************************/
	public String getnewNO_contact();
	/*--------------사용자에게 보여주는 주소---------------*/
	List<SharingDto> selectContactList(HashMap<String,String> map) throws Exception;
	public HashMap<String, String> selectContactcontentOne(String no) throws Exception;

	/*--------------POST---------------*/
	public int registContactcontent(HashMap<String,String> map) throws Exception;
	public boolean modifyContactcontent(HashMap<String,String> map) throws Exception;
	
	/*--------------GET---------------*/	
	public boolean deleteContactcontent(String no) throws Exception;
	public boolean statusContactcontent(String no) throws Exception;
}
