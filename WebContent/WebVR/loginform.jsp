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
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
	
<!-- favicon -->
<link rel="shortcut icon" href="<c:url value='/resources/icon/palette_black.png' />">

<style type="text/css">
.bgdiv{
position: absolute; 
width: 100%;
height: 100%;
background-color: black;
}
.jumbotron {  
	background-color: black;
}

.container-md {
	min-width: 500px;
	max-width: 750px;
}

@
mixin clearfix () { &::after {
	display: block;
	content: "";
	clear: both;
}

}
//
Usage as a mixin
.element { @include clearfix;
	
}
</style>


<title>Login</title>
</head>
<body>
<div class ="bgdiv">
	<div class="jumbotron jumbotron-fluid">
		<div class="container text-white">
			<h1 class="display-4">Untact Gallery</h1>
			
		</div>
	</div>
	<div class="container-md text-white">
		<form method="post" action="<c:url value='/WebVR/login' />">
			<div class="form-group">
				<label for="exampleInputId">Email</label>
				<input type="text" class="form-control" id="exampleInputId" name="email">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword">Password</label>
				<input type="password" class="form-control" id="exampleInputPassword" name="password">
			</div>
			<div class="clearfix">
					<u><a href="<c:url value='/WebVR/register/form' />" >sign in</a></u>
				<button type="submit" class="btn btn-outline-light btn-lg float-right">login</button>
			</div>
		</form>
		
		<c:if test="${loginFailed}">
			${exception}
		</c:if>
	</div>
	</div>
	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    -->
</body>
</html>