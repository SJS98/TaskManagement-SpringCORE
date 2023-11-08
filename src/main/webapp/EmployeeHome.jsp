<%@page import="java.util.stream.Collectors"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.emptaskmanagement.entity.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Employee | Home</title>
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

*::-webkit-scrollbar {
	display: none;
}

#view-task-menu {
	height: 80vh;
	width: 80vw;
	margin: 2% 10% 0% 10%;
	background: rgba(255, 255, 255, .3);
	border-radius: 10px;
	box-shadow: 0 0 10px -5px;
	backdrop-filter: blur(10px);
	position: relative;
	overflow: scroll;
}

#profile-menu {
	height: 80vh;
	width: 80vw;
	margin: 2% 10% 0% 10%;
	background: rgba(255, 255, 255, .3);
	border-radius: 10px;
	box-shadow: 0 0 10px -5px;
	backdrop-filter: blur(10px);
	position: relative;
	display: none;
}

#profile-menu img {
	height: 200px;
	border: 2px solid gray;
	border-radius: 5px;
	position: absolute;
	top: 50px;
	left: 100px;
}

.employee-details {
	height: 200px;
	width: 650px;
	position: absolute;
	top: 50px;
	left: 350px;
	border-radius: 5px;
	box-shadow: inset 0 0 10px -5px black;
	background: rgba(0, 0, 0, .1);
	padding-left: 20px;
}

.employee-details  table tr {
	height: 90px;
}

.employee-details  table tr th {
	margin: 5px;
	margin-left: 50px;
	padding: 10px;
	font-size: 20px;
	border-radius: 10px;
	text-align: center;
}

.employee-details table tr td {
	margin: 5px;
	padding: 10px;
	border-radius: 10px;
	text-align: center;
}

#msg {
	text-align: center;
	font-size: 25px;
	font-weight: bold;
	padding-top: 40px;
}

.task-table {
	width: 800px;
	height: 100px;
	overflow: hidden;
	margin: 50px;
}

.task-table tr {
	height: 50px;
}

.task-table tr td {
	text-align: center;
}

.about {
	width: fit-content;
	margin: auto;
}

.assign-btn {
	padding: 5px;
	background-color: lightgreen;
	border: none;
	color: black;
	font-weight: bold;
	border-radius: 5px;
	box-shadow: 0 0 10px -5px;
}

.assign-btn:active {
	transform: scale(.95);
}

.assign-btn:hover {
	cursor: pointer;
}
</style>

</head>
<body>

	<%
	User employee = (User) session.getAttribute("current_user");
	%>

	<nav>
		<span class="logo" onclick="location.href='index.html'">LOGO</span>
		<div class="crud-btns">
			<button id="view-task">View Tasks</button>
			<button id="profile">Profile</button>
			<button onclick="location.href='logout'">Logout</button>
		</div>
	</nav>


	<div id="profile-menu">

		<img alt="manager image"
			src="https://cdn4.iconfinder.com/data/icons/people-avatar-1-2/512/29-1024.png">

		<div class="employee-details">
			<table>

				<tr>


					<th>Name</th>
					<td><%=employee.getName()%></td>

					<th>ID</th>
					<td><%=employee.getId()%></td>

				</tr>

				<tr>

					<th>Email</th>
					<td><%=employee.getEmail()%></td>

					<th>Password</th>
					<td><%=employee.getPassword()%></td>

				</tr>



			</table>
		</div>

	</div>

	<div id="view-task-menu">

		<div class="about">
			<%
			if (employee != null) {
			%>

			<table class="task-table">
				<%
				if (!employee.getTasks().isEmpty()) {

					//sorting 
					employee.setTasks(employee.getTasks().stream().sorted((t1, t2) -> t1.getStatus().compareTo(t2.getStatus()))
					.collect(Collectors.toList()));
				%>
				<tr>
					<th>ID</th>
					<th>Description</th>
					<th>Assign On</th>
					<th>Completed On</th>
					<th>Status</th>
				</tr>
				<%
				for (Task task : employee.getTasks()) {
				%>
				<tr>
					<td><%=task.getId()%></td>
					<td><%=task.getDesc()%></td>
					<td><%=task.getCreatedDateTime()%></td>
					<td><%=task.getCompletedDateTime() == null ? "-" : task.getCompletedDateTime()%></td>
					<td><button
							onclick="location.href='update-task?taskid=<%=task.getId()%>'"
							style=<%=task.getStatus().equals("Assigned") ? "background-color:orange" : "background-color:lightgreen"%>
							class="assign-btn" ><%=task.getStatus()%></button></td>
				</tr>
				<%
				}
				%>
			</table>

			<%
			} else {
			%>
			<p class="msg">No task assigned yet!</p>
			<%
			}
			}
			%>
		</div>

	</div>


	<script>	
		
	

	 const menuBtns = document.getElementsByClassName("crud-btns")[0];
	 	 
	 const displayMenu = (event) => {
		 const menuType = event.target.id;
		console.log(menuType)
		document.getElementById('profile-menu').style.display='none';
		document.getElementById('view-task-menu').style.display='none';

		if(menuType == 'profile'){
			document.getElementById('profile-menu').style.display='block';
		} else if(menuType == 'view-task'){
			document.getElementById('view-task-menu').style.display='block';
		} 
	 } 
	 
	 menuBtns.addEventListener("click",displayMenu);
	 
	 function closeMsg(){
		 document.getElementById('msg').style.display='none';
	 }
	 
	</script>
</body>
</html>