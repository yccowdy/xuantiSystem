package com.kk.subject.model;

import java.sql.*;

public class ConnDb {

private Connection ct=null;
	
	//得到连接
	public Connection getConn(){
		try {
			//1.加载驱动
		    Class.forName("com.mysql.jdbc.Driver");
		    //2.得到连接
		     this.ct=DriverManager.getConnection("jdbc:mysql://localhost:3306/xk","root","1234");
		    //this.ct=DriverManager.getConnection("jdbc:mysql://61.152.93.43:3306/lixiang88","lixiang88","abc123abc123");
		    if(this.ct.isClosed()){
		    	System.out.println("连接不成功！");
		    }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return this.ct;
	}
	
}
