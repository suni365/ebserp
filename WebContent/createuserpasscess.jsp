
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*" %>
<%@page import ="java.io.*" %>
<%@page import ="javax.servlet.*,java.text.*" %>
<%@page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>

<!DOCTYPE html>
<html>
<head>
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

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Create CESS Details
        <small>CESS User Name / Password</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Create Cess User Details</li>
      </ol>
    </section>
	<%
		PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("select id, cmp_name from company ORDER BY cmp_name ASC");
//		pstm.setString(1,"admin/staff");
//		pstm.setString(2,"staff");
		ResultSet rscmp = pscmp.executeQuery();
  	%>

    <section class="content">
      <div class="box box-info">
        <div class="box-body">
	   		<table border=1 style="width:100%">
	    		<tr>
	    			<td align="center" width=25%>Select Company</td>
	    			<td>
						<select id='cmp' style="width: 100%;  overflow:scroll; border: none">
				    		<option hidden="">SELECT COMPANY</option>
						<% 
								rscmp = pscmp.executeQuery();
						  		while(rscmp.next())
						  		{
			  			%>
				    		<option value=<%=rscmp.getString("id") %> ><%=rscmp.getString("cmp_name") %></option>
			  			<%
						  		}
			  			%>
				    	</select>
					</td>
	    		</tr>
	    		<tr>
	    		<td align="center">Enter Cess User ID</td>
	    		<td>
			    <input type="text" id='cess_user' maxlength="20" style="width:100%; border: none" >
			    </td>	
	    		</tr>
	    		<tr>
	    		<td align="center">Enter Cess Password</td>
	    		<td>
			    <input type="text" id='cess_pass' maxlength="20" style="width:100%; border: none">	
	    		</td>
	    		</tr>
	    	</table>
				<div class="box-footer clearfix" style="float-bottom; height:100%">
					<button type="button" class="btn btn-info" onclick="createcessdetails();">Create Cess Details</button>
				</div>
	    	
        	
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
	function createcessdetails() {
		cmp = document.getElementById('cmp').value;
		cmp_nam = document.getElementById('cmp').options[document.getElementById("cmp").selectedIndex].text;
		cess_user = document.getElementById('cess_user').value;
		cess_pass = document.getElementById('cess_pass').value;

		$.ajax({	
        url: "Servebserp?action=createcessdetails",//your jsp page name
        method: "POST",//HTTP method.
        data: {cmp:cmp, cess_user:cess_user, cess_pass:cess_pass},//sending request to state.jsp page.
		success: function (data)
        {
				swal(cmp_nam, 'Cess user pass created Sucessfully', 'success');
        }
        });
	};
</script>

</body>
</html>
