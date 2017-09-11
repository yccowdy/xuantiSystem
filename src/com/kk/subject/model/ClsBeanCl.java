package com.kk.subject.model;

import java.sql.*;
import java.util.ArrayList;

public class ClsBeanCl {
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

	//返回一个包含所有ClsBean的ArrayList
	public ArrayList<ClsBean> getAllCls(String yuanxi){
		String sql = "select * from t_class where yuanxi='"+yuanxi+"'";
		ArrayList<ClsBean> al = new ArrayList<ClsBean>();
		ClsBean cb = null;

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				cb = new ClsBean(rs.getString(1),rs.getString(2),rs.getInt(3));
				al.add(cb);
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

	
	public ArrayList getAllCls1(){
		String sql = "select id from t_class";
		ArrayList<String> al = new ArrayList<String>();
		String cb = null;

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				cb =  new String(rs.getString(1));
				al.add(cb);
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

	
	/**
	 * 顺带添加学生
	 * @param cls_id
	 * @param major
	 * @param stuNum
	 * @return
	 */
	public int insertCls(String cls_id,String major,String stuNum ,String yuanxi) {
		// TODO Auto-generated method stub
		String sql ="update t_class set majorName='"+major+"',stuNum='"+stuNum+"',yuanxi='"+yuanxi+"'where id='"+cls_id+"'";
		String sql1="update t_student set major='"+major+"' where class='"+cls_id+"'";
		int i=0;
		//System.out.println("sql="+sql);11.3
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
			ps = ct.prepareStatement(sql1);
			i = ps.executeUpdate();
			//顺带添加学生 WXP 暂时不要
			//int n = new StudentBeanCl().batchAddStu(cls_id, stuNum);//14:36
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}
	//只添加
	public int insert(String cls_id,String major,String stuNum ,String yuanxi) {
		// TODO Auto-generated method stub
		String sql ="insert t_class (id,majorName,stuNum,yuanxi) values('"+cls_id+"','"+major+"','"+stuNum+"','"+yuanxi+"')";
		int i=0;
		//System.out.println("sql="+sql);11.3
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
			//顺带添加学生 WXP 暂时不要
			//int n = new StudentBeanCl().batchAddStu(cls_id, stuNum);//14:36
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}

	/**
	 * 顺带删除学生
	 * @param id
	 * @return
	 */
	public int delClsById(String id) {
		// TODO Auto-generated method stub
		String sql = "delete from t_class where id='"+id+"'";
		//System.out.println("删除原有班级信息");
		//WXP新加删除学生表中原有的学生信息
		String sql1 = "delete from t_student where id='"+id+"'";
		int i=0;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			i = ps.executeUpdate();
			System.out.println("删除成功 ");
			ps = ct.prepareStatement(sql1);
			ps.executeUpdate();
			/**
			 * 顺带删除学生
			 * @author kangkang574 2015/12/02
			 */
			//int n = new StudentBeanCl().batchDelByClsId(id);//14:36
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}
	//通过班级号获得专业名称
	public String getMajorById(String cls_id) {
		// TODO Auto-generated method stub
		String sql = "select majorName from t_class where id='"+cls_id+"'";

		System.out.println("sql="+sql);

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) return rs.getString(1);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return null;

	}

	//通过major返回一个包含所有专业是此major的ClsId的数组
	public int[] getClsByMajor(String majorName){
		String sql = "select count(*) from(select id from t_class where majorName='"+majorName+"') as t_clsIds";
		int[] ClsArray=null;
		int i=0;

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next())	ClsArray = new int[rs.getInt(1)];
			sql = "select id from t_class where majorName='"+majorName+"'";
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				ClsArray[i++] = rs.getInt(1);
			}
			return ClsArray;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	//通过major返回一个包含所有专业是此major的ClsId的数组
	public int[] getAllClsArr(){
		String sql = "select count(*) from t_class";
		int[] ClsArray=null;
		int i=0;

		try {
			synchronized (sql) {
				ct = new ConnDb().getConn();
				ps = ct.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next())	ClsArray = new int[rs.getInt(1)];
				sql = "select id from t_class";
				ps = ct.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){
					ClsArray[i++] = rs.getInt(1);
				}
			}
			return ClsArray;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	/**
	 * 
	 * @param cls_id
	 * @return
	 */
	public ClsBean getClsById(String cls_id){
		String sql = "select * from t_class where id='"+cls_id+"'";
		ClsBean cb=null;
		int i=0;

		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				cb = new ClsBean(rs.getString(1),rs.getString(2),rs.getInt(3));
			}
			return cb;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
}
