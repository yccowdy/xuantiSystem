package com.ax.subject.model;

import java.sql.*;
import java.text.Collator;
import java.util.*;

public class SubjectBeanCl {
	private Connection ct=null;


	private Statement sm=null;


	private PreparedStatement ps=null;
	private ResultSet rs=null;


	//插入一条题目,成功返回插入的题目的id，不成功返回-1
	
	public int insertSubject(SubjectBean subBean){

		int s_id=-1;
		try {
			this.ct = (new ConnDb()).getConn();
			String sql="insert into t_subject (title, teacher, direction, introduction, schedule, reference," +
					" requirement, domain, time, state, selectedNum) values(?,?,?,?,?,?,?,?,'"
					+(new java.sql.Date(System.currentTimeMillis()))+"',?,?)";
			this.ps = this.ct.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, subBean.getTitle());
			ps.setString(2, subBean.getTeacher());
			ps.setString(3, subBean.getDirection());
			ps.setString(4, subBean.getIntroduction());
			ps.setString(5, subBean.getSchedule());
			ps.setString(6, subBean.getReference());
			ps.setString(7, subBean.getRequirement());
			ps.setString(8, subBean.getDomain());
			ps.setInt(9, subBean.getState());
			ps.setInt(10, subBean.getSelectedNum());
			ps.executeUpdate();

			System.out.println("sql="+sql);

			this.rs = this.ps.getGeneratedKeys();
			if(rs.next()){
				s_id=rs.getInt(1);
			}

			if(this.rs.next()) {
				s_id=this.rs.getInt(1);//获取刚才插入的记录的题目id
			}
			return s_id;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSource();
		}
	}

	//通过题目编号（id）返回一个SubjectBean
	public SubjectBean getSubjectById(int id){
		SubjectBean sb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select * from t_subject where id='"+id+"'";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
			}
			return sb;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSource();
		}
	}
	public SubjectBean getSubjectById(String id){

		return getSubjectById(Integer.parseInt(id));
	}
	//返回所有题目
	public ArrayList<SubjectBean> getAllSub(int id,String yuanxi){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select * from t_subject as a where a.state = '1'and yuanxi='"+yuanxi+"' and a.id not in (select sub_id from t_stu_sub as b where stu_id='"+id+"') order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSource();

		}
	}
	
	
	/**
	 * 找到备选题库集合
	 * @return
	 */
	public ArrayList<SubjectBean> getAlternativeSub(int id){
		 
		ArrayList<SubjectBean> al = new ArrayList<SubjectBean>();
		
		
//		ArrayList<StudentSubjectBean> ssbAl = new ArrayList<StudentSubjectBean>();
//	    SubjectBean subBean;
// 		for(int i=0;i<ssbAl.size();i++){
//			
//			subBean = new SubjectBeanCl().getSubjectById(ssbAl.get(i).getSub_id());
//		
//		}
		SubjectBean sb = null ;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject as a where a.state = '1' and a.id not in (select sub_id from t_stu_sub as b where stu_id='"+id+"') order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);



			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSource();

		}
			
		
		
	}
//杨春超编写 11.3
	/**
	 * //通过老师找到对应他出的题目
	 */
	public ArrayList<SubjectBean> getAllSubFromTeacher(String teacherName){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' and state=1";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
				
	}
	
	/**
	 * 通过方向找出对应的所有题目
	 */
	public ArrayList<SubjectBean> getAllSubFromDirection(String direction) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where direction like '%"+direction+"%' and state=1";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
		
	}
	//通过题目关键字找出对应的所有题目
	public ArrayList<SubjectBean> getAllSubFromTitle(String title) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where title like '%"+title+"%'and state=1 ";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
		}
	
	public ArrayList<SubjectBean> getAllSubFromTeaandDir(String teacherName, String direction) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' and direction like '%"+direction+"%'  and state=1";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
	}
	public ArrayList<SubjectBean> getAllSubFromTeaandTit(String teacherName, String title) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' and title like '%"+title+"%'  ";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
	}
	public ArrayList<SubjectBean> getAllSubFromDirandTit(String direction, String title) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where direction like '%"+direction+"%' and title like '%"+title+"%' and state=1 ";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
	}
	public ArrayList<SubjectBean> getAllSubFromTeaandDirandTit(String teacherName,String direction, String title) {
		// TODO Auto-generated method stub
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		
		try {
			ct = new ConnDb().getConn();
			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' and direction like '%"+direction+"%' and title like '%"+title+"%'  and state=1";
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				al.add(sb);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSource();
		}
		return al;		
	}
	
	
	
