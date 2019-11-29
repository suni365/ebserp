<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="javax.servlet.*,java.text.*" %>

<%@ page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Exaccpro | ERP</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.min.css">
  <!-- Tab Page style -->
  <link rel="stylesheet" href="css/tabpage.css">
  
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

<style>
/* unvisited link */
a:link {
  color: black;
}

/* visited link */
a:visited {
  color: black;
}

</style>

<style>
.disptable{
    margin-left: 10px;
    margin-right: 10px;
    margin-top: 10px;
    background: white;
	font-size: 12px;
    font-family: sans-serif;
}
</style>

<style>
table {
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th {
  cursor: pointer;
}

th, td {
  text-align: left;
}

tr:nth-child(even) {
  background-color: #f2f2f2
}
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini" link="black">
<%
if (session.getAttribute("roll")==null)
{
	response.sendRedirect("index.html");
	return;
}
%>
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Control Panel
        <small>User Details</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">User Details</li>
      </ol>
    </section>

	<%
	Integer i=0;
		PreparedStatement psud=Dataconnect.connectDB().prepareStatement("select * from users where roll = ? or roll=? ORDER BY name ASC");
		psud.setString(1, "staff");
		psud.setString(2, "admin/staff");
		ResultSet rsud = psud.executeQuery();
	%>

    <!-- Main content -->
    <section class="content">
      <div class="box box-info">
	      <div class="box-body">
	      
	      <div class="tab">
			  <button class="tablinks active" onclick="openCity(event, 'Staff')">Staff</button>
			  <button class="tablinks" onclick="openCity(event, 'Admin')">Admin</button>
			  <button class="tablinks" onclick="openCity(event, 'Resigned')">Resigned</button>
		</div>

		<div id="Staff" class="tabcontent" style="display:block">
			<table border= 1 id="myTable">
			<thead>
				<tr>
				<th style="text-align: center" onclick="sortTable(0)">SL No</th>
				<th style="text-align: center" onclick="sortTable(1)">User ID</th>
				<th style="text-align: center" onclick="sortTable(2)">Roll</th>
				<th style="text-align: center" onclick="sortTable(3)">Name</th>
				<th style="text-align: center" onclick="sortTable(0)">Mobile</th>
				<th style="text-align: center" onclick="sortTable(4)">Designation</th>
				<th style="text-align: center" onclick="sortTable(5)">DOJ</th>
				<th style="text-align: center">Action</th>
				</tr>
			</thead>
			<tbody>
			<%
			while(rsud.next())
				{i = i + 1;
			%>
				<tr>
				<td style="text-align: center"><%
				if (i < 10)
					{ out.println("0"+i); }
				else
				{ out.println(i); }
				
				%>
				<td style="text-align: center"><%=rsud.getString("user")%></td>
				<td style="text-align: center"><%=rsud.getString("roll")%></td>
				<td style="text-align: center"><%=rsud.getString("name")%></td>
				<td style="text-align: center"><%=rsud.getString("mobile")%></td>
				<td style="text-align: center"><%=rsud.getString("designation")%></td>
				<td style="text-align: center"><%=rsud.getString("DOJ")%></td>
				<td style="text-align: center"><a href="#" Onclick="edituser(<%=rsud.getInt("id")%>)"><i class="fa fa-arrow-circle-right"> Edit</i></a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		</div>
		
		<div id="Admin" class="tabcontent">
		<%
			i = 0;
			psud=Dataconnect.connectDB().prepareStatement("select * from users where roll = ? ORDER BY name ASC");
			psud.setString(1, "admin");
			rsud = psud.executeQuery();
		%>
			<table border= 1 id="myTable">
			<thead>
				<tr>
				<th style="text-align: center" onclick="sortTable(0)">SL No</th>
				<th style="text-align: center" onclick="sortTable(1)">User ID</th>
				<th style="text-align: center" onclick="sortTable(2)">Roll</th>
				<th style="text-align: center" onclick="sortTable(3)">Name</th>
				<th style="text-align: center" onclick="sortTable(4)">Designation</th>
				<th style="text-align: center" onclick="sortTable(5)">DOJ</th>
				<th style="text-align: center">Action</th>
				</tr>
			</thead>
			<tbody>
			<%
			while(rsud.next())
				{i = i + 1;
			%>
				<tr>
				<td style="text-align: center"><%
				if (i < 10)
					{
					out.println("0"+i);
					}
				else
				{
					out.println(i);
				}
				
				%>
				<td style="text-align: center"><%=rsud.getString("user")%></td>
				<td style="text-align: center"><%=rsud.getString("roll")%></td>
				<td style="text-align: center"><%=rsud.getString("name")%></td>
				<td style="text-align: center"><%=rsud.getString("designation")%></td>
				<td style="text-align: center"><%=rsud.getString("DOJ")%></td>
				<td style="text-align: center"><a href="#" Onclick="edituser(<%=rsud.getInt("id")%>)"><i class="fa fa-arrow-circle-right"> Edit</i></a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		</div>
		
		<div id="Resigned" class="tabcontent">
		  <h3>Resigned</h3>
		<%
			i = 0;
			psud=Dataconnect.connectDB().prepareStatement("select * from users where roll = ? ORDER BY name ASC");
			psud.setString(1, "resigned");
			rsud = psud.executeQuery();
		%>
			<table border= 1 id="myTable">
			<thead>
				<tr>
				<th style="text-align: center" onclick="sortTable(0)">SL No</th>
				<th style="text-align: center" onclick="sortTable(1)">User ID</th>
				<th style="text-align: center" onclick="sortTable(2)">Roll</th>
				<th style="text-align: center" onclick="sortTable(3)">Name</th>
				<th style="text-align: center" onclick="sortTable(4)">Designation</th>
				<th style="text-align: center" onclick="sortTable(5)">DOJ</th>
				<th style="text-align: center">Action</th>
				</tr>
			</thead>
			<tbody>
			<%
			while(rsud.next())
				{i = i + 1;
			%>
				<tr>
				<td style="text-align: center"><%
				if (i < 10)
					{
					out.println("0"+i);
					}
				else
				{
					out.println(i);
				}
				
				%>
				<td style="text-align: center"><%=rsud.getString("user")%></td>
				<td style="text-align: center"><%=rsud.getString("roll")%></td>
				<td style="text-align: center"><%=rsud.getString("name")%></td>
				<td style="text-align: center"><%=rsud.getString("designation")%></td>
				<td style="text-align: center"><%=rsud.getString("DOJ")%></td>
				<td style="text-align: center"><a href="#" Onclick="edituser(<%=rsud.getInt("id")%>)"><i class="fa fa-arrow-circle-right"> Edit</i></a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		</div>
	      </div>
      </div>
      </section>

<!-- Sweet Alert -->
<script src='jquery/sweetalert.js'></script>
<!-- Tab Page -->
<script src='jquery/tabpage.js'></script>

<script>
	function edituser(id) {
		$.ajax({	
        url: "create_edit_staff.jsp",//your jsp page name
        method: "POST",//HTTP method.
        data: {id:id},//sending request to state.jsp page.
    	success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
        });
	};
</script>
	
<script>
	function sortTable(n) {
	  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
	  table = document.getElementById("myTable");
	  switching = true;
	  //Set the sorting direction to ascending:
	  dir = "asc"; 
	  /*Make a loop that will continue until
	  no switching has been done:*/
	  while (switching) {
	    //start by saying: no switching is done:
	    switching = false;
	    rows = table.rows;
	    /*Loop through all table rows (except the
	    first, which contains table headers):*/
	    for (i = 1; i < (rows.length - 1); i++) {
	      //start by saying there should be no switching:
	      shouldSwitch = false;
	      /*Get the two elements you want to compare,
	      one from current row and one from the next:*/
	      x = rows[i].getElementsByTagName("TD")[n];
	      y = rows[i + 1].getElementsByTagName("TD")[n];
	      /*check if the two rows should switch place,
	      based on the direction, asc or desc:*/
	      if (dir == "asc") {
	        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
	          //if so, mark as a switch and break the loop:
	          shouldSwitch= true;
	          break;
	        }
	      } else if (dir == "desc") {
	        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
	          //if so, mark as a switch and break the loop:
	          shouldSwitch = true;
	          break;
	        }
	      }
	    }
	    if (shouldSwitch) {
	      /*If a switch has been marked, make the switch
	      and mark that a switch has been done:*/
	      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
	      switching = true;
	      //Each time a switch is done, increase this count by 1:
	      switchcount ++;      
	    } else {
	      /*If no switching has been done AND the direction is "asc",
	      set the direction to "desc" and run the while loop again.*/
	      if (switchcount == 0 && dir == "asc") {
	        dir = "desc";
	        switching = true;
	      }
	    }
	  }
	}
</script>

</body>


</html>
