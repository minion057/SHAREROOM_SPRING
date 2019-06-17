<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
function fn_login(){
	var data = {};
	data["id"]= $('#user').val();
	data["pw"]= $('#pass').val();
	$.ajax({
		url : '/ShareMySpace/login.do',
		type : 'post',
		data:JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
		success : function(result) {
			if(result>=1){
				alert("로그인 성공! \n"+"아이디 : "+$('#user').val()+"\n비밀번호 : "+$('#pass').val());
				document.listForm.action="/ShareMySpace/mypage?id="+$('#user').val();
				document.listForm.submit();
			}else{
				alert("아이디혹은 비밀번호가 맞지않습니다");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			if($('#user').val().length == 0 || $('#pass').val().length == 0){
				alert("정보를 입력하세요");
				xhr.abort();
			}
		}
	});
}
function fn_idcheck(){
	var user_id = $('#user_id').val();
	var regId = /^[A-Za-z0-9]{6,12}$/;
	$.ajax({
		url : '/ShareMySpace/user/idCheck?userId='+user_id,
		type : 'get',
		success : function(data) {	
			if (data >= 1) {
				$('#id_check').text("사용중인 아이디입니다");
			} else {
				$('#id_check').text("사용가능");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr, opt){
			if(user_id.length == 0){
				$('#id_check').text("아이디를 입력해주세요");
				xhr.abort();	
			}else if(!regId.test(user_id)) {						
				$('#id_check').text("소문자와 숫자 6~12자리만 가능합니다");
				xhr.abort();	
			}
		}
	});
}
function fn_emailcheck(){
	var user_email = $('#user_email').val();
	var regEmail =  /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	$.ajax({
		url : '/ShareMySpace/user/emailCheck?useremail='+ user_email,
		type : 'get',
		success : function(data) {					
			if (data >= 1) {
				$('#email_check').text("사용중인 이메일입니다");
			} else {
				$('#email_check').text("사용가능");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			if(user_email.length == 0){
				$('#email_check').text("이메일을 입력해주세요");
				xhr.abort();
			}else if(!regEmail.test(user_email)) {						
				$('#email_check').text("이메일을 확인해주세요");
				xhr.abort();
			}
		}
	});
}
function fn_phonecheck(){
	var user_phone = $('#user_phone').val();
	var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	$.ajax({
		url : '/ShareMySpace/user/phoneCheck?userphone='+ user_phone,
		type : 'get',
		success : function(data) {					
			if (data >= 1) {
					$('#phone_check').text("사용중인 전화번호입니다");
			} else {
				$('#phone_check').text("사용가능");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			if(user_phone == 0){
				$('#phone_check').text("전화번호를 입력해주세요");
				xhr.abort();
			}else if(user_phone.length!=11){
				$('#phone_check').text("숫자만 11자 입력해주세요");
				xhr.abort();
			}
			else if(regPhone.test(user_phone)==false) {						
				$('#phone_check').text("전화번호를 확인해주세요");
				xhr.abort();
			}
		}
	});
}
function fn_signup(){
	var data = {};
	data["id"]= $('#user_id').val();
	data["pw"]= $('#user_pwc').val();
	data["email"]= $('#user_email').val();
	data["phone"]= $('#user_phone').val();
	$.ajax({
		url : '/ShareMySpace/signup.do',
		type : 'post',
		data:JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
		success : function(adata) {	
			alert("회원가입 성공! \n"+"아이디 : "+$('#user_id').val()+"\n비밀번호 : "+$('#user_pwc').val()+"\n 이메일 : "+$('#user_email').val()+"\n 전화번호 : "+$('#user_phone').val());
			document.listForm.action="/ShareMySpace/login_signup";
			document.listForm.submit();
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			pw = $('#user_pw').val()
			if($('#user_id').val().length == 0 || pw.length  == 0 || $('#user_pwc').val().length == 0 || $('#user_email').val().length == 0 || $('#user_phone').val().length == 0){
				alert("정보를 입력하세요");
				xhr.abort();
			}
			else if(new RegExp(/[^a-z|^0-9]/gi).test(pw) == false && pw.search(/[~!@#$%^&*()_+|<>?:{}]/) <= 0 || pw.length <8 || pw.length > 16){
				$('#pw_check').text("비밀번호는 8~16자로 영문,숫자,특수문자 조합이여야 합니다");
				xhr.abort();
			}
			else if($('#user_pwc').val()!=$('#user_pw').val()){
				$('#pw_check').text("비밀번호를 정확히 입력해주세요");
				xhr.abort();
			}else if($('#id_check').text()!="사용가능" || $('#email_check').text()!="사용가능"|| $('#phone_check').text()!="사용가능"){
				alert("중복 검사를 해주세요");
				xhr.abort();
			}else{
				$('#pw_check').text("사용가능");
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
                        <li><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
                        <li><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
                </div>
            </div>
        </div>
    </div>
    <div class="login-wrap">
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>

            <div class="login-form">
                <div class="sign-in-htm">
                    <div class="group">
                        <label for="user" class="label">Username</label>
                        <input id="user" name="user" type="text" class="input" minlength="6" maxlength="12">
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Password</label>
                        <input id="pass" name="pass" type="password" class="input" data-type="password" value="" minlength="8" maxlength="16">>
                    </div>
                    <div class="group">
                    		<input onClick="javascript:fn_login()" type="button" class="button" value="Sign In">
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <a class="login-a" href="<c:url value='/ShareMySpace/login/forgot' />">Forgot ID & Password?</a>
                    </div>
                </div>
                <div class="sign-up-htm">
                    <div class="group">
                        <label for="user" class="label">Username</label>
                        <input id="user_id" type="text" class="input" onchange="$('#id_check').text('중복 검사 필요')" placeholder="사용하실 아이디를 입력해주세요." minlength="6" maxlength="12"/>
                        <div id="id_check" class="checkdiv"  style="width: 300px;"></div>
                    	<input id="checkinput" class="button" onClick="javascript:fn_idcheck()" type="button" value="id check"/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Password</label>
                        <input id="user_pw" type="password" class="input" data-type="password" onchange="$('#pw_check').text('내용 변경 감지, pwc를 확인하세요')" placeholder="사용하실 비밀번호를 입력해주세요." minlength="8" maxlength="16"/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Repeat Password</label>
                        <input id="user_pwc" type="password" class="input" data-type="password" onchange="$('#pw_check').text('내용 변경 감지, pw를 확인하세요')" placeholder="다시 비밀번호를 입력해주세요." minlength="8" maxlength="16"/>
                        <div id="pw_check" class="checkdiv"  style="float:right"></div>
                    </div>
                    <div class="group">
                        <label for="email" class="label">Email Address</label>
                        <input id="user_email" type="text" class="input" onchange="$('#email_check').text('중복 검사 필요')" placeholder="사용하실 이메일을 입력해주세요." minlength="11" maxlength="40"/>
                        <div id="email_check" class="checkdiv"  style="width: 280px;"></div>
                    	<input id="checkinput" class="button" onClick="javascript:fn_emailcheck()" type="button" value="email check"/>
                    </div>
                    <div class="group">
                        <label for="phone" class="label">Phone Number</label>
                        <input id="user_phone" type="text" class="input" onchange="$('#phone_check').text('중복 검사 필요')" placeholder="사용하실 전화번호를 입력해주세요." minlength="11" maxlength="11"/>
                        <div id="phone_check" class="checkdiv" style="width: 270px;" ></div>
                    	<input id="checkinput" class="button" onClick="javascript:fn_phonecheck()" type="button" value="phone check" style="margin-bottom:10px;"/>
                    </div>
                    <div class="group">
                        <input type="button" class="button" value="Sign Up" onClick="javascript:fn_signup()"/>
                    </div>
                    <div class="hr" style="margin-bottom:15px"></div>
                    <div class="foot-lnk">
                        <label for="tab-1">Already Member?</label>
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
