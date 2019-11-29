package com.java;
import java.sql.*; 

public class Arrayclass {

	private int team_id;
	private String team_team_name;
	
	private int cmp_team_id;
	private String cmp_cmp_name;
	
	private int hb_cmp_id;
	private String hb_cmp_nam;
	private int hb_work_id;
	private String hb_work_nam;
	private String hb_task_nam;

	private String  hb_cmp_type;
	private int hb_cmp_acc;
	private int hb_cmp_team;
	private Date hb_cmp_date;
	
	private int cess_cmp;
	private String cess_cess_user;
	private String cess_cess_pass;
	private Date cess_pass_changed_on;
	
	private int gst_cmp;
	private String gst_gst_pass;
	private Date gst_pass_changed_on;
	
	private int cmpup_cmp_id;
	private String cmpup_cmp_name;
	private int cmpup_cmp_status;
	private String cmpup_cmp_type;
	private int cmpup_acc_type_id;
	private int cmpup_team_id;
	private String cmpup_gst_login_id;
	private String cmpup_gst_mobile;
	private String cmpup_gst_email;
		
	
	public int getTeam_id() {
		return team_id;
	}
	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}
	public String getTeam_team_name() {
		return team_team_name;
	}
	public void setTeam_team_name(String team_team_name) {
		this.team_team_name = team_team_name;
	}
	public int getCmp_team_id() {
		return cmp_team_id;
	}
	public void setCmp_team_id(int cmp_team_id) {
		this.cmp_team_id = cmp_team_id;
	}
	public String getCmp_cmp_name() {
		return cmp_cmp_name;
	}
	public void setCmp_cmp_name(String cmp_cmp_name) {
		this.cmp_cmp_name = cmp_cmp_name;
	}
	public int getHb_cmp_id() {
		return hb_cmp_id;
	}
	public void setHb_cmp_id(int hb_cmp_id) {
		this.hb_cmp_id = hb_cmp_id;
	}
	public String getHb_cmp_nam() {
		return hb_cmp_nam;
	}
	public void setHb_cmp_nam(String hb_cmp_nam) {
		this.hb_cmp_nam = hb_cmp_nam;
	}
	public int getHb_work_id() {
		return hb_work_id;
	}
	public void setHb_work_id(int hb_work_id) {
		this.hb_work_id = hb_work_id;
	}
	public String getHb_work_nam() {
		return hb_work_nam;
	}
	public void setHb_work_nam(String hb_work_nam) {
		this.hb_work_nam = hb_work_nam;
	}
	public String getHb_task_nam() {
		return hb_task_nam;
	}
	public void setHb_task_nam(String hb_task_nam) {
		this.hb_task_nam = hb_task_nam;
	}
	public String getHb_cmp_type() {
		return hb_cmp_type;
	}
	public void setHb_cmp_type(String hb_cmp_type) {
		this.hb_cmp_type = hb_cmp_type;
	}
	public int getHb_cmp_acc() {
		return hb_cmp_acc;
	}
	public void setHb_cmp_acc(int hb_cmp_acc) {
		this.hb_cmp_acc = hb_cmp_acc;
	}
	public int getHb_cmp_team() {
		return hb_cmp_team;
	}
	public void setHb_cmp_team(int hb_cmp_team) {
		this.hb_cmp_team = hb_cmp_team;
	}
	public Date getHb_cmp_date() {
		return hb_cmp_date;
	}
	public void setHb_cmp_date(Date hb_cmp_date) {
		this.hb_cmp_date = hb_cmp_date;
	}
	public int getCess_cmp() {
		return cess_cmp;
	}
	public void setCess_cmp(int cess_cmp) {
		this.cess_cmp = cess_cmp;
	}
	public String getCess_cess_user() {
		return cess_cess_user;
	}
	public void setCess_cess_user(String cess_cess_user) {
		this.cess_cess_user = cess_cess_user;
	}
	public String getCess_cess_pass() {
		return cess_cess_pass;
	}
	public void setCess_cess_pass(String cess_cess_pass) {
		this.cess_cess_pass = cess_cess_pass;
	}
	public Date getCess_pass_changed_on() {
		return cess_pass_changed_on;
	}
	public void setCess_pass_changed_on(Date cess_pass_changed_on) {
		this.cess_pass_changed_on = cess_pass_changed_on;
	}
	public int getGst_cmp() {
		return gst_cmp;
	}
	public void setGst_cmp(int gst_cmp) {
		this.gst_cmp = gst_cmp;
	}
	public String getGst_gst_pass() {
		return gst_gst_pass;
	}
	public void setGst_gst_pass(String gst_gst_pass) {
		this.gst_gst_pass = gst_gst_pass;
	}
	public Date getGst_pass_changed_on() {
		return gst_pass_changed_on;
	}
	public void setGst_pass_changed_on(Date gst_pass_changed_on) {
		this.gst_pass_changed_on = gst_pass_changed_on;
	}
	public int getCmpup_cmp_id() {
		return cmpup_cmp_id;
	}
	public void setCmpup_cmp_id(int cmpup_cmp_id) {
		this.cmpup_cmp_id = cmpup_cmp_id;
	}
	public String getCmpup_cmp_name() {
		return cmpup_cmp_name;
	}
	public void setCmpup_cmp_name(String cmpup_cmp_name) {
		this.cmpup_cmp_name = cmpup_cmp_name;
	}
	public String getCmpup_cmp_type() {
		return cmpup_cmp_type;
	}
	public void setCmpup_cmp_type(String cmpup_cmp_type) {
		this.cmpup_cmp_type = cmpup_cmp_type;
	}
	public int getCmpup_acc_type_id() {
		return cmpup_acc_type_id;
	}
	public void setCmpup_acc_type_id(int cmpup_acc_type_id) {
		this.cmpup_acc_type_id = cmpup_acc_type_id;
	}
	public int getCmpup_team_id() {
		return cmpup_team_id;
	}
	public void setCmpup_team_id(int cmpup_team_id) {
		this.cmpup_team_id = cmpup_team_id;
	}
	public String getCmpup_gst_login_id() {
		return cmpup_gst_login_id;
	}
	public void setCmpup_gst_login_id(String cmpup_gst_login_id) {
		this.cmpup_gst_login_id = cmpup_gst_login_id;
	}
	public int getCmpup_cmp_status() {
		return cmpup_cmp_status;
	}
	public void setCmpup_cmp_status(int cmpup_cmp_status) {
		this.cmpup_cmp_status = cmpup_cmp_status;
	}
	public String getCmpup_gst_mobile() {
		return cmpup_gst_mobile;
	}
	public void setCmpup_gst_mobile(String cmpup_gst_mobile) {
		this.cmpup_gst_mobile = cmpup_gst_mobile;
	}
	public String getCmpup_gst_email() {
		return cmpup_gst_email;
	}
	public void setCmpup_gst_email(String cmpup_gst_email) {
		this.cmpup_gst_email = cmpup_gst_email;
	}
	
	
	
	
	
	
	
	
	

	
	
}
