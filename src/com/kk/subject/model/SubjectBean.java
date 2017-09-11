package com.kk.subject.model;
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
	private Date time;			//出题时间，添加时直接获取系统时间即可
	private int state;			//审核状态
	private int selectedNum;	//已经选题人数
	private String key; //wxp 11.5号加入关键字
	private String yuanxi;
	
	//不带参数的构造方法
	public SubjectBean(){
		
	}
	//带全部参数的构造方法 11.5增加了关键字的
	public SubjectBean(int id,String title,String teacher,String direction,String introduction,String schedule,
			String reference,String requirement,String domain,Date time,int state,int selectedNum,String key,String yuanxi){
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
		this.setkey(key);
		this.setYuanxi(yuanxi);
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
			String reference,String requirement,String domain,int state,int selectedNum,String key,String yuanxi){
		this.setId(id);
		this.setTitle(title);
		this.setTeacher(teacher);
		this.setDirection(direction);	
		this.setkey(key);
		introduction = introduction.equals("此处填写题目简介")?"":introduction;
		schedule = schedule.equals("此处填写进程安排")?"":schedule;
		reference = reference.equals("此处填写参考文献")?"":reference;
		requirement = requirement.equals("此处填写学生要求")?"":requirement;
		domain = domain.equals("此处填写题目所属领域")?"":domain;
		//key = key.equals("此处填写关键词")?"":key;//11.4
		this.setIntroduction(introduction);
		this.setSchedule(schedule);
		this.setReference(reference);
		this.setRequirement(requirement);
		this.setDomain(domain);
		this.setTime(time);
		this.setState(state);
		this.setSelectedNum(selectedNum);
		this.setYuanxi(yuanxi);
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
	//wxp 11.5关键字
	public String getkey() {
		return key;
	}
	public void setkey(String key) {
		this.key = key;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getYuanxi() {
		return yuanxi;
	}
	public void setYuanxi(String yuanxi) {
		this.yuanxi = yuanxi;
	}
	
}
