package com.kk.subject.model;

public class Settings {//设置参数类

	private int warnNum;
	private int maxSelNum;
	private int graduateGrade;
	public Settings(int warnNum, int maxSelNum,int graduateGrade) {
		// TODO Auto-generated constructor stub
		this.setMaxSelNum(maxSelNum);
		this.setWarnNum(warnNum);
		this.setGraduateGrade(graduateGrade);
	}
	public Settings(){
		
	}
	public int getWarnNum() {
		return warnNum;
	}
	public void setWarnNum(int warnNum) {
		this.warnNum = warnNum;
	}
	public int getMaxSelNum() {
		return maxSelNum;
	}
	public void setMaxSelNum(int maxSelNum) {
		this.maxSelNum = maxSelNum;
	}
	public int getGraduateGrade() {
		return graduateGrade;
	}
	public void setGraduateGrade(int graduateGrade) {
		this.graduateGrade = graduateGrade;
	}
	
}
