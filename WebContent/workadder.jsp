<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Exaccpro | ERP</title>
    </head>
    <body>
	      <select name = "work" id = "work1" style="border: none; width: 100%;" >
		      <Option hidden = "">Select Work</Option>            
           <%
           		int cntwrk;
                int company = Integer.parseInt(request.getParameter("company"));
		      
				PreparedStatement ps=Dataconnect.connectDB().prepareStatement("SELECT COUNT(*) FROM WORK WHERE cmp_id=? and work=?");
				ps.setInt(1,company);
				ps.setString(2,"Data Collection");
				ResultSet rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Data Collection</Option>
                		<%
                	}
               	}
                
				ps.setString(2,"Accounting");
				rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Accounting</Option>
                		<%
                	}
               	}

				ps.setString(2,"Statutory Calculation");
				rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Statutory Calculation</Option>
                		<%
                	}
               	}

				ps.setString(2,"Verification");
				rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Verification</Option>
                		<%
                	}
               	}
                
				ps.setString(2,"Filing");
				rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Filing</Option>
                		<%
                	}
               	}
                
				ps.setString(2,"Reporting");
				rs = ps.executeQuery();
                while (rs.next())
                {
                	if (rs.getInt(1) == 0 )
                	{
                		%>
							<Option>Reporting</Option>
                		<%
                	}
               	}
                
                
                
                
            %>
        </select>
    </body>  
</html>

