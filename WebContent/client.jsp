<%@page import="java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<title>Exaccpro | ERP</title>
      </head>
    <body>
	      <select name = "selclientid" id = "selclientid" style="width: 100%;" >
		      <Option hidden = "">Select Client</Option>            
           <%
                int selteam = Integer.parseInt(request.getParameter("selteam"));
				PreparedStatement ps=Dataconnect.connectDB().prepareStatement("select * from company where team_id=?");
				ps.setInt(1,selteam);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            %>
                	<option value="<%=rs.getString("id")%>"><%=rs.getString("cmp_name")%></option>
            <%
                }
            %>
        </select>
    </body>
</html>

