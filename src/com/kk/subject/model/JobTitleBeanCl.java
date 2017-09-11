package com.kk.subject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class JobTitleBeanCl {
	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	//关闭资源
	public void closeSourse(){
		try {
			if(this.rs!=null){
				this.rs.close();
				this.rs=null;
			}
			if(this.ps!=null){
				this.ps.close();
				this.ps=null;
			}
			if(this.ct!=null){
				this.ct.close();
				this.ct=null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//返回一个包含所有JobTitleBean的Array
	public String[] getAllJT(){
		String sql = "select count(*) from t_JobTitle";
		String[] jtArr = null;
		ClsBean cb = null;

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				jtArr = new String[rs.getInt(1)];
				sql = "select * from t_JobTitle";
				ps = ct.prepareStatement(sql);
				rs = ps.executeQuery();
				for(int i=0;i<jtArr.length && rs.next();i++){
					jtArr[i] = rs.getString(1);
				}
			}
			return jtArr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	public int delJt(String jobTitle) {
		// TODO Auto-generated method stub
		String sql = "delete from t_JobTitle where jobTitle='"+jobTitle+"'";
		int i=-1;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
		
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return i;
		}finally{
			closeSourse();
		}
	}

	public boolean jtExist(String jobTitle) {
		// TODO Auto-generated method stub
		String[] jtArr = this.getAllJT();
		
		for(int i=0;i<jtArr.length;i++){
			if(jobTitle.equals(jtArr[i]))	return true;
		}
		return false;
	}

	public int insertJt(String jobTitle) {
		// TODO Auto-generated method stub
		String sql = "insert into t_JobTitle (jobTitle) values (?)";
		int i=-1;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, jobTitle);
			i = ps.executeUpdate();
		
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return i;
		}finally{
			closeSourse();
		}
	}
}
