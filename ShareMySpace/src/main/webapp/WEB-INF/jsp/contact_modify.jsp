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
	 //수정
	   function fn_modify(no){
		   var data = {};
			data["id"]= '${user.id}';
			data["no"]= no;
			data["title"]= $('#title').val();
			data["contents"]= $('#contents').val();
			$.ajax({
				url : '/ShareMySpace/help/modify.do?no='+no,
				type : 'post',
				data:JSON.stringify(data),
		        contentType : "application/json; charset=utf-8",
				success : function(adata) {	
				   	document.listForm.action = "/ShareMySpace/help/content?no="+no;
				   	document.listForm.submit();
				}, error : function() {
					console.log("실패");
				}, beforeSend: function(xhr){
					if($('#title').val() == "" || $('#contents').val() == ""){
						alert("정보를 입력하세요");
						xhr.abort();
					}else if($('#title').val()=="${sharingdetail.title}" && $('#contents').val()=="${sharingdetail.contents}"){
						alert("정보가 변한 내용이 없습니다. 글 목록으로 돌아갑니다");
					   	document.listForm.action = "/ShareMySpace/help/content?no="+no;
					   	document.listForm.submit();
					   	xhr.abort();
					}
				}
			});
	   }
	 //삭제
	   function fn_delete(no){
			$.ajax({
				url : '/ShareMySpace/help/delete?no='+no,
				type : 'get',
				success : function(data) {					
					alert("${user.id}님 글 삭제완료. \n 문의 게시판 목록으로 돌아갑니다.");
					document.listForm.action = "/ShareMySpace/help";
				   	document.listForm.submit();
				}, error : function() {
					console.log("실패");
				}, beforeSend: function(xhr){
					if(!${logincheck}) {
						alert("로그인하세요.");
						xhr.abort();
				    }else if('${user.id}'!=$('#regID').val()){
						alert("다른 사용자의 글을 삭제할 수 없습니다.")
						xhr.abort();
					}
				}
			});
	   }
	   function fn_mypage(id){
			document.listForm.action="/ShareMySpace/mypage?id="+id;
			document.listForm.submit();
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
                                <li>글제목</li>
                                <li><input id="title" name="title" class="content-title" type="text" value="${sharingdetail.title}" placeholder="수정할 글제목을 입력해주세요." maxlength="200"/></li>
                            </ul>
                        </li>
                        
						<li>
                            <ul>
                                <li>작성자</li>
                                <li><input id="id" name="id" type="text" value="${sharingdetail.id}" readonly="readonly"/></li>
                                <li></li>
                                <li></li>
                                <li>연락처</li>
                                <li><input type="text" value="${fn:substring(sharingdetail.phone,0,3)}-${fn:substring(sharingdetail.phone,3,7)}-${fn:substring(sharingdetail.phone,7,11)}" readonly="readonly" /></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>내용</li>
                                <li>
                                    <textarea id="contents" name="contents" cols="93" rows="20" wrap="soft" placeholder="수정할 글내용을 입력해주세요." maxlength="5000" >${sharingdetail.contents}</textarea>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="bt">
                        <a href="javascript:fn_modify(${sharingdetail.no})" class="icon icon-refresh button">수정</a>
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
