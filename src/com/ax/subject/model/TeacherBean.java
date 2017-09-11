package com.ax.subject.model;

public class TeacherBean {

	private String id;	//登陆账号
	private String psw;	//密码
	private String name;//姓名
	private SEX sex;	//性别
	private String phoneNum;//电话号码
	private String email;	//电子邮箱
	private String jobTitle;//职称
	private int maxSubNum;	//最大出题数目

	//构造方法
	public TeacherBean(){
	}
	//带参数的构造方法
	public TeacherBean(String id,String psw,String name,SEX sex,String phoneNum,String email,String jobTitle,int maxSubNum){
		this.setId(id);
		this.setPsw(psw);
		this.setName(name);
		this.setSex(sex);
		this.setPhoneNum(phoneNum);
		this.setEmail(email);
		this.setJobTitle(jobTitle);
		this.setMaxSubNum(maxSubNum);
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public int getMaxSubNum() {
		return maxSubNum;
	}
	public void setMaxSubNum(int maxSubNum) {
		this.maxSubNum = maxSubNum;
	}
	public SEX getSex() {
		return sex;
	}
	public void setSex(SEX sex) {
		this.sex = sex;
	}
}
