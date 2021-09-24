<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<!-- Optional JavaScript -->

<title>방명록</title>

<style type="text/css">
@font-face {
	font-family: 'NEXON Lv1 Gothic OTF';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'NEXON Lv1 Gothic OTF';
}
.card { $ 
	card-height: 100%;
	background-color: black;
}

.list-group {
	min-height: 750px;
	max-height: 750px;
	overflow: auto;
	-webkit-overflow-scrolling: touch;
}

.list-group-item {
	margin-bottom: 20px;
	margin-right: 10px;
	/*border-radius: 15px;*/
	border-color: lightgrey;
}
</style>

</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-header text-white">
				<h5>Guest book</h5>
			</div>
			<div class="card-body overflow-auto">
				<div class="list-group">

					<c:forEach var="gb" items="${GBUList}" varStatus="status">
						<a class="list-group-item list-group-item-dark"
							aria-current="true">
							<div class="d-flex w-100 justify-content-between">
								<h5 class="mb-1">${gb.nickname}</h5>
								<small>${gb.date}</small>
							</div>
							<p class="mb-1">${gb.content}</p>
						</a>
					</c:forEach>
				</div> 
			</div>
			<div class="card-footer text-white">
				<form method="POST" action="<c:url value='/WebVR/exhb/guestbook/create'>
											<c:param name='exhibitionId' value='${exhibitionId}' />
											</c:url>">
					<div class="mb-3">
						<input type="text" class="form-control" id="content" name="content">
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<button type="submit" class="btn btn-outline-light me-md-2">Send</button>
					</div>
				</form>
			</div>
		</div>
	</div>



	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>

</html>