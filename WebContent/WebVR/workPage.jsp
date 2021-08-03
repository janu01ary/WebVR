 <!-- 배경화면 검정, 글자색 흰색으로 수정 필요 -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>artwork</title>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../resources/css/workPage.css">
</head>
<body>
	<div id="workPage" class="center-block">
		<!-- 이미지 첨부 확인을 위해 임의로 사진 넣음. 추후 데이터베이스에서 가져올 예정 -->
		<br>
		<img src="momo.jpg" alt="workImage" class="img-responsive">
		
	    <table width="100%" style="text-align:left;">
			<tr>
			    <td>
			    	<img src="../resources/icon/comment.png" alt="commentIcon" width="50px">
			    </td>
				<td>
					<img src="../resources/icon/likes.png" alt="likeIcon" width="50px">
				</td>
				<td>
					99+
				</td>
				
				<td width="70%">
				</td>
				
				<td>
					<img src="../resources/icon/share.png" alt="shareIcon" width="50px">
				</td>
				<td>
					<img src="../resources/icon/view.png" alt="viewIcon" width="50px">
				</td>
				<td>
					99+
				</td>
			</tr>
	
			<tr>
				<td colspan="7" style="padding:15px;">
					<h3 style="display:inline">작품 제목</h3> 
					<h4 style="display:inline">작가 이름</h4>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="padding:20px;"><h5>작품 설명 들어갈 부분 작품 설명 들어갈 부분 작품 설명 들어갈 부분 작품 설명 들어갈 부분</h5></td>
			</tr>
	    </table>
	</div>
</body>
</html>