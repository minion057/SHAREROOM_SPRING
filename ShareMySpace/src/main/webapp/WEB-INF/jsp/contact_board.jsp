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
		document.listForm.action = "/ShareMySpace/help";
		document.listForm.submit();
	}

	function fn_select(id) {
	document.listForm.action = "/ShareMySpace/help/content?no="+id;
	document.listForm.submit();
	}function fn_mypage(id){
		document.listForm.action="/ShareMySpace/mypage?id="+id;
		document.listForm.submit();
	}function fn_reg(){
		if(!${logincheck}){
			alert("로그인을 해주세요");
			return;
			}
		document.listForm.action="/ShareMySpace/help/regist";
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
                        <li><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
                        <li><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
                        <li class="current_page_item"><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
                        <li><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div id="wrapper">
	<div id="page" class="container">
		<div id="content" style="float:none;     margin-left: 200px;">
			<div id="banner"> <img src="/resource/res/img/logo_contact.PNG" width="790" height="300" alt="" /> </div>
			<div id="board">
                <div id="tbox1">
                    
                    <ul class="list">
                        <li>
                            <ul>
                                <li>No</li>
                                <li>Title</li>
                                <li>Status</li>
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
                                	<li><c:choose>
									        <c:when test="${result.status eq 0}"> 처리중 </c:when>
                                			<c:otherwise>처리완료</c:otherwise>
                                		</c:choose>
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
                                       
                    <a href="javascript:fn_reg()" class="icon icon-file-alt button">문의 등록하기</a>
                    <input id="searchKeyword" name="searchKeyword" class="search" type="text" value="${searchKeyword}" placeholder="검색할 제목을 입력해주세요."/>
                    <a class="icon icon-search" href="javascript:fn_sharingsearch($('#searchKeyword').val())"></a>
                </div>
				
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