package com.kk.subject.model;

public class SubStuTeaBean {

	private int sub_id;
	private int stu_id;
	private String tea_id;
	
	//不带参数的构造方法
	public SubStuTeaBean(){
		
	}
	//带参数的构造方法
	public SubStuTeaBean(int sub_id,int stu_id,String tea_id){
		setStu_id(stu_id);
		setSub_id(sub_id);
		setTea_id(tea_id);
	}
	public int getSub_id() {
		return sub_id;
	}
	public void setSub_id(int sub_id) {
		this.sub_id = sub_id;
	}
	public int getStu_id() {
		return stu_id;
	}
	public void setStu_id(int stu_id) {
		this.stu_id = stu_id;
	}
	public String getTea_id() {
		return tea_id;
	}
	public void setTea_id(String tea_id) {
		this.tea_id = tea_id;
	}
}
