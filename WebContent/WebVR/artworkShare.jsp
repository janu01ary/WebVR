<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebVR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../resources/css/artworkShare.css">
</head>
<body>
    
    <div class="artwork">
        <div class="artwork-img-block">
            <img class="artwork-img" src="">
        </div>
        <div class="about-artwork">
            <span class="artwork-title">작품 제목</span>
            <!-- <br> -->
            <span class="artist">작가 이름</span>
        </div>
    </div>

    <div class="share">
        <a href=""><img class="icon" src="../resources/icon/kakaotalk_icon.png"></a>
        <a href=""><img class="icon" src="../resources/icon/facebook_icon.png"></a>
        <a href=""><img class="icon" src="../resources/icon/instagram_icon.png"></a>
        <a href=""><img class="icon" src="../resources/icon/twitter_icon.png"></a>
        <br>
        <span class="url">URL</span>
        <input readonly value="url 주소">
        <button type="button" class="btn btn-outline-light">COPY</button>
    </div>

    <!-- 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>