package com.kk.subject.model;

public class ClsBean {

	private String id;	//班级号
	private String majorName;	//专业名称
	private int stuNum;	//学生人数

	public ClsBean(){
	}

	public ClsBean(String id, String majorName, int stuNum){
		this.setId(id);
		this.setMajorName(majorName);
		this.setStuNum(stuNum);
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMajorName() {
		return majorName;
	}
	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	public int getStuNum() {
		return stuNum;
	}
	public void setStuNum(int stuNum) {
		this.stuNum = stuNum;
	}
}
