<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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
<body>
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
        Create / Alter
        <small>Hand Book</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Hand Book Details</li>
      </ol>
    </section>

	<%
		PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("select * from company ORDER BY cmp_name ASC");
//		pstm.setString(1,"admin/staff");
//		pstm.setString(2,"staff");
		ResultSet rscmp;

		PreparedStatement psteam=Dataconnect.connectDB().prepareStatement("select * from team ORDER BY team_name ASC");
		ResultSet rsteam = psteam.executeQuery();
	%>
  	    <!-- Main content -->
    <section class="content">

			<div class="box box-info">
            	<div class="box-header">
	              <i class="fa fa-th"></i>
    	          <h3 class="box-title">Create Company</h3>
        		  	<div class="box-tools pull-right">
						<button type="button" class="btn bg-teal btn-sm" data-toggle="collapse" data-target="#create-cmp"><i class="fa fa-plus"></i></button>
					</div>
            </div>
            <div class="box-body border-radius-none collapse" id="create-cmp" >
              <div style="height: 100px">
	    		<table border=1 style="width:100%">
		    		<tr>
		    			<td align="right" width=25%>Company Name &nbsp;</td>
		    			<td> <input type="text" id="company" style="border: none; width: 100%;" ></td>
	    			</tr>
	    			<tr>
		    			<td align="right">Type &nbsp;</td>
		    			<td>&nbsp;
		    			<input type="radio" name = "type" id="type" value="SME" style="border: none">
		    			SME
		    			<input type="radio" name = "type" id="type" value="NSME" style="border: none" checked>
		    			NSME
		    			<input type="radio" name = "type" id="type" value="ASME" style="border: none">
		    			ASME
		    			</td>
	    			</tr>
	    			<tr>
		    			<td align="right">Accounts Type &nbsp;</td>
		    			<td>&nbsp;
		    			<input type="radio" name="acc" id="acc" value=1 style="border: none" checked>
		    			Accounting
		    			<input type="radio" name="acc" id="acc" value=2 style="border: none" >
		    			Verification
		    			<input type="radio" name="acc" id="acc" value=3 style="border: none" >
		    			Filing
		    			</td>
	    			</tr>
	    			<tr>
		    			<td align="right">Team &nbsp;</td>
		    			<td>
		    			<select id="team" style="border: none; width: 100%;" >
		    			<%
				  		while(rsteam.next())
				  		{
		    			%>
		    			<option value=<%=rsteam.getInt("id")%>><%=rsteam.getString("team_name")%></option>
		    			<%
				  		}
		    			%>
		    			</select>
						</td>
		    		</tr>
		    	</table>
              </div>
	            <div class="box-footer clearfix" style="float-bottom">
					<button type="button" class="btn btn-info" onclick="myCMPADDFunc();">Create New Company</button>
				</div>
            </div>
          </div>

<br>
			<div class="box box-info">
            	<div class="box-header">
	              <i class="fa fa-th"></i>
    	          <h3 class="box-title">Create Work</h3>
        		      <div class="box-tools pull-right">
						<button type="button" class="btn bg-teal btn-sm" data-toggle="collapse" data-target="#create-work"><i class="fa fa-plus"></i></button>
				</div>
            </div>
            <div class="box-body border-radius-none collapse" id="create-work" >
              <div style="height: 50px;">
				<table border=1 style="width:70%">
	    		<tr>
    				<td align="right" width=25%>Select Company : </td>
	    			<td>
						<select id="company1" style="width: 100%; overflow:scroll; border: none">
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
	    		<td align="right">Select Work : </td>
	    		<td id="work_sel1">
					<select style="border: none; width: 100%;" >
						 <Option hidden = "">Select Work</Option>
					</select>
	    		</td>
	    		</tr>
	    	</table>
              </div>
	            <div class="box-footer clearfix" style="float-bottom; height:100%">
					<button type="button" class="btn btn-info" onclick="myWORKADDFunc();">Create New Work</button>
				</div>
            </div>
          </div>

