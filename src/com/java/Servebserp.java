package com.java;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;



/**
 * Servlet implementation class Login
 */
@WebServlet("/Servebserp")
public class Servebserp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servebserp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());

		String act= request.getParameter("action");	
		//System.out.println("Inside Get");
		//		doPost(request, response);
		
		if(act.equals("sessionout"))
		{
//			System.out.println("inside session out");
			response.setContentType("text/html");
			HttpSession session = request.getSession();
			session.removeAttribute("id");
			session.removeAttribute("username");
			session.removeAttribute("roll");
			session.removeAttribute("Name");
			session.removeAttribute("Designation");
			session.removeAttribute("DOJ");
			session.removeAttribute("team_id");
			session.invalidate();
			response.sendRedirect("index.html");
		}	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String act= request.getParameter("action");	
//Action = "login"
		if(act.equals("login"))
			{
				users objuser = new users();
				objuser.setUsername(request.getParameter("username"));
				objuser.setPassword(request.getParameter("password"));
				objuser = Dao.chklogin(objuser);

				HttpSession session = request.getSession(true);
				session.setAttribute("id", objuser.id);
				session.setAttribute("username", objuser.username);
				session.setAttribute("roll", objuser.roll);
				session.setAttribute("Name", objuser.Name);
				session.setAttribute("Designation", objuser.Designation);
				session.setAttribute("DOJ", objuser.DOJ);
				session.setAttribute("team_id", objuser.team_id);

//				request.setAttribute("objuser", objuser);

				if (objuser.getRoll().equals("Wrong") || objuser.getRoll().equals("resigned") )
					{
					request.getRequestDispatcher("invalid.html").forward(request,response);
					session.removeAttribute("roll");
//					response.sendRedirect("invalid.html");
					}
						else if (objuser.getRoll().equals("admin"))
					{
							if (objuser.getPassword().equals("123"))
							{
								request.getRequestDispatcher("chngpass.html").forward(request,response);
							}
							else
							{
								request.getRequestDispatcher("admin.jsp").forward(request,response);
							}
					}      
						else if (objuser.getRoll().equals("staff") || objuser.getRoll().equals("admin/staff")  )
					{
							if (objuser.getPassword().equals("123"))
							{
								request.getRequestDispatcher("chngpass.html").forward(request,response);
							}
							else
							{
						request.getRequestDispatcher("main.jsp").forward(request,response);
							}
					}
			}

		if(act.equals("chngpass"))
		{
			HttpSession session = request.getSession(false);
			Dao.newpass(request.getParameter("newpass"), (Integer) session.getAttribute("id"));
			
			if (session.getAttribute("roll").equals("admin"))
			{
				request.getRequestDispatcher("admin.jsp").forward(request,response);
			}
			else
			{
				request.getRequestDispatcher("main.jsp").forward(request,response);
			}
		}
		
		
//Action = "dailyreport"
		if (act.equals("dailyreport"))
			{
				Dao Daojobsheet= new Dao();
				ArrayList<Jobsheet> lijobsheet=Daojobsheet.displayDet(request.getSession().getAttribute("id"));
//				for (Jobsheet j : lijobsheet)
//				{
//					System.out.println(j.getJob_company());	
//				}
				request.setAttribute("lijobsheet1",lijobsheet);
				request.getRequestDispatcher("monthlyreport.jsp").forward(request,response);
			}	
	
//Action = "addrecord"
		if(act.equals("addrecord"))
		{
			String[] company = request.getParameterValues("company");
			String[] work = request.getParameterValues("work");
			String[] task = request.getParameterValues("task");
			String[] time_s = request.getParameterValues("time_s");
			String[] time_e = request.getParameterValues("time_e");
			String[] details = request.getParameterValues("details");
			String[] status = request.getParameterValues("status");
			Jobsheet addrecord = new Jobsheet();
			Dao Daojobsheet= new Dao();
			int status1 = 0;			
			
			for (int i=0; i<company.length; i++)
			{
			addrecord.setJob_date(new java.sql.Date(System.currentTimeMillis()));
			addrecord.setJob_company(company[i]);
			addrecord.setJob_work(work[i]);
			addrecord.setJob_task(task[i]);
			addrecord.setJob_details(details[i]);
			addrecord.setJob_time_s(java.sql.Time.valueOf(time_s[i]));
			addrecord.setJob_time_e(java.sql.Time.valueOf(time_e[i]));
			addrecord.setJob_status(status[i]);
			addrecord.setJob_user_id(Integer.parseInt(request.getParameter("lg_id")));
//			addrecord.setJob_user_id(openclass.emp_id);

			int status2 = Daojobsheet.adddetails(addrecord);
			status1 = status2;
			}
//			System.out.println(status1);

			if (status1 != 0)
			{
//				PrintWriter out = response.getWriter();
//Alert or Script in Servlet using html/jsp method
				
//				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
//				out.println("<script>");
//				out.println("$(document).ready(function(){");
//				out.println("alert('Record inserted Sucessfully');");
//				out.println("});");
//				out.println("</script>");
				
//				out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
//				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");

//				out.println("<script src='jquery/jquery.min.js'></script>");
//				out.println("<script src='jquery/sweetalert.js'></script>");
				
				
//				out.println("<script>");
//				out.println("$(document).ready(function(){");
//				out.println("swal('Good job!', 'Your todays Daily Jobsheet uploaded!', 'success');");
//				out.println("});");
//				out.println("</script>");

//				System.out.println("Inside");

//METHOD TO USE INCLUDE INSTEAD OF FORWARD BY LESS SECURITY
//				request.getRequestDispatcher("main.jsp").include(request,response);
				
				HttpSession session = request.getSession(true);
				session.setAttribute("datainserted", "inserted");
//				response.sendRedirect("success.html");
				response.sendRedirect("main.jsp");
//				request.setAttribute("datainserted","inserted");
//				request.getRequestDispatcher("main.jsp").forward(request,response);
			}
		}
		

