package com.kk.subject.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;



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

			i=this.sm.executeUpdate(sql);

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
	}

	//通过老师id获取“我的题目”的所有s_id  WXP按年份获取肯定在这里改
	public int[] getS_id(String t_id){
		int i=-1;
		int[] s_id=null;//用于存当年的课题
		int[] sa_id=null;//用来存全部的课题
		int i1=0;//用于当数组下标
		int count=0;
		Calendar date = Calendar.getInstance();
		Calendar now=Calendar.getInstance(); 
		Date d=null;
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();

			String sql="select count(*) from t_teacher_sub where t_id='"+t_id+"'";
			this.rs=this.sm.executeQuery(sql);
			if(rs.next()) i=rs.getInt(1);//获取老师所有课题的数目
			if(i==0) {
				return null;
			}
			sql="select s_id from t_teacher_sub where t_id='"+t_id+"'";
			this.rs = this.sm.executeQuery(sql);
			
			sa_id=new int[i];
			//s_id = new int[i];
			i=0;
			while(rs.next()){
				//System.out.println(i);
				sa_id[i++] = rs.getInt(1);//获取所有课题的ID
			}
			//11.2 获取定义的数组长度,防止数组出现空指针异常 
			for(int n=0;n<i;n++)
			{
				//System.out.println(n);
				//int m=s_id[n];//11.1
				sql="select time from t_subject where id='"+sa_id[n]+"'";//11.1查询对应课题ID的信息
				//System.out.println(n);
				this.rs = this.sm.executeQuery(sql);
				if(rs.next()) d=rs.getDate(1);
				if(d!=null) date.setTime(d);
				String y=date.get(Calendar.YEAR)+"";//获取对应ID的出题年份
				//System.out.println(y);//看是否获取到对应ID的出题年份并把打印出来.
				String year=now.get(Calendar.YEAR)+"";//获取系统的年份
				//System.out.println(year);
				//System.out.println(y.equals(year));
				if(y.equals(year))
				{//比较年份是否相等 赋值
					count++;
					//System.out.println(s_id[i1]);
					//System.out.println("OK1");
				}
			}
			s_id = new int[count];
			//11.2加入的
			for(int m=0;m<i;m++)
			{
				//System.out.println(m);
				//int m=s_id[n];//11.1
				sql="select time from t_subject where id='"+sa_id[m]+"'";//11.1查询对应课题ID的信息
				//System.out.println(n);
				this.rs = this.sm.executeQuery(sql);
				if(rs.next()) d=rs.getDate(1);
				if(d!=null) date.setTime(d);
				String y1=date.get(Calendar.YEAR)+"";//获取对应ID的出题年份
				//System.out.println(y1);//看是否获取到对应ID的出题年份并把打印出来.
				String year1=now.get(Calendar.YEAR)+"";//获取系统的年份
				//System.out.println(year1);
				//System.out.println(y.equals(year));
				if(y1.equals(year1))
				{//比较年份是否相等 赋值
					s_id[i1++]=sa_id[m];
					//System.out.println(s_id[i1]);
					//System.out.println("OK2");
				}
			}
			return s_id;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
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

	
	
	
	
	
	//更改出题人名字
	public int updateTeacherName(String teaId, String newName) {
		// TODO Auto-generated method stub
		int i=0;
		int[] subIds = this.getS_id(teaId);
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			for(int j=0;subIds!=null&&j<subIds.length;j++){
				String sql = "update t_subject set teacher='"+newName+"' where id='"+subIds[j]+"'";
				i+=this.sm.executeUpdate(sql);
			}

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return i;
	}

	/* 判断题目是否存在：
	 * false:不存在
	 * self:自己已经出了这道题
	 * true：其他老师已经出了这道题
	 */
	public String titleExistCheck(String teaId, String title) {
		// TODO Auto-generated method stub
		String result="false";
		int[] subIds = new SubjectBeanCl().getSubIdsByTitle(title);
		if(subIds != null){
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			for(int i=0;i<subIds.length;i++){
				String tId = tsbc.getTeaId(subIds[i]);
				if(teaId.equals(tId)) {
					result="self";
					return result;
				}
			}
			result = "true";
		}
		return result;
	}


	//获取对应题目编号的老师账号
	public String getTeaId(int subId) {
		// TODO Auto-generated method stub
		String teaId=null;
		try {
			ct = new ConnDb().getConn();
			sm = ct.createStatement();
			rs = sm.executeQuery("select t_id from t_teacher_sub where s_id='"+subId+"'");
			if(rs.next())	teaId = rs.getString(1);
			return teaId;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();			
		}
	}

}
