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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- Google font -->
	<link rel="stylesheet"
          href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <title>댓글화면</title>

   <style type="text/css">
        .card{
            $card-height:100%;
            background-color: black;
        }
 
        .list-group{
            min-height: 750px;
            max-height: 750px;
            overflow: auto;
            -webkit-overflow-scrolling: touch;
        }
        .list-group-item{
            margin-bottom: 20px;
            margin-right: 10px;
            border-radius: 15px;
            border-color: lightgrey; 
            background-color: black; 
        }
        .mb-1{
            color: white;
        }
        .mb-2{
            color: lightgrey;
        }
        small {
            color: lightgrey;
        }
        .icon {
        	font-size: 1.5em;
        }
    </style>
</head>
<body>
<div class="card-group">
    <div class="card">
        <img src="sample.jpg" class="card-img-top" alt="sample">
        <div class="card-body text-white">
            <h5 class="card-title">title</h5>
            <p class="card-text">caption in here</p>
        </div>
    </div>
    <!--댓글창-->
    <div class="card">
        <div class="card-header text-white">
            <h5>Comment</h5>
        </div>
        <div class="card-body overflow-auto">
            <div class="list-group">
	            <c:forEach var="comment" items="${commentList}" varStatus="status">
	            	<div class="list-group-item" aria-current="true">
	                    <div class="d-flex w-100 justify-content-between">
	                        <h5 class="mb-1">${userList[status].nickname}</h5>
	                        <small class="mb-2">
	                        	${comment.date}
	                        	<c:if test="${userList[status].id eq userId}"> <!-- 댓글 작성자와 현재 로그인된 사용자가 같으면 -->
	                        		<a class="material-icons icon ml-1"
	                        		   href="<c:url value='/WebVR/artwork/comment/delete'>
	                        		   			<c:param name='commentId' value='${comment.id}' />
	                        		   		 </c:url>">delete</a>
	                        	</c:if>
	                        </small>
	                    </div>
	                    <p class="mb-1">${comment.content}</p>
                	</div>
	            </c:forEach>
	            <!-- 
                <a class="list-group-item" aria-current="true">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">UserName</h5>
                        <small class="mb-2">3 days ago<button class="btn btn-outline-light custom-p-2 ml-2">삭제</button></small>
                    </div>
                    <p class="mb-1">Some placeholder content</p>
                </a>
                <a class="list-group-item" aria-current="true">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">UserName</h5>
                        <small class="mb-2">3 days ago<button class="btn btn-outline-light custom-p-2 ml-2">삭제</button></small>
                    </div>
                    <p class="mb-1">Some placeholder content in a paragraph.</p>
                </a>
                <a class="list-group-item" aria-current="true">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">UserName</h5>
                        <small>3 days ago<span class="material-icons icon ml-1">delete</span></small>
                    </div>
                    <p class="mb-1">Some placeholder content in a paragraph.</p>
                </a>
                <a class="list-group-item" aria-current="true">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">UserName</h5>
                        <small class="mb-2">3 days ago</small>
                    </div>
                    <p class="mb-1">Some placeholder content in a paragraph.</p>
                </a> -->
            </div>
        </div>
        <div class="card-footer text-white">
            <form action="<c:url value='/WebVR/arkwork/comment/create'>
            				<c:param name='artworkId' value='${artworkId}'/>
            			  </c:url>" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="InputComment">
                </div>
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                	<button type="submit" class="btn btn-outline-light me-md-2">Send</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>

</html>