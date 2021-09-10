<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebVR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value='/resources/css/home.css' />">
    <script>
    </script>
</head>
<body>
    <div class="top">
        <!-- 로그인 되어 있지 않으면-->
        <button type="button" class="btn btn-outline-light">LOGIN/JOIN</button>
         
        <!-- 로그인 되어 있으면 -->
        <button type="button" class="btn btn-outline-light">LOGOUT</button>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/mypage_circle.png' />" alt="My Page"></a>
    </div>
    
    <div class="description">
    <p class="title"><b>Untact Gallery</b><p> 
<p>코로나19로 어려움을 겪고 있는</p> 
<p>작가들을 위한 가상 현실 기반 온라인 전시 플랫폼</p> 
    <a href="#exhibition-list" class="btn btn-light btn-outline-dark">진행 중인 전시 목록 보기</a>
    </div>

    <div class="list-block" id="exhibition-list">
        <div class="list-title">진행 중인 전시 목록</div>
        <div class="list">  
            <a href="<c:url value='/WebVR/exhb' />" class="exhibition-link">
                <div class="exhibition"> 
                    <img src="<c:url value='/resources/img/poster.jpg' />" class="exhibition-img"><br>
                    <span>전시 이름1</span>
                </div>
            </a>
            <a href="<c:url value='/WebVR/exhb' />" class="exhibition-link">
                <div class="exhibition"> 
                    <img src="<c:url value='/resources/img/poster.jpg' />" class="exhibition-img"><br>
                    전시 이름2
                </div>
            </a>
            <a href="<c:url value='/WebVR/exhb' />" class="exhibition-link">
                <div class="exhibition"> 
                    <img src="<c:url value='/resources/img/poster.jpg' />" class="exhibition-img"><br>
                    전시 이름3
                </div>
            </a>
            <a href="<c:url value='/WebVR/exhb' />" class="exhibition-link">
                <div class="exhibition"> 
                    <img src="<c:url value='/resources/img/poster.jpg' />" class="exhibition-img"><br>
                    전시 이름4
                </div>
            </a>
            <c:forEach var="exhb" items="${exhibitionList}" varStatus="status">
            	<a href="<c:url value='/WebVR/exhb' />" class="exhibition-link">
	            	<div class="exhibition"> 
	                    <img src="<c:url value='/resources/icon/mypage_circle.png' />" class="exhibition-img">
	                    ${exhb.title}
	                </div>
            	</a>
            </c:forEach>
            <a href="" class="exhibition-link">
                <div class="exhibition">
                    <img src="" class="exhibition-img"><br>
                    전시 이름2
                </div>
            </a>
            <a href="" class="exhibition-link">
                <div class="exhibition">
                    <img src="" class="exhibition-img">
                    전시 이름3
                </div>
            </a>    
            <a href="" class="exhibition-link">
                <div class="exhibition">
                    <img src="" class="exhibition-img">
                    전시 이름4
                </div>
            </a>
        </div>
    </div>

    <!-- 부트스트랩-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>