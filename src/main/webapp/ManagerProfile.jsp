<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.emptaskmanagement.entity.*"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>EMP Management | Home</title>
<link rel="icon"
	href="https://spinalcompass.com/wp-content/uploads/2017/07/Employees_icon-01.png">

<style>
* {
	margin: 0;
	padding: 0;
}

body:-webkit-scrollbar {
	display: none
}

body {
	background:
		url(https://tripleinnovation.com.au/wp-content/uploads/2018/11/Image-6F-iStock-475697960.jpg);
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	background-repeat: no-repeat;
}

nav {
	height: 50px;
	background: linear-gradient(5deg, rgb(194, 219, 124), rgb(235, 243, 160));
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: space-between;
	box-shadow: 0 0 10px -5px black;
	color: #fff;
}

.logo {
	font-size: 30px;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-weight: bolder;
	margin-left: 15px;
}

.logo:hover {
	text-shadow: 0 0 10px;
}

.crud-btns * {
	border: none;
	color: black;
	font-size: 20px;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin-right: 15px;
	padding: 2px 10px;
	background-color: white;
	border-radius: 5px;
	cursor: pointer;
	transition: all .05s ease-in-out;
	box-shadow: 0 0 10px -5px black;
	color: black;
}

.crud-btns *:hover {
	cursor: pointer;
}

.crud-btns *:active {
	transform: scale(.95);
}


 #profile-menu{
	height: 80vh;
	width: 80vw;
	margin: 2% 10% 0% 10%;
	background: rgba(255, 255, 255, .3);
	border-radius: 10px;
	box-shadow: 0 0 10px -5px;
	backdrop-filter: blur(10px);
	position: relative;
}

#profile-menu img{
	height: 200px;
	border: 2px solid gray;
	border-radius: 5px;
	position: absolute;
	top: 50px;
	left: 100px;
}

.manager-details{
	height: 200px;
	width: 650px;
	position: absolute;
	top: 50px;
	left: 350px;
	border-radius:5px;
	box-shadow:inset 0 0 10px -5px black;
	background: rgba(0,0,0,.1);
	padding-left: 20px;
}

.manager-details table tr{
	height: 90px;		
}

.manager-details table tr th{
	
	margin: 5px;
	margin-left:50px;
	padding: 10px;
	font-size: 20px;
	border-radius: 10px;
}

.manager-details table tr td{
	margin: 5px;
	padding: 10px;
	border-radius: 10px;
	
}
</style>

</head>
<body>

	<%
	
		User manager = (User) session.getAttribute("current_user");
	%>

	<nav>
		<span class="logo" onclick="location.href='index.html'">LOGO</span>
		<div class="crud-btns">
			<button id="back-btn" onclick="location.href='ManagerHome.jsp'">Back</button>
			<button onclick="location.href='logout'">Logout</button>
		</div>
	</nav>

	<div id="profile-menu">
	
	<img alt="manager image" src="https://cdn4.iconfinder.com/data/icons/people-avatar-1-2/512/29-1024.png">
	
	<div class="manager-details">
		<table>
		
		<tr>
		
		
		<th>Name</th>
		<td><%=manager.getName()%></td>
		
		<th>ID</th>
		<td><%=manager.getId()%></td>
		
		</tr>
		
		<tr>
		
		<th>Email</th>
		<td><%=manager.getEmail()%></td>
		
		<th>Password</th>
		<td><%=manager.getPassword()%></td>
		
		</tr>
		
		
		
		</table>
	</div>
	
	</div>

	<script>	
		
	//pass validation
	 document.getElementById('cpass').addEventListener('keyup', () => {
	      const pass = document.getElementById('pass').value;
	      const cpass = document.getElementById('cpass').value;

	      if (pass !== cpass) {

	        document.getElementById('incorrectPass').style.display = 'block';
	        setTimeout(() => {
	          document.getElementById('incorrectPass').style.display = 'none';
	        }, 3000);
	      }
	 });
	 
	 menuBtns.addEventListener("click",displayMenu);
	 
	 function closeMsg(){
		 document.getElementById('msg').style.display='none';
	 }
	 
	</script>
</body>
</html>