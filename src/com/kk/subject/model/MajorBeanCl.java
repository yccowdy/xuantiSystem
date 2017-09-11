package com.kk.subject.model;

import java.util.ArrayList;
import java.sql.*;

public class MajorBeanCl {

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
	
	//返回一个包含所有MajorBean的ArrayList
	public ArrayList getAllMajor(String yuanxi){
		String sql = "select * from t_major where academy='"+yuanxi+"'";
		ArrayList<MajorBean> al = new ArrayList<MajorBean>();
		MajorBean mb = null;
		
		
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				mb = new MajorBean(rs.getInt(1),rs.getString(2));
				al.add(mb);
			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	
	public ArrayList getAllMajor1(){
		String sql = "select major from t_major";
		ArrayList<String> al = new ArrayList<String>();
		String mb = null;
		
		
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				mb = new String(rs.getString(1));;
				al.add(mb);
			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	public int insertMajor(String major,String yuanxi) {
		// TODO Auto-generated method stub
		String sql = "insert into t_major (major,academy) values ('"+major+"','"+yuanxi+"')";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}

	public int delMajorById(String id) {
		// TODO Auto-generated method stub
		String sql = "delete from t_major where id='"+id+"'";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}
}
