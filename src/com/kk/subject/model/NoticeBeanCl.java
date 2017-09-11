package com.kk.subject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class NoticeBeanCl {

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

	public int insertNoticeBean(NoticeBean nb) {
		// TODO Auto-generated method stub
		int nId=-1;
		try {
			this.ct = (new ConnDb()).getConn();
			String sql="insert into t_notice (title, publisher, time, detail) values(?,?,?,?)";
			this.ps = this.ct.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, nb.getTitle());
			ps.setString(2, nb.getPublisher());
			ps.setDate(3, nb.getTime());
			ps.setString(4, nb.getDetail());
			ps.executeUpdate();

			this.rs = this.ps.getGeneratedKeys();
			if(rs.next()){
				nId=rs.getInt(1);
			}

			if(this.rs.next()) {
				nId=this.rs.getInt(1);//获取刚才插入的记录的通告id
			}
			return nId;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSourse();
		}
	}

	//通过id获取NoticeBean
	public NoticeBean getNoticeById(String id){
		String sql="select * from t_notice where id=?";
		NoticeBean nb=null;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()){
				nb = new NoticeBean(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDate(4),rs.getString(5));
			}
			return nb;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	//获取所有题目
	public ArrayList<NoticeBean> getAllNotice() {
		// TODO Auto-generated method stub
		ArrayList<NoticeBean> al=new ArrayList<NoticeBean>();
		NoticeBean nb=null;
		String sql="select * from t_notice";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				nb = new NoticeBean(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getDate(4),rs.getString(5));
				al.add(nb);
			}
			return al;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	public int delMoticeById(String id) {
		// TODO Auto-generated method stub
		String sql="delete from t_notice where id=?";
		int i=-1;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, id);
			i = ps.executeUpdate();
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return i;
		}finally{
			closeSourse();
		}
	}
}
