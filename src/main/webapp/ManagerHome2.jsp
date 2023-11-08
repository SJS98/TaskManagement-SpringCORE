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

.form {
	text-align: center;
	padding-top: 200px;
	width: 600px;
	margin: auto;
}

.form input, #search-field {
	height: 30px;
	width: 250px;
	border: none;
	box-sizing: border-box;
	outline-offset: 4px;
	outline-color: gray;
	outline-width: 0.5px;
	margin: 7px;
	padding-left: 10px;
	border-radius: 20px;
	box-shadow: 0 0 10px -5px;
}

.form div * {
	margin-top: 20px;
	height: 30px;
	width: 100px;
	border-radius: 35px;
	transition: all .05s ease-in-out;
	border: none;
	color: #fff;
	font-weight: bold;
	box-shadow: 0 0 10px -5px black;
}

.options {
	display: list-item;
	list-style: none;
	max-width: 300px;
	margin: auto;
}

.buttons button {
	width: 250px;
	height: 30px;
	padding: 5px 10px;
	margin-top: 10px;
	border: none;
	border-radius: 5px;
	background: rgba(255, 255, 255, .8);
}

#add-emp-menu img {
	position: absolute;
	top: 50px;
	left: 500px;
	height: 100px;
}

#view-emp-menu img {
	position: absolute;
	top: 40px;
	left: 100px;
	height: 100px;
}

#search-field {
	margin-left: 20px;
	margin-top: 150px;
}

.emp-id {
	position: relative;
	margin: auto;
	top: 20px;
	left: 400px;
}

#add-emp-menu h1 {
	background-color: #fff;
	border-radius: 40px;
	margin: 20px auto;
	width: fit-content;
	padding: 10px 40px;
	box-shadow: inset 0 0 10px -5px;
}

#view-emp-menu h1 {
	background-color: #fff;
	border-radius: 40px;
	width: fit-content;
	padding: 10px 40px;
	box-shadow: inset 0 0 10px -5px;
}

.add-btn:hover, .back-btn:hover {
	cursor: pointer;
}

.add-btn:active, .back-btn:active {
	transform: scale(.95);
}

.add-btn, .back-btn {
	box-shadow: 0 0 10px -5px;
}

.add-btn {
	background: rgba(176, 255, 123, 0.8);
}

#view-emp-menu {
	height: 80vh;
	width: 80vw;
	margin: 2% 10% 0% 10%;
	background: rgba(255, 255, 255, .3);
	border-radius: 10px;
	box-shadow: 0 0 10px -5px;
	backdrop-filter: blur(10px);
	height: 80vh;
}

#add-emp-menu, #profile-menu, #view-all-emp-menu, #remove-emp-menu,
	#update-emp-menu, #assign-task-menu {
	display: none;
	height: 80vh;
	width: 80vw;
	margin: 2% 10% 0% 10%;
	background: rgba(255, 255, 255, .3);
	border-radius: 10px;
	box-shadow: 0 0 10px -5px;
	backdrop-filter: blur(10px);
}

#msg {
	color: whitesmoke;
	min-width: 250px;
	padding: 10px;
	border-radius: 5px;
	position: absolute;
	margin: 30px 550px;
	box-shadow: 0 0 10px 2px white;
	font-weight: bold;
	text-align: center
}

.emp-details {
	margin: auto;
	margin-top: 40px;
	height: 250px;
	width: 800px;
	background-color: #fff;
	height: 250px;
	border-radius: 10px;
}

.emp-details::-webkit-scrollbar {
	display: none;
}

.emp-details .about {
	padding-top: 10px;
	overflow: scroll;
	height: 220px;
}

*::-webkit-scrollbar {
	display: none;
}

table th {
	height: fit-content;
}

table tr {
	background-color: rgba(0, 0, 0, .1);
	border-radius: 5px;
}

table td {
	text-align: center;
}

.about-table {
	width: 800px;
	display: flex;
	justify-content: space-evenly;
}

.about-table * {
	padding: 5px;
}

.task-table {
	width: 800px;
	height: 200px;
	overflow: hidden;
}
</style>

