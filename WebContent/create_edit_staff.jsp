<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*" %>
<%@page import ="java.io.*" %>
<%@page import ="javax.servlet.*,java.text.*" %>
<%@page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>

<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

<!DOCTYPE html>
<html>
<head>
  <title>Exaccpro | ERP</title>

    <style>
      .flex-container {
        display: flex;
        align-items: center; /* Use another value to see the result */
        width: 100%;
        height: 200px;
        background-color: #1faadb;
      }
      .flex-container > div {
        width: 25%;
        height: 60px;
        margin: 5px;
        border-radius: 3px;
        background-color: #8ebf42;
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

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Staff
        <small>Details</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Staff Details</li>
      </ol>
    </section>

<%
Integer id,team_id=1,ver_userid=0;
String user="",pass="",roll="",name="",address="",mobile="",desi="",DOJ="";
id = Integer.parseInt(request.getParameter("id"));

PreparedStatement psstaff=Dataconnect.connectDB().prepareStatement("select * from users where id = ?");
psstaff.setInt(1, id);
ResultSet rsstaff = psstaff.executeQuery();

while(rsstaff.next())
{
	id = rsstaff.getInt("id");
	user=rsstaff.getString("user");
	pass=rsstaff.getString("pass");
	roll=rsstaff.getString("roll");
	name=rsstaff.getString("name");
	address=rsstaff.getString("address");
	mobile=rsstaff.getString("mobile");
	desi=rsstaff.getString("designation");
	DOJ=rsstaff.getString("DOJ");
	team_id=rsstaff.getInt("team_id");
	ver_userid=rsstaff.getInt("ver_userid");
}

PreparedStatement pstm=Dataconnect.connectDB().prepareStatement("select * from users where roll = ? or roll = ? ORDER BY name ASC");
pstm.setString(1,"admin/staff");
pstm.setString(2,"staff");

ResultSet rstm = pstm.executeQuery();

ArrayList<users> alallm = new ArrayList<users>();
ArrayList<Arrayclass> altg = new ArrayList<Arrayclass>();

PreparedStatement psallm=Dataconnect.connectDB().prepareStatement("select * from users where roll <> ?");
psallm.setString(1,"resigned");

ResultSet rsallm = psallm.executeQuery();
	while(rsallm.next())
	{
		users objallm = new users();
		objallm.setId(rsallm.getInt("id"));
		objallm.setName(rsallm.getString("name"));
		alallm.add(objallm);
	}

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
   		<div style="float:left; width:50%; margin-left:10px">
	 		<table style="width:100%; vlign:middle" >
	 	   		<tr height = 30px>
		   		<td width=20%>ID</td>
		   		<td><input type="text" style="width:20%; background-color:#d3d3d3;" value=<%=id %> readonly> </td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Login User IDs</td>
		   		<td><input type="text" id="user" style="width:42%;" placeholder='user id' value='<%=user%>' maxlength=10>
		   		&nbsp;Roll&nbsp;
			   		<select id="roll" style="height:27px; width:50% ">
			   			<option hidden=true>Select Roll</option>
						<option <% if (roll.equals("admin")) { %> selected <% } %> >admin</option>
						<option <% if (roll.equals("staff")) { %> selected <% } %> >staff</option>
						<option <% if (roll.equals("admin/staff")) { %> selected <% } %> >admin/staff</option>
						<option <% if (roll.equals("resigned")) { %> selected <% } %> >resigned</option>
			   		</select>
		   		</td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Name</td>
		   		<td><input type="text" id="name" style="width:100%;" placeholder='Full Name' value='<%=name%>' maxlength=14></td>
		   		</tr>
	 	   		<tr height = 90px>
		   		<td>Address</td>
		   		<td><textarea rows="4" cols="50" id="address" style="width:100%;" placeholder='Full Address' maxlength=100><%=address%></textarea></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Mobile</td>
		   		<td><input type="text" id="mobile" style="width:100%;" placeholder='Mobile' value='<%=mobile%>' maxlength=10></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Designation</td>
		   		<td>
			   		<select id="desi" style="height:27px; width:100% ">
			   			<option hidden=true>Select Designation</option>
						<option <% if (desi.equals("Trainee")) { %> selected <% } %> >Trainee</option>
						<option <% if (desi.equals("Accountant")) { %> selected <% } %> >Accountant</option>
						<option <% if (desi.equals("Accounts Manager")) { %> selected <% } %> >Accounts Manager</option>
						<option <% if (desi.equals("Director")) { %> selected <% } %> >Director</option>
			   		</select>
		   		</td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>DOJ</td>
		   		<td><input type="text" id="DOJ" style="width:100%;" placeholder='MMM-YY' value='<%=DOJ%>'></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Team</td>
		   		<td>
			   		<select id="team_id" style="height:27px; width:100% ">
			      		<%
						for (Arrayclass count: altg)
			            {
		      			%>
				      		<Option value = <%=count.getTeam_id()%>  
		      			<%
		      				if (count.getTeam_id() == team_id)
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
	 	   		<tr height = 30px>
		   		<td>Verification By</td>
		   		<td>
			   		<select id="ver_userid" style="height:27px; width:100% ">
					    <Option value=0 style="color:red">none</Option>           
					    	<%
								for (users count: alallm)
					            {
			      			%>
						      		<Option value = <%=count.getId()%>  
				      			<%
				      				if (count.getId() == ver_userid)
				      				{
				      					out.println("Selected");
				      				}
				      			%>
				      			> <%=count.getName() %>
				      			</Option>
				      			<%
					      			}
					      		%>
			   		</select>
		   		</td>
		   		</tr>
	    	</table>
    </div>
        <div style="float:left;
        			width:20%;
        			margin-left:70px; margin-top:40px;
					border: 2px solid red;
					padding: 10px; border-radius: 25px;" >
 	 		<table style="width:100%">
	 	   		<tr height = 30px>
		   		<td width=80%>Create Attendance</td>
		   		<td width=20%><input type="checkbox" id="attend"></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>Payroll</td>
		   		<td><input type="checkbox" id="payroll"></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>GST Update</td>
		   		<td><input type="checkbox" id="gst"></td>
		   		</tr>
	 	   		<tr height = 30px>
		   		<td>KFC Update</td>
		   		<td><input type="checkbox" id="kfc"></td>
		   		</tr>
	    	</table>
		</div>
	    	
	    	<div style="float:bottom; width:1%;">
	    	&nbsp;
	    	</div>
			<div class="box-footer clearfix" style="float-bottom; height:100%">
				<% if (id != 0)
					{
				%>
					<button type="button" class="pull-left btn btn-info" onclick="staff_details('<%=id%>','reset','123');">RESET PASS</button>
				<%
					}
				%>
				<button type="button" class="pull-right btn btn-info" onclick="staff_details('<%=id%>','update','<%=pass%>');"> <% if (id == 0) { out.println("CREATE"); } else { out.println("UPDATE"); } %> </button>
			</div>
        </div>
       </div>
    </section>

<!-- page script -->
<script>
	function staff_details(id, button,pass) {
		user = document.getElementById('user').value;
		Roll = document.getElementById('roll').value;
		Name = document.getElementById('name').value;
		Address = document.getElementById('address').value;
		Mobile = document.getElementById('mobile').value;
		Desi = document.getElementById('desi').value;
		DOJ = document.getElementById('DOJ').value;
		team_id = document.getElementById('team_id').value;
		ver_userid = document.getElementById('ver_userid').value;

		$.ajax({	
        url: "Servebserp?action=userdetailsaving",//your jsp page name
        method: "POST",//HTTP method.
        data: {id:id, user:user, Roll:Roll, Name:Name, Address:Address, Mobile:Mobile, Desi:Desi, DOJ:DOJ, team_id:team_id, ver_userid:ver_userid, pass:pass},//sending request to state.jsp page.
		success: function (data)
        {
			if (button == "reset")
				{
				swal(Name, 'Password Reseted to 123', 'success');
				}
			else
				{
				swal(Name, 'Details updated!', 'success');
				}
        }
        });
	};
</script>

</body>
</html>
