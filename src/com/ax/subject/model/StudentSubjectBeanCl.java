package com.ax.subject.model;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
public class StudentSubjectBeanCl {


	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;
	private TeacherBean tb=null;
//
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
			closeSource();
		}
		return i;
	}
	
	/*//志愿数一、二、三
	public void selVolunteer()
	{
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			rs=sm.executeQuery("select sub_Id from t_stu_sub ");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
	}*/
	
	//志愿数一、二、三
	public int getWish(int sub_id ,int stu_id)
	{
		
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			rs=sm.executeQuery("select wish from t_stu_sub where sub_id='"+sub_id+"' and stu_id ='"+stu_id+"'");
			if(rs.next()) return rs.getInt(1);
			else return 0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSource();
		}
	}
	
	public int getSubIdByWish(String wish, String stu_id)
	{
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			rs=sm.executeQuery("select sub_id from t_stu_sub where wish = '"+wish+"' and stu_id = '"+stu_id+"'");
			if(rs.next()) return rs.getInt(1);
			else return 0;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSource();
		}
	}
	
	
	//通过学生id获取已选题目
	public ArrayList<StudentSubjectBean> getSubAlByStuId(int stuId){
		ArrayList<StudentSubjectBean> ssbAl = new ArrayList<StudentSubjectBean>();
		StudentSubjectBean ssb = null;
		String sql = "select * from t_stu_sub where stu_Id='"+stuId+"'";
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				ssb = new StudentSubjectBean();
				ssb.setStu_id(stuId);
				ssb.setSub_id(rs.getInt(2));
				ssb.setWish(rs.getInt(3));
				ssb.setState(rs.getInt(4));
				ssbAl.add(ssb);
			}
			return ssbAl;
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	//通过学生ID查找已选备选题的数目
	
	public int getSelectedAlternativeByStuId(int stuId){
		
		int i=0;
		String sql = "select count(*) from t_stu_sub where stu_Id='"+stuId+"'and wish='"+4+"'";
		try {
			this.ct = (new ConnDb()).getConn();
			this.sm = this.ct.createStatement();
			rs = sm.executeQuery(sql);
			if(rs.next()) i = rs.getInt(1);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return i;
	}
	
	
	//关闭资源
		public void closeSource(){
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
/**
 * 通过学生ID 和题目ID 来判断是否存在该题
 * @param subId
 * @param stuId
 * @return
 */
		public boolean existSubIdStuId(String subId, String stuId) {
			// TODO Auto-generated method stub
			String sql = "select * from t_stu_sub where stu_id = '"+stuId+"' and sub_id = '"+subId+"'";
			boolean a = false ;
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				rs = sm.executeQuery(sql);
				if(rs.next())
				{
					a = true;
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return a;
		}
/**
 * 通过题目 和学生id得到志愿数
 * @param subId
 * @param stuId
 * @return
 */
		public String getWishBySubIdStuId(String subId, String stuId) {
			// TODO Auto-generated method stub
			int wish = -1 ;
			String sql = "select wish from t_stu_sub where sub_id = '"+subId+"' and stu_id = '"+stuId+"'";
			
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				rs = sm.executeQuery(sql);
				if(rs.next()){
					wish = rs.getInt(1);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return wish+"";
		}
		
		
/**
 * 删除志愿数相同的这一条记录
 * @param stuId
 * @param wish
 */
		public int deleteByStuIdWish(String stuId, String wish) {
			// TODO Auto-generated method stub
			String sql = "delete from t_stu_sub where stu_id = '"+stuId+"' and wish = '"+wish+"'";
			int i=0;
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				i = sm.executeUpdate(sql);
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return i;
		}
/**
 * 更新志愿数 
 * @param subId
 * @param stuId
 * @param wish
 */
		public int updateWish(String subId, String stuId, String wish) {
			// TODO Auto-generated method stub
			String sql = "update t_stu_sub set wish = '"+wish+"' where stu_id = '"+stuId+"' and sub_id = '"+subId+"'";
			int i=0;
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				i = sm.executeUpdate(sql);


			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{

				closeSource();
			}
			return i;
		}

		public boolean getExistWish(String wish, String stuId) {
			// TODO Auto-generated method stub
			String sql = "select * from t_stu_sub where wish = '"+wish+"' and stu_id = '"+stuId+"'";
			boolean a = false ;
			try {
				
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				rs = sm.executeQuery(sql);
				if(rs.next())
				{
					a = true ;
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return a;
			
		}
			
		public int insertByStuIdWish1(String subId, String stuId, String wish) {
			// TODO Auto-generated method stub
			int w=Integer.parseInt(wish);
			String sql = "update stuselecttitle set title1='"+subId+"' where Stuid='"+stuId+"'";
			 if(w==2){
				 sql = "update stuselecttitle set title2='"+subId+"' where Stuid='"+stuId+"'";
			}else if(w==3){
				sql = "update stuselecttitle set title3='"+subId+"' where Stuid='"+stuId+"'";
			}else if(w==4){
				 sql ="update stuselecttitle set title4='"+subId+"' where Stuid='"+stuId+"'";
			}else if(w==5){
				sql = "update stuselecttitle set title5='"+subId+"' where Stuid='"+stuId+"'";
			}else if(w==6){
				sql = "update stuselecttitle set title6='"+subId+"' where Stuid='"+stuId+"'";
			}
			int i=0;
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				i = sm.executeUpdate(sql);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return i;
			
		}
		

		public int insertByStuIdWish(String subId, String stuId, String wish) {
			// TODO Auto-generated method stub
			String sql = "insert into t_stu_sub (sub_Id,stu_Id,wish) values ('"+subId+"','"+stuId+"','"+wish+"')";
			int i=0;
			try {
				ct = new ConnDb().getConn();
				sm = ct.createStatement();
				i = sm.executeUpdate(sql);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				closeSource();
			}
			return i;
			
		}
		

		

		
}
