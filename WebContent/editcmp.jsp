
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*" %>
<%@page import ="java.io.*" %>
<%@page import ="javax.servlet.*,java.text.*" %>
<%@page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>

<%@page import="com.java.Arrayclass"%>

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
        Edit Client
        <small>Details</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#" onclick="cmplist();">Client List</a></li>
        <li class="active">Update Client Details</li>
      </ol>
    </section>
	<%
		Integer cmp_id = Integer.parseInt(request.getParameter("cmp_id"));
		PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("SELECT * FROM company WHERE id=?");
		pscmp.setInt(1,cmp_id);
		ResultSet rscmp = pscmp.executeQuery();
  	%>

	<%
	ArrayList<Arrayclass> altg = new ArrayList<Arrayclass>();

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
            	   		<table border=1 style="width:100%">
<%
			while (rscmp.next())
			{
 %>
 	   		<tr>
	   		<td width=20%>Client ID</td>
	   		<td><%=rscmp.getInt("id") %> </td>
	   		</tr>
	   		<tr>
	   		<td>Client No</td>
	   		<td><%=rscmp.getInt("file_no")%></td>
	   		</tr>
	   		<tr>
	   		<td>Name</td>
	   		<td><input type="text" id="cmp_name" value='<%=rscmp.getString("cmp_name") %>' style = "width:100% ; border: none"></td>
	   		</tr>
	   		<tr>
	   		<td>Status</td>
	   		<td>
				<select id="cmp_status" style = "width:100%; background-color:transparent; border: none">
					<option value = 1 <% if (rscmp.getInt("cmp_status")==1) { %> selected <% } %> >Running</option>
					<option value = 2<% if (rscmp.getInt("cmp_status")==2) { %> selected <% } %> >Hold</option>
					<option value = 3 <% if (rscmp.getInt("cmp_status")==3) { %> selected <% } %> >Stopped</option>
				</select>
			</td>
	   		</tr>
	   		<tr>
	   		<td>Type</td>
	   		<td>
				<select id="cmp_type" style = "width:100%; background-color:transparent; border: none">
					<option <% if (rscmp.getString("type").equals("SME")) { %> selected <% } %> >SME</option>
					<option <% if (rscmp.getString("type").equals("NSME")) { %> selected <% } %> >NSME</option>
					<option <% if (rscmp.getString("type").equals("ASME")) { %> selected <% } %> >ASME</option>
				</select>
			</td>
	   		</tr>
	   		<tr>
	   		<td>Accounting Style</td>
	   		<td>
				<select id="acc_type_id" style = "width:100%; background-color:transparent; border: none">
					<option value = 1 <% if (rscmp.getInt("acc_type_id")==1) { %> selected <% } %> >Accounting Only</option>
					<option value = 2 <% if (rscmp.getInt("acc_type_id")==2) { %> selected <% } %> >Verification</option>
					<option value = 3 <% if (rscmp.getInt("acc_type_id")==3) { %> selected <% } %> >Filing</option>
				</select>
			</td>
	   		</tr>
	   		<tr>
	   		<td>Team</td>
	   		<td>
				<select style="border: none; width: 100%; background: 0 0; overflow:scroll;" id="team_id">
		      		<%
					for (Arrayclass count: altg)
		            {
	      			%>
			      		<Option value = <%=count.getTeam_id()%>  
	      			<%
	      				if (count.getTeam_id() == rscmp.getInt("team_id"))
	      				{
	      					out.println("Selected");
	      				}
	      			%>
	      			> <%=count.getTeam_team_name() %> </Option>
	      			<%
		      			}
		      		%>

				</select>				
	   		</td>
	   		</tr>
	   		<tr>
	   		<td>GST Login ID</td>
	   		<td><input type="text" id="gst_login_id" value='<%=rscmp.getString("gst_login_id") %>' style = "width:100%; border: none"></td>
	   		</tr>
	   		<tr>
	   		<td>GST Login Pass</td>
	   		<td><%=rscmp.getString("gst_login_pass") %></td>
	   		</tr>
	   		<tr>
	   		<td>GST Reg Mobile No:</td>
	   		<td><input type="text" id="gst_mobile" value='<%=rscmp.getString("gst_mobile") %>' style = "width:100%; border: none"></td>
	   		</tr>
	   		<tr>
	   		<td>GST Reg email</td>
	   		<td><input type="text" id="gst_email" value='<%=rscmp.getString("gst_email") %>' style = "width:100%; border: none"></td>
	   		</tr>
	   		<tr>
	   		<td>Cess Login ID</td>
	   		<td><%=rscmp.getString("cess_login_id") %></td>
	   		</tr>
	   		<tr>
	   		<td>Cess Login Pass</td>
	   		<td><%=rscmp.getString("cess_login_pass") %></td>
	   		</tr>
<%
}
%>
	    	</table>
				<div class="box-footer clearfix" style="float-bottom; height:100%">
					<button type="button" class="btn btn-info" onclick="deletecmpdetails();">DELETE</button>
					<button type="button" class="pull-right btn btn-info" onclick="updatecmpdetails();">UPDATE</button>
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
function updatecmpdetails() {
	cmp_id = <%=cmp_id%>;
	cmp_name = document.getElementById('cmp_name').value;
	cmp_status = document.getElementById('cmp_status').value;
	cmp_type = document.getElementById('cmp_type').value;
	acc_type_id = document.getElementById('acc_type_id').value;
	team_id = document.getElementById('team_id').value;
	gst_login_id = document.getElementById('gst_login_id').value;
	gst_mobile = document.getElementById('gst_mobile').value;
	gst_email = document.getElementById('gst_email').value;
	
	$.ajax({	
    url: "Servebserp?action=cmpupdate",//your jsp page name
	method: "POST",//HTTP method.
    data: {cmp_id:cmp_id, cmp_name:cmp_name, cmp_status:cmp_status, cmp_type:cmp_type, acc_type_id:acc_type_id, team_id:team_id, gst_login_id:gst_login_id, gst_mobile:gst_mobile, gst_email:gst_email},//sending request to state.jsp page.
    success: function (data)
    {
		swal(cmp_name, 'Company Details Updated Sucessfully', 'success');
    }
    });
};

</script>

</body>
</html>
