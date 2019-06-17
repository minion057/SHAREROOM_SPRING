<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Share My Space</title>
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans:600'>
    <link type="text/css" rel="stylesheet" href="/resource/res/css/default.css">
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="/resource/res/css/fonts.css" media="all" />
    <link type="text/css" rel="stylesheet" href="/resource/res/css/sharing_board.css">
    
    <!--[if IE 6]>
    <link href="default_ie6.css" rel="stylesheet" type="text/css" />
    <![endif]-->
	<script src="http://code.jquery.com/jquery-Latest.min.js"></script>	
	<script type="text/javaScript" language="javascript" defer="defer">
	function fn_mypage(id){
		document.listForm.action="/ShareMySpace/mypage?id="+id;
		document.listForm.submit();
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
<body >
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
                        <li ><a href="<c:url value='/ShareMySpace/home' />" accesskey="1" title="">Homepage</a></li>
                        <li ><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
                        <li><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
                        <li><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
                        <li class="current_page_item"><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div id="wrapper">
	<div id="page" class="container">
		<div id="content">
			<div id="banner"> <img src="/resource/res/img/about us.PNG" width="790" height="650" alt="" style="margin-top:150px"/> </div>
			
		</div>
		<div id="sidebar">
			<div class="box1">
                <div class="title">
                    <h2>Share My Space</h2>
                    <span class="byline">공간을 공유하다.</span>
                </div>
                <p>나만의 공간을, 내가 없는 시간에, 다른 사람들과 공유해보세요!</p>
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