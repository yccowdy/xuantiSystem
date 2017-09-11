package com.ax.subject.model;

public class StudentBean {

	private int id;	//初始登陆账号为班序号（19110109）
	private String psw;	//初始密码为班序号（19110109）
	private String name;//姓名
	private SEX sex;	//性别
	private String cls; //班级
	private String major;  //专业
	private String phoneNum;//电话号码
	private String email;	//电子邮箱
//	private String direction; //选题方向
	private int privilege; //选题权限（有权限才能选题）
	private int selectNum; //已选题数
	private String yuanxi;
	
	
	//构造方法
	public StudentBean(){
	}
	//不带院系的构造方法
	public StudentBean(int id,String psw,String name,SEX sex,String cls,String major,String phoneNum,String email,int privilege,int selectNum){
		this.setId(id);
		this.setPsw(psw);
		this.setName(name);
		this.setSex(sex);
		this.setCls(cls);
		this.setMajor(major);
		this.setPhoneNum(phoneNum);
		this.setEmail(email);
		//this.setDirection(direction);
		this.setPrivilege(privilege);
		this.setSelectNum(selectNum);
		
	}
	//带参数的构造方法
		public StudentBean(int id,String psw,String name,SEX sex,String cls,String major,String phoneNum,String email,int privilege,int selectNum,String yuanxi){
			this.setId(id);
			this.setPsw(psw);
			this.setName(name);
			this.setSex(sex);
			this.setCls(cls);
			this.setMajor(major);
			this.setPhoneNum(phoneNum);
			this.setEmail(email);
			//this.setDirection(direction);
			this.setPrivilege(privilege);
			this.setSelectNum(selectNum);
			this.setYuanxi(yuanxi);
			
		}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
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
	public SEX getSex() {
		return sex;
	}
	public void setSex(SEX sex) {
		this.sex = sex;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
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
	
	public int getPrivilege() {
		return privilege;
	}
	public void setPrivilege(int privilege) {
		this.privilege = privilege;
	}
	public int getSelectNum() {
		return selectNum;
	}
	public void setSelectNum(int selectNum) {
		this.selectNum = selectNum;
	}
	public String getYuanxi() {
		return yuanxi;
	}
	public void setYuanxi(String yuanxi) {
		this.yuanxi = yuanxi;
	}
}
