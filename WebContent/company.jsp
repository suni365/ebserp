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
    
	      <select id="company" name="company" style="border: none; width: 100%;" >
		      <Option hidden= "" >Select company</Option>
              <%
				PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("select * from company order by cmp_name");
				ResultSet rscmp = pscmp.executeQuery();

                while (rscmp.next()) {
              %>
              <option value="<%=rscmp.getInt("id")%>"><%=rscmp.getString("cmp_name")%></option>
              <%
                  }
              %>
   			  <optgroup label="----------------------------------------"></optgroup>
  		      <Option value=0 style="color:red">EBS PRIVATE LIMITED</Option>
              
	      </select>

</body>

<script>
    $(document).ready(function () {
        $("#company").on("change", function () {
            var company = $("#company").val();
                $("#error").html("");
                $.ajax({
                    url: "work.jsp",
                    method: "POST",
                    data: {company: company},
                    success: function (data)
                    {
                        $("#work_id").html(data);//response sending to task.jsp page 
                    }
                });
        });
    });
</script>


</html>