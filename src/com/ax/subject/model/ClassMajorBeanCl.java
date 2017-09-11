package com.ax.subject.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClassMajorBeanCl {

	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;
	private ClassMajorBean cmb=null;

	public ClassMajorBean getClassById(){

		try {
			cmb =new ClassMajorBean();
			this.ct = new ConnDb().getConn();
			sm = ct.createStatement();
			String sql = "select * from t_class ";
			rs = sm.executeQuery(sql);
			if(rs.next()){
				cmb.setId(rs.getString(1));
				cmb.setMajorname(rs.getString(2));
				cmb.setStuNum(rs.getString(3));

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return cmb;
	}

	public int[] getClassId(){
		int AllClassId[] = null;
		int i = 0;
		try {
			this.ct = new ConnDb().getConn();
			sm = ct.createStatement();
			String sql = "select count(*)  from t_class ";
			rs = sm.executeQuery(sql);
			while(rs.next()){
				AllClassId = new int[rs.getInt(1)];
			}
			String sql1 = "select id from t_class";
			rs = sm.executeQuery(sql1);
			while(rs.next()){
				AllClassId[i++] = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return AllClassId;
	}
	public ArrayList<ClassMajorBean> getAllClassMajorBean(){
		ArrayList<ClassMajorBean> AllMajor = new ArrayList<ClassMajorBean>();
		ClassMajorBean cmb=null;
		int i = 0;
		try {
			this.ct = new ConnDb().getConn();
			sm = ct.createStatement();
			/*String sql = "select count(*)  from t_class ";
			rs = sm.executeQuery(sql);
			while(rs.next()){
				AllMajor = new int[rs.getInt(1)];
			}*/
			String sql1 = "select * from t_class";
			rs = sm.executeQuery(sql1);
			while(rs.next()){
				cmb = new ClassMajorBean();
				cmb.setId(rs.getString(1));
				cmb.setMajorname(rs.getString(2));
				cmb.setStuNum(rs.getInt(3)+"");
				AllMajor.add(cmb);
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return AllMajor;
	}

	public String getMajorNameById(String id){
		String majorName = "";
		try {
			ct = new ConnDb().getConn();
			sm = ct.createStatement();
					
			String sql = "select majorName form t_class  where id = '"+id+"'";
			rs = sm.executeQuery(sql);
			while(rs.next()){
				majorName = rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return majorName;
	}

	public void closeSourse(){
		try {
			if(this.rs!=null){
				this.rs.close();
				this.rs=null;
			}
			if(this.sm!=null){
				this.sm.close();
				this.sm=null;
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
}