//	师兄之前用的代码/**
//	 * //通过老师找到对应他出的题目
//	 */
//	public ArrayList<SubjectBean> getAllSubFromTeacher(String teacherName){
//		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
//		SubjectBean sb=null;
//		
//		try {
//			ct = new ConnDb().getConn();
//			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' ";
//			sm = ct.createStatement();
//			rs = sm.executeQuery(sql);
//			while(rs.next()){
//				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
//						rs.getString(4), rs.getString(5), rs.getString(6),
//						rs.getString(7), rs.getString(8), rs.getString(9),
//						rs.getDate(10),rs.getInt(11), rs.getInt(12));
//				al.add(sb);
//			}
//			
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}finally{
//			this.closeSource();
//		}
//		return al;		
//				
//	}
//	
//	/**
//	 * 通过方向找出对应的所有题目
//	 */
//	public ArrayList<SubjectBean> getAllSubFromDirection(String direction) {
//		// TODO Auto-generated method stub
//		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
//		SubjectBean sb=null;
//		
//		try {
//			ct = new ConnDb().getConn();
//			String sql = "select * from t_subject where direction like '%"+direction+"%' ";
//			sm = ct.createStatement();
//			rs = sm.executeQuery(sql);
//			while(rs.next()){
//				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
//						rs.getString(4), rs.getString(5), rs.getString(6),
//						rs.getString(7), rs.getString(8), rs.getString(9),
//						rs.getDate(10),rs.getInt(11), rs.getInt(12));
//				al.add(sb);
//			}
//			
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}finally{
//			this.closeSource();
//		}
//		return al;		
//		
//	}
//	/**
//	 * 通过关键字找出对应的所有题目
//	 */
//	public ArrayList<SubjectBean> getAllSubFromkey(String key) {
//		// TODO Auto-generated method stub
//		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
//		SubjectBean sb=null;
//		
//		try {
//			ct = new ConnDb().getConn();
//			String sql = "select * from t_subject where title like '%"+key+"%' ";
//			sm = ct.createStatement();
//			rs = sm.executeQuery(sql);
//			while(rs.next()){
//				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
//						rs.getString(4), rs.getString(5), rs.getString(6),
//						rs.getString(7), rs.getString(8), rs.getString(9),
//						rs.getDate(10),rs.getInt(11), rs.getInt(12));
//				al.add(sb);
//			}
//			
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}finally{
//			this.closeSource();
//		}
//		return al;		
//		
//	}
//	
//	
//	public ArrayList<SubjectBean> getAllSubFromTeaandDir(String teacherName, String direction) {
//		// TODO Auto-generated method stub
//		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
//		SubjectBean sb=null;
//		
//		try {
//			ct = new ConnDb().getConn();
//			String sql = "select * from t_subject where teacher like '%"+teacherName+"%' and direction like '%"+direction+"%'  ";
//			sm = ct.createStatement();
//			rs = sm.executeQuery(sql);
//			while(rs.next()){
//				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
//						rs.getString(4), rs.getString(5), rs.getString(6),
//						rs.getString(7), rs.getString(8), rs.getString(9),
//						rs.getDate(10),rs.getInt(11), rs.getInt(12));
//				al.add(sb);
//			}
//			
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}finally{
//			this.closeSource();
//		}
//		return al;		
//	}

	//通过题目id删除某个题目
	public int delSubjectById(String id) {
		// TODO Auto-generated method stub
		int i=0;
		try {
			String sql="delete from t_subject where id='"+id+"'";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);

			i = this.ps.executeUpdate(sql);

			return i;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSource();
		}
	}
	
	public boolean delSubjectById(String stuId ,String subId){
		boolean a =false ;
			try {
				ct =new ConnDb().getConn();
				sm =ct.createStatement();
				int i = sm.executeUpdate("delete from t_stu_sub where stu_id ='"+stuId+"' and sub_Id = '"+subId+"' ");
				if(i==1){
					a=true;
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				
				this.closeSource() ;
			}
		return a;
	}

	/*public int addNum(String subId ,int seledNum) {
		// TODO Auto-generated method stub
		String sql = "update t_subject set selectedNum = '"+seledNum+1+"' where  id = '"+subId+"'";
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
	}*/

	//关闭资源
	public void closeSource(){
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

	
	public int updateSelectedNum(String temp, int a) {
		// TODO Auto-generated method stub
		String sql="";
		if(a==1){
			sql = "update t_subject set selectedNum = selectedNum+1 where  id = '"+temp+"'";
		}else if(a==-1){
			sql = "update t_subject set selectedNum = selectedNum-1 where  id = '"+temp+"'";

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

	
	

}
