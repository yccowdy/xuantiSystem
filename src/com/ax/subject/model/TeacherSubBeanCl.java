package com.ax.subject.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TeacherSubBeanCl {
	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;

	public void insertSubject(String t_id,int s_id){

		int i=0;
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			String sql="insert into t_teacher_sub (t_id, s_id) values ('"+t_id+"','"+s_id+"')";
			
			System.out.println("sql="+sql);
			i=this.sm.executeUpdate(sql);
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	//通过老师id获取“我的题目”的所有s_id
	public int[] getS_id(String t_id){
		int i=0;
		int[] s_id=null;
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			
			String sql="select count(*) from (select s_id from t_teacher_sub where t_id='"+t_id+"') as temp";
			this.rs=this.sm.executeQuery(sql);
			
			if(rs.next()) i=rs.getInt(1);
			
			sql="select s_id from t_teacher_sub where t_id='"+t_id+"'";
			this.rs = this.sm.executeQuery(sql);
			
			System.out.println("sql="+sql);
			this.rs = this.sm.executeQuery(sql);
			
			s_id = new int[i];
			i=0;
			while(rs.next()){
				s_id[i++] = rs.getInt(1);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
			return s_id;
		}
	}

	
	//
	
	//关闭资源
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
