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

</script>
<style>
   		.box{
   		width:1100px;
   		margin:0 auto;
          margin-top:3%;
        }
        .demo-card-square.mdl-card {
            width: 320px;
            height: 320px;
            float: left;
            margin: 1rem;
            position: relative;
          }
          
          .demo-card-square.mdl-card:hover {
            box-shadow: 5px 20px 10px 1px rgba(0, 0, 0, .14), 0 3px 14px 2px rgba(0, 0, 0, .12), 0 5px 5px -3px rgba(0, 0, 0, .2);
          }
          
          .demo-card-square > .mdl-card__title {
            color: #fff;
            background: black;
          }
          
          .demo-card-square > .mdl-card__accent {
            background: black;
          }
          .img{
          position: relative;
          background-image:url(/resource/res/img/파티룸.jfif);
          width:100%;
          height:100%;
          background-size: cover;
        }
        .img-cover{
          position: absolute;
          height: 100%;
          width: 100%;
          background-color: rgba(0, 0, 50, 0.4);
          z-index: 1;
        }
        .text{
          position:absolute;
          top:50%;
          left:50%;
          transform: translate(-50%,-50%);
          color:white;
          z-index: 2;
          text-align: center;
        }
     </style>
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
                        <li class="current_page_item"><a href="<c:url value='/ShareMySpace/home' />" accesskey="1" title="">Homepage</a></li>
                        <li><a href="<c:url value='/ShareMySpace/sharing' />" accesskey="2" title="">Sharing</a></li>
                        <li><a href="<c:url value='/ShareMySpace/review' />" accesskey="3" title="">Review</a></li>
                        <li><a href="<c:url value='/ShareMySpace/help' />" accesskey="4" title="">Help</a></li>
                        <li><a href="<c:url value='/ShareMySpace/aboutus' />" accesskey="5" title="">About Us</a></li>
                </div>
            </div>
        </div>
    </div>
	<div class = "box">
            <!-- 카드형식-->
        <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=회의실' />">
            <div class="img" >
                <img src="/resource/res/img/main/회의룸.jpg" class="img-cover">
                <div class="text">
                    <h2>회의룸</h2>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
        <!-- 카드형식-->
        <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=파티룸' />">
            <div class="img" >
                <img src="/resource/res/img/main/파티룸.jpg" class="img-cover">
                <div class="text">
                    <h2>파티룸</h2>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
          
        <!-- 카드형식 -->
        <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=작업실' />">
            <div class="img" >
                <img src="/resource/res/img/main/작업실.jfif" class="img-cover">
                <div class="text">
                    <h2>작업실</h2>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
        <!-- 카드형식 -->
         <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=민박' />">
            <div class="img" >
                <img src="/resource/res/img/main/민박.png" class="img-cover">
                <div class="text">
                    <h2>민박</h2>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
        <!-- 카드형식 -->
		<div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=세미나실' />">
            <div class="img" >
                <img src="/resource/res/img/main/세미나룸.jpg" class="img-cover">
                <div class="text">
                    <h3>세미나룸</h3>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
        <!-- 카드형식 -->
       <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=공유주방' />">
            <div class="img" >
                <img src="/resource/res/img/main/공유주방.jfif" class="img-cover">
                <div class="text">
                    <h3>공유주방</h3>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
         <!-- 카드형식 -->
       <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=다목적홀' />">
            <div class="img" >
                <img src="/resource/res/img/main/다목적홀.jpg" class="img-cover">
                <div class="text">
                    <h3>다목적홀</h3>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
         <!-- 카드형식 -->
       <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=연습실' />">
            <div class="img" >
                <img src="/resource/res/img/main/연습실.jpg" class="img-cover">
                <div class="text">
                    <h2>연습실</h2>
                </div>
                <div class="img-cover"></div>
            </div></a>
        </div>
        
        <div class="mdl-card mdl-shadow--2dp demo-card-square" style="position:relative;z-index:1;">
            <a href="<c:url value='/ShareMySpace/sharing?searchType=엠티장소' />">
            <div class="img" >
                <img src="/resource/res/img/main/MT장소.jpg" class="img-cover">
                <div class="text">
                    <h3>MT장소</h3>
                </div>
                <div class="img-cover"></div>
            </div>
        </div></a>
     </div>
    <div id="portfolio-wrapper" style="border-top: 0px solid #D4D4D4;">
        <div id="portfolio" class="container" style="border-top: 1px solid #D4D4D4; margin-top:1050px">
            <div class="title">
                <h2 style="margin-top: 80px;">Contact Us</h2>
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
