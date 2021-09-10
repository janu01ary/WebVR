<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebVR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value='/resources/css/artworkShare.css' />">
</head>
<body>
    
    <div class="artwork">
        <div class="artwork-img-block">   
            <c:set var="s3_bucket_link" value="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/" />
			<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.artworkAddress}"/>"  class="artwork-img">
        </div>
        <div class="about-artwork">
            <span class="artwork-title"><c:out value="${artwork.title}"/></span>
            <!-- <br> -->
            <span class="artist"><c:out value="${artwork.artistName}"/></span>
        </div>
    </div>

    <div class="share">
        <a href=""><img class="icon" src="<c:url value='/resources/icon/kakaotalk_icon.png' />"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/facebook_icon.png' />"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/instagram_icon.png' />"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/twitter_icon.png' />"></a>
        <br>
        <span class="url">URL</span>
        <input readonly value="url 주소">
        <button type="button" class="btn btn-outline-light">COPY</button>
    </div>

    <!-- 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>