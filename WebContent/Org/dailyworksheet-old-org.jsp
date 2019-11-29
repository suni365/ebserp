<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%@ page import = "java.sql.*"%>

<%@page import="com.java.Dataconnect"%>
<%@ page  import="com.java.users" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Employee | Dashboard</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="css/skins/_all-skins.min.css">  
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">

<% users lg= (users)request.getAttribute("objuser");%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Daily Work Sheet -->
<form action = "Servebserp">
<div class="box box-info">
<div class="box-header">
	<h4 align="center">Daily Work Sheet</h4>
<div class="box-tools pull-right">
	<button type="button" class="btn bg-teal btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
	</button>
	<button type="button" class="btn bg-teal btn-sm" data-widget="remove"><i class="fa fa-times"></i>
	</button>
</div>
</div>

<div class="box-body">
	<table border="1"  id="job_sheet">
  	<tbody>
    <tr>
      <th width="20%" bgcolor="#9D99F8" style="text-align: center" scope="col">Company</th>
      <th width="12%" bgcolor="#9D99F8" style="text-align: center" scope="col">Work</th>
      <th width="15%" bgcolor="#9D99F8" style="text-align: center" scope="col">Task</th>
      <th bgcolor="#9D99F8" style="text-align: center" scope="col">Details</th>
      <th width="8%" bgcolor="#9D99F8" style="text-align: center" scope="col">Time Start</th>
      <th width="8%" bgcolor="#9D99F8" style="text-align: center" scope="col">Time End</th>
      <th width="10%" bgcolor="#9D99F8" style="text-align: center" scope="col">Status</th>
    </tr>
<% for(int i = 1; i <= 2; i++)
{
	%>
   <tr>
      <%-- <td> <input type = "text" name = "company" placeholder = "select company" style="border: none; width: 100%"> </td> --%>
      <td>
	      <select id="company_id<%=i %>" name="company" style="border: none; width: 100%;  overflow:scroll;" >
		      <Option hidden= "" > Select company</Option>
              
              <%
	      		Dataconnect db =new Dataconnect();
	      		Connection conn=db.connectDB();
	      		Statement st = conn.createStatement();
	            ResultSet rs = st.executeQuery("select * from company");
                while (rs.next()) {
              %>
              <option value="<%=rs.getString("id")%>"><%=rs.getString("cmp_name")%></option>
              <%
                  }
              %>
	      </select>
      </td>
      <td id="work_id<%=i%>">
	      <select style="border: none; width: 100%;" >
		      <Option hidden = "">Select Work</Option>
	      </select>
	  </td>
      <td id ="task_id<%=i%>">
	      <select style="border: none; width: 100%;" >
		      <Option hidden = "">Select Task</Option>
	      </select>
	  </td>
      <td> <input type = "text" name = "details" placeholder = "Type details" style="border: none; width: 100%"></td>
      <td> <input type = "text" name = "time_s" placeholder = "Start time" style="border: none; text-align: center;  width: 100%" value="9:30 am" ></td>
      <td> <input type = "text" name = "time_e" placeholder = "End time" style="border: none; text-align: center; width: 100%"></td>
      <td>
   	      <select name ="status" style="border: none; width: 100%">
	      <Option hidden = "">Select Status</Option>
	      <Option>On Process</Option>
	      <Option>Finished</Option>
	      </select>
	</td>
    </tr>
    <%
    }
    %>
  </tbody>
</table>

        </div>
        
        <div class="box-footer clearfix">
			<input type="hidden" name="action" value="addrecord">
			<button type="submit" class="pull-right btn btn-default" id="sendEmail">Send <i class="fa fa-arrow-circle-right"></i></button>
        </div>
      </div>

</form>
      <!-- /Daily Work Sheet -->
      
<!-- jQuery 3 -->
<script src="jquery/jquery.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="jquery/bootstrap.min.js"></script>

</body>

<script>
$(document).ready(function () {
	
    $("#company_id1").on("change", function () {
        var company_id = $("#company_id1").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 1},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id1").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id2").on("change", function () {
        var company_id = $("#company_id2").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 2},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id2").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id3").on("change", function () {
        var company_id = $("#company_id3").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 3},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id3").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>


<script>
$(document).ready(function () {
	
    $("#company_id4").on("change", function () {
        var company_id = $("#company_id4").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 4},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id4").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id5").on("change", function () {
        var company_id = $("#company_id5").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 5},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id5").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id6").on("change", function () {
        var company_id = $("#company_id6").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 6},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id6").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id7").on("change", function () {
        var company_id = $("#company_id7").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 7},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id7").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

<script>
$(document).ready(function () {
	
    $("#company_id8").on("change", function () {
        var company_id = $("#company_id8").val();//id of company select box of index.jsp page;
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company_id: company_id, row_id: 8},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id8").html(data);//output or response will display in state select box.
                }
            });
    });

	});
</script>

</html>