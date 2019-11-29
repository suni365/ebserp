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
        <small>Pending Jobs</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Pending Jobs</li>
      </ol>
    </section>

	<%
		PreparedStatement pstm=Dataconnect.connectDB().prepareStatement("select * from users where ver_userid = ?");
		pstm.setInt(1,(Integer) session.getAttribute("id"));
	
		ResultSet rstm = pstm.executeQuery();
	%>


    <!-- Main content -->
      <div class="disptable">
      	<h4 align = "center">Team Members Work Pending For Verification</h4>
	<table class="table table-bordered table-striped" id=emp >
		<thead>
			<tr>
			<th width="8%" style="text-align: center">Date</th>
			<th width="20%" style="text-align: center">Company</th>
			<th width="13%" style="text-align: center">Work</th>
			<th width="15%" style="text-align: center">Task</th>
			<th style="text-align: center">Details</th>
			<th width="5%" style="text-align: center">Remark</th>
			<th width="12%" style="text-align: center">Status</th>
			</tr>
		</thead>
	<%	
	int row_id=0;
		while(rstm.next())
			{row_id = row_id+1;
	%>
<tr>
<td align = center> <img src= "img/users/<%=rstm.getString("user")%>.jpg" class="img-circle" width=50 height=50 ></td>
<td colspan = 6> <H3><%  out.println("Team Member : "+rstm.getString("name") );%></H3></td>
</tr>

	<%
		PreparedStatement pstmjv=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where job_user_id = ? AND isnull(Job_manager_status)");
		pstmjv.setInt(1,rstm.getInt("id"));
	
		ResultSet rstmjv = pstmjv.executeQuery();

		while(rstmjv.next())
			{
			row_id = row_id+1;
	%>
   			<tr>
			<td><%out.println(ft.format(rstmjv.getDate("Job_date")));%> </td>
		    <td><%out.println(rstmjv.getString("Job_company"));%></td>
		    <td><%out.println(rstmjv.getString("Job_work"));%></td>
	 	    <td><%out.println(rstmjv.getString("Job_task"));%></td>
		    <td><%out.println(rstmjv.getString("Job_details"));%></td>
		    <td><input type = "text" maxlength=30 id='manager_remark<%=row_id%>'></td>
		    <td>
		    <input type = 'button' onClick="myMJVFunc(<%=row_id%>,this,<%=rstmjv.getString("Job_id")%>,'Accept');" value ="Accept">
		    <input type = 'button' onClick="myMJVFunc(<%=row_id%>,this,<%=rstmjv.getString("Job_id")%>,'Reject');" value ="Reject">
		    </td>
			</tr>
   <%
		    }
    %>

	<%
			}
	%>
</table>



       </div>

</body>

<script>
	function myMJVFunc(manremid,row_det, Job_id, job_verstat) {
		row_id = row_det.parentNode.parentNode.rowIndex;

		manremark = document.getElementById('manager_remark'+manremid).value;
//		var myTab = document.getElementById('emp');
//		var objCells = myTab.rows.item(2).cells;
//		var asd = objCells.item(5).innerHTML;
//		alert(asd);		

//		var x1 = $(row_det).val();
//		alert(x1);
		
		
		$.ajax({	
        url: "Servebserp?action=managerjobver",//your jsp page name
        method: "POST",//HTTP method.
        data: {manremark : manremark, Job_id: Job_id, job_verstat:job_verstat},//sending request to state.jsp page.
        success: function (data)
        {
		    emp.deleteRow(row_id);

//            $("#ajaxpage").html(data);//output or response will display in state select box.
        }
        });
	};
</script>


</html>
