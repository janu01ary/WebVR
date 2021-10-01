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
    
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        Kakao.init('dd68b664f92649fe5f364ce2c71e40c7');
        Kakao.isInitialized();
    </script>
    
    <script>
	    const s3_bucket_link = 'https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/';
	    const artworkId = '${artwork.artworkId}';
	    const exhibitionId = '${artwork.exhibitionId}';
	    const title = '${artwork.title}';
	    const artworkAddress = '${artwork.artworkAddress}';
	    const description = '${artwork.description}';
	    const artistName = '${artwork.artistName}';
	    const likesCount = parseInt('${artwork.likesCount}');
	    const url = 'http://localhost:8080/WebVR/WebVR/exhb/List/artwork?artworkId='; // 추후 수정 필요(현재는 로컬에서만 돌아감)
	    const shareURL = url + artworkId;
		
	    function setShare() {
	        Kakao.Link.sendDefault({
	        objectType: 'feed',
	        content: {
        	  title: title,
	          description: description,
	          imageUrl: s3_bucket_link + exhibitionId + '/' + artworkAddress ,
	          link: {
	            mobileWebUrl: shareURL,
	            webUrl: shareURL
	          },
	        },
	        social: {
	            likeCount: likesCount
	          },
	        buttons: [
	          {
	            title: '확인하기',
	            link: {
	              mobileWebUrl: shareURL,
	              webUrl: shareURL
	            },
	          }
	        ]
	      });
	    }
	
	    function shareFacebook() {
	    	var sendUrl = shareURL; // 전달할 URL
	        window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
	    }
	    function shareTwitter() {
	        var sendText = ""; // 전달할 텍스트, 나중에 필요하면 사용
	        var sendUrl = shareURL; // 전달할 URL
	        window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
	    }
	    function copyToClipboard() {
	    	var url = '';
	    	var textarea = document.createElement("textarea");
	    	document.body.appendChild(textarea);
	    	url = window.document.location.href;
	    	textarea.value = url;
	    	textarea.select();
	    	document.execCommand("copy");
	    	document.body.removeChild(textarea);
	    	alert("URL이 복사되었습니다.");
    	}
    </script>
    
</head>
<body>


    <div class="artwork">
        <div class="artwork-img-block">   
            <c:set var="s3_bucket_link" value="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/" />
			<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.exhibitionId}"/>/<c:out value="${artwork.artworkAddress}"/>"  class="artwork-img">
        </div>
        <div class="about-artwork">
            <span class="artwork-title"><c:out value="${artwork.title}"/></span>
            <!-- <br> -->
            <span class="artist"><c:out value="${artwork.artistName}"/></span>
        </div>
    </div>

    <div class="share">
        <a href=""><img class="icon" src="<c:url value='/resources/icon/kakaotalk_icon.png' />" onclick="setShare()"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/facebook_icon.png' />" onclick="shareFacebook()"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/instagram_icon.png' />" onclick="copyToClipboard()"></a>
        <a href=""><img class="icon" src="<c:url value='/resources/icon/twitter_icon.png' />" onclick="shareTwitter()"></a>
        <br>
        <span class="url">URL</span>
        <input readonly value="${pageContext.request.requestURL}"> <!-- 이 부분 추후 수정 필요 -->
        <button type="button" class="btn btn-outline-light" onclick="copyToClipboard()">COPY</button>
    </div>

    <!-- 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>