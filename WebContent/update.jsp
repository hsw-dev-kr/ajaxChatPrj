<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>    
<%@ page import="user.UserDAO" %>    
<!DOCTYPE html>
<html>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if( userID == null){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있는 않습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		UserDTO user = new UserDAO().getUser(userID);
	%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP Ajax 실시간 회원제 채팅 서비스</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	function getUnread(){
		$.ajax({
			type: "POST",
			url: "./chatUnread",
			data: {
				userID : encodeURIComponent('<%= userID %>'),
			},
			success: function(result){
				if(result >= 1){
					showUnread(result);
				}else{
					showUnread('');
				}
			}
		});
	}
	function getInifiniteUnread(){ /* 반복적으로 서버한테 읽지 메시지 갯수를 달라고 함 */
		setInterval(function(){
			getUnread();
		}, 4000);
	}
	function showUnread(result){
		$('#unread').html(result);/* unread가는 원소를  매개변수인 result로 채워넣는다 */
	}
	function passwordCheckFunction() {
		var userpassword1 = $('#userPassword1').val();
		var userpassword2 = $('#userPassword2').val();
		if(userpassword1 != userpassword2){
			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		}else{
			$('#passwordCheckMessage').html('');
		}
	}
</script>		
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
					<a class="navbar-brand" href="index.jsp">실시간 회원제 채팅 서비스</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a></li>
				<li><a href="find.jsp">친구찾기</a></li>
				<li><a href="box.jsp">메시지함<span id="unread" class="label label-info"></span></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="buton" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li class="active"><a href="update.jsp">회원정보수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>			
		</div>
	</nav>
	<div class="container">
		<form method="post" action="./userUpdate">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 정보 수정 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td colspan="2"><h5><%=user.getUserid() %></h5>
							<input class="form-control" type="hidden" name="userID" value="<%=user.getUserid()%>">
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<!-- onkeyup 비밀번호 입력할 때 마다 실행 -->
						<td colspan="2"><input onkeyup="passwordCheckFunction();"
							class="form-control" type="password" id="userPassword1"
							name="userPassword1" maxlength="20" placeholder="비밀번호를 입력해주세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호확인</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckFunction();"
							class="form-control" type="password" id="userPassword2"
							name="userPassword2" maxlength="20"
							placeholder="비밀번호를 확인을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="userName" name="userName" maxlength="20"
							placeholder="이름을  입력하세요." value="<%=user.getUsername()%>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="2"><input class="form-control" type="number"
							id="userAge" name="userAge" maxlength="20"
							placeholder="나이를  입력하세요." value="<%=user.getUserage()%>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
							<div class="form-group"
								style="text-align: center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary <% if(user.getUsergender().equals("남자")) out.print("active");%>">
										<input type="radio" name="userGender" autocomplete="off" value="남자"
											<% if(user.getUsergender().equals("여자")) out.print("checked");%>>남자
									</label> 
									<label class="btn btn-primary <% if(user.getUsergender().equals("여자")) out.print("active");%>">
										<input type="radio" name="userGender" autocomplete="off" value="여자" 
											<% if(user.getUsergender().equals("여자")) out.print("checked");%>>여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" type="email"
							id="userEmail" name="userEmail" maxlength="20"
							placeholder="이메일을 입력하세요." value="<%= user.getUseremail()%>"></td>
					</tr>
					<tr>
						<td><input class="form-control"type="hidden" id="userProfile" name="userProfile" value="a.jpg"></td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="2"><h5 style=" color: red;" id="passwordCheckMessage"></h5>
							</td><td><input class="btn btn-primary pull-right" type="submit" value="수정"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>	
		<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType= (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-dlign-center">
					<div class="modal-content 
					<% if(messageType.equals("오류 메시지")) 
							out.println("panel-warning"); 
						else 
							out.println("panel-success"); %>">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span>
								<span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
									<%=messageType %>
							</h4>
						</div>
						<div class="modal-body">
							<%=messageContent %>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	<script type="text/javascript">
		$('#messageModal').modal("show");
	</script>

	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<%
		if(userID != null){	
	%>
		<script type="text/javascript">
			$(document).ready(function(){ /* 반복적인 메시지를 불러오는 실행 하는함수 */
				getInifiniteUnread();
			});
		</script>
	<%
		}
	%>
</body>
</html>