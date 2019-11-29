package com.java;
//import java.util.*; 
import java.sql.*; 

public class Jobsheet {

private int job_id;
private Date job_date;
private String job_company;
private String job_work;
private String job_task;
private String job_details;
private Time job_time_s;
private Time job_time_e;
private String job_status;
private String job_manger_remark;
private int job_user_id;
public int getJob_id() {
	return job_id;
}
public void setJob_id(int job_id) {
	this.job_id = job_id;
}
public Date getJob_date() {
	return job_date;
}
public void setJob_date(Date job_date) {
	this.job_date = job_date;
}
public String getJob_company() {
	return job_company;
}
public void setJob_company(String job_company) {
	this.job_company = job_company;
}
public String getJob_work() {
	return job_work;
}
public void setJob_work(String job_work) {
	this.job_work = job_work;
}
public String getJob_task() {
	return job_task;
}
public void setJob_task(String job_task) {
	this.job_task = job_task;
}
public String getJob_details() {
	return job_details;
}
public void setJob_details(String job_details) {
	this.job_details = job_details;
}
public Time getJob_time_s() {
	return job_time_s;
}
public void setJob_time_s(Time job_time_s) {
	this.job_time_s = job_time_s;
}
public Time getJob_time_e() {
	return job_time_e;
}
public void setJob_time_e(Time job_time_e) {
	this.job_time_e = job_time_e;
}
public String getJob_status() {
	return job_status;
}
public void setJob_status(String job_status) {
	this.job_status = job_status;
}
public String getJob_manger_remark() {
	return job_manger_remark;
}
public void setJob_manger_remark(String job_manger_remark) {
	this.job_manger_remark = job_manger_remark;
}
public int getJob_user_id() {
	return job_user_id;
}
public void setJob_user_id(int job_user_id) {
	this.job_user_id = job_user_id;
}


}