package com.kk.subject.model;

public class Department {
	private int id;
	private String department;
	
	public Department(){
		
	}
	public Department(int id,String department){
		this.setDepartment(department);
		this.setId(id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}

}
