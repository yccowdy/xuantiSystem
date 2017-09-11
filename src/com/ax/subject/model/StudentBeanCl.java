package com.ax.subject.model;

import java.sql.*;

import com.ax.subject.model.ConnDb;
import com.common.controller.Md5;
import com.kk.subject.model.SubjectBeanCl;
import com.kk.subject.model.TeacherSubBeanCl;

public class StudentBeanCl {

	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;
	private StudentBean tb=null;
	
	//通过id获取一个student的信息
	public StudentBean getStudentById(String id){
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			String sql="select * from T_Student where id='"+id+"'";
			this.rs = sm.executeQuery(sql);
			
			if(rs.next()){
				this.tb = new StudentBean();
												
				tb.setId(rs.getInt(1));
				tb.setPsw(rs.getString(2));
				tb.setName(rs.getString(3));
				tb.setSex(SEX.toEnum(rs.getString(4)));
				tb.setCls(rs.getString(5));
				tb.setMajor(rs.getString(6));
				tb.setPhoneNum(rs.getString(7));
				tb.setEmail(rs.getString(8));
				//tb.setDirection(rs.getString(9));
				tb.setPrivilege(rs.getShort(9));
				tb.setSelectNum(rs.getShort(10));
				tb.setYuanxi(rs.getString(11));
				
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
	public StudentBean getStudentById(int id){
		return getStudentById(id+"");
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

	public boolean checkGraduate(String id ,String gradu){
		boolean b = false ;
		try {
			int id1=Integer.parseInt(id.substring(3,5));
			int gradu1 = Integer.parseInt(gradu.substring(2));
			if(id1==gradu1){
				b = true;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			return false;
		}
		return b;
	}
	public boolean checkUser(String id, String p)
	{
		boolean b=false;
		Md5 md5=new Md5();
		try {
			//链接和创建
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			//查询
			rs=sm.executeQuery("select psw from T_Student where id='"+id+"'");
			//根据结果  做判断
		      if(rs.next())
		      {
		      //说明用户存在
		    	//用Md5进行加密处理匹配
		    	  String str=rs.getString(1);
					String str1=md5.MD5(str);
					
					String ptr = md5.MD5(p);
				
					if(str1.equals(ptr)){
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
	
	public boolean checkEmail(String id, String p)
	{
		boolean b=false;
		try {
			//链接和创建
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			//查询
			rs=sm.executeQuery("select email from T_Student where id='"+id+"'");
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
	
	/**
	 * 判断信息是否完善
	 */
	public boolean Fill_Info(String id){
		boolean a = false ;
		tb=getStudentById(id);
		if(tb.getName()!=null&&!tb.getName().equals("")&&tb.getEmail()!=null&&!tb.getEmail().equals("")&&tb.getPhoneNum()!=null&&!tb.getPhoneNum().equals("")){
		a = true ; 
		}
		return a ;
	}
	/**
	 * 检测是否有相同的电话号码
	 */
	public String phoneNumberExitCheck(String id ,String phoneNum){
		String result = "false" ; 
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_student where phoneNum = '"+phoneNum+"' and id<>'"+id+"' ";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			if(rs.next()){
               	result = "true" ;			
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			
			this.closeSourse();
		}
		return result;
	}
	/**
	 * 检测是否有相同的邮箱
	 * @param id=账号
	 * @param email=邮件
	 * @return 
	 */
	public String emaliExitCheck(String id, String email) {
		// TODO Auto-generated method stub
		String result = "false" ;
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_student where email = '"+email+"' and id<>'"+id+"'";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			if(rs.next()){
				result = "true" ;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return result;
	}
			
}
