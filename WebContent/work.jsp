<%--
    Document   : state
    Created on : 15 Feb, 2018, 11:15:40 AM
    Author     : Dharmesh Mourya
--%>


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

	      <select name = "work" id = "work" style="border: none; width: 100%;" >
		      <Option hidden = "">Select Work</Option>            
           <%
                int company = Integer.parseInt(request.getParameter("company"));
				PreparedStatement ps=Dataconnect.connectDB().prepareStatement("select * from work where cmp_id=?");
				ps.setInt(1,company);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            %>
                	<option value="<%=rs.getString("id")%>"><%=rs.getString("work")%></option>
            <%
                }
            %>
<%--   		 			<Option value=-3>Finalization</Option> --%> 
            
            <% 
            	if (company == 0)
            	{
        	%>
		 			<Option value=-1 style="color:red">EBS INTERNAL WORK</Option>
		 			<Option value=-2 style="color:red">EBS EXTERNAL WORK</Option>
		 	<%
            		
            	}
            %>
<!--  				<optgroup label="----------------------------------------"></optgroup>
		 			<Option value=0 style="color:red">CLIENT MEETING</Option>
-->            
        </select>
    </body>
    
    <script>
    $(document).ready(function () {
        $("#work").on("change", function () {
            var work_id = $("#work").val();
                $("#error").html("");
                $.ajax({
                    url: "task.jsp",
                    method: "POST",
                    data: {work_id: work_id},
                    success: function (data)
                    {
                        $("#task_id").html(data);//response sending to task.jsp page 
                    }
                });
        });
    });
</script>
  
</html>

