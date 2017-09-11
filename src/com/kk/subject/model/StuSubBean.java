package com.kk.subject.model;

public class StuSubBean {
	private int stuId;
	private int subId;
	private int wish;
	private int state;
	
	public StuSubBean(){
	}
	public StuSubBean(int stuId,int subId,int wish,int state){
		setStuId(stuId);
		setSubId(subId);
		setWish(wish);
		setState(state);
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
}
