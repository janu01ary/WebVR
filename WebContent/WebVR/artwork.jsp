 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>artwork</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/workPage.css' />">

<!-- favicon -->
<link rel="shortcut icon" href="<c:url value='/resources/icon/palette_black.png' />">

<style type="text/css">
	@font-face {
    font-family: 'NEXON Lv1 Gothic OTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}

	#workPage{
	  width: 60%; 
	  text-align: left;
	}
	
	body {
		background-color: black;
		font-family: 'NEXON Lv1 Gothic OTF';
	}
	th {
		color: white;
	}
	td {
		color: white;
		padding: 10px;
	}
</style>
<script>	
function isLogin(){ 
     var login = '<%=(String)request.getAttribute("login")%>';

      if (login === 'true'){ // 로그인 되어있는 경우
    	 const artworkId = '${artwork.artworkId}';
         location.href='/WebVR/WebVR/artwork/like?artworkId=' + artworkId;
      }
      else { // 로그인 되어있지 않은 경우
    	  alert('로그인이 필요합니다');
      }	
}   
</script>
</head>
<body>
	<div id="workPage" class="center-block" >
		<br><br>
		<c:set var="s3_bucket_link" value="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/" />
		<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.exhibitionId}"/>/<c:out value="${artwork.artworkAddress}"/>"  class="artwork-img" width="100%">
		
	    <table width="100%" style="text-align:left;">
			<tr>
			    <th>
			    	<a href="<c:url value='/WebVR/artwork/comment'> <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
	        		<img src="<c:url value='/resources/icon/comment.png' />" alt="commentIcon" width="50px" /> </a> 
			    </th>
				<th>
	        		<c:choose>
						<c:when test="${like eq true}">
							<img src="<c:url value='/resources/icon/redHeart.png' />" alt="likeIcon" width="32px" onClick="isLogin()" />
						</c:when>
						<c:otherwise>
							<img src="<c:url value='/resources/icon/likes.png' />" alt="likeIcon" width="50px" onClick="isLogin()" />
						</c:otherwise>
					</c:choose>
	        		
				</th>
				<th> 
					<c:choose>
						<c:when test="${artwork.likesCount < 100}">
							<c:out value="${artwork.likesCount}"/>
						</c:when>
						<c:otherwise>
							<c:out value="99+"/>
						</c:otherwise>
					</c:choose>
				</th>
				
				<th width="70%">
				</th>
				
				<th>
					<a href="<c:url value='/WebVR/artwork/share'> <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
	        		<img src="<c:url value='/resources/icon/share.png' />" alt="shareIcon" width="50px" /> </a>
				</th>
				<th>
					<img src="<c:url value='/resources/icon/view.png' />" alt="viewIcon" width="50px" />
				</th>
				<th>
					<c:choose>
						<c:when test="${artwork.viewCount < 100}">
							<c:out value="${artwork.viewCount}"/>
						</c:when>
						<c:otherwise>
							<c:out value="99+"/>
						</c:otherwise>
					</c:choose>
				</th>
			</tr>
	
			<tr>
				<td colspan="7" >
					<h3 style="display:inline"><c:out value="${artwork.title}"/>&nbsp;</h3> 
					<h4 style="display:inline"><c:out value="${artwork.artistName}"/>&nbsp;</h4>
					<fmt:formatDate value="${artwork.date}" pattern="yyyy" var="date"/>
                    <h5 style="display:inline"><c:out value="${date}"/></h5>
				</td>
			</tr>
			<tr>
				<td colspan="7" ><h4><c:out value="${artwork.description}"/></h4></td>
			</tr>
	    </table>
	</div>
</body>
</html>