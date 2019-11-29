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

  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<%
if (session.getAttribute("roll")==null)
	{
		response.sendRedirect("index.html");
		return;
	}
%>

<%//SimpleDateFormat ft = new SimpleDateFormat ("E dd-MM-yyyy'at' hh:mm:ss a zzz");%>
<%SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");%>

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Report
        <small>Under Process Jobs</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Under Process Jobs</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->      
      <div class="box box-info"><h5 align = "center"><strong>Under Process Jobs</strong></h5>
        <div class="box-body">
			<font size="2" face="Calibri" >
              <table id="dailyreport" class="table table-bordered table-striped">
                <thead>
                <tr>
					<th width="8%" style="text-align: center">Date</th>
					<th width="20%" style="text-align: center">Company</th>
					<th width="13%" style="text-align: center">Work</th>
					<th width="15%" style="text-align: center">Task</th>
					<th width="25%" style="text-align: center">Details</th>
                </tr>
                </thead>
                <tbody>
					<%
					PreparedStatement psupj=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where job_user_id = ? AND Job_status1 = ?");
					psupj.setInt(1,(Integer) session.getAttribute("id"));
					psupj.setString(2, "On Process");

					ResultSet rsupj = psupj.executeQuery();

					while(rsupj.next())
					{
					%>
			    <tr>
					<td><%out.println(ft.format(rsupj.getDate("Job_date")));%> </td>
				    <td><%out.println(rsupj.getString("Job_company"));%></td>
				    <td><%out.println(rsupj.getString("Job_work"));%></td>
				    <td><%out.println(rsupj.getString("Job_task"));%></td>
				    <td><%out.println(rsupj.getString("Job_details"));%></td>
			    </tr>
					   <%
					    }
				    %>
                </tbody>
              </table>
              </font>
              </div>
              </div>
    </section>    <!-- /.content -->

</body>
</html>
