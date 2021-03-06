<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebVR</title>
    <link rel="shortcut icon" href="#">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value='/resources/css/register.css' />">
    
	<!-- favicon -->
	<link rel="shortcut icon" href="<c:url value='/resources/icon/palette_black.png' />">

    <script>
	    function CheckEmail(str) {      
	         var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	         if(!reg_email.test(str)) {                            
	              return false;         
	         }                            
	         else {                       
	              return true;         
	         }                            
	    }                             

	  	//회원가입이 가능한지 체크
	    //아이디, 비밀번호 입력 여부 및 비밀번호와 비밀번호 확인의 일치 여부 체크
        function check() {
            var form = document.form;

            var email = form.email.value;
            if (!CheckEmail(email)) {
                alert("이메일을 정확히 입력해주세요.");
                return;
            }
            
            var password = form.password.value;
            var password_check = form.password_check.value;

            if(!email || !password || !password_check) {
                alert("이메일과 비밀번호를 모두 입력해주세요.");
            } else if(password != password_check) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다");
            } else {
                form.submit();
            }
        }
    </script>
</head>
<body>
    
    <div class="box">
    	<!-- 회원가입이 실패한 경우 exception 객체에 저장된 오류 메시지를 출력 -->
        <c:if test="${registerFailed}">
	      <font color="red"><c:out value="${exception.getMessage()}" /></font>
	    </c:if>
        <form name="form" method="post" action="<c:url value='/WebVR/register' />">
            <table>
                <tr>
                    <td class="width-110">Email</td>
                    <td><input type="text" name="email"></td>
                </tr>
                <tr>
                    <td class="width-110">Password</td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td class="width-110">Confirm</td>
                    <td><input type="password" name="password_check"></td>
                </tr>
                <tr>
                    <td class="width-110">Nickname</td>
                    <td><input type="text" name="nickname"></td>
                </tr>
                <tr>
                    <td colspan="2"><button onclick="check()" class="btn btn-outline-light">회원가입</button></td>
                </tr>
            </table>
        </form>
    </div>

    <!-- 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>