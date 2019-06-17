<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : Contour 
Description: A board, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130706

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Share My Space</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
    <link href="/resource/res/css/default.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resource/res/css/fonts.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resource/res/css/sharing_write.css" rel="stylesheet" type="text/css" media="all" />

    <!--[if IE 6]>
    <link href="default_ie6.css" rel="stylesheet" type="text/css" />
    <![endif]-->
	<script src="http://code.jquery.com/jquery-Latest.min.js"></script>	
	<script type="text/javaScript" language="javascript" defer="defer">
	function fn_reg(){
		var data = {};
		data["id"]= '${user.id}';
		data["title"]= $('#title').val();
		data["address"]= $('#address').val();
		data["type"]= $('#type').val();
		data["reservation"]= $('#reservation').val();
		data["contents"]= $('#contents').val();
		$.ajax({
			url : '/ShareMySpace/review/regist.do',
			type : 'post',
			data:JSON.stringify(data),
	        contentType : "application/json; charset=utf-8",
			success : function(adata) {	
				if(adata != ""){
			   		document.listForm.action = "/ShareMySpace/review/content?no="+adata;
			   		document.listForm.submit();
				} else{
					alert("등록시킨 글 번호가 넘어오질 못했습니다. \n 후기 게시판 목록으로 이동합니다.");
			   		document.listForm.action = "/ShareMySpace/review";
			   		document.listForm.submit();
				}
			}, error : function() {
				console.log("실패");
			}, beforeSend: function(xhr){
				if($('#title').val() == "" || $('#contents').val() == ""){
					alert("정보를 입력하세요");
					xhr.abort();
				}
			}
		});
	}
	function fn_mypage(id){
		document.listForm.action="/ShareMySpace/mypage?id="+id;
		document.listForm.submit();
	}function fn_location(){
		document.listForm.action = "/ShareMySpace/review?searchLocation="+$('#location').val();
		document.listForm.submit();
	}function fn_type(room, location){
		if(location!="no"){
			document.listForm.action = "/ShareMySpace/review?&searchType="+room+"&searchLocation="+location;
			document.listForm.submit();
		}else{
			document.listForm.action = "/ShareMySpace/review?searchType="+room;
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
				<h1><a href="javascript:fn_mypage('${user.id}')" class="icon icon-group"><span>My Page / Logout</span></a></h1>
                </div>
			
                <div id="menu">
                    <ul>
                        <li ><a href="<c:url value='/ShareMySpace/home' />" accesskey="1" title="">Homepage</a></li>
                        <li ><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
                        <li class="current_page_item"><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
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
			<div id="banner"> <img src="/resource/res/img/logo_review.PNG" width="790" height="300" alt="" /> </div>
			<div id="board">
                <div id="tbox1">
                    
                    <ul class="list">
                        <li>
                            <ul>
                                <li>글제목</li>
                                <li><input id="title" name="title" class="content-title" type="text" placeholder="등록할 글제목을 입력해주세요." maxlength="200"/></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>주소</li>
                                <li>
                                    <select id="address" name="address" class="combo">
                                        <c:forEach var="result" items="${addressList}" varStatus="status">
                    						<option value="${result.address}"><c:out value="${result.address}"/></option>
                    					</c:forEach>
                					</select>
                                    </select>
                                </li>
                                <li>공간 유형</li>
                                <li>
                                    <select id="type" name="type" class="combo">
                                        <c:forEach var="result" items="${roomtypeList}" varStatus="status">
                    						<option value="${result.type}"><c:out value="${result.type}"/></option>
										</c:forEach>
                                    </select>
                                </li>
                                <li>예약 유형</li>
                                <li>
                                    <select id="reservation" name="reservation" class="combo">
                                        <option value="time">time 단위</option>
                                        <option value="day">day 단위</option>
                                        <option value="all">time&day 단위</option>
                                    </select>
                                </li>
                            </ul>
                        </li>
						<li>
                            <ul>
                                <li>작성자</li>
                                <li><input id="id" name="id" type="text" value="${user.id}" readonly="readonly"/></li>
                                <li></li>
                                <li></li>
                                <li>연락처</li>
                                <li><input type="text" value="${fn:substring(user.phone,0,3)}-${fn:substring(user.phone,3,7)}-${fn:substring(user.phone,7,11)}" readonly="readonly" /></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>내용</li>
                                <li>
                                    <textarea id="contents" name="contents" cols="93" rows="20" wrap="soft" placeholder="등록할 글내용을 입력해주세요." maxlength="5000"></textarea>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="bt" >
                        <a href="javascript:fn_reg()" class="icon icon-file-alt button" >등록</a>
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
