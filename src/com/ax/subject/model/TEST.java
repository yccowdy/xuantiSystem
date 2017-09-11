package com.ax.subject.model;
import java.sql.*;

import com.ax.subject.model.ConnDb;
public class TEST {

	/**
	 * @param args
	 */
	private Connection ct=null;
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		TeacherBeanCl tbc=new TeacherBeanCl();
		TeacherBean tb=tbc.getTeacherById("test");

		System.out.println(SEX.FEMALE==tb.getSex());
		System.out.println(tb.getSex()==SEX.MALE?"selected":"21");

	}
	
	public void query(){
		
	}
	
	public void insert(){
		ConnDb cd=new ConnDb();
		Connection ct=cd.getConn();
		String sql="insert into TTeacher (id,psw) values ('test','abc123')";
		String sql1="insert into T_Student (id,psw) values ('19110109','abc123')";
		try {
			Statement sm = ct.createStatement();
			sm.executeUpdate(sql);
			sm.executeUpdate(sql1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
