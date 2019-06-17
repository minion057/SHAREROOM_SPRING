<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Share My Space</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
    <link href="/resource/res/css/default.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resource/res/css/fonts.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resource/res/css/sharing_content.css" rel="stylesheet" type="text/css" media="all" />
    
    <!--[if IE 6]>
    <link href="default_ie6.css" rel="stylesheet" type="text/css" />
    <![endif]-->
	<script src="http://code.jquery.com/jquery-Latest.min.js"></script>	
	<script type="text/javaScript" language="javascript" defer="defer">

	function fn_mypage(id){
		document.listForm.action="/ShareMySpace/mypage?id="+id;
		document.listForm.submit();
	}
   
   
   //수정
   function fn_modify(no){
	   if(!${logincheck}) {
			alert("로그인하세요.");
			return;
	   }if('${user.id}'!=$('#regID').val()){
			alert("다른 사용자의 글을 수정할 수 없습니다.")
			return;
		   }
  		document.listForm.action = "/ShareMySpace/sharing/modify?no="+no;
  		document.listForm.submit();
   }
   
   //삭제
   function fn_delete(no){
		$.ajax({
			url : '/ShareMySpace/sharing/delete?no='+no,
			type : 'get',
			success : function(data) {				
				if('${user.id}' != "admin"){
					alert("${user.id}님 글 삭제완료. \n공간 공유 게시판 목록으로 돌아갑니다.");
					document.listForm.action = "/ShareMySpace/sharing";
				   	document.listForm.submit();
				}			
				alert("관리자가 ${user.id}회원 글 삭제완료. \n공유 게시판 목록으로 돌아갑니다.");
				document.listForm.action = "/ShareMySpace/sharing";
			   	document.listForm.submit();
			}, error : function() {
				console.log("실패");
			}, beforeSend: function(xhr){
				if(!${logincheck}) {
					alert("로그인하세요.");
					xhr.abort();
			    }else if('${user.id}'!=$('#regID').val()){
			    	if('${user.id}' != "admin"){
						alert("다른 사용자의 글을 삭제할 수 없습니다.")
						xhr.abort();
				    }
				}
			}
		});
   }function fn_location(){
		document.listForm.action = "/ShareMySpace/sharing?searchLocation="+$('#location').val();
		document.listForm.submit();
	}function fn_type(room, location){
		if(location!="no"){
			document.listForm.action = "/ShareMySpace/sharing?&searchType="+room+"&searchLocation="+location;
			document.listForm.submit();
		}else{
			document.listForm.action = "/ShareMySpace/sharing?searchType="+room;
			document.listForm.submit();
		}
	}
	</script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
