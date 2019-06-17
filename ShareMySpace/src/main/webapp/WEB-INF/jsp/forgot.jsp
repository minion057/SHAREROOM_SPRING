<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Share My Space</title>
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans:600'>
    <link rel="stylesheet" href="/resource/res/css/login_signup.css">
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
    <link href="/resource/res/css/fonts.css" rel="stylesheet" type="text/css" media="all" />
    
    <!--[if IE 6]>
    <link href="default_ie6.css" rel="stylesheet" type="text/css" />
    <![endif]-->
	<script src="http://code.jquery.com/jquery-Latest.min.js"></script>	
<script type="text/javaScript" language="javascript" defer="defer">
function fn_findid(){
	// 정규식 - 이메일 유효성 검사
    var regEmail =  /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    // 정규식 -전화번호 유효성 검사
    var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
    var data = {};
	data["email"]= $('#id_email').val();
	data["phone"]= $('#id_phone').val();
    $.ajax({
		url : '/ShareMySpace/find.id',
		type : 'post',
		data:JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
		success : function(adata) {	
			if(adata != ""){
				alert("입력하신 정보! \n"+"이메일 : "+$('#id_email').val()+"\n전화번호 : "+$('#id_phone').val()+"\n----------------------------------\n 찾은 정보\n 아이디 : "+adata);
				document.listForm.action="/ShareMySpace/login/forgot";
				document.listForm.submit();
			}else{
				alert("그런 회원 정보는 없습니다.");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			if($('#id_email').val().length == 0 || $('#id_phone').val().length == 0){
				alert("정보를 입력하세요");
				xhr.abort();
			}else if(!regEmail.test($('#id_email').val()) || $('#id_email').val().length > 40){
				alert("이메일을 확인해주세요");
				xhr.abort();
			}else if(!regPhone.test($('#id_phone').val()) || $('#id_phone').val().length < 11){
				alert("전화번호을 확인해주세요");
				xhr.abort();
			}
		}
	});
}
function fn_findpw(){
	// 정규식 - 이메일 유효성 검사
    var regEmail =  /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    // 정규식 -전화번호 유효성 검사 >숫자 11자리
    var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
    //정규식 - 아이디 유효성 검사 >> 영어 or 숫자 6~12자리
	var regId = /^[A-Za-z0-9]{6,12}$/;
    var data = {};
	data["id"]= $('#pw_id').val();
	data["email"]= $('#pw_email').val();
	data["phone"]= $('#pw_phone').val();
    $.ajax({
		url : '/ShareMySpace/find.pw',
		type : 'post',
		data:JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
		success : function(adata) {	
			if(adata != ""){
				alert("입력하신 정보! \n"+"아이디 : "+$('#pw_id').val()+"\n이메일 : "+$('#pw_email').val()+"\n전화번호 : "+$('#pw_phone').val()+"\n----------------------------------\n 찾은 정보\n 비밀번호 : "+adata);
				document.listForm.action="/ShareMySpace/login/forgot";
				document.listForm.submit();
			}else{
				alert("그런 회원 정보는 없습니다.");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			if($('#pw_id').val().length == 0 || $('#pw_email').val().length == 0 || $('#pw_phone').val().length == 0){
				alert("정보를 입력하세요");
				xhr.abort();
			}else if(!regId.test($('#pw_id').val()) || $('#pw_id').val().length > 12){
				alert("아이디을 확인해주세요");
				xhr.abort();
			}else if(!regEmail.test($('#pw_email').val()) || $('#pw_email').val().length > 40){
				alert("이메일을 확인해주세요");
				xhr.abort();
			}else if(!regPhone.test($('#pw_phone').val()) || $('#pw_phone').val().length < 11){
				alert("전화번호을 확인해주세요");
				xhr.abort();
			}
		}
	});
}
</script>
</head>
<body >
<form id="listForm" name="listForm" method="post">
    <div id="header-wrapper">
        <div id="header-wrapper2">
            <div id="header" class="container">
                <div id="logo">
					<h1><a href="<c:url value='/ShareMySpace/login_signup' />" class="icon icon-group"><span>Login / Sign Up</span></a></h1>
                </div>
                <div id="menu">
                    <ul>
                        <li ><a href="<c:url value='/ShareMySpace/home' />" accesskey="1" title="">Homepage</a></li>
                        <li><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
                        <li><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
                        <li><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
                        <li><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="login-wrap">
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Find ID</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Find PW</label>

            <div class="login-form">
                <div class="sign-in-htm">
                    <div class="group">
                        <label for="user" class="label">Email</label>
                        <input id="id_email" type="text" class="input" minlength="11" maxlength="40" placeholder="검색할 회원의 이메일을 입력해주세요."/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Phone Number</label>
                        <input id="id_phone" type="text" class="input" minlength="11" maxlength="11" placeholder="검색할 회원의 전화번호을 입력해주세요."/>
                    </div>
                    <div class="group">
                        <input onClick="javascript:fn_findid()" type="button" class="button" value="Find ID"/>
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <label for="tab-2">Forgot Password?</label>
                    </div>
                </div>
                <div class="sign-up-htm">
                    <div class="group">
                        <label for="user" class="label">Username</label>
                        <input id="pw_id" type="text" class="input" placeholder="검색할 회원의 아이디를 입력해주세요." minlength="6" maxlength="12" />
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Email Address</label>
                        <input id="pw_email" type="email" class="input" minlength="11" maxlength="40" placeholder="검색할 회원의 이메일을 입력해주세요."/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Phone Number</label>
                        <input id="pw_phone" type="text" class="input" minlength="11" maxlength="11" placeholder="검색할 회원의 전화번호을 입력해주세요." />
                    </div>
                    <div class="group">
                        <input onClick="javascript:fn_findpw()" type="button" class="button" value="Find PW"/>
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <label for="tab-1">Forgot ID?</label>
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
