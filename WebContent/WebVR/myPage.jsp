<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>my_page</title>
        <link rel="stylesheet" href="../resources/myPage.css" type="text/css">
    </head>
    <body>
        <!-- 사이트 이름이나 로고 나중에 추가 -->
        <h1 id="title">사이트 이름</h1>
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
            <!-- 오른쪽 content에 띄울 mypage 내용들 -->
            <!-- 마이 프로필 -->
            <div id="my_profile" class="content">
                <table>
                    <tr>
                        <th id="profile_title" colspan="2">최가희</th> <!-- user 이름 -->
                    </tr>
                    <tr>
                        <th class="profile_detail">e-mail | </th>
                        <td class="profile_value">gogo@gmail.com</td> <!-- user 이메일 -->
                    </tr>
                    <tr>
                        <th class="profile_detail">관심 분야 | </th>
                        <td class="profile_value">현대 미술</td>
                    </tr>
                    <tr>
                        <td id="empty" colspan="2"></td> <!-- empty -->
                    </tr>
                    <tr>
                        <th class="profile_detail">관람 횟수 | </th>
                        <td class="profile_value">5</td> <!-- user의 관람 횟수 -->
                    </tr>
                    <tr>
                        <th class="profile_detail">전시 횟수 | </th>
                        <td class="profile_value">2</td> <!-- user가 주최한 전시 횟수-->
                    </tr>
                </table>
            </div>
            <!-- 회원 정보 변경 -->
            <div id="edit_profile" class="content">
                <form id="edit_form">
                    <table>
                        <tr>
                            <th class="editForm_title">이름 | </th>
                            <td><input type="text" id="edit_name" class="edit_input" placeholder="최가희"></td>
                            <!-- placeholder에는 해당하는 user 정보 넣어주기 -->
                        </tr>
                        <tr>
                            <th class="editForm_title">e-mail | </th>
                            <td><input type="email" id="edit_email" class="edit_input" placeholder="gogo@gmail.com"></td>
                        </tr>
                        <tr>
                            <th class="editForm_title">전화번호 | </th>
                            <td><input type="phone" id="edit_phone" class="edit_input" placeholder="010-1234-5678"></td>
                        </tr>
                        <tr>
                            <th class="editForm_title">비밀번호 | </th>
                            <td><input type="password" id="edit_pwd" class="edit_input"></td>
                        </tr>
                        <tr>
                            <th class="editForm_title">비밀번호 재확인 | </th>
                            <td><input type="password" id="edit_pwdCheck" class="edit_input"></td>
                        </tr>
                    </table>
                    <button id="edit_confirm">수정</button>
                </form>
            </div>
            <!-- 관람 내역 -->
            <div id="watch_history" class="content">
                <table style="margin-top: 40px; border-spacing:10px">
                    <tr>
                        <td>
                            <div class="watch_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                        <td>
                            <div class="watch_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                        <td>
                            <div class="watch_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">가로로 3개 초과하면 tr 추가해서 아래로 추가하도록 하기! 이거 자세히 버튼 아래에 고정 못 시키나 고민하기..</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="watch_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 좋아한 작품 보기 -->
            <div id="favorite_art" class="content">
                <table style="width: 90%; table-layout: fixed; border-spacing: 13px;">
                    <tr>
                        <td class="like_td">
                            <img src="../resources/img/shiba.jpg" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/cat.jpg" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/leaves.jpg" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/square2.jpg" class="like_image" alt="...">
                        </td>
                    </tr>
                    <tr>
                        <td class="like_td">
                            <img src="../resources/img/korea.jpg" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/square.jpg" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/img.png" class="like_image" alt="...">
                        </td>
                        <td class="like_td">
                            <img src="../resources/img/img.png" class="like_image" alt="...">
                        </td>
                    </tr>
                    <tr>
                        <td class="like_td">
                            <img src="../resources/img/img.png" class="like_image" alt="...">
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 작성한 댓글 보기 -->
            <div id="my_reply" class="content">
                <table style="margin-top:20px;">
                    <tr>
                        <td class="reply_box">
                            <h3 class="reply_exhib" style="display: inline">전시회 이름</h3>
                            <p class="reply_artwork" style="display: inline">작품 이름</p>
                            <p class="reply_content">붓터치가 예술이에요^-^</p>
                        </td>
                        <td>
                            <button class="reply_delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="reply_box">
                            <h3 class="reply_exhib" style="display: inline">전시회 이름</h3>
                            <p class="reply_artwork" style="display: inline">작품 이름</p>
                            <p class="reply_content">새로 추가될수록 tr을 추가합시당</p>
                        </td>
                        <td>
                            <button class="reply_delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="reply_box">
                            <h3 class="reply_exhib" style="display: inline">전시회 이름</h3>
                            <p class="reply_artwork" style="display: inline">작품 이름</p>
                            <p class="reply_content">새로 추가될수록 tr을 추가합시당</p>
                        </td>
                        <td>
                            <button class="reply_delete">삭제</button>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 전시 목록 보기 -->
            <div id="exhib_list" class="content">
                <table style="margin-top: 40px; border-spacing:10px">
                    <tr>
                        <td>
                            <div class="exhib_card">
                                <img src="../resources/img/shiba.jpg" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                        <td>
                            <div class="exhib_card">
                                <img src="../resources/img/cat.jpg" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                        <td>
                            <div class="exhib_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">가로로 3개 초과하면 tr 추가해서 아래로 추가하도록 하기! 이거 자세히 버튼 아래에 고정 못 시키나 고민하기..</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="exhib_card">
                                <img src="../resources/img/img.png" class="card_image" alt="...">
                                <div class="card_body">
                                    <h2 class="card_title">전시회 이름</h2>
                                    <p class="card_text">전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음! 전시회에 대한 설명! 3~4줄 이내로 끝나도록 해야할 것같음!</p>
                                </div>
                                <div class="card_button_box"><button class="card_button">자세히</button></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 전시 작품 관리 -->
            <div id="exhib_manage" class="content">
                <table style="margin-top:20px;">
                    <tr>
                        <td>
                            <img src="../resources/img/korea.jpg" class="manage_image" alt="...">
                        </td>
                        <td class="manage_box">
                            <div style="margin-bottom:10px;">
                                <h3 class="manage_exhib" style="display: inline">전시회 이름</h3>
                                <p class="manage_artwork" style="display: inline">작품 이름</p>
                            </div>
                            <div>
                                <p class="manage_views" style="display: inline">218</p>
                                <p class="manage_likes" style="display: inline">20</p>
                            </div>
                        </td>
                        <td>
                            <button class="manage_edit">수정</button>
                            <button class="manage_delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../resources/img/shiba.jpg" class="manage_image" alt="...">
                        </td>
                        <td class="manage_box">
                            <div style="margin-bottom:10px;">
                                <h3 class="manage_exhib" style="display: inline">전시회 이름</h3>
                                <p class="manage_artwork" style="display: inline">여기도 tr을 점점 추가해나가는 걸로</p>
                            </div>
                            <div>
                                <p class="manage_views" style="display: inline">조회수 아이콘 나중에 넣기</p>
                                <p class="manage_likes" style="display: inline">좋아요 아이콘 나중에 넣기</p>
                            </div>
                        </td>
                        <td>
                            <button class="manage_edit">수정</button>
                            <button class="manage_delete">삭제</button>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 회원 탈퇴 -->
            <div id="leave_acc" class="content">
                <p>
                    회원 탈퇴 클릭
                </p>
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