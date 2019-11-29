<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%@ page import = "java.sql.*"%>

<%@page import="com.java.Dataconnect"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Exaccpro | ERP</title>
  <link rel="shortcut icon" type="image/x-icon" href="img/ebserp.ico" />   
  
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="css/skins/_all-skins.min.css">  
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini" onload="noBack();"
    onpageshow="if (event.persisted) noBack();" onunload="">
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);

if (session.getAttribute("roll")==null || session.getAttribute("roll").equals("staff"))
{
	response.sendRedirect("index.html");
	return;
}
%>

<% //users lg = (users) request.getAttribute("objuser");%>
<% String datainserted = (String) session.getAttribute("datainserted"); %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>E</b>BS</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Exaccpro</b>-ERP</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

<div class="navbar-custom-menu">
	<ul class="nav navbar-nav">
	<!-- Messages: style can be found in dropdown.less--><!-- Notifications: style can be found in dropdown.less --><!-- Tasks: style can be found in dropdown.less --><!-- User Account: style can be found in dropdown.less -->
	<li class="dropdown user user-menu">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
	<img src= "img/users/<%=session.getAttribute("username")%>.jpg" class="user-image" alt="User Image">
	<span class="hidden-xs">
		<%out.println(session.getAttribute("Name"));%>
	</span>
	</a>
 	<ul class="dropdown-menu">
	<!-- User image -->
	<li class="user-header">
	<img src= "img/users/<%=session.getAttribute("username")%>.jpg"  class="img-circle" alt="User Image">
		<p>
			<%
				out.println(session.getAttribute("Name")+ " - ");
				out.println(session.getAttribute("Designation"));
			%>
				<small>Member since
                <% out.println(session.getAttribute("DOJ"));%>
                </small>
		</p>
	</li>
    <!-- Menu Footer-->
    <li class="user-footer">
	<div class="pull-left">
		<a href="#" onclick="underprogress()" class="btn btn-default btn-flat">Profile</a>
	</div>
	<form action ="Servebserp">
	<input type="hidden" name="action" value="sessionout">
     <div class="pull-right">
		<button type="button" onclick="submit();" class="btn btn-default btn-flat">Sign out</button>
     </div>
     </form>
	</li>
	</ul>
    </li>
    </ul>
    </div>
    
    </nav>
  </header>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
<!-- sidebar: style can be found in sidebar.less -->
<section class="sidebar">
<!-- Sidebar user panel -->
	<div class="user-panel">
	  <div class="pull-left image">
	    <img src="img/users/<%=session.getAttribute("username")%>.jpg" class="img-circle" alt="User Image">
	  </div>
	  <div class="pull-left info">
	    <p><% out.println(session.getAttribute("Name"));%></p>
		<p><% out.println(session.getAttribute("Designation"));%></p>
<!--  	<a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->	 
	  </div>
	</div>
      
<!-- search form -->
<form action="#" method="get" class="sidebar-form">
	<div class="input-group">
		<input type="text" name="q" class="form-control" placeholder="Search...">
			<span class="input-group-btn">
				<button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
				</button>
			</span>
	</div>
</form>
<!-- /.search form -->

<!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">MAIN NAVIGATION</li>
        
<!--<li class="active treeview"> -->
	<li class="treeview">
	  <a href="#">
	    <i class="fa fa-dashboard"></i> <span>User Type</span>
	    <span class="pull-right-container">
	      <i class="fa fa-angle-left pull-right"></i>
	    </span>
	  </a>
	  <ul class="treeview-menu">
		    <li class="active"><a href="#"><i class="fa fa-circle-o"></i>Admin</a></li>				
		<%		
		if (session.getAttribute("roll").equals("admin/staff"))
			{
		%>
	    <li><a href="main.jsp"><i class="fa fa-circle-o"></i>Staff</a></li>
		<%
			}
		
		%>
	  </ul>
	</li>
	<li class="treeview">
	  <a href="#">
	    <i class="fa ion-android-settings"></i>
	    <span>Settings</span>
	    <span class="pull-right-container">
		<i class="fa fa-angle-left pull-right"></i>
	    </span>
	  </a>
	<ul class="treeview-menu">
		<li class="treeview"><a href="#"><i class="fa ion-android-person"></i><span>Staff Details</span></a>
			<ul class="treeview-menu">
				<li><a href="#" onclick="create_edit_staff();"><i class="fa  fa-user-plus"></i><span>Create Staff</span></a> </li>
				<li><a href="#" onclick="staff_list();"><i class="fa fa-users"></i><span>Staff List</span></a> </li>
			</ul>
    	</li>
		<li><a href="#" onclick="myCHBFunc();"><i class="fa ion-ios-book"></i><span>Hand Book Details</span></a> </li>
	</ul>
	</li>

	<li class="treeview">
	  <a href="#">
	    <i class="fa fa-star"></i>
	    <span>Create / Alter Tax Login</span>
	    <span class="pull-right-container">
		<i class="fa fa-angle-left pull-right"></i>
	    </span>
	  </a>
	  <ul class="treeview-menu">
	    <li><a href="#" onclick="gstchngpass()"><i class="fa fa-circle-o"></i> Change GST Pass</a></li>
	    <li><a href="#" onclick="cesslogpass()"><i class="fa fa-circle-o"></i> Add Cess Login Details</a></li>
	  </ul>
	</li>


	<li class="treeview">
	  <a href="#">
	    <i class="fa fa-pie-chart"></i>
	    <span>Tax Payers User Details</span>
	    <span class="pull-right-container">
		<i class="fa fa-angle-left pull-right"></i>
	    </span>
	  </a>
	  <ul class="treeview-menu">
	    <li><a href="#" onclick="gstuserpass()"><i class="fa fa-circle-o"></i> GST User / Pass</a></li>
	    <li><a href="#" onclick="cessuserpass()"><i class="fa fa-circle-o"></i> Cess User / Pass</a></li>
	  </ul>
	</li>

    <li class="treeview">
      <a href="#">
        <i class="fa fa-laptop"></i>
        <span>Report</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
      </a>

      <ul class="treeview-menu">
        <li><a href="#" onclick="CWReport()"><i class="fa fa-circle-o"></i> Company wise Report</a></li>
        <li><a href="#" onclick="SWReport()"><i class="fa fa-circle-o"></i> Staff wise Report</a></li>
        <li><a href="#" onclick="CWHB()"><i class="fa fa-circle-o"></i> Company wise Hand Book</a></li>
        <li><a href="#" onclick="Handbookfull()"><i class="fa fa-circle-o"></i> Full Hand Book</a></li>
      </ul>
    </li>
     </ul>
     
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">

	<div id = "ajaxpage" >

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-home"></i> Home</li>
        <li><i class="fa fa-dashboard"></i> Dashboard</li>
      </ol>
    </section>

              <%
				String countcmp="--";

				PreparedStatement pscmp=Dataconnect.connectDB().prepareStatement("select count(*) from company");
				ResultSet rscmp = pscmp.executeQuery();

				while(rscmp.next())
				{
					countcmp = rscmp.getString(1);
				}
	            %>

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">

        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3><%=countcmp %></h3>
              <p>Companys</p>
            </div>
            <div class="icon">
              <i class="ion-bag"></i>
            </div>
            <a href="#" onclick="cmplist();" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>

        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>--<sup style="font-size: 20px">%</sup></h3>
              <p>Overall Progress of Team</p>
            </div>
            <div class="icon">
              <i class="ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>

        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>--</h3>
              <p>--</p>
            </div>
            <div class="icon">
              <i class="ion-pie-graph"></i>
            </div>
            <a href="#" onclick="myUPJFunc();" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>

        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>--</h3>
              <p>--</p>
            </div>
            <div class="icon">
              <i class="ion-person-add"></i>
            </div>
            <a href="#" onclick="myPJFunc();" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
      </div>

      <div class="row">
		<section Style ="margin-Left:15px; margin-right:15px  ">
			Dashboard Here:-
		</section>
	</div>
    </section>    <!-- /.content -->
    
    </div>    <!-- /.AjaxPage div-->
    
    
  </div>   <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0.0-beta
    </div>
