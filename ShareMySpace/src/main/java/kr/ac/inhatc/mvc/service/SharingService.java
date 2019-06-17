package kr.ac.inhatc.mvc.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.inhatc.mvc.dto.SharingDto;
import kr.ac.inhatc.mvc.mapper.SharingMapper;

@Service
public class SharingService {	
	@Autowired
	SharingMapper sharing;
	public List<?> addressList() throws Exception {
		return sharing.addressList();
	} //주소 목록 가져오기
	public List<?> roomtypeList() throws Exception {
		return sharing.roomtypeList();
	} //공간 유형 목록 가져오기
	
	/********************************************home, about us 페이지*************************************************/
	
	
	
	
	
	/********************************************sharing 공간 공유 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/
	public List<SharingDto> selectSharingList(HashMap<String,String> map) throws Exception {
		return sharing.selectSharingList(map);
	}
	public HashMap<String, String> selectSharingcontentOne(String no) throws Exception{
		return sharing.selectSharingcontentOne(no);
	}
	
	/*--------------POST---------------*/
	public String registSharingcontent(HashMap<String,String> map) throws Exception{
		sharing.registSharingcontent(map); //글을 등록시키고
		return sharing.getnewNO();//글의 번호를 가져온다
	}
	public boolean modifySharingcontent(HashMap<String,String> map) throws Exception{
		return sharing.modifySharingcontent(map);
	}
	
	/*--------------GET---------------*/
	public boolean deleteSharingcontent(String no) throws Exception{
		return sharing.deleteSharingcontent(no);
	}
	
	
	
	
	/********************************************review 공간 후기 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/
	public List<SharingDto> selectReviewList(HashMap<String,String> map) throws Exception {
		return sharing.selectReviewList(map);
	}
	public HashMap<String, String> selectReviewcontentOne(String no) throws Exception{
		return sharing.selectReviewcontentOne(no);
	}
	
	/*--------------POST---------------*/
	public String registReviewcontent(HashMap<String,String> map) throws Exception{
		sharing.registReviewcontent(map); //글을 등록시키고
		return sharing.getnewNO();//글의 번호를 가져온다
	}
	public boolean modifyReviewcontent(HashMap<String,String> map) throws Exception{
		return sharing.modifyReviewcontent(map);
	}
	
	/*--------------GET---------------*/
	public boolean deleteReviewcontent(String no) throws Exception{
		return sharing.deleteReviewcontent(no);
	}
	
	
	
	
	/********************************************help 문의 / 신고 게시판*************************************************/
	/*--------------사용자에게 보여주는 주소---------------*/
	public List<SharingDto> selectContactList(HashMap<String,String> map) throws Exception {
		return sharing.selectContactList(map);
	}
	public HashMap<String, String> selectContactcontentOne(String no) throws Exception{
		return sharing.selectContactcontentOne(no);
	}
	
	/*--------------POST---------------*/
	public String registContactcontent(HashMap<String,String> map) throws Exception{
		sharing.registContactcontent(map); //글을 등록시키고
		return sharing.getnewNO_contact();//글의 번호를 가져온다
	}
	public boolean modifyContactcontent(HashMap<String,String> map) throws Exception{
		return sharing.modifyContactcontent(map);
	}
	
	/*--------------GET---------------*/
	public boolean deleteContactcontent(String no) throws Exception{
		return sharing.deleteContactcontent(no);
	}
	public boolean statusContactcontent(String no) throws Exception{
		return sharing.statusContactcontent(no);
	}
}
