package com.ax.subject.model;
import java.sql.Date;
public class SubjectBean {

	private int id;
	private String title;
	private String teacher;		//出题老师的名字
	private String direction;	//题目
	private String introduction;//题目简介
	private String schedule;	//进程安排
	private String reference;	//参考文献
	private String requirement;	//学生要求
	private String domain;		//所属领域
	private Date time;		//出题时间，添加时直接获取系统时间即可
	private int state;			//审核状态
	private int selectedNum;	//已经选题人数
	
	//不带参数的构造方法
	public SubjectBean(){
		
	}
	//带全部参数的构造方法
	public SubjectBean(int id,String title,String teacher,String direction,String introduction,String schedule,
			String reference,String requirement,String domain,Date time,int state,int selectedNum){
		this.setId(id);
		this.setTitle(title);
		this.setTeacher(teacher);
		this.setDirection(direction);
		this.setIntroduction(introduction);
		this.setSchedule(schedule);
		this.setReference(reference);
		this.setRequirement(requirement);
		this.setDomain(domain);
		this.setTime(time);
		this.setState(state);
		this.setSelectedNum(selectedNum);
	}
	//不带id的构造方法
	public SubjectBean(String title,String teacher,String direction,String introduction,String schedule,
			String reference,String requirement,String domain,Date time,int state,int selectedNum){
		this.setTitle(title);
		this.setTeacher(teacher);
		this.setDirection(direction);
		this.setIntroduction(introduction);
		this.setSchedule(schedule);
		this.setReference(reference);
		this.setRequirement(requirement);
		this.setDomain(domain);
		this.setTime(time);
		this.setState(state);
		this.setSelectedNum(selectedNum);
	}
	//不带id和time的构造方法
	public SubjectBean(String title,String teacher,String direction,String introduction,String schedule,
			String reference,String requirement,String domain,int state,int selectedNum){
		this.setId(id);
		this.setTitle(title);
		this.setTeacher(teacher);
		this.setDirection(direction);
		this.setIntroduction(introduction);
		this.setSchedule(schedule);
		this.setReference(reference);
		this.setRequirement(requirement);
		this.setDomain(domain);
		this.setTime(time);
		this.setState(state);
		this.setSelectedNum(selectedNum);
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
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	public String getRequirement() {
		return requirement;
	}
	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getSelectedNum() {
		return selectedNum;
	}
	public void setSelectedNum(int selectedNum) {
		this.selectedNum = selectedNum;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}