</head>
<body>


	<%
	// FetchAll Users

	List<User> emps = (List<User>) session.getAttribute("emp_list");

	Map<Integer, List<Task>> allTaskByUserId = new HashMap<>();

	for (User user : emps) {
		allTaskByUserId.put(user.getId(), user.getTasks());
	}

	User searchedEmp = null;

	String id = request.getParameter("id");
	if (id != null) {
		int empId = Integer.parseInt(id);
		for (User user : emps)
			if (user.getId() == empId) {
		searchedEmp = user;
		break;
			}
	}
	%>
	<nav>
		<span class="logo" onclick="location.href='index.html'">LOGO</span>
		<div class="crud-btns">
			<button id="add-emp">Add Emp</button>
			<button id="view-emp">View Emp</button>
			<button id="view-all-emp">View All Emps</button>
			<button id="assign-task">Assign Task</button>
			<button id="remove-emp">Remove Emp</button>
			<button id="update-emp">Update Emp</button>
			<button id="profile">Profile</button>
			<button onclick="location.href='logout'">Logout</button>
		</div>
	</nav>

	<div id="add-emp-menu">

		<div class="options">
			<img
				src="https://cdn3.iconfinder.com/data/icons/team-management/136/19-1024.png"
				alt="img">
		</div>

		<div class="form">
			<h1>Add Employee</h1>
			<form action="add-emp" method="post">

				<input type="text" name="username" placeholder="Full Name" required>
				<input type="email" name="email" placeholder="Email" required>
				<input type="password" id="pass" name="password"
					placeholder="Password" required> <input type="password"
					id="cpass" name="cpassword" placeholder="Confirm Password" required>
				<div>
					<button class="add-btn">Add</button>
				</div>
			</form>
			<p id="incorrectPass" style="display: none">Password does not
				match!</p>
		</div>
	</div>

	<div id="view-emp-menu">

		<div class="emp-id">
			<form action="ManagerHome.jsp">
				<input type="search" id="search-field"
					placeholder="Enter Employee ID" name="id"> <input
					type="search" class="search-btn">
			</form>

			<div class="options">
				<img
					src="https://cdn3.iconfinder.com/data/icons/team-management/136/19-1024.png"
					alt="img">
			</div>
		</div>

		<div class="emp-details">
			<div class="about">
				<%
				if (searchedEmp != null) {
				%>
				<table class="about-table">
					<tr>
						<th>Employee ID</th>
						<th>Employee Name</th>
						<th>Employee Email</th>
					</tr>
					<tr>
						<td id="empId"></td>
						<td id="empName"></td>
						<td id="empEmail"></td>
					</tr>
				</table>
				<table class="task-table">
					<%
					if (!searchedEmp.getTasks().isEmpty()) {

						for (Task task : searchedEmp.getTasks()) {
					%>
					<tr>
						<td><%=task.getId()%></td>
						<td><%=task.getDesc()%></td>
						<td><%=task.getCreatedDateTime()%></td>
						<td><%=task.getCompletedDateTime()%></td>
						<td><%=task.getStatus()%></td>
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
				%>
			</div>

			<%
			} else {
			%>
			<p class="msg">No Employee! Please search</p>
			<%
			}
			%>
		</div>
	</div>

	<div id="view-all-emp-menu"></div>
	<div id="assign-task-menu"></div>
	<div id="remove-emp-menu"></div>
	<div id="update-emp-menu"></div>
	<div id="profile-menu"></div>

	<script>
	
	function updateEmpDetails() {
        // Get the user input from the search field
        var userInput = document.getElementById("search-field").value;

        // Pass the user input to the scriptlet
        <%String userInput = "' + userInput + '";

System.out.print(userInput);%>
	}
	
	
	
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

	 const menuBtns = document.getElementsByClassName("crud-btns")[0];
	 	 
	 const displayMenu = (event) => {
		 const menuType = event.target.id;
		console.log(menuType)
		document.getElementById('add-emp-menu').style.display='none';
		document.getElementById('view-emp-menu').style.display='none';
		document.getElementById('view-all-emp-menu').style.display='none';
		document.getElementById('assign-task-menu').style.display='none';
		document.getElementById('remove-emp-menu').style.display='none';
		document.getElementById('update-emp-menu').style.display='none';
		document.getElementById('profile-menu').style.display='none';

		if(menuType == 'profile'){
			document.getElementById('profile-menu').style.display='block';
		} else if(menuType == 'add-emp'){
			document.getElementById('add-emp-menu').style.display='block';
		} else if(menuType == 'view-emp'){
			document.getElementById('view-emp-menu').style.display='block';
		} else if(menuType == 'view-all-emp'){
			document.getElementById('view-all-emp-menu').style.display='block';
		} else if(menuType == 'assign-task'){
			document.getElementById('assign-task-menu').style.display='block';
		} else if(menuType == 'remove-emp'){
			document.getElementById('remove-emp-menu').style.display='block';
		} else if(menuType == 'update-emp'){
			document.getElementById('update-emp-menu').style.display='block';
		}
	 } 
	 
	 menuBtns.addEventListener("click",displayMenu);
	 
	 function closeMsg(){
		 document.getElementById('msg').style.display='none';
	 }
	 
	</script>
</body>
</html>