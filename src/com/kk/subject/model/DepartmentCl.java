package com.kk.subject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DepartmentCl {

	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	//返回一个包含所有Department的ArrayList
	public ArrayList<Department> getAllDep(){
		String sql = "select * from t_department";
		ArrayList<Department> al = new ArrayList<Department>();
		Department d = null;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				d = new Department(rs.getInt(1),rs.getString(2));
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

	public ArrayList<String> getAllDepartments(){
		String sql = "select  department from t_department";
		String deptName;
		ArrayList<String> deptNameArr = new ArrayList<String>();
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				deptName = new String(rs.getString(1));
				deptNameArr.add(deptName);
			}
			return deptNameArr;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	public int addDep(String department) {
		// TODO Auto-generated method stub
		String sql = "insert into t_department (department) values (?)";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, department);
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

	public int delDepById(String id) {
		// TODO Auto-generated method stub
		String sql = "delete from t_department where id=?";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, id);
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