<%--https://adminlte.io --%>
    <strong>Copyright &copy; 2019-2050 <a href="http://tinyurl.com/ebserp">Exaccpro.ERP</a>.</strong> All rights
    reserved to Mr. Biju Narayanan.
  </footer>
</div>


<!-- jQuery 3 -->
<script src="jquery/jquery.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="jquery/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="jquery/adminlte.min.js"></script>

<!-- Sweet Alert -->
<script src='jquery/sweetalert.js'></script>

<script>
function Handbookfull() {
    $.ajax({
    url: "handbook-full.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function cmpedit() {
	$.ajax({	
    url: "editcmp.jsp",//your jsp page name
    method: "POST",//HTTP method.
    data: {cmp_id:20},//sending request to state.jsp page.
	success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};

</script>



<script>
function gstchngpass() {
	    $.ajax({
	        url: "chnguserpassgst.jsp",//your jsp page name
	        method: "POST",//HTTP method.
	        success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
            });
	};
</script>


<script>
function cmplist() {
	    $.ajax({
	        url: "cmplist.jsp",//your jsp page name
	        method: "POST",//HTTP method.
	        success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
            });
	};
</script>

<script>
function cesslogpass() {
	    $.ajax({
	        url: "createuserpasscess.jsp",//your jsp page name
	        method: "POST",//HTTP method.
	        success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
            });
	};
</script>


<script>
function cessuserpass() {
	    $.ajax({
	        url: "userpasscess.jsp",//your jsp page name
	        method: "POST",//HTTP method.
	        success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
            });
	};
</script>

<script>
function gstuserpass() {
	    $.ajax({
	        url: "userpassgst.jsp",//your jsp page name
	        method: "POST",//HTTP method.
	        success: function (data)
	        {
	            $("#ajaxpage").html(data);//output or response will display in state select box.
	        }
            });
	};
</script>

<script>
function myCHBFunc() {
    $.ajax({
    url: "createhandbook.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function myDHBFunc() {
    $.ajax({
        url: "Servebserp?action=deletehandbook",//your jsp page name
        method: "POST"//HTTP method.
        });
	};
</script>

<script>
function myVSFunc() {
    $.ajax({
    url: "verificationsetting.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function create_edit_staff() {
    $.ajax({
    url: "create_edit_staff.jsp",//your jsp page name
    method: "POST",//HTTP method.
	data: {id:0},//sending request to state.jsp page.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>


<script>
function staff_list() {
    $.ajax({
    url: "userdetails.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function CWReport() {
    $.ajax({
    url: "reportpage-cmpwise.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function SWReport() {
    $.ajax({
    url: "reportpage-staffwise.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>

<script>
function CWHB() {
    $.ajax({
    url: "reportpage-cmpwisehb.jsp",//your jsp page name
    method: "POST",//HTTP method.
    success: function (data)
    {
        $("#ajaxpage").html(data);//output or response will display in state select box.
    }
    });
};
</script>


<script>
if ("<%out.print(datainserted);%>" == "inserted")
{
$(document).ready(function(){
swal('Good job!', 'Your todays Daily Jobsheet uploaded!', 'success');
});

	//	alert("Record inserted Sucessfully");
	}
</script>

<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
</SCRIPT>
<% session.removeAttribute("datainserted"); %>

</body>
</html>
