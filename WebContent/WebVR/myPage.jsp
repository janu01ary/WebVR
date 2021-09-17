<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="controller.*" %>
<%@ page import="model.*" %>
<%
	User user = (User)request.getAttribute("user");
	List<Likes> likesList = (List<Likes>)request.getAttribute("likesList");
	List<Visit> visitList = (List<Visit>)request.getAttribute("visitList");
	List<Comment> commentList = (List<Comment>)request.getAttribute("commentList");
	List<Exhibition> exhibitionList = (List<Exhibition>)request.getAttribute("exhibitionList");
	HashMap<Integer, List<Artwork>> artworkMap = (HashMap<Integer, List<Artwork>>)request.getAttribute("artworkMap");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>my_page</title>
        <link rel="stylesheet" href="../resources/css/myPage.css" type="text/css">
    </head>
    <body>
        <!-- 사이트 이름이나 로고 나중에 추가 -->
        <h1 id="title">Untact Gallery</h1>
        <div id="entire">
            <!-- 마이페이지 메뉴 리스트 -->
            <!-- 나중에 클릭 시 해당 메뉴는 색칠하는 것도 좋을 듯~ -->
            <div id="menuList">
                <h2 id="menuTitle">마이 페이지</h2>
                <h3 class="headMenu">나의 정보</h3>
                <hr>
                <p class="menuItem" onClick="openMenu(event, 'my_profile')" id="defaultOpen">마이 프로필</p>
                <p class="menuItem" onClick="openMenu(event, 'edit_profile')">회원 정보 수정</p>
                <br>
                <h3 class="headMenu">나의 관람</h3>
                <hr>
                <p class="menuItem" onClick="openMenu(event, 'watch_history')">관람 이력</p>
                <p class="menuItem" onClick="openMenu(event, 'favorite_art')">내가 좋아한 작품</p>
                <p class="menuItem" onClick="openMenu(event, 'my_reply')">작성한 댓글 보기</p>
                <br>
                <h3 class="headMenu">나의 전시</h3>
                <hr>
                <p class="menuItem" onClick="openMenu(event, 'exhib_list')">전시 목록</p>
                <p class="menuItem" onClick="openMenu(event, 'exhib_manage')">전시 작품 관리</p>
                <br>
                <h3 id="warning" onClick="openMenu(event, 'leave_acc')">회원 탈퇴</h3>
            </div>
            <!-- 오른쪽 content에 띄울 myPage 내용들 -->
            <!-- 마이 프로필 -->
            <div id="my_profile" class="content">
                <table>
                    <tr>
                        <th id="profile_title" colspan="2">
                        	<%=user.getNickname() %>
                        </th> <!-- user 이름 -->
                    </tr>
                    <tr>
                        <th class="profile_detail">e-mail | </th>
                        <td class="profile_value">
                        	<%=user.getEmail() %>
                        </td> <!-- user 이메일 -->
                    </tr>
                </table>
            </div>
            <!-- 회원 정보 변경 -->
            <div id="edit_profile" class="content">
                <form action="/WebVR/WebVR/myPage/update" id="edit_form" role="form" method="POST">
                    <table>
                        <tr>
                            <th class="editForm_title">이름 | </th>
                            <td>
                            	<input type="text" id="edit_name" name="edit_name" class="edit_input" placeholder="<%=user.getNickname() %>">
                            </td>
                            <!-- placeholder에는 해당하는 user 정보 넣어주기 -->
                        </tr>
                        <tr>
                            <th class="editForm_title">e-mail | </th>
                            <td>
                            	<input type="email" id="edit_email" name="edit_email" class="edit_input" placeholder="<%=user.getEmail() %>">
                            </td>
                        </tr>
                        <tr>
                            <th class="editForm_title">비밀번호 | </th>
                            <td><input type="password" id="edit_pwd" name="edit_pwd" class="edit_input"></td>
                        </tr>
                    </table>
                    <button type="submit" id="edit_confirm">수정</button>
                </form>
            </div>
            <!-- 관람 내역 -->
            <div id="watch_history" class="content">
                <table style="margin-top: 40px; border-spacing:10px">
                <%
                	Iterator<Visit> visitIter = visitList.iterator();
                	for(int i = 0; visitIter.hasNext(); i++){
                		Visit visit = (Visit)visitIter.next();
                		if(i % 3 == 0){
                %>
                    <tr>
                    <% } %>
                        <td>
                            <div class="watch_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title"><%=visit.getExhibitionTitle() %></h2>
                                    <p class="card_text"><%=visit.getExhibitionDesc() %></p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    <% if(i % 3 == 2){ %>
                    </tr>
                    <% }} %>
                </table>
            </div>
            <!-- 좋아한 작품 보기 -->
            <div id="favorite_art" class="content">
                <table style="width: 90%; table-layout: fixed; border-spacing: 13px;">
                <%
                	Iterator<Likes> likesIter = likesList.iterator();
                	for(int i = 0; likesIter.hasNext(); i++){
                		Likes likes = (Likes)likesIter.next();
                		if(i % 4 == 0){
                %>
                    <tr>
                    <% } %>
                        <td class="like_td">
                        	<p> <%= likes.getLikeId() %>
                            <img src="../resources/img/shiba.jpg" class="like_image" alt="...">
                        </td>
                    <% if(i % 4 == 3){ %>
                    </tr>
                <% }} %>
                </table>
            </div>
            <!-- 작성한 댓글 보기 -->
            <div id="my_reply" class="content">
                <table style="margin-top:20px;">
                <%
                	Iterator<Comment> commentIter = commentList.iterator();
                	for(int i = 0; commentIter.hasNext(); i++){
                		Comment comment = (Comment)commentIter.next();
                %>
                    <tr>
                        <td class="reply_box">
                            <h3 class="reply_exhib" style="display: inline"><%= comment.getArtworkTitle() %></h3>
                            <p class="reply_content"><%= comment.getContent() %></p>
                        </td>
                        <td>
                            <button class="reply_delete">삭제</button>
                        </td>
                    </tr>
                <% } %>
                </table>
            </div>
            <!-- 전시 목록 보기 -->
            <div id="exhib_list" class="content">
                <table style="margin-top: 40px; border-spacing:10px">
                <%
                	Iterator<Exhibition> exhibitionIter = exhibitionList.iterator();
                	for(int i = 0; exhibitionIter.hasNext(); i++){
                		Exhibition exhibition = (Exhibition)exhibitionIter.next();
                		if(i % 3 == 0){
                %>
                    <tr>
                    <% } %>
                        <td>
                            <div class="exhib_card">
                                <img src="../resources/img/shiba.jpg" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title"><%=exhibition.getTitle() %></h2>
                                    <p class="card_text"><%=exhibition.getDescription() %></p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    <% if(i % 3 == 2){ %>
                    </tr>
                    <% }} %>
                </table>
            </div>
            <!-- 전시 작품 관리 -->
            <div id="exhib_manage" class="content">
                <table style="margin-top:20px;">
                <%
          	      	Iterator<Integer> keys = artworkMap.keySet().iterator();
         			while( keys.hasNext() ){
                    	int key = keys.next();
                    	Iterator<Artwork> artworkIter = artworkMap.get(key).iterator();
                    	for(int i = 0; artworkIter.hasNext(); i++){
                    		Artwork artwork = (Artwork)artworkIter.next();
                %>
                    <tr>
                        <td>
                            <img src="../resources/img/korea.jpg" class="manage_image" alt="...">
                        </td>
                        <td class="manage_box">
                            <div style="margin-bottom:10px;">
                                <h3 class="manage_exhib" style="display: inline">전시회 이름</h3>
                                <p class="manage_artwork" style="display: inline"><%=artwork.getTitle() %></p>
                            </div>
                            <div>
                                <p class="manage_views" style="display: inline"><%=artwork.getViewCount() %></p>
                                <p class="manage_likes" style="display: inline"><%=artwork.getLikesCount() %></p>
                            </div>
                        </td>
                        <td>
                            <button class="manage_delete">삭제</button>
                        </td>
                    </tr>
                 <% }} %>
                </table>
            </div>
            <!-- 회원 탈퇴 -->
            <div id="leave_acc" class="content">
            <form action="/WebVR/WebVR/myPage/delete" role="form" method="POST">
            	<table>
                    <tr>
                        <th id="profile_title" colspan="2">
                        	탈퇴하시겠습니까?
                        </th>
                    </tr>
                    <tr>
                       	<th class="editForm_title">비밀번호 | </th>
                      	<td><input type="password" id="edit_pwd" name="edit_pwd" class="edit_input"></td>
                 	</tr>
            	</table>
               	<button type="submit" id="delete_confirm">탈퇴</button>
           	</form>
            </div>
        </div>
        <script>
            //오른쪽 content 페이지 변환 스크립트
            function openMenu(evt, page){
                var i, content, clickItem;

                //content 내용들 일단 전부 안 보이게
                content = document.getElementsByClassName("content");
                for (i = 0; i < content.length; i++) {
                    content[i].style.display = "none";
                 }

                // menuItem 다 가져온 후, active된 클래스 삭제
                clickItem = document.getElementsByClassName("menuItem");
                for (i = 0; i < clickItem.length; i++) {
                    clickItem[i].className = clickItem[i].className.replace(" active", "");
                }

                // 현재 클릭한 메뉴를 보여주며 active 클래스에 추가해주기
                document.getElementById(page).style.display = "block";
                evt.currentTarget.className += " active";
            }

            //최초 실행 시 디폴트로 열린 페이지 지정 (마이 프로필)
            document.getElementById("defaultOpen").click();
        </script>
    </body>
</html>