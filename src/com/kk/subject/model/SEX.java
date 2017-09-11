package com.kk.subject.model;

public enum SEX {

	MALE("男"),FEMALE("女");
	public String stringValue;
	private SEX(String stringValue){
		this.stringValue=stringValue;
	}
	
	//从String类型返回SEX类型
	public static SEX toEnum(String sex){
		if(sex.equals("男"))
			return SEX.MALE ;
		else 
			return SEX.FEMALE;
	}
	
	//从SEX类型返回String类型
	public static String toStringValue(SEX sex){
		return sex.stringValue;
	}
}
