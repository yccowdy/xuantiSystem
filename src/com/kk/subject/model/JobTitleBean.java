package com.kk.subject.model;

public class JobTitleBean {

	private String jobTitle;

	public JobTitleBean(){

	}
	public JobTitleBean(String jobTitle){
		this.setJobTitle(jobTitle);
	}


	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
}