<div id="header-wrapper">
	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
                    <h1>
                    	<c:choose>
			 				<c:when test="${logincheck}"><a href="javascript:fn_mypage('${user.id}')" class="icon icon-group"><span>My Page / Logout</span></a></c:when>
							<c:otherwise><a href="<c:url value='/ShareMySpace/login_signup' />" class="icon icon-group"><span>Login / Sign Up</span></a></c:otherwise>
						</c:choose></h1>
                </div>
			<div id="menu">
				<ul>
					<li><a href="<c:url value='/ShareMySpace/login' />" accesskey="1" title="">Homepage</a></li>
					<li class="current_page_item"><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
					<li><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
					<li><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
					<li><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div id="wrapper">
	<div id="page" class="container">
		<div id="content">
			<div id="banner"> <img src="/resource/res/img/logo_sharing.PNG" width="790" height="300" alt="" /> </div>
			<div id="board">
                <div id="tbox1">
                    
                    <ul class="list">
                        <li>
                            <ul>
                                <li>글제목</li>
                                <li><input id="content_title" class="content-title" type="text" value="${sharingdetail.title}" readonly="readonly"/></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>주소</li>
                                <li><input type="text" value="${sharingdetail.address}" readonly="readonly"/></li>
                                <li>공간 유형</li>
                                <li><input type="text" value="${sharingdetail.type}" readonly="readonly"/></li>
                                <li>예약 유형</li>
                                <li>
                                	<c:choose>
			 							<c:when test="${sharingdetail.reservation eq 'time'}">
											<input type="text" value="time 단위" readonly="readonly" />
										</c:when>
										<c:when test="${sharingdetail.reservation eq 'day'}">
											<input type="text" value="day 단위" readonly="readonly" />
										</c:when>
										<c:otherwise>
											<input type="text" value="time/day 단위" readonly="readonly" />
										</c:otherwise>
									</c:choose>
                                </li>
                            </ul>
                        </li>
						<li>
                            <ul>
                                <li>작성자</li>
                                <li><input id="regID" type="text" value="${sharingdetail.id}" readonly="readonly"/></li>
                                <li><c:choose>
			 							<c:when test="${sharingdetail.date eq sharingdetail.editdate}">작성 시각</c:when>
										<c:otherwise>수정 시각</c:otherwise>
								</c:choose></li>
                                <li><input type="text" value="${sharingdetail.editdate}" readonly="readonly"/></li>
                                <li>연락처</li>
                                <li><input type="text" value="${fn:substring(sharingdetail.phone,0,3)}-${fn:substring(sharingdetail.phone,3,7)}-${fn:substring(sharingdetail.phone,7,11)}" readonly="readonly" /></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>내용</li>
                                <li>
                                    <textarea cols="93" rows="20" wrap="soft" readonly="readonly">${sharingdetail.contents}</textarea>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="bt">
                        <a href="javascript:fn_modify(${sharingdetail.no})" class="icon icon-refresh button">수정</a>&nbsp;&nbsp;
                        <a href="javascript:fn_delete(${sharingdetail.no})" class="icon icon-trash button">삭제</a>

                    </div>
                </div>
				
			</div>
		</div>
		<div id="sidebar">
			<div class="box1">
                <div class="title">
                    <h2>Share My Space</h2>
                    <span class="byline">공간을 공유하다.</span>
                </div>
                <p>나만의 공간을, 내가 없는 시간에, 다른 사람들과 공유해보세요!</br></br>1. Location 클릭 : 위치 검색</br>
                2. Room Type 클릭 : 공간 유형 검색</br>3. 게시판 아래 검색창 : 제목 검색</br>1,2,3번 기능을 함께 사용하면 더 자세한 검색 가능</p>
				<a href="<c:url value='/ShareMySpace/aboutus' />" class="icon icon-ok button">Read More</a>
			</div>
			<div class="box2">
				<div class="title">
					<h2>Location</h2>
				</div>
                <select id="location" name="location" class="combo" onchange="javacript:fn_location()">
                	<option value="no" selected>선택 없음</option>
                	<c:forEach var="result" items="${addressList}" varStatus="status">
                    	<option value="${result.address}" <c:if test="${result.address eq searchLocation}">selected</c:if>><c:out value="${result.address}"/></option>
                    </c:forEach>
                </select>
			</div>
			<div class="box3">
				<div class="title">
                    <h2>Room Type</h2>
				</div>
                <ul class="list">
                	<c:forEach var="result" items="${roomtypeList}" varStatus="status">
                    	<li><a href="javascript:fn_type('${result.type}',$('#location').val())"><c:out value="${result.type}"/></a></li>
					</c:forEach>
                </ul>
			</div>
		</div>
	</div>
</div>
<div id="portfolio-wrapper">
	<div id="portfolio" class="container">
		<div class="title">
            <h2>Contact Us</h2>
		</div>
        <p class="description">Help center : (+82) 032 - 1111 - 1111 <br />E-mail : inhatc@gmail.com</p>
	</div>
</div>
<div id="copyright" class="container">
	<p>&copy; INHAROOM. All rights reserved.</p>
</div>
</form>
</body>
</html>
