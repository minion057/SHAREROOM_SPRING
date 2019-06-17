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
	function fn_sharingsearch(searchKeyword) {
		if('${searchLocation}' != ""){
			if('${searchType}' != ""){
				document.listForm.action = "/ShareMySpace/sharing?searchKeyword="+searchKeyword+"&searchLocation=${searchLocation}&searchType=${searchType}";
				document.listForm.submit();
			}else{
				document.listForm.action = "/ShareMySpace/sharing?searchKeyword="+searchKeyword+"&searchLocation=${searchLocation}";
				document.listForm.submit();
			}
		}else{
			if('${searchType}' != ""){
				document.listForm.action = "/ShareMySpace/sharing?searchKeyword="+searchKeyword+"&searchType=${searchType}";
				document.listForm.submit();
			}else{
				document.listForm.action = "/ShareMySpace/sharing?searchKeyword="+searchKeyword;
				document.listForm.submit();
			}
		}
	}
	function fn_location(){
		if($('#location').val()!="no"){
			if('${searchType}' != ""){
				if('${searchKeyword}' != ""){
					document.listForm.action = "/ShareMySpace/sharing?searchLocation="+$('#location').val()+"&searchKeyword=${searchKeyword}&searchType=${searchType}";
					document.listForm.submit();
				}else{
					document.listForm.action = "/ShareMySpace/sharing?searchLocation="+$('#location').val()+"&searchType=${searchType}";
					document.listForm.submit();
				}
			}else{
				if('${searchKeyword}' != ""){
					document.listForm.action = "/ShareMySpace/sharing?searchLocation="+$('#location').val()+"&searchKeyword=${searchKeyword}";
					document.listForm.submit();
				}else{
					document.listForm.action = "/ShareMySpace/sharing?searchLocation="+$('#location').val();
					document.listForm.submit();
				}
			}
		}
	}function fn_type(room){
		if('${searchLocation}' != ""){
			if('${searchKeyword}' != ""){
				document.listForm.action = "/ShareMySpace/sharing?searchType="+room+"&searchKeyword=${searchKeyword}&searchLocation=${searchLocation}";
				document.listForm.submit();
			}else{
				document.listForm.action = "/ShareMySpace/sharing?searchType="+room+"&searchLocation=${searchLocation}";
				document.listForm.submit();
			}
		}else{
			if('${searchKeyword}' != ""){
				document.listForm.action = "/ShareMySpace/sharing?searchType="+room+"&searchKeyword=${searchKeyword}";
				document.listForm.submit();
			}else{
				document.listForm.action = "/ShareMySpace/sharing?searchType="+room;
				document.listForm.submit();
			}
		}
	}

	function fn_select(id) {
	document.listForm.action = "/ShareMySpace/sharing/content?no="+id;
	document.listForm.submit();
	}function fn_mypage(id){
		document.listForm.action="/ShareMySpace/mypage?id="+id;
		document.listForm.submit();
	}function fn_reg(){
		if(!${logincheck}){
			alert("로그인을 해주세요");
			return;
			}
		document.listForm.action="/ShareMySpace/sharing/regist";
		document.listForm.submit();
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
                                <li>No</li>
                                <li>Title</li>
                                <li>Type</li>
                                <li>Location</li>
                                <li>User</li>
                                <li>Date</li>
                            </ul>
                        </li>
                        <!-- 게시물이 출력될 영역 -->
                        <c:forEach var="result" items="${subjectList}" varStatus="status">
                        	<li>
                        		<ul>
                                	<li><c:out value="${result.no}"/></li>
             	                    <li><a onClick="javascript:fn_select('${result.no}')">
             	                    	<c:choose>
									        <c:when test="${fn:length(result.title) gt 26}">
 										       <c:out value="${fn:substring(result.title, 0, 25)}...">
  										    </c:out></c:when>
       										<c:otherwise>
    	    									<c:out value="${result.title}">
        									</c:out></c:otherwise>
										</c:choose>
									</a></li>
                  	            	<li><c:out value="${result.type}"/></li>
                                	<li><c:out value="${result.address}"/></li>
                                	<li><c:out value="${result.id}"/></li>
                                	<li><c:out value="${result.date}"/></li>
                            	</ul>    
                         	</li>
                         </c:forEach>
                        <!-- 게시판 페이징 영역 -->
                        <li>
                            <div id="divPaging">
                                <div>◀</div>
                                <div><b>1</b></div>
                                <div>2</div>
                                <div>3</div>
                                <div>4</div>
                                <div>5</div>
                                <div>▶</div>
                            </div>
                        </li>
                    </ul>
                                       
                    <a href="javascript:fn_reg()" class="icon icon-file-alt button">공간 등록하기</a>
                    <input id="searchKeyword" name="searchKeyword" class="search" type="text" value="${searchKeyword}" placeholder="검색할 제목을 입력해주세요."/>
                    <a class="icon icon-search" href="javascript:fn_sharingsearch($('#searchKeyword').val())"></a>
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
                    	<li><a href="javascript:fn_type('${result.type}')"><c:out value="${result.type}"/></a></li>
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