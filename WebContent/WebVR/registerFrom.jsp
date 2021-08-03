<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebVR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../resources/css/registerForm.css">

    <script>
	  	//회원가입이 가능한지 체크
	    //아이디, 비밀번호 입력 여부 및 비밀번호와 비밀번호 확인의 일치 여부 체크
        function check() {
            var form = document.form;

            var id = form.id.value;
            var password1 = form.password1.value;
            var password2 = form.password2.value;

            if(!id || !password1 || !password2) {
                alert("아이디와 비밀번호를 모두 입력해주세요.");
            } else if(password1 != password2) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다");
            } else {
                form.action = "";
                form.submit();
            }
        }
    </script>
</head>
<body>
    
    <div class="box">
        <form name="form" method="post">
            <table>
                <tr>
                    <td class="width-110">아이디</td>
                    <td><input type="text" name="id"></td>
                </tr>
                <tr>
                    <td class="width-110">비밀번호</td>
                    <td><input type="password" name="password1"></td>
                </tr>
                <tr>
                    <td class="width-110">비밀번호 확인</td>
                    <td><input type="password" name="password2"></td>
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