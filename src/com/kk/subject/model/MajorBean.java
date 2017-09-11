package com.kk.subject.model;

public class MajorBean {

	private int id;
	private String major;
	private final String academy="计算机学院";
	public MajorBean(int id, String major) {
		// TODO Auto-generated constructor stub
		this.setId(id);
		this.setMajor(major);
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getAcademy() {
		return academy;
	}

}
