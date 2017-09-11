package com.kk.subject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.jsp.tagext.TryCatchFinally;

public class StuSubBeanCl {
	private Connection ct;
	private PreparedStatement ps;
	private ResultSet rs;

	public ArrayList<StuSubBean> getAllSSB(){
		ArrayList<StuSubBean> AllSSB = new ArrayList<StuSubBean>();
		StuSubBean ssb=null;
		String sql = "select * from t_stu_sub";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()){
				ssb = new StuSubBean(rs.getInt(1), rs.getInt(2), rs.getInt(3),rs.getInt(4));
				AllSSB.add(ssb);
			}
			return AllSSB;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	/**
	 * 管理员给学生指派题目
	 * @param stuId学生账号
	 * @param subId题目编号
	 * @return 1成功 , 0失败，-1出错
	 */
	public int assignByStuIdSubId(String stuId,String subId){
		int i=0;
		String sql="insert into t_stu_sub (stu_Id,sub_Id,wish,state) values (?,?,?,?)";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			ps.setInt(3, 5);
			ps.setInt(4, 1);
			i = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			i=-1;
		}finally{
			closeSourse();
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


	/**
	 * 根据stuId和subId删除管理员的这个指派
	 * @param stuId 学生账号
	 * @param subId	题目编号
	 * @return	返回操作影响数据库记录条数，-1非正常退出
	 */
	public int repealAssign(String stuId, String subId) {
		// TODO Auto-generated method stub
		int i=0;
		String sql="delete from t_stu_sub where stu_id=? and sub_id=?";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			i = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
		return i;
	}
	

}
