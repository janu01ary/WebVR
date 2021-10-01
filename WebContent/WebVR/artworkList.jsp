 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>artwork list</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/listPage.css' />">

<!-- favicon -->
<link rel="shortcut icon" href="<c:url value='/resources/icon/palette_black.png' />">

<style type="text/css">
	@font-face {
	    font-family: 'NEXON Lv1 Gothic OTF';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	#listPage {
		text-align: center;
		width: 90%;
	}
	
	body {
		background-color: black;
		font-family: 'NEXON Lv1 Gothic OTF';
	}
	
	table {
		width: 90%;
		margin-left:5%;
		margin-right:5%;
	}
	td {
		padding: 10px;
	}
</style>
</head>
<body>
	<div id="listPage" class="center-block" style="overflow:auto">
 		<br><br>
     	<table width="70%" style="margin-right:10px;" class="img-responsive">
     		<c:set var="s3_bucket_link" value="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/" />
			<c:forEach var="artwork" items="${artworkList}" varStatus="status">
				<c:choose>
					<c:when test="${status.index % 3  eq 0}">
						<tr>
							<td width="23%">
								<a href="<c:url value='/WebVR/exhb/List/artwork'>
								   <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
									<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.exhibitionId}"/>/<c:out value="${artwork.artworkAddress}"/>"  class="img-responsive">
								</a>
							 </td>
					</c:when>
					<c:when test="${(status.index + 1) % 3  eq 0}">
							<td width="23%">
								<a href="<c:url value='/WebVR/exhb/List/artwork'>
								   <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
									<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.exhibitionId}"/>/<c:out value="${artwork.artworkAddress}"/>"  class="img-responsive">
								</a>
							 </td>
						 </tr>
					</c:when>
					<c:otherwise>
							<td width="23%">
								<a href="<c:url value='/WebVR/exhb/List/artwork'>
								   <c:param name='artworkId' value='${artwork.artworkId}'/></c:url>">
									<img src="<c:out value="${s3_bucket_link}"/><c:out value="${artwork.exhibitionId}"/>/<c:out value="${artwork.artworkAddress}"/>"  class="img-responsive">
								</a>
							 </td>
					</c:otherwise>
				</c:choose>
		    </c:forEach>
    	</table>
	</div>
</body>
</html>