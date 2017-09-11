package com.kk.subject.model;

public class TeacherSubBean {

	private String t_id;//老师ID
	private int s_id;//题目编号
	
	
	public TeacherSubBean(String t_id,int s_id){
		this.setS_id(s_id);
		this.setT_id(t_id);
	}
	
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
}
