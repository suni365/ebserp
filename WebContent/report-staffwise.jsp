<%@page import ="java.io.*" %>
<%@page import ="javax.servlet.*,java.text.*" %>
<%@page import="java.util.ArrayList" %>

<%@page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Exaccpro | ERP</title>
</head>
<body>

<%SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");%>

	<%
		Date Fday, Tday;
		Fday = Date.valueOf(request.getParameter("Fday"));
		Tday = Date.valueOf(request.getParameter("Tday"));
		PreparedStatement pscmplist=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where Job_company <> ? and Job_company <> ? and Job_company <> ? and Job_date >= ? and Job_date <= ? ORDER BY Job_user_id, Job_company ASC, Job_date ASC");
		pscmplist.setString(1, "Lunch Break");
		pscmplist.setString(2, "Tea Break");
		pscmplist.setString(3, "EBS PRIVATE LIMITED");
		pscmplist.setDate(4, Fday);
		pscmplist.setDate(5, Tday);
		ResultSet rscmplist = pscmplist.executeQuery();
	%>

	<%
		ArrayList<users> alallm = new ArrayList<users>();
		ArrayList<Arrayclass> alcmp = new ArrayList<Arrayclass>();
		
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

		PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("select * from company ORDER BY cmp_name ASC");
		
		ResultSet rscmp = pscmp.executeQuery();
  		while(rscmp.next())
  		{
  			Arrayclass objcmp = new Arrayclass();
  			objcmp.setCmp_team_id(rscmp.getInt("team_id"));
  			objcmp.setCmp_cmp_name(rscmp.getString("cmp_name"));
  			alcmp.add(objcmp);
  		}
		%>
		
		<% Integer selteam;
		selteam = Integer.parseInt(request.getParameter("selteam"));
		String staff_name = null, cmp_name = "";
		%>
		


		<table border= 1 id="myTable" width=100%>
			<thead>
				<tr>
				<th width="5%" style="text-align: center">SL No</th>
				<th style="text-align: center">Staff Name</th>
				<th style="text-align: center">Company</th>
				<th style="text-align: center">Date</th>
				<th style="text-align: center">Work</th>
				<th style="text-align: center">Task</th>
				</tr>
			</thead>
			<tbody>
			<%
			Integer i = 1, j = 1;
			Boolean insrow = false;

			while (rscmplist.next())
			{
				if (selteam == 0)
				{
					insrow = true;
				}
				else
				{
				for (users count: alallm)
				{
					if (count.getId() == rscmplist.getInt("Job_user_id"))
					{
						if (count.getTeam_id() == selteam)
						{
							insrow = true;
						}
					}
				}
				}
				if (insrow == true)
				{
					
				%>
				<tr>
				<%
					for (users count: alallm)
					{
						if (count.getId() == rscmplist.getInt("Job_user_id"))
						{
							if (staff_name == count.getName())
							{ 
								%>
								<td></td>
								<td></td>
								<%

							}
							else
							{
								%>
								<td align="center"> <%=j %> </td>
								<td>
								<%
									j = j + 1;
									staff_name = count.getName();
									out.println(count.getName());
								%>
								</td>
								<%
							}
							
						}
					}				
				%>
				<td>
				<%
					if (cmp_name.equals(rscmplist.getString("Job_company")))
					{ }
					else
					{
						cmp_name = rscmplist.getString("Job_company");
						out.println(rscmplist.getString("Job_company"));
					}
				%>					
				</td>
				<td><%=ft.format(rscmplist.getDate("Job_date"))%></td>
				<td><%=rscmplist.getString("Job_work")%></td>
				<td><%=rscmplist.getString("Job_task")%></td>
				</tr>
				<%
				i++;
			}
				insrow = false;
			}
			%>
			</tbody>
		</table>

</body>
</html>