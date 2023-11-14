package com.naver.erp;

public class CalendarDTO {
	private String subject;						 
	private String schedule_start_date;								 
	private String schedule_end_date;		 
	private String summary;								 
	private String location;						 
	private String color;					 
	private String cal_num;			
	
	public String getCal_num() {
		return cal_num;
	}
	public void setCal_num(String cal_num) {
		this.cal_num = cal_num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSchedule_start_date() {
		return schedule_start_date;
	}
	public void setSchedule_start_date(String schedule_start_date) {
		this.schedule_start_date = schedule_start_date;
	}
	public String getSchedule_end_date() {
		return schedule_end_date;
	}
	public void setSchedule_end_date(String schedule_end_date) {
		this.schedule_end_date = schedule_end_date;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}		

	
}
