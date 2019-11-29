<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%@ page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>

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
  <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="css/skins/_all-skins.min.css">  
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
  
  		<style>
            .container{overflow: hidden}
            .tab{float: left;}
            .tab-2{margin-left: 50px}
            .tab-2 input{display: block;margin-bottom: 10px}
            tr{transition:all .25s ease-in-out}
            tr:hover{background-color:#EEE;cursor: pointer}
        </style>
        
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%// users lg = (users) request.getAttribute("objuser");

if (session.getAttribute("roll")==null)
	{
		response.sendRedirect("index.html");
		return;
	}
%>

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Create
        <small>Daily Job Sheet</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="main.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Created Daily Job Sheet</li>
      </ol>
    </section>

<!--Adding Daily Work Sheet -->
<div class="box box-info">
        <center><b>Daily Job Sheet</b></center>
<div class="box-body" style="float:left; width:85% ">

	<table id="create_job_sheet" border="1" style="font-size:11pt; font-face:Verdana; align:center; width:100%">
  	<tr>
      <td width = "20%"><b>Company</b></td>
      <td colspan="3" id="allcompany" width="80%">
	      <select id="company" name="company" style="border: none; width: 100%;  overflow:scroll;" >
		      <Option hidden= "" >Select company</Option>		      
              <%
	      		Dataconnect db =new Dataconnect();
	      		Connection conn=Dataconnect.connectDB();
	      		Statement st = conn.createStatement();
	            ResultSet rs = st.executeQuery("select * from company where team_id = "+ session.getAttribute("team_id") +" order by cmp_name");
                while (rs.next()) {
              %>
              <option value="<%=rs.getInt("id")%>"><%=rs.getString("cmp_name")%></option>
              <%
                  }
              %>
   			  <optgroup label="----------------------------------------"></optgroup>
		      <Option value="allcompany" style="color:red">SHOW ALL COMPANY</Option>           
  		      <Option value=0 style="color:red">EBS PRIVATE LIMITED</Option>
              
	      </select>
      </td>
	</tr>
    <tr>
      <td><b>Work</b></td>
      <td id="work_id">
	      <select style="border: none; width: 100%;" >
		      <Option hidden = "">Select Work</Option>
	      </select>
	  </td>
    	<td style="text-align: center" width = "20%"><b>Task</b></td>
		<td id ="task_id">
		<select style="border: none; width: 100%;" >
		      <Option hidden = "">Select Task</Option>
	      </select>
	  </td>
	</tr>
              <%
              Time job_time_s = java.sql.Time.valueOf("09:30:00");
              String lock_time_s = null;
              rs = st.executeQuery("SELECT Job_time_e FROM `dailyjobsheet` WHERE `Job_date` = '" + new java.sql.Date(System.currentTimeMillis())  + "' AND `Job_user_id` ="+ session.getAttribute("id"));
              while (rs.next())
              {
              	job_time_s = rs.getTime(1);
              	lock_time_s = "readOnly";
               }
              %>
    <tr>
      <td><b>Start_time</b></td>
      <td> <input type = "time" name="time_s" id="time_s" placeholder = "Start Time" style="border: none; text-align: center;  width: 100%"
       value=<%=job_time_s%> <%=lock_time_s%> ></td>
      <td style="text-align: center"><b>End Time</b></td>
      <td> <input type = "time" name="time_e" id="time_e" placeholder = "End Time" style="border: none; text-align: center; width: 100%" value="17:30:00"></td>
    </tr>
    <tr>
      <td><b>Details</b></td>
      <td colspan="3"> <textarea rows="3" maxlength="100" name="details" id="details" placeholder = "Type details" style="border: none; width: 100%"></textarea></td>
    </tr>
    <tr>
	<td><b>Select Status</b></td>
      <td colspan="3">
   	      <select name="status" id="status" style="border: none; width: 100%">
	      <Option hidden = "">Select Status</Option>
	      <Option>On Process</Option>
	      <Option>Finished</Option>
	      </select>
	</td>
</tr>
</table>
      </div>
               <div class="box-footer clearfix" style="float-bottom; height:100%">
       
	<!-- 		<button type="button" class="pull-right btn btn-default" onclick="addHtmlTableRow();">Add Record  <i class="fa fa-arrow-circle-right"></i></button>-->
			<button type="button" class="pull-right btn btn-default" onclick="addbreak('Lunch');">Add Lunch Break <i class="fa fa-arrow-circle-right"></i></button><br> <br>
			<button type="button" class="pull-right btn btn-default" onclick="addbreak('Tea');">Add Tea Break <i class="fa fa-arrow-circle-right"></i></button><br> <br>
			<button type="button" class="pull-right btn btn-default" onclick="addHtmlTableRow();">Add Record <i class="fa fa-arrow-circle-right"></i></button>
     </div>
      </div>

      <!-- /Adding Daily Work Sheet -->

<!-- Listing Daily Work Sheet -->
<div class="box box-info">
        <center><b>Today's Job Sheet</b></center>
<form action="Servebserp" method="POST">
<div class="box-body">
	<table border="1"  id="jobtable" style="width:100%; ">
    <tr>
      <th width="20%" bgcolor="#9D99F8" style="text-align: center" scope="col">Company</th>
      <th width="12%" bgcolor="#9D99F8" style="text-align: center" scope="col">Work</th>
      <th width="15%" bgcolor="#9D99F8" style="text-align: center" scope="col">Task</th>
      <th width="27%" bgcolor="#9D99F8" style="text-align: center" scope="col">Details</th>
      <th width="8%" bgcolor="#9D99F8" style="text-align: center" scope="col">Time Start</th>
      <th width="8%" bgcolor="#9D99F8" style="text-align: center" scope="col">Time End</th>
      <th width="10%" bgcolor="#9D99F8" style="text-align: center" scope="col">Status</th>
    </tr>
</table>
</div>
	<div class="box-footer clearfix">
	
		<input type="hidden" name="action" value="addrecord">
		<input type="hidden" name="lg_id" value= <%=session.getAttribute("id") %> >
		<button type="button" onclick="delHtmlTableRow();">Delete Last Record</button>
		<button type="button" class="pull-right btn btn-default" onclick="this.disabled='disabled';this.form.submit()">Submit Record <i class="fa fa-arrow-circle-right"></i></button>
	</div>
</form>

</div>
 &nbsp;

<script>
function delHtmlTableRow()
	{
		if (jobtable.rows.length > 1)
		{
            document.getElementById("time_s").value = document.getElementById("time_s"+jobtable.rows.length).value;
		    jobtable.deleteRow(jobtable.rows.length-1);			
		}

	}
</script>

        <script>
            // add Row
            function addHtmlTableRow()
            {
                // get the table by id
                // create a new row and cells
                // get value from input text
                // set the values into row cell's
                
                company = document.getElementById("company").options[document.getElementById("company").selectedIndex].text,
                work = document.getElementById("work").options[document.getElementById("work").selectedIndex].text,
                task = document.getElementById("task").options[document.getElementById("task").selectedIndex].text,
                time_s = document.getElementById("time_s").value,
                time_e = document.getElementById("time_e").value,
                details = document.getElementById("details").value,
                status = document.getElementById("status").value;

                if ((time_s.length) == 5)
            	{
            	time_s = time_s+":00";
            	}

                if ((time_e.length) == 5)
            	{
            	time_e = time_e+":00";
            	}
                
                if (work == "Select Work")
            	{
            	alert("Work Should not be Empty");
            	return false;
            	}

                if (task == "Select Task")
            	{
            	alert("Task Should not be Empty");
            	return false;
            	}

                if (details.length == 0 )
                	{
                	alert("Details Should not be Empty");
                	return false;
                	}
                
                if (status == "Select Status")
            	{
            	alert("Status Should not be Empty");
            	return false;
            	}

                var newRow = jobtable.insertRow(),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4),
                cell6 = newRow.insertCell(5),
                cell7 = newRow.insertCell(6);
                
                cell1.innerHTML = "<input type='text' name='company' readonly style='text-align: center;  width: 100%' value='"+company+"'>";
                cell2.innerHTML = "<input type='text' name='work' readonly style='text-align: center;  width: 100%' value='"+work+"'>";
                cell3.innerHTML = "<input type='text' name='task' readonly style='text-align: center;  width: 100%' value='"+task+"'>";
                cell4.innerHTML = "<input type='text' name='details' readonly style='text-align: center;  width: 100%' value='"+details+"'>";
                cell5.innerHTML = "<input type='time' name='time_s' id='time_s" + jobtable.rows.length + "''" + " readonly style='text-align: center;  width: 100%' value='"+time_s+"'>";
                cell6.innerHTML = "<input type='time' name='time_e' readonly style='text-align: center;  width: 100%' value='"+time_e+"'>";
                cell7.innerHTML = "<input type='text' name='status' readonly style='text-align: center;  width: 100%' value='"+status+"'>";

                document.getElementById("time_s").readOnly = true,
                document.getElementById("time_s").value = time_e,
                document.getElementById("details").value = "",
                document.getElementById("status").value = "Select Status";
            
            }
 </script>

        <script>
            // add Break
            function addbreak(bretype)
            {
                // get the table by id
                // create a new row and cells
                // get value from input text
                // set the values into row cell's
                
                company = bretype + " Break",
                work = bretype + " Break",
                task = bretype + " Break",
                time_s = document.getElementById("time_s").value,
                time_e = document.getElementById("time_e").value,
                details = bretype + " Break",
                status = "Finished";

                if ((time_s.length) == 5)
            	{
            	time_s = time_s+":00";
            	}

                if ((time_e.length) == 5)
            	{
            	time_e = time_e+":00";
            	}
                
                var newRow = jobtable.insertRow(jobtable.rows.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3),
                cell5 = newRow.insertCell(4),
                cell6 = newRow.insertCell(5),
                cell7 = newRow.insertCell(6);
                
                cell1.innerHTML = "<input type='text' name='company' readonly style='text-align: center;  width: 100%' value='"+company+"'>";
                cell2.innerHTML = "<input type='text' name='work' readonly style='text-align: center;  width: 100%' value='"+work+"'>";
                cell3.innerHTML = "<input type='text' name='task' readonly style='text-align: center;  width: 100%' value='"+task+"'>";
                cell4.innerHTML = "<input type='text' name='details' readonly style='text-align: center;  width: 100%' value='"+details+"'>";
                cell5.innerHTML = "<input type='time' name='time_s' id='time_s" + jobtable.rows.length + "''" + " readonly style='text-align: center;  width: 100%' value='"+time_s+"'>";
                cell6.innerHTML = "<input type='time' name='time_e' readonly style='text-align: center;  width: 100%' value='"+time_e+"'>";
                cell7.innerHTML = "<input type='text' name='status' readonly style='text-align: center;  width: 100%' value='"+status+"'>";

                document.getElementById("time_s").readOnly = true,
                document.getElementById("time_s").value = time_e,
                document.getElementById("details").value = "",
                document.getElementById("status").value = "Select Status";
                
            
            }
 </script>

      <!-- /Listing Daily Work Sheet -->

<script>
$(document).ready(function () {
    $("#company").on("change", function () {
        var company = $("#company").val();//id of company select box of index.jsp page;company")

        if(company == "allcompany")
        	{
            $.ajax({
                url: "company.jsp",//your jsp page name
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#allcompany").html(data);//output or response will display in state select box.
                }
            });

        	}
        else
        	{
            $.ajax({
                url: "work.jsp",//your jsp page name
                data: {company: company},//sending request to state.jsp page.
                method: "POST",//HTTP method.
                success: function (data)
                {
                    $("#work_id").html(data);//output or response will display in state select box.
                }
            });
        	}
    });

	});
</script>

</body>
</html>