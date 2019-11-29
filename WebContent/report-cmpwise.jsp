<%@page import="java.io.*" %>
<%@page import="javax.servlet.*,java.text.*" %>
<%@page import="java.util.ArrayList" %>

<%@page import="java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
</head>
<body>

<%SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");%>

	<%
		Date Fday, Tday;
		Fday = Date.valueOf(request.getParameter("Fday"));
		Tday = Date.valueOf(request.getParameter("Tday"));
		PreparedStatement pscmplist=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where Job_company <> ? and Job_company <> ? and Job_company <> ? and Job_date >= ? and Job_date <= ? ORDER BY Job_company ASC, Job_user_id, Job_date ASC");	
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
		selteam = Integer.parseInt(request.getParameter("selteam")); %>

		<table border= 1 id="myTable" width=100%>
			<thead>
				<tr>
				<th width="5%" style="text-align: center">SL No</th>
				<th style="text-align: center">Company</th>
				<th style="text-align: center">Staff Name</th>
				<th style="text-align: center">Date</th>
				<th style="text-align: center">Work</th>
				<th style="text-align: center">Task</th>
				</tr>
			</thead>
			<tbody>
			<%
			Integer i = 1;
			String c_cmp = "", prv_cmp="";
			Integer c_sta = 0;
			Boolean insrow = false, isteam = false;
			while (rscmplist.next())
			{
				if (selteam == 0)
				{
					insrow = true;
				}
				else
				{
					if (prv_cmp.equals(rscmplist.getString("Job_company")))
					{
						if (isteam == true)
						{
							insrow = true;
						}
						else
						{
							insrow = false;
						}
					}
					else
					{				
						for (Integer j = 0; j < alcmp.size(); j++)
						{
							if (alcmp.get(j).getCmp_cmp_name().equals(rscmplist.getString("Job_company")))
							{
								if (alcmp.get(j).getCmp_team_id() == selteam)
								{
									isteam = true;
									insrow = true;
								}
								else
								{
									isteam = false;
									insrow = false;
								}
								break;
							}
							else
							{
								isteam = false;
								insrow = false;
							}
						}
					}
				}
				if (insrow == true)
				{
					

				%>
				<tr>
				<%
				if (c_cmp.equals(rscmplist.getString("Job_company")))
				{
					%>
					<td></td>
					<td></td>
					<%
				}
				else
				{
					%>
				<td align = "center"><%=i %></td>
				<td>
					<%
					out.println(rscmplist.getString("Job_company"));
					i++;
					%>
				</td>
					<%
				}
				
				%>
				<td>
				<%
				if (c_sta.equals(rscmplist.getInt("Job_user_id")) && c_cmp.equals(rscmplist.getString("Job_company")) )
				{}
				else
				{
					for (users count: alallm)
					{
						if (count.getId() == rscmplist.getInt("Job_user_id"))
						{
							out.println(count.getName());
						}
					}				
				}
								
				%>
				</td>
				<td><%=ft.format(rscmplist.getDate("Job_date"))%></td>
				<td><%=rscmplist.getString("Job_work")%></td>
				<td><%=rscmplist.getString("Job_task")%></td>
				</tr>
				<%
				c_sta = rscmplist.getInt("Job_user_id");
				c_cmp = rscmplist.getString("Job_company");
				}
				prv_cmp = rscmplist.getString("Job_company");
			}
			%>
			</tbody>
		</table>

</body>
</html>