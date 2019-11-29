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
        Client
        <small>List</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Client List</li>
      </ol>
    </section>
	<%

		ArrayList<Arrayclass> altg = new ArrayList<Arrayclass>();

	
		PreparedStatement psgst=Dataconnect.connectDB().prepareStatement("select * from company ORDER BY cmp_name ASC");
		ResultSet rsgst = psgst.executeQuery();
		
		PreparedStatement pstg=Dataconnect.connectDB().prepareStatement("select * from team ");
		ResultSet rstg = pstg.executeQuery();
  		while(rstg.next())
  		{
  			Arrayclass objtg = new Arrayclass();
  			objtg.setTeam_id(rstg.getInt("id"));
  			objtg.setTeam_team_name(rstg.getString("team_name"));
  			altg.add(objtg);
  		}  		

  	%>

    <section class="content">
      <div class="box box-info">
        <div class="box-body">
              <table id="example1" style="font-size:10pt; font-face:calibri" class="table table-bordered table-striped">
                <thead>
                <tr>
					<th width="5%" style="text-align: center">SL</th>
					<th width="10%" style="text-align: center">File No:</th>
					<th style="text-align: center">Client Name</th>
					<th width="10%" style="text-align: center">TYPE</th>
					<th width="10%" style="text-align: center">Nature</th>
					<th width="10%" style="text-align: center">Team</th>
					<th width="10%" style="text-align: center">Status</th>
                </tr>
                </thead>
                <tbody>
				<% 
				int i=1;
		  		while(rsgst.next())
		  		{
	  			%>
			    <tr>
<%-- 					<td><%out.println(ft.format(rsgst.getJob_date()));%> </td>
--%>
				    <td><%=i%></td>
				    <td><%=rsgst.getInt("file_no")%></td>
				    <td> <a href="#" onClick="cmpedit(<%=rsgst.getInt("id")%>)"><%=rsgst.getString("cmp_name")%> </a> </td>
				    <td><%=rsgst.getString("type")%></td>
				    <td>
				    <%
				    switch (rsgst.getInt("acc_type_id"))
				    {
				    case 1:
				    	out.println("Full Accounting");
				    	break;
				    case 2:
				    	out.println("Verification only");
				    	break;
				    case 3:
				    	out.println("Filing Only");
				    	break;
				    }
				    %>
				    </td>
				    <td>
				    
   		      		<%
					for (Arrayclass count: altg)
		            {
	      				if (count.getTeam_id() == rsgst.getInt("team_id"))
	      				{
	      					out.println(count.getTeam_team_name());
	      				}
	      			}
		      		%>
				    <td>
				    <%
				    switch (rsgst.getInt("cmp_status"))
				    {
				    case 1:
				    	out.println("Running");
				    	break;
				    case 2:
				    	out.println("Hold");
				    	break;
				    case 3:
				    	out.println("Stopped");
				    	break;
				    }
				    %>
				    </td>

			    </tr>
			    <%
			    i++;
			    }
				%>
                </tbody>
              </table>
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
function cmpedit(cmp_id) {
//	alert(cmp_id);
	
	$.ajax({	
    url: "editcmp.jsp",//your jsp page name
    method: "POST",//HTTP method.
    data: {cmp_id:cmp_id},//sending request to state.jsp page.
	success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};

</script>

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
