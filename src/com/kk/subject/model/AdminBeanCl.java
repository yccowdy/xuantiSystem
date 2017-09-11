package com.kk.subject.model;

import java.sql.*;
import java.util.ArrayList;

import com.ax.subject.model.ConnDb;
import com.common.controller.Md5;

public class AdminBeanCl {

	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	public AdminBean getAdminById(String id){
		String sql="select * from t_admin where id='"+id+"'";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				AdminBean ab = new AdminBean();
				ab.setId(rs.getString(1));
				ab.setPsw(rs.getString(2));
				ab.setName(rs.getString(3));
				ab.setType(rs.getInt(4));
				ab.setSex(rs.getString(5));
				ab.setPhoneNum(rs.getString(6));
				ab.setEmail(rs.getString(7));
				ab.setYuanxi(rs.getString(8));
				return ab;
			}else{
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	public ArrayList<AdminBean> getAll(){
		ArrayList<AdminBean> al = new ArrayList<AdminBean>();
		String sql="select * from t_admin";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				AdminBean ab = new AdminBean();
				ab.setId(rs.getString(1));
				ab.setPsw(rs.getString(2));
				ab.setName(rs.getString(3));
				ab.setType(rs.getInt(4));
				ab.setSex(rs.getString(5));
				ab.setPhoneNum(rs.getString(6));
				ab.setEmail(rs.getString(7));
				ab.setYuanxi(rs.getString(8));
				al.add(ab);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
		return al;
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
		//通过adminBean添加一个老师账号
		public int insertByTb(AdminBean ad){
			int i=0;

			try {
				String sql="insert into t_admin (id,psw,name,type,sex,phoneNum,email,department) values (?,?,?,?,?,?,?,?)";
				this.ct = (new ConnDb()).getConn();
				this.ps = this.ct.prepareStatement(sql);
				ps.setString(1, ad.getId());
				ps.setString(2, ad.getPsw());
				ps.setString(3, ad.getName());
				ps.setInt(4, ad.getType());
				ps.setString(5, ad.getSex());
				ps.setString(6, ad.getPhoneNum());
				ps.setString(7, ad.getEmail());
				ps.setString(8, ad.getYuanxi());
				i = ps.executeUpdate();
				return i;
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				return -1;
			}finally{
				this.closeSourse();
			}
		}
		//修改密码成功返回1，不成功返回-1
		public int updateData(String sql) {
			// TODO Auto-generated method stub
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
		public boolean checkExist(String adminId) {
			// TODO Auto-generated method stub
			if(this.getAdminById(adminId)!=null) return true;
			else return false;
		}
		public boolean checkUser(String id, String psw) {
			// TODO Auto-generated method stub
			boolean b=false;
			Md5 md5=new Md5();
			String sql = "select psw from t_admin where id='"+id+"'";
			try {
				ct = new ConnDb().getConn();
				ps = ct.prepareStatement(sql);
				
				rs = ps.executeQuery(sql);
				if(rs.next()) 
				{
					//用Md5进行加密处理匹配
					String str=rs.getString(1);
					String str1=md5.MD5(str);
					
					String ptr = md5.MD5(psw);
					
					
					
					if(str1.equals(ptr)){
						//一定合法
						b=true;
					}
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				
			}finally{
				closeSourse();
			}
			return b;
		}
}
