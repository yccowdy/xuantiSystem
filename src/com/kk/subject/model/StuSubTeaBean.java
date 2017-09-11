package com.kk.subject.model;

public class StuSubTeaBean {
	private int stuId;
	private int subId;
	private int wish;
	private String stuName;
	private String teaName;
	private String subTitle;
	private int state;
	

	
	public StuSubTeaBean(){
	}
	//带参数的构造方法
	public StuSubTeaBean(int stuId,int subId,int wish,String stuName,String teaName,String subTitle,int state){
		setStuId(stuId);
		setSubId(subId);
		setWish(wish);
		setStuName(stuName);
		setTeaName(teaName);
		setState(state);
		setSubTitle(subTitle);
	}
	
	public int getStuId() {
		return stuId;
	}
	public void setStuId(int stuId) {
		this.stuId = stuId;
	}
	public int getSubId() {
		return subId;
	}
	public void setSubId(int subId) {
		this.subId = subId;
	}
	public int getWish() {
		return wish;
	}
	public void setWish(int wish) {
		this.wish = wish;
	}
	public String getTeaName() {
		return teaName;
	}
	public void setTeaName(String teaName) {
		this.teaName = teaName;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
}
