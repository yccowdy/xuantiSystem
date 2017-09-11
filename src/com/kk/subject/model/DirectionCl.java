package com.kk.subject.model;

import java.sql.*;
import java.util.*;

public class DirectionCl {

	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//返回一个包含所有Direction的ArrayList
	public ArrayList getAllDirec(){
		String sql = "select * from t_direction";
		ArrayList<Direction> al = new ArrayList<Direction>();
		Direction d = null;
		
		
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				d = new Direction(rs.getInt(1),rs.getString(2));
				al.add(d);
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

	//通过id删除一个direction
	public int delById(int id) {
		// TODO Auto-generated method stub
		String sql = "delete from t_direction where id='"+id+"'";
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

	//增加一个direction
	public int insertDirec(String direction) {
		// TODO Auto-generated method stub
		String sql = "insert into t_direction (direction) values (?)";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, direction);
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
