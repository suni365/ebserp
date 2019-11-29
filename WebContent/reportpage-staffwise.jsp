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
        <small>Staff wise Report</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><a href="admin.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active">Staff wise Report</li>
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
	Period From:
	<input type="date" id="Fday" value=<%=LocalDate.now().withDayOfMonth(1) %>>
	Period To :
	<input type="date" id="Tday" value = <%= new java.sql.Date(System.currentTimeMillis()) %>>
	<input type="Button" value = "Proceed" onclick="cmpreport();">


    </div>
    
<div class="box box-info">
	<div class="box-body" id="ajaxcmpwisetable">

	</div>
</div>

<script>
function cmpreport() {
	var selteam = $("#selteam").val();//id of company select box of index.jsp page;company")
	var Fday = $("#Fday").val();//id of company select box of index.jsp page;company")
	var Tday = $("#Tday").val();//id of company select box of index.jsp page;company")
		$.ajax({
        url: "report-staffwise.jsp",//your jsp page name
        data: {selteam: selteam, Fday:Fday, Tday:Tday},//sending request to state.jsp page.
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
