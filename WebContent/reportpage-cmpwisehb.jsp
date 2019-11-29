<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="javax.servlet.*,java.text.*" %>
<%@page import="java.util.ArrayList" %>

<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.Month"%>

<%@ page import = "java.sql.*"%>
<%@page import="com.java.Dataconnect"%>
<%@page import="com.java.users"%>
<%@page import="com.java.Arrayclass"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Exaccpro | ERP</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.min.css">

  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
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
        Report
        <small>Company wise Hand Book Report</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Company wise Hand Book Report</li>
      </ol>
    </section>

	<%
		ArrayList<Arrayclass> altg = new ArrayList<Arrayclass>();
		
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
    <!-- Main content -->
    <div class="disptable" align="center">
	<table>
	<tr>
	<td>
	Select Team : 
	<Select id="selteam">
	<option hidden=true> </option>
	<option value = 0>ALL</option>
	<%
	for (Arrayclass count: altg)
		{
	%>
	<option value = 
	<%=	count.getTeam_id()%>
	>
	<%=	count.getTeam_team_name()%>
	</option>
	<%
	}
	%>
	</Select>
</td>
<td>
	Select Client : 
</td>
<td id = "selclient"  width = 250px>
		<Select id="selclientid" style="width:250px">
		<option hidden=true>Select Client</option>
		</Select>
</td>
<td>
	Period From:
	<input type="date" id="Fday" value=<%=LocalDate.now().withDayOfMonth(1) %>>
	Period To :
	<input type="date" id="Tday" value = <%= new java.sql.Date(System.currentTimeMillis()) %>>
	<input type="Button" value = "Proceed" onclick="cmpreport();">
</td>
	</tr>
	</table>
    </div>
    
<div class="box box-info">
	<div class="box-body" id="ajaxcmpwisetable">

	</div>
</div>

<script>
    $(document).ready(function () {
        $("#selteam").on("change", function () {
            var selteam = $("#selteam").val();
                $("#error").html("");
                $.ajax({
                    url: "client.jsp",
                    method: "POST",
                    data: {selteam: selteam},
                    success: function (data)
                    {
                        $("#selclient").html(data);//response sending to task.jsp page 
                    }
                });
        });
    });
</script>

<script>
function cmpreport() {
	var cmp_name = document.getElementById("selclientid").options[document.getElementById("selclientid").selectedIndex].text;
	var selclientid = $("#selclientid").val();//id of company select box of index.jsp page;company")
	var Fday = $("#Fday").val();//id of company select box of index.jsp page;company")
	var Tday = $("#Tday").val();//id of company select box of index.jsp page;company")
		$.ajax({
        url: "report-cmpwisehb.jsp",//your jsp page name
        data: {cmp_name:cmp_name,  selclientid: selclientid, Fday:Fday, Tday:Tday},//sending request to state.jsp page.
        method: "POST",//HTTP method.
        success: function (data)
        {
            $("#ajaxcmpwisetable").html(data);//output or response will display in state select box.
        }
    });
};
</script>

</body>
</html>
