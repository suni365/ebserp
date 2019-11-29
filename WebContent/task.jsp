<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.java.Dataconnect"%>
<%@ page import = "java.sql.*"%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  	<title>Exaccpro | ERP</title>
    </head>
    <body>    
	      <select name="task" id="task" style="border: none; width: 100%;" >
		      <Option hidden = "">Select Task</Option>
            <%
				int work_id = Integer.parseInt(request.getParameter("work_id"));
				String  SQLQuery = "select * from task where work_id=?";
		      
				if (work_id < 0)
					{
						SQLQuery = "select * from ebstask where work_id=?";
					}
				    	
					PreparedStatement ps=Dataconnect.connectDB().prepareStatement(SQLQuery);
					ps.setInt(1,(Integer) work_id);
					ResultSet rs = ps.executeQuery();
					while (rs.next())
					{
					%>
						<option value=<%=rs.getString("id")%>><%=rs.getString("task")%></option>
					<%
					}
				%>

<!--  			<optgroup label="----------------------------------------"></optgroup>
	      	<Option value=0 style="color:red">OTHER TASK</Option>
-->		      
        </select>
    </body>
</html>