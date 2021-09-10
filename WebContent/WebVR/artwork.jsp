 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>artwork</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/workPage.css' />">
<style type="text/css">
	#workPage{
	  width: 60%; 
	  text-align: left;
	}
	
	body {
		background-color: black;
	}
	th {
		color: white;
	}
	td {
		color: white;
		padding: 10px;
	}
</style>
</head>
<body>
	<div id="workPage" class="center-block">
		<br><br>
		<c:set var="s3_bucket_link" value="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/" />
		<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.artworkAddress}"/>"  class="img-responsive">
		
	    <table width="100%" style="text-align:left;">
			<tr>
			    <th>
			    	<a href="<c:url value='/WebVR/artwork/comment'> <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
	        		<img src="<c:url value='/resources/icon/comment.png' />" alt="commentIcon" width="50px" /> </a> 
			    </th>
				<th>
					<a href="<c:url value='/WebVR/artwork/like'> <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
	        		<img src="<c:url value='/resources/icon/likes.png' />" alt="commentIcon" width="50px" /> </a>
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
	        		<img src="<c:url value='/resources/icon/share.png' />" alt="commentIcon" width="50px" /> </a>
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
					<h3 style="display:inline"><c:out value="${artwork.title}"/></h3> 
					<h4 style="display:inline"><c:out value="${artwork.artistName}"/></h4>
					<h5 style="display:inline"><c:out value="${artwork.date}"/></h5>
				</td>
			</tr>
			<tr>
				<td colspan="7" ><h4><c:out value="${artwork.description}"/></h4></td>
			</tr>
	    </table>
	</div>
</body>
</html>