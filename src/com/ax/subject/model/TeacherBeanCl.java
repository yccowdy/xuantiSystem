package com.ax.subject.model;

import java.sql.*;

public class TeacherBeanCl {

	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;
	private TeacherBean tb=null;
	
	//通过id获取一个teacher的信息
	public TeacherBean getTeacherById(String id){
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			String sql="select * from T_Teacher where id='"+id+"'";
			this.rs = sm.executeQuery(sql);
			
			if(rs.next()){
				this.tb = new TeacherBean();
				
				tb.setId(rs.getString(1));
				tb.setPsw(rs.getString(2));
				tb.setName(rs.getString(3));
				tb.setSex(SEX.toEnum(rs.getString(4)));
				tb.setPhoneNum(rs.getString(5));
				tb.setEmail(rs.getString(6));
				tb.setJobTitle(rs.getString(7));
				tb.setMaxSubNum(rs.getShort(8));
			}
			
			//tb.setSex(new SEX(rs.getString(3)));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return this.tb;
	}
	
	 public TeacherBean getTeacherBySubId(String sub_id){
			try {
				this.ct = (new ConnDb()).getConn();
				this.sm = this.ct.createStatement();
				String sql="select * from T_Teacher where id in(select  t_id from t_teacher_sub where s_id='"+sub_id+"')";
				this.rs = sm.executeQuery(sql);
				
				if(rs.next()){
					this.tb = new TeacherBean();
					
					tb.setId(rs.getString(1));
					tb.setPsw(rs.getString(2));
					tb.setName(rs.getString(3));
					tb.setSex(SEX.toEnum(rs.getString(4)));
					tb.setPhoneNum(rs.getString(5));
					tb.setEmail(rs.getString(6));
					tb.setJobTitle(rs.getString(7));
					tb.setMaxSubNum(rs.getShort(8));
				}
				
				//tb.setSex(new SEX(rs.getString(3)));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				this.closeSourse();
			}
			return this.tb;
		}
	
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
	
	//验证用户是否存在
	public boolean checkUser(String u,String p)
	{
		boolean b=false;
		try {
			//链接和创建
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			//查询
			rs=sm.executeQuery("select psw from T_Teacher where id='"+u+"'");
			//根据结果  做判断
		      if(rs.next())
		      {
		      //说明用户存在
		      if(rs.getString(1).equals(p)){
		      //一定合法
		      b=true;
		      }
		     }
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return b;
	}
	
	
	//更新数据
	
		public int updateData(String sql){
			int i=0;
			try {
				this.ct = (new ConnDb()).getConn();
				this.sm = this.ct.createStatement();
				i = sm.executeUpdate(sql);

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				this.closeSourse();
			}
			return i;
		}
	
	
	
	
	
	
	
}
