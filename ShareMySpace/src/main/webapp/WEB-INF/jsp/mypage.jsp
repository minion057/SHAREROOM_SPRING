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
function fn_logout(){
	$.ajax({
		url : '/ShareMySpace/logout',
		type : 'get',
		success : function(data) {	
			if(data){
				alert("${user.id}님 안녕히가세요");
				document.listForm.action="/ShareMySpace/login_signup";
				document.listForm.submit();
			}else{
				alert("${user.id}님 에러가 났습니다");
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr, opt){
			if($('#userid').val().length == 0 || "${user.id}" != $('#userid').val()){
				alert("${user.id}님의 마이페이가 아닙니다");
				document.listForm.action="/ShareMySpace/mypage?id="+${user.id};
				document.listForm.submit();
				xhr.abort();	
			}
		}
	});	
}
function fn_mypage(id){
	document.listForm.action="/ShareMySpace/mypage?id="+id;
	document.listForm.submit();
}
function fn_emailcheck(){
	var user_email = $('#email').val();
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
			if("${user.email}" == user_email){
				//정보가 바뀌지 않음 > 검사할 필요가 없음 >> 중복아님을 넘겨줌
				$('#email_check').text("");
				xhr.abort();
			}
			else if(user_email.length == 0){
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
	var user_phone = $('#phone').val();
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
			if("${user.phone}" == user_phone){
				//정보가 바뀌지 않음 > 검사할 필요가 없음 >> 중복아님을 넘겨줌
				$('#phone_check').text("");
				xhr.abort();
			}
			else if(user_phone.length == 0){
				$('#phone_check').text("전화번호를 입력해주세요");
				xhr.abort();
			}else if(!regPhone.test(user_phone)) {			
				$('#phone_check').text("전화번호를 확인해주세요");
				xhr.abort();
			}
		}
	});
}
function fn_check(){
	// 정규식 - 이메일 유효성 검사
    var regEmail =  /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    // 정규식 -전화번호 유효성 검사
    var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
    var data = {};
	data["id"]= "${user.id}";
	data["pw"]= $('#password').val();
	data["email"]= $('#email').val();
	data["phone"]= $('#phone').val();
    $.ajax({
		url : '/ShareMySpace/mypage.modify',
		type : 'post',
		data:JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
		success : function(adata) {	
			alert("정보변경 성공! \n"+"아이디 : "+$('#user_id').val()+"\n비밀번호 : "+$('#password').val()+"\n 이메일 : "+$('#email').val()+"\n 전화번호 : "+$('#phone').val());
			document.listForm.action="/ShareMySpace/mypage?id=${user.id}";
			document.listForm.submit();
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr){
			pw = $('#password').val();
			var email_check = ("${user.email}" == $('#email').val());
			var phone_check = ("${user.phone}" == $('#phone').val());
			var pw_check = ("${user.password}" == $('#password').val());
			if($('#userid').val().length == 0 || $('#password').val().length == 0 || $('#email').val().length == 0 || $('#phone').val().length == 0){
				alert("정보를 입력하세요");
				xhr.abort();
			}else if(email_check && phone_check && pw_check){
				alert("정보 변경이 없습니다");
				xhr.abort();
			}
			else if(new RegExp(/[^a-z|^0-9]/gi).test(pw) == false && pw.search(/[~!@#$%^&*()_+|<>?:{}]/) <= 0 || pw.length <8 || pw.length > 16){
				alert("비밀번호는 8~16자로 영문,숫자,특수문자 조합이여야 합니다");
				xhr.abort();
			}else if($('#email_check').text()!="" && $('#email_check').text()!="사용가능"){
				alert('이메일 중복확인을 해주세요');
				xhr.abort();
		    }else if($('#phone_check').text()!="" && $('#phone_check').text()!="사용가능"){
				alert('전화번호 중복확인을 해주세요');
				xhr.abort();
		    }
		}
	});
}
function fn_withdrawl(){
	$.ajax({
		url : '/ShareMySpace/mypage/withdrawl?id=${user.id}',
		type : 'get',
		success : function(data) {	
			if(data){
				alert("그동안 서비스는 어떠셨나요?\n다음에도 다시 가입해서 이용해주세요\n감사했습니다");
				document.listForm.action="/ShareMySpace/login_signup";
				document.listForm.submit();
			}else{
				alert("본인의 마이페이지가 맞나요?");
				document.listForm.action="/ShareMySpace/mypage?id="+${user.id};
				document.listForm.submit();
			}
		}, error : function() {
			console.log("실패");
		}, beforeSend: function(xhr, opt){
			if($('#userid').val().length == 0 || "${user.id}" != $('#userid').val()){
				alert("${user.id}님의 마이페이지가 아닙니다");
				document.listForm.action="/ShareMySpace/mypage?id="+${user.id};
				document.listForm.submit();
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
                    <h1><a href="javascript:fn_mypage('${user.id}')" class="icon icon-group"><span>My Page / Logout</span></a></h1>
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
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">My Page</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Withdrawal</label>

            <div class="login-form">
                <div class="sign-in-htm">
                    <div class="group">
                        <label for="user" class="label">Username</label>
                        <input id="userid" name = "userid" type="text" class="input" value="${user.id}" readonly="readonly"/>
                    </div>
                    <div class="group">
                        <label for="user" class="label">Password</label>
                        <input id="password" name="password" type="text" class="input" value="${user.password}"/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Email Address</label>
                        <input id="email" name="email" type="text" class="input" value="${user.email}" onchange="$('#email_check').text('중복 검사 필요')" minlength="11" maxlength="40"/>
                        <div id="email_check" class="checkdiv"  style="width: 280px;"></div>
                    	<input id="checkinput" class="button" onClick="javascript:fn_emailcheck()" type="button" value="email check"/>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Phone Number</label>
                        <input id="phone" name="phone" type="text" class="input" value="${user.phone}" onchange="$('#phone_check').text('중복 검사 필요')" minlength="11" maxlength="11"/>
                        <div id="phone_check" class="checkdiv" style="width: 270px;" ></div>
                    	<input id="checkinput" class="button" onClick="javascript:fn_phonecheck()" type="button" value="phone check" style="margin-bottom:10px;"/>
                    </div>
                    <div class="group">
                        <input onClick="javascript:fn_check()" type="button" class="button" value="정보 수정"/>
                    </div>
                    <div class="hr" style="margin-bottom:30px"></div>
                    <div class="group">
                        <input onClick="javascript:fn_logout()" type="submit" class="button" value="Logout"/>
                    </div>
                </div>
                <div class="sign-up-htm">
                    <div class="hr" style="margin-top:80px"></div>
                    <div class="group">
                        <p class="p" style="text-align:center; font-size:20pt">정말 탈퇴하시겠습니까?</p>
                    </div>
                    <div class="group">
                        <p class="p" style="text-align:center; margin-bottom:40px; font-size:14pt">탈퇴시, 작성하신 글까지 모두 삭제됩니다.</p>
                    </div>
                    <div class="group">
                        <input onClick="javascript:fn_withdrawl()" type="submit" class="button" value="YES"/>
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <label for="tab-1">Update my account</label>
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
