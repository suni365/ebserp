<%@page import="java.io.*" %>
<%@page import="javax.servlet.*,java.text.*" %>
<%@page import="java.util.ArrayList" %>

<%@ page import="java.time.LocalDate"%>

<%@ page import="static java.time.temporal.ChronoUnit.*"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%@page import="java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/showonhover.css">
  <title>Exaccpro | ERP</title>
</head>
<body>

<%
	SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");
	SimpleDateFormat Hh = new SimpleDateFormat ("hh:mm aa");
	SimpleDateFormat HH = new SimpleDateFormat ("HH:mm");	
	DateTimeFormatter DF = DateTimeFormatter.ofPattern("HH:mm");
%>
<%
		ArrayList<users> alallm = new ArrayList<users>();
		
		PreparedStatement psallm=Dataconnect.connectDB().prepareStatement("select * from users");
		
		ResultSet rsallm = psallm.executeQuery();
  		while(rsallm.next())
  		{
  			users objallm = new users();
  			objallm.setId(rsallm.getInt("id"));
  			objallm.setName(rsallm.getString("name"));
  			objallm.setTeam_id(rsallm.getInt("team_id"));
  	  		alallm.add(objallm);
  		}

Integer selclientid;
String cmp_name;
Date Fday, Tday;
selclientid = Integer.parseInt(request.getParameter("selclientid"));
cmp_name = request.getParameter("cmp_name");
Fday = Date.valueOf(request.getParameter("Fday"));
Tday = Date.valueOf(request.getParameter("Tday"));

%>
<h3><%= cmp_name%> </h3>

	<table border ="1" width=100% Style = "border-collapse:collapse;" align="center">
		<tr>
			<td align="center" width = 15%><strong>Work</strong></td>
			<td align="center" width = 20%><strong>Task</strong></td>
			<td align="center"><strong>Date</strong></td>
		</tr>
<%
Integer Rowmerger = 2;
%>
<%
PreparedStatement pswrk=Dataconnect.connectDB().prepareStatement("select * from work where cmp_id = ?");
pswrk.setInt(1,selclientid);
ResultSet rswrk = pswrk.executeQuery();
while (rswrk.next()) {

PreparedStatement pstsk1=Dataconnect.connectDB().prepareStatement("select count(*) from task where work_id = ?");
pstsk1.setInt(1,rswrk.getInt("id"));
ResultSet rstsk1 = pstsk1.executeQuery();
while (rstsk1.next())
{
	Rowmerger = rstsk1.getInt(1);
} 

%>
<tr>
<td rowspan=<%= Rowmerger%> ><%=rswrk.getString("work")%></td>
<%
PreparedStatement pstsk=Dataconnect.connectDB().prepareStatement("select * from task where work_id = ?");
pstsk.setInt(1,(Integer) rswrk.getInt("id"));
ResultSet rstsk = pstsk.executeQuery();
while (rstsk.next()) {
%>

<td><%=rstsk.getString("task")%></td>
<td>
<%
PreparedStatement pswtdat=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where Job_company = ? and Job_work = ? and Job_task = ? and Job_date >= ? and Job_date <= ?");
pswtdat.setString(1, cmp_name);
pswtdat.setString(2, rswrk.getString("work"));
pswtdat.setString(3, rstsk.getString("task"));
pswtdat.setDate(4, Fday);
pswtdat.setDate(5, Tday);
ResultSet rswtdat = pswtdat.executeQuery();
while (rswtdat.next()) {
%>	
	<a class="hideDisplay">
	<%= ft.format(rswtdat.getDate("job_date"))+","%>
	<span class="showDisplayOnHover">
	<span class="showHeaderDisplayOnHover">
<% 	
		for (users count: alallm)
		{
			if (count.getId() == rswtdat.getInt("Job_user_id"))
			{
				out.println(count.getName());
			}
		}				
%>
	</span>
		<span class="showTimeOfDisplayOnHover">
			<i>(<%=Hh.format(rswtdat.getTime("job_time_s")) %> to <%= Hh.format(rswtdat.getTime("job_time_e"))%>)</i>
		</span>
		<span class="showDurationOfDisplayOnHover">
		Duration : 
		<%
		    LocalTime arrival = LocalTime.parse(HH.format(rswtdat.getTime("job_time_s")), DF);
		    LocalTime departure = LocalTime.parse(HH.format(rswtdat.getTime("job_time_e")), DF);
			out.println(HOURS.between(arrival, departure)+" Hr");
				if (MINUTES.between(arrival, departure) < 60)
					{out.println(MINUTES.between(arrival, departure)+" Min");}
				else
					{out.println(MINUTES.between(arrival, departure) - (HOURS.between(arrival, departure) * 60)+" Min");}
				
		%>
		</span>
		<br>
		<span class="showBodyOfDisplayOnHover">
			<%= rswtdat.getString("job_details")%>
		</span>
	</span>
</a>
<%

}
%>
</td>
</tr>

<%
}
}
%>
	</table>
        <div class="box-footer clearfix">
          <button type="button" class="pull-right btn btn-default" >Close <i class="fa fa-arrow-circle-right"></i></button>
        </div>
</body>
</html>