<br>
			<div class="box box-info">
            	<div class="box-header">
	              <i class="fa fa-th"></i>
    	          <h3 class="box-title">Create Task</h3>
        		      <div class="box-tools pull-right">
						<button type="button" class="btn bg-teal btn-sm" data-toggle="collapse" data-target="#create-task"><i class="fa fa-plus"></i></button>
				</div>
            </div>
            <div class="box-body border-radius-none collapse" id="create-task" >
              <div style="height: 75px;">
	    		<table border=1 style="width:100%">
	    		<tr>
	    			<td align="right" width=25%>Select Company : </td>
	    			<td>
						<select id = "company2" style="width: 100%;  overflow:scroll; border: none">
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
	    		<td align="right">Select Work to Add : </td>
	    		<td id="work_sel2">
					<select style="border: none; width: 100%;" >
						 <Option hidden = "">Select Work</Option>
					</select>
	    		</td>
	    		</tr>
	    		<tr>
	    		<td align="right">Type Task :</td>
	    		<td>
			    <input type="text" id="task_name" style="width:100%; border: none">	
	    		</td>
	    		</tr>
	    	</table>
              </div>
	            <div class="box-footer clearfix" style="float-bottom; height:100%">
					<button type="button" class="btn btn-info" onclick="myTASKADDFunc();">Create New Task</button>
				</div>
            </div>
          </div>

    </section>    <!-- /.content -->


</body>



<!-- Sweet Alert -->
<script src='jquery/sweetalert.js'></script>

<script>
function myCMPADDFunc()
{
	var company = document.getElementById("company").value;	
	var type = document.getElementById("type").value;
	var acc = document.getElementById("acc").value;
	var team = document.getElementById("team").value;	

		$.ajax({	
	        url: "Servebserp?action=companyadder",//your jsp page name
	        method: "POST",//HTTP method.
	        data: {company:company, type:type, acc:acc, team:team},//sending request to state.jsp page.
			success: function (data)
		        {
					swal('Creat Company', company + ' Created', 'success');
		        }
	        });	
	};
</script>


<script>
function myWORKADDFunc()
{
	
	var cmp_id = document.getElementById("company1").value;
	var cmp_nam = document.getElementById("company1").options[document.getElementById("company1").selectedIndex].text;	
	var work_nam = document.getElementById("work1").value;

		$.ajax({	
	        url: "Servebserp?action=workadder",//your jsp page name
	        method: "POST",//HTTP method.
	        data: {cmp_id:cmp_id,cmp_nam:cmp_nam, work_nam:work_nam},//sending request to state.jsp page.
			success: function (data)
		        {
					swal('Work Created', work_nam + ' Created', 'success');
		        }
	        });	
	};
</script>

<script>
function myTASKADDFunc()
{
	
	var cmp_nam = document.getElementById("company2").options[document.getElementById("company2").selectedIndex].text;	
	var work_id = document.getElementById("work2").value;
	var work_nam = document.getElementById("work2").options[document.getElementById("work2").selectedIndex].text;
	var task_nam = document.getElementById("task_name").value;

			$.ajax({	
	        url: "Servebserp?action=taskadder",//your jsp page name
	        method: "POST",//HTTP method.
	        data: {cmp_nam:cmp_nam, work_id:work_id, work_nam:work_nam, task_nam:task_nam},//sending request to state.jsp page.
			success: function (data)
		        {
					swal('Task Created', task_nam + ' Created', 'success');
		        }
	        });	
	};
</script>

<script>
$(document).ready(function () {
    $("#company1").on("change", function () {
        var company1 = $("#company1").val();//id of company select box of index.jsp page;company")
            $.ajax({
                url: "workadder.jsp",//your jsp page name
                data: {company: company1},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_sel1").html(data);//output or response will display in state select box.
                }
            });
    });
	});
</script>	

<script>
$(document).ready(function () {
    $("#company2").on("change", function () {
        var company2 = $("#company2").val();//id of company select box of index.jsp page;company")
            $.ajax({
                url: "work2.jsp",//your jsp page name
                data: {company: company2},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_sel2").html(data);//output or response will display in state select box.
                }
            });
    });
	});
</script>	


</html>
