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
		}if('${sharingdetail.status}' == 1){
			alert("처리가 완료된 글을 수정할 수 없습니다.")
			return;
		}
  		document.listForm.action = "/ShareMySpace/help/modify?no="+no;
  		document.listForm.submit();
   }
   
   //삭제
   function fn_delete(no){
		$.ajax({
			url : '/ShareMySpace/help/delete?no='+no,
			type : 'get',
			success : function(data) {		
				if('${user.id}' != "admin"){
					alert("${user.id}님 글 삭제완료. \n문의 게시판 목록으로 돌아갑니다.");
					document.listForm.action = "/ShareMySpace/help";
				   	document.listForm.submit();
				}			
				alert("관리자가 ${user.id}회원 글 삭제완료. \n문의 게시판 목록으로 돌아갑니다.");
				document.listForm.action = "/ShareMySpace/help";
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
   }
   
   //관리자(admin) 글 처리 상태 변경
   function fn_status(no){
		$.ajax({
			url : '/ShareMySpace/help/status?no='+no,
			type : 'get',
			success : function(data) {				
				alert("관리자가 ${user.id}회원 글 처리완료.");
				document.listForm.action = "/ShareMySpace/help/content?no="+no;
			   	document.listForm.submit();
			}, error : function() {
				console.log("실패");
			}
		});
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
                                <li style="color : red; margin-left: 350px;font-size: 14pt;"><c:choose>
			 							<c:when test="${sharingdetail.status eq 0}">처리중</c:when>
										<c:otherwise>처리 완료</c:otherwise>
									</c:choose>
								</li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>글제목</li>
                                <li><input id="content_title" class="content-title" type="text" value="${sharingdetail.title}" readonly="readonly"/></li>
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
                    <c:if test = "${user.id eq 'admin'}"><a href="javascript:fn_status(${sharingdetail.no})" class="icon icon-refresh button">처리완료</a>&nbsp;&nbsp;</c:if>
                        <a href="javascript:fn_modify(${sharingdetail.no})" class="icon icon-refresh button">수정</a>&nbsp;&nbsp;
                        <a href="javascript:fn_delete(${sharingdetail.no})" class="icon icon-trash button">삭제</a>

                    </div>
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
