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
        Report
        <small>Hand Book</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Hand Book</li>
      </ol>
    </section>

      <!-- Daily Work Sheet -->
      <div class="box box-info">
        <div class="box-body"><h4 align="center">Hand Book</h4>

	<table border ="1" Style = "border-collapse:collapse; width:100%">
		<tr>
			<td align="center"><strong>Sl</strong></td>
			<td align="center" width = 70px><strong>Company</strong></td>
			<td align="center" width = 70px><strong>Work</strong></td>
			<td align="center" ><strong>Task</strong></td>
		</tr>
<%
Integer i = 1;

	Dataconnect db =new Dataconnect();
	Connection conn=Dataconnect.connectDB();
	Statement cmpst = conn.createStatement();
	ResultSet cmp = cmpst.executeQuery("select * from company where team_id =" + session.getAttribute("team_id") + " order by team_id, cmp_name");
	while (cmp.next()) {
%>
<tr>
<td align="center"><%=i%></td>
<td colspan = "3" bgcolor="skyblue"><Strong><font size="4" color="white"><%=cmp.getString("cmp_name")%></font></Strong></td>
</tr>
<%
Statement wrkst = conn.createStatement();
ResultSet wrk = wrkst.executeQuery("select * from work where cmp_id ="+cmp.getInt("id"));
while (wrk.next()) {
%>
<tr>
<td colspan="2" ></td>
<td colspan="2" bgcolor="lightgreen"><font color="red"><%=wrk.getString("work")%></font></td>
</tr>

<%
Statement tskst = conn.createStatement();
ResultSet tsk = tskst.executeQuery("select * from task where work_id ="+wrk.getInt("id"));
while (tsk.next()) {
%>

<tr>
<td colspan="3"></td>
<td bgcolor="lightgrey"><font color="black"><%=tsk.getString("task")%></font></td>
</tr>


<%} %>
<%} %>


<%
	i++;}
%>
	</table>
        </div>
        <div class="box-footer clearfix">
          <button type="button" class="pull-right btn btn-default" >Close <i class="fa fa-arrow-circle-right"></i></button>
        </div>
      </div>
      <!-- /Daily Work Sheet -->
</body>
</html>