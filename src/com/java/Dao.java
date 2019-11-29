package com.java;
	import java.sql.*;
	import java.util.*;	
	
	
	
	public class Dao 
	{
		//Method managerremarks
		public static void managerremarks(Integer Job_id, String job_verstat, String manremark) {
			try
			{
				PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE dailyjobsheet SET Job_manager_remark=?, job_manager_status=? Where Job_id =?") ;
				ps.setString(1,manremark);
				ps.setString(2,job_verstat);
				ps.setInt(3,Job_id);
				
				ps.executeUpdate();
				
			}
				catch(SQLException e)
					{
						System.out.println(e);
					}
			
		}

		
		
		//Method chklogin
	public static users chklogin(users L)
		{
		L.setRoll("Wrong");
			try
				{
					PreparedStatement ps=Dataconnect.connectDB().prepareStatement("select * from users where user=? and pass=?");
					ps.setString(1,L.username);
					ps.setString(2,L.password);
					
					ResultSet rs = ps.executeQuery();
										
					while(rs.next())
					{
						L.setId(rs.getInt("id"));
						L.setUsername(rs.getString("user"));
						L.setPassword(rs.getString("pass"));
						L.setRoll(rs.getString("roll"));
						L.setName(rs.getString("name"));
						L.setDesignation(rs.getString("designation"));
						L.setDOJ(rs.getString("DOJ"));
						L.setTeam_id(rs.getInt("team_id"));
						
						//openclass.emp_id = rs.getInt("id");
					}
				}
					catch(SQLException e)
						{
							System.out.println(e);
						}
			return L;
		}

	//Method newpass
	public static void newpass(String newpass, Integer userid) {
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE users SET pass=? Where id =?") ;
			ps.setString(1,newpass);
			ps.setInt(2,userid);
			
			ps.executeUpdate();
			
		}
			catch(SQLException e)
				{
					System.out.println(e);
				}
		
	}
	
	//Method displayDet
	public ArrayList<Jobsheet> displayDet(Object userid)
	{
		ArrayList<Jobsheet> list = new ArrayList<Jobsheet>();
		ResultSet rs= null; 

		try
	{
//			ps=conn.prepareStatement("select users.Name,users.designation,users.DOJ,dailyjobsheet.company,dailyjobsheet.id,dailyjobsheet.work,dailyjobsheet.task,dailyjobsheet.details,status,dailyjobsheet.manager_remark from users INNER JOIN dailyjobsheet on users.id=dailyjobsheet.id");
//			ps=conn.prepareStatement("select dailyjobsheet.company,dailyjobsheet.id,dailyjobsheet.work,dailyjobsheet.task,dailyjobsheet.details,status,dailyjobsheet.manager_remark from dailyjobsheet where dailyjobsheet.user_id =" + openclass.emp_id);

			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("select * from dailyjobsheet where job_user_id =" + userid + " ORDER BY job_id DESC");
			rs=ps.executeQuery();
		while(rs.next())
 	{
//		 System.out.println(openclass.emp_id);
//		 System.out.println(rs.getInt("job_id"));

	 	Jobsheet js=new Jobsheet();
	 	js.setJob_id(rs.getInt("job_id"));
	 	js.setJob_date(rs.getDate("job_date"));
	    js.setJob_company(rs.getString("Job_company"));
	    js.setJob_work(rs.getString("Job_work"));
		js.setJob_task(rs.getString("Job_task"));
		js.setJob_details(rs.getString("Job_details"));
		js.setJob_time_s(rs.getTime("Job_time_s"));
		js.setJob_time_e(rs.getTime("Job_time_e"));
		js.setJob_status(rs.getString("Job_status"));
		js.setJob_manger_remark(rs.getString("Job_manager_remark"));
		list.add(js);
 	}
	}
		catch(SQLException e)
	{
			e.printStackTrace();
	}
		return list;
	}	

