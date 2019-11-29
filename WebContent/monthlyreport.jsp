<%@ page import="com.java.Jobsheet" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="javax.servlet.*,java.text.*" %>

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

<% ArrayList<Jobsheet> lg1= (ArrayList<Jobsheet>)request.getAttribute("lijobsheet1");%>
<%//SimpleDateFormat ft = new SimpleDateFormat ("E dd-MM-yyyy'at' hh:mm:ss a zzz");%>
<%SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");%>

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Report
        <small>Monthly Work Sheet</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Monthly Work Sheet</li>
      </ol>
    </section>

    <section class="content">
      <div class="box box-info">
        <div class="box-body">
			<font size="2" face="calibri" >

              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
					<th width="8%" style="text-align: center">Date</th>
					<th width="20%" style="text-align: center">Company</th>
					<th width="13%" style="text-align: center">Work</th>
					<th width="15%" style="text-align: center">Task</th>
					<th style="text-align: center">Details</th>
					<th width="5%" style="text-align: center">Start</th>
					<th width="5%" style="text-align: center">End</th>
					<th width="5%" style="text-align: center">Status</th>
					<th width="5%" style="text-align: center">Remarks</th>
                </tr>
                </thead>
                <tbody>
					<%
						for(int i=0;i<lg1.size();i++)
						{
							Jobsheet obj=lg1.get(i);
					%>
			    <tr>
			    
					<td><%out.println(ft.format(obj.getJob_date()));%> </td>
				    <td><%out.println(obj.getJob_company());%></td>
				    <td><%out.println(obj.getJob_work());%></td>
				    <td><%out.println(obj.getJob_task());%></td>
				    <td><%out.println(obj.getJob_details());%></td>
				    <td><%out.println(obj.getJob_time_s());%></td>
				    <td><%out.println(obj.getJob_time_e());%></td>
				    <td><%out.println(obj.getJob_status());%></td>
				    <td><%out.println(obj.getJob_manger_remark());%></td>
			    </tr>
					   <%
					    }
				    %>
                </tbody>
                <tfoot>
                <tr>
					<th style="text-align: center">Date</th>
					<th style="text-align: center">Company</th>
					<th style="text-align: center">Work</th>
					<th style="text-align: center">Task</th>
					<th style="text-align: center">Details</th>
					<th style="text-align: center">Start</th>
					<th style="text-align: center">End</th>
					<th style="text-align: center">Status</th>
					<th style="text-align: center">Remarks</th>
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
        'order'		  : [[0, 'desc']],
        'info'        : true,
        'autoWidth'   : true
    })
    $('#example2').DataTable({
    })
  })
</script>
</body>
</html>
