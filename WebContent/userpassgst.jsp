
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*" %>
<%@page import ="java.io.*" %>
<%@page import ="javax.servlet.*,java.text.*" %>
<%@page import="java.util.ArrayList" %>

<%@page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

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
  <!-- DataTables -->
  <link rel="stylesheet" href="css/dataTables.bootstrap.min.css">
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

<%SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");%>

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        GST Details
        <small>GST User Name / Password</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Monthly Work Sheet</li>
      </ol>
    </section>
	<%
		PreparedStatement psgst=Dataconnect.connectDB().prepareStatement("select * from company ORDER BY cmp_name ASC");
//		pstm.setString(1,"admin/staff");
//		pstm.setString(2,"staff");
		ResultSet rsgst = psgst.executeQuery();
  	%>

    <section class="content">
      <div class="box box-info">
        <div class="box-body">
			<font size="2" face="calibri" >
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
					<th style="text-align: center">Name</th>
					<th width="10%" style="text-align: center">Login Id</th>
					<th width="10%" style="text-align: center">Password</th>
					<th width="10%" style="text-align: center">Mobile</th>
					<th width="10%" style="text-align: center">Email</th>
					<th width="10%" style="text-align: center">Prv Pass Changed</th>
					<th width="10%" style="text-align: center">Prv Pass</th>
                </tr>
                </thead>
                <tbody>
				<% 
		  		while(rsgst.next())
		  		{
	  			%>
			    <tr>
<%-- 					<td><%out.println(ft.format(rsgst.getJob_date()));%> </td>
--%>
				    <td><%=rsgst.getString("cmp_name")%></td>
				    <td><%=rsgst.getString("gst_login_id")%></td>
				    <td><%=rsgst.getString("gst_login_pass")%></td>
				    <td><%=rsgst.getString("gst_mobile")%></td>
				    <td><%=rsgst.getString("gst_email")%></td>
				    <td><%=ft.format(rsgst.getDate("gst_pass_changed_on"))%></td>
				    <td><%=rsgst.getString("gst_prv_pass")%></td>

			    </tr>
			    <%
			    }
				%>
                </tbody>
                <tfoot>
                <tr>
					<th style="text-align: center">Name</th>
					<th style="text-align: center">Login Id</th>
					<th style="text-align: center">Password</th>
					<th style="text-align: center">Mobile</th>
					<th style="text-align: center">Email</th>
					<th style="text-align: center">Prv Pass Changed</th>
					<th style="text-align: center">Prv Pass</th>
                </tr>
                </tfoot>
              </table>
              </font>
              </div>
              </div>
    </section>
<!-- jQuery 3 -->
<!-- DataTables -->
<script src="jquery/jquery.dataTables.min.js"></script>
<script src="jquery/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="jquery/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="jquery/fastclick.js"></script>

<!-- page script -->
<script>
  $(function () {
 	$('#example1').DataTable({
 		'lengthMenu'  : [[10, 25, 50, -1], [10, 25, 50, "All"]],
		'searching'   : true,
        'paging'      : true,
        'lengthChange': true,
        'ordering'    : true,
        'order'		  : [[0, 'asc']],
        'info'        : true,
        'autoWidth'   : true
    })
    $('#example2').DataTable({
    })
  })
</script>
</body>
</html>