//Method Add Details
	
	public int adddetails(Jobsheet js)
	{
		int status = 0;
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("insert into dailyjobsheet(Job_date, Job_company, Job_work, Job_task, Job_details, Job_time_s, Job_time_e, Job_status, Job_status1, Job_user_id) values (?,?,?,?,?,?,?,?,?,?)") ;
			ps.setDate(1,js.getJob_date());
			ps.setString(2,js.getJob_company());
			ps.setString(3,js.getJob_work());
			ps.setString(4,js.getJob_task());
			ps.setString(5,js.getJob_details());
			ps.setTime(6,  js.getJob_time_s());
			ps.setTime(7,  js.getJob_time_e());
			ps.setString(8,js.getJob_status());
			ps.setString(9,js.getJob_status());

			if (js.getJob_status().equals("On Process"))
				{
					PreparedStatement psupj=Dataconnect.connectDB().prepareStatement("SELECT job_id FROM dailyjobsheet WHERE Job_user_id = ? AND Job_company = ? AND Job_work = ? AND Job_task = ? AND Job_status1 = ?");
					psupj.setInt(1, js.getJob_user_id()); 
					psupj.setString(2,js.getJob_company());
					psupj.setString(3,js.getJob_work());
					psupj.setString(4,js.getJob_task());
					psupj.setString(5,"On Process");

					ResultSet rsupj = psupj.executeQuery();

					while(rsupj.next())
					{
						ps.setString(9,"Cont Process");
					}

				}
			ps.setInt(10,js.getJob_user_id());
			
			status = ps.executeUpdate();
			
			if (js.getJob_status().equals("Finished"))
				{
					PreparedStatement psupj=Dataconnect.connectDB().prepareStatement("UPDATE dailyjobsheet SET job_status1 = 'Finished' WHERE Job_user_id = ? AND Job_company = ? AND Job_work = ? AND Job_task = ? AND job_status1 = 'On Process'");
					psupj.setInt(1, js.getJob_user_id()); 
					psupj.setString(2,js.getJob_company());
					psupj.setString(3,js.getJob_work());
					psupj.setString(4,js.getJob_task());
					psupj.executeUpdate();

				}
			
		}
			catch(SQLException e)
				{
					System.out.println(e);
				}
		return status;
	}

	public static void userdetailsaving(users uds) {
		// TODO Auto-generated method stub
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE users SET user=?, pass=?, roll=?, name=?, address=?, mobile=?, designation=?, DOJ=?, team_id=?, ver_userid=? Where id =?") ;
			ps.setString(1, uds.getUsername());
			ps.setString(2, uds.getPassword());
			ps.setString(3, uds.getRoll());
			ps.setString(4, uds.getName());
			ps.setString(5, uds.getAddress());
			ps.setString(6, uds.getMobile());
			ps.setString(7, uds.getDesignation());
			ps.setString(8, uds.getDOJ());
			ps.setInt(9, uds.getTeam_id());
			ps.setInt(10, uds.getVer_user_id());
			ps.setInt(11, uds.getId());
			
			ps.executeUpdate();
			
		}
			catch(SQLException e)
				{
					System.out.println(e);
				}
	}

	public static void taskadder(Arrayclass taskadder) {
		// TODO Auto-generated method stub
		try
			{
				PreparedStatement ps=Dataconnect.connectDB().prepareStatement("insert into task (cmp_name, work_id, work, task) values (?,?,?,?)") ;
				ps.setString(1, taskadder.getHb_cmp_nam());
				ps.setInt(2, taskadder.getHb_work_id());
				ps.setString(3, taskadder.getHb_work_nam());
				ps.setString(4, taskadder.getHb_task_nam());
				
				ps.executeUpdate();
			}
		catch(SQLException e)
			{
				System.out.println(e);
			}
		
	}



	public static void workadder(Arrayclass workadder) {
		// TODO Auto-generated method stub
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("insert into work (cmp_id, cmp_name, work) values (?,?,?)") ;
			ps.setInt(1, workadder.getHb_cmp_id());
			ps.setString(2, workadder.getHb_cmp_nam());
			ps.setString(3, workadder.getHb_work_nam());
			
			ps.executeUpdate();
		}
	catch(SQLException e)
		{
			System.out.println(e);
		}


		
	}

	public static void createcessdetails(Arrayclass createcessdetails) {
		// TODO Auto-generated method stub
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE company SET cess_login_id=?, cess_login_pass=?, cess_pass_changed_on=? WHERE id=?") ;
			ps.setString(1, createcessdetails.getCess_cess_user());
			ps.setString(2, createcessdetails.getCess_cess_pass());
			ps.setDate(3, createcessdetails.getCess_pass_changed_on());
			ps.setInt(4, createcessdetails.getCess_cmp());
			
			ps.executeUpdate();
		}
	catch(SQLException e)
		{
			System.out.println(e);
		}

	}



	public static void chnggstpass(Arrayclass chnggstpass) {
		// TODO Auto-generated method stub
		String old_gst_pass = null;
		try
		{
		
		
		PreparedStatement psgstpass=Dataconnect.connectDB().prepareStatement("SELECT gst_login_pass FROM company WHERE id =?");
		psgstpass.setInt(1, chnggstpass.getGst_cmp());
		ResultSet rsgstpass = psgstpass.executeQuery();
		while(rsgstpass.next())
		{
			old_gst_pass = rsgstpass.getString("gst_login_pass");
		}
		
		}
		
		catch(SQLException e)
		{
			System.out.println(e);
		}
		
		
		try
		{
			PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE company SET gst_login_pass=?, gst_pass_changed_on=?, gst_prv_pass=? WHERE id=?") ;
			ps.setString(1, chnggstpass.getGst_gst_pass());
			ps.setDate(2, chnggstpass.getGst_pass_changed_on());
			ps.setString(3, old_gst_pass);
			ps.setInt(4, chnggstpass.getGst_cmp());
			
			ps.executeUpdate();
		}
	catch(SQLException e)
		{
			System.out.println(e);
		}

		
		
	}



	public static void companyadder(Arrayclass companyadder) {
		// TODO Auto-generated method stub
		Integer file_no = 0;

		try {

			//select count(*) from company where team_id = ?");
		PreparedStatement pscrecmp=Dataconnect.connectDB().prepareStatement("SELECT MAX(file_no) FROM company");
		ResultSet rscrecmp = pscrecmp.executeQuery();
			while(rscrecmp.next())
			{
				file_no = rscrecmp.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		file_no = file_no + 1;
		
		try {
	
		PreparedStatement ps=Dataconnect.connectDB().prepareStatement("insert into company(file_no, cmp_name, type, acc_type_id, cmp_status, team_id, gst_pass_changed_on, cess_pass_changed_on) values (?,?,?,?,?,?,?,?)");
		ps.setInt(1, file_no);
		ps.setString(2,companyadder.getHb_cmp_nam());
		ps.setString(3,companyadder.getHb_cmp_type());
		ps.setInt(4,companyadder.getHb_cmp_acc());
		ps.setInt(5,1);
		ps.setInt(6,companyadder.getHb_cmp_team());
		ps.setDate(7, companyadder.getHb_cmp_date());
		ps.setDate(8, companyadder.getHb_cmp_date());
	
		ps.executeUpdate();
		}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
	}



	public static void cmpupdate(Arrayclass cmpupdate) {
		// TODO Auto-generated method stub
		try {
			
		PreparedStatement ps=Dataconnect.connectDB().prepareStatement("UPDATE company SET cmp_name=?, cmp_status=?, type=?, acc_type_id=?, team_id=?, gst_login_id=?, gst_mobile=?, gst_email=? WHERE id=?") ;
		ps.setString(1, cmpupdate.getCmpup_cmp_name());
		ps.setInt(2, cmpupdate.getCmpup_cmp_status());
		ps.setString(3, cmpupdate.getCmpup_cmp_type());
		ps.setInt(4, cmpupdate.getCmpup_acc_type_id());
		ps.setInt(5, cmpupdate.getCmpup_team_id());
		ps.setString(6, cmpupdate.getCmpup_gst_login_id());
		ps.setString(7, cmpupdate.getCmpup_gst_mobile());
		ps.setString(8, cmpupdate.getCmpup_gst_email());
		ps.setInt(9, cmpupdate.getCmpup_cmp_id());
		
		ps.executeUpdate();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}	
	}