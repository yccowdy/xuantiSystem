package com.kk.subject.model;

import java.sql.Date;


public class NoticeBean {
	private int id;
	private String title;
	private String publisher;
	private Date time;
	private String detail;

	public NoticeBean(){

	}
	//不带id的构造方法
	public NoticeBean(String title,String publisher,Date time,String detail){
		this.setTitle(title);
		this.setPublisher(publisher);
		this.setTime(time);
		this.setDetail(detail);
	}
	//带id的构造方法
	public NoticeBean(int id,String title,String publisher,Date time,String detail){
		this.setId(id);
		this.setTitle(title);
		this.setPublisher(publisher);
		this.setTime(time);
		this.setDetail(detail);
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
}