//Action = "ManagerJobOver"
		if (act.equals("managerjobver"))
			{
			int Job_id = Integer.parseInt(request.getParameter("Job_id"));
			String job_verstat = request.getParameter("job_verstat");
			String manremark = request.getParameter("manremark");

			Dao.managerremarks(Job_id,job_verstat,manremark);
			
//			System.out.println("Man Remark = "+ manremark + " Job id = "+ Job_id + " verstat = "+ job_verstat);
			}
		
//Action = "userdetailsaving"
		if (act.equals("userdetailsaving"))
		{
			users uds = new users();
			uds.setId(Integer.parseInt(request.getParameter("id")));
			uds.setUsername(request.getParameter("user"));
			uds.setPassword(request.getParameter("pass"));
			uds.setRoll(request.getParameter("Roll"));
			uds.setName(request.getParameter("Name"));
			uds.setAddress(request.getParameter("Address"));
			uds.setMobile(request.getParameter("Mobile"));
			uds.setDesignation(request.getParameter("Desi"));
			uds.setDOJ(request.getParameter("DOJ"));
			uds.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
			uds.setVer_user_id(Integer.parseInt(request.getParameter("ver_userid")));
		
			Dao.userdetailsaving(uds);
			request.getRequestDispatcher("admin.jsp").forward(request,response);
		}

//Action = "workadder"
		if (act.equals("workadder"))
			{
			Arrayclass workadder = new Arrayclass();
			workadder.setHb_cmp_id(Integer.parseInt(request.getParameter("cmp_id")));
			workadder.setHb_cmp_nam(request.getParameter("cmp_nam"));
			workadder.setHb_work_nam(request.getParameter("work_nam"));
			Dao.workadder(workadder);
			}
				
//Action = "taskadder"
		if (act.equals("taskadder"))
			{
			Arrayclass taskadder = new Arrayclass();
			taskadder.setHb_cmp_nam(request.getParameter("cmp_nam"));
			taskadder.setHb_work_id(Integer.parseInt(request.getParameter("work_id")));
			taskadder.setHb_work_nam(request.getParameter("work_nam"));
			taskadder.setHb_task_nam(request.getParameter("task_nam"));
			Dao.taskadder(taskadder);
			}

//Action = "createcessdetails"
		if (act.equals("createcessdetails"))
			{
			Arrayclass createcessdetails = new Arrayclass();
			createcessdetails.setCess_cmp(Integer.parseInt(request.getParameter("cmp")));
			createcessdetails.setCess_cess_user(request.getParameter("cess_user"));
			createcessdetails.setCess_cess_pass(request.getParameter("cess_pass"));
			createcessdetails.setCess_pass_changed_on(new java.sql.Date(System.currentTimeMillis()));
			Dao.createcessdetails(createcessdetails);
			}

//Action = "chnggstpass"
		if (act.equals("chnggstpass"))
			{
			Arrayclass chnggstpass = new Arrayclass();
			chnggstpass.setGst_cmp(Integer.parseInt(request.getParameter("cmp")));
			chnggstpass.setGst_gst_pass(request.getParameter("gst_pass"));
			chnggstpass.setGst_pass_changed_on(new java.sql.Date(System.currentTimeMillis()));
			Dao.chnggstpass(chnggstpass);
			}
				
//Action = "companyadder"
		if (act.equals("companyadder"))
			{
			Arrayclass companyadder = new Arrayclass();
			companyadder.setHb_cmp_nam(request.getParameter("company"));
			companyadder.setHb_cmp_type(request.getParameter("type"));
			companyadder.setHb_cmp_acc(Integer.parseInt(request.getParameter("acc")));
			companyadder.setHb_cmp_team(Integer.parseInt(request.getParameter("team")));
			companyadder.setHb_cmp_date(new java.sql.Date(System.currentTimeMillis()));
			
			Dao.companyadder(companyadder);
			}

//Action = "cmpupdate"
		if (act.equals("cmpupdate"))
			{
			Arrayclass cmpupdate = new Arrayclass();
			cmpupdate.setCmpup_cmp_id(Integer.parseInt(request.getParameter("cmp_id")));
			cmpupdate.setCmpup_cmp_name(request.getParameter("cmp_name"));
			cmpupdate.setCmpup_cmp_status(Integer.parseInt(request.getParameter("cmp_status")));
			cmpupdate.setCmpup_cmp_type(request.getParameter("cmp_type"));
			cmpupdate.setCmpup_acc_type_id(Integer.parseInt(request.getParameter("acc_type_id")));
			cmpupdate.setCmpup_team_id(Integer.parseInt(request.getParameter("team_id")));
			cmpupdate.setCmpup_gst_login_id(request.getParameter("gst_login_id"));
			cmpupdate.setCmpup_gst_mobile(request.getParameter("gst_mobile"));
			cmpupdate.setCmpup_gst_email(request.getParameter("gst_email"));

			Dao.cmpupdate(cmpupdate);
			}

	}
	}