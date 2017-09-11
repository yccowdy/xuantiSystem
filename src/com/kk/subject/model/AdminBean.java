package com.kk.subject.model;

public class AdminBean {


	private String id;
	private String psw;
	private String name;
	private int type;
	private String sex;	//性别
	private String phoneNum;//电话号码
	private String email;	//电子邮箱
	private String yuanxi;	//院系
	
	public AdminBean() {
		super();
	}

	public AdminBean(String id, String psw, String name, int type, String sex,
			String phoneNum, String email, String yuanxi) {
		super();
		this.id = id;
		this.psw = psw;
		this.name = name;
		this.type = type;
		this.sex = sex;
		this.phoneNum = phoneNum;
		this.email = email;
		this.yuanxi = yuanxi;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getYuanxi() {
		return yuanxi;
	}
	public void setYuanxi(String yuanxi) {
		this.yuanxi = yuanxi;
	}

	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPsw() {
		return psw;
	}
	public void setPsw(String psw) {
		this.psw = psw;
	}
}
