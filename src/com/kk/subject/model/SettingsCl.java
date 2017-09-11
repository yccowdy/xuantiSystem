package com.kk.subject.model;

import java.sql.*;

//import com.sun.org.apache.regexp.internal.recompile;

public class SettingsCl {
	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	//修改一个题目信息成功返回1，不成功返回-1
	public Settings getSettings(){
		Settings s=null;
		try {
			ct = (new ConnDb()).getConn();
			ps = this.ct.prepareStatement("select * from t_settings");
			rs = this.ps.executeQuery();
			if(rs.next()) s = new Settings(rs.getInt(2),rs.getInt(3),rs.getInt(4));
			return s;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			this.closeSourse();
		}
	}

	//设置warnNum，成功返回1，不成功返回-1
	public int setWarnNum(String warnNum){
		String sql = "update t_settings set warnNum='"+warnNum+"'";
		int i=0;
		try {
			ct = (new ConnDb()).getConn();
			ps = this.ct.prepareStatement(sql);
			i = this.ps.executeUpdate();
			return i;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSourse();
		}
	}

	//设置maxSelNum，成功返回1，不成功返回-1
	public int setMaxSelNum(String maxSelNum){
		String sql = "update t_settings set maxSelNum='"+maxSelNum+"'";
		int i=0;
		try {
			ct = (new ConnDb()).getConn();
			ps = this.ct.prepareStatement(sql);
			i = this.ps.executeUpdate();
			return i;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSourse();
		}
	}

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

	public int setGraduateGrade(String graduateGrade) {
		// TODO Auto-generated method stub
		String sql = "update t_settings set graduateGrade='"+graduateGrade+"'";
		int i=0;
		try {
			ct = (new ConnDb()).getConn();
			ps = this.ct.prepareStatement(sql);
			i = this.ps.executeUpdate();
			return i;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSourse();
		}
	}
}
