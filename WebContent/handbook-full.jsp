<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%@ page import = "java.sql.*"%>

<%@page import="com.java.Dataconnect"%>
        
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Exaccpro | ERP</title>
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
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="css/skins/_all-skins.min.css">
  
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-blue sidebar-mini">

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Report
        <small>Hand Book</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Hand Book</li>
      </ol>
    </section>

      <!-- Daily Work Sheet -->
      <div class="box box-info">
        <div class="box-body"><h4 align="center">Daily Work Sheet</h4>

	<table border ="1" Style = "border-collapse:collapse; valign:center">
		<tr>
			<td align="center"><strong>file_no</strong></td>
			<td align="center"><strong>cmp_name</strong></td>
			<td align="center" width = 150px><strong>type</strong></td>
			<td align="center" width = 150px><strong>acc_type_id</strong></td>
			<td align="center" ><strong>team_id</strong></td>
			<td align="center" ><strong>work</strong></td>
			<td align="center" ><strong>task</strong></td>
		</tr>
<%
Integer i = 1;

	Dataconnect db =new Dataconnect();
	Connection conn=Dataconnect.connectDB();
	Statement cmpst = conn.createStatement();
	ResultSet cmp = cmpst.executeQuery("select * from company order by cmp_name");
	while (cmp.next()) {
%>
<tr>
<td bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("file_no")%></font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("cmp_name")%></font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("type")%></font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("acc_type_id")%></font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("team_id")%></font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white">&nbsp;</font></Strong></td>
<td bgcolor="skyblue"><Strong><font size="4" color="white">&nbsp;</font></Strong></td>
</tr>
<%
Statement wrkst = conn.createStatement();
ResultSet wrk = wrkst.executeQuery("select * from work where cmp_id ="+cmp.getInt("id"));
while (wrk.next()) {
%>
<tr>
<td colspan="5" ></td>
<td colspan="2" bgcolor="lightgreen"><font color="red"><%=wrk.getString("work")%></font></td>
</tr>

<%
Statement tskst = conn.createStatement();
ResultSet tsk = tskst.executeQuery("select * from task where work_id ="+wrk.getInt("id"));
while (tsk.next()) {
%>

<tr>
<td colspan="6"></td>
<td bgcolor="lightgrey"><font color="black"><%=tsk.getString("task")%></font></td>
</tr>


<%
}}
	i++;}
%>
	</table>
        </div>
        <div class="box-footer clearfix">
          <button type="button" class="btn btn-default" onclick="openPage('excel/excel_export.jsp')">Exporter <i class="fa fa-arrow-circle-right"></i></button>
          <button type="button" class="pull-right btn btn-default" >Close <i class="fa fa-arrow-circle-right"></i></button>
        </div>
      </div>
      <!-- /Daily Work Sheet -->
      
      
<script type="text/javascript">
	function openPage(pageURL)
 	{
 	window.location.href = pageURL;
 	}
</script>
      
</body>
</html>