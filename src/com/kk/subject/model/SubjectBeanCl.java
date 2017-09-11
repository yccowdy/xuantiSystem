package com.kk.subject.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import com.ax.subject.model.ConnDb;



public class SubjectBeanCl {
	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;


	//插入一条题目,成功返回插入的题目的id，不成功返回-1
	public int insertSubject(SubjectBean subBean){
		//11.5
		int s_id=-1;
		try {
			this.ct = (new ConnDb()).getConn();
			System.out.println(subBean.getkey());
			String sql="insert into t_subject(title, teacher, direction, introduction, schedule, reference, requirement, domain, time, state, selectedNum, keyNum,yuanxi) values(?,?,?,?,?,?,?,?,'"+(new java.sql.Date(System.currentTimeMillis()))+"',?,?,?,?)";
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
			ps.setString(11, subBean.getkey());
			ps.setString(12, subBean.getYuanxi());
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
			this.closeSourse();
		}
	}

	//通过题目编号（id）返回一个SubjectBean 11.5号增加返回一个
	public SubjectBean getSubjectById(String id){
		SubjectBean sb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select * from t_subject where id=?";
			ps=ct.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12),rs.getString(13),rs.getString(14));
			}
			return sb;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	public SubjectBean getSubjectById(int id){
		return getSubjectById(id+"");
	}
    
	//返回所有题目11.3今年本院所有题目
	public ArrayList<SubjectBean> getAllSub(String yuanxi){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		Calendar date = Calendar.getInstance();//11.3
		Calendar now=Calendar.getInstance(); //11.3
		String year=now.get(Calendar.YEAR)+"";//获取系统的年份
		//System.out.println(year);//11.3
		Date d=null;//11.3
		try {
			ct=new ConnDb().getConn();
			String sql="select * from t_subject where yuanxi='"+yuanxi+"'order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				d=rs.getDate(10);//11.3
				if(d!=null) date.setTime(d);//11.3
				String y=date.get(Calendar.YEAR)+"";//获取对应ID的出题年份
				System.out.println(y);//看是否获取到对应ID的出题年份并把打印出来.
				if(y.equals(year))
				{//比较年份是否相等 赋值
					al.add(sb);
				}
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
	
	//返回所有题目11.3往年本院所有题目
	public ArrayList<SubjectBean> getAllSub2(String yuanxi){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		Calendar date = Calendar.getInstance();//11.3
		Calendar now=Calendar.getInstance(); //11.3
		String year=now.get(Calendar.YEAR)+"";//获取系统的年份
		//System.out.println(year);//11.3
		Date d=null;//11.3
		try {
			ct=new ConnDb().getConn();
			String sql="select * from t_subject where yuanxi='"+yuanxi+"' order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				d=rs.getDate(10);//11.3
				if(d!=null) date.setTime(d);//11.3
				String y=date.get(Calendar.YEAR)+"";//获取对应ID的出题年份
				System.out.println(y);//看是否获取到对应ID的出题年份并把打印出来.
				if(!(y.equals(year)))
				{//比较年份是否相等 赋值
					al.add(sb);
				}
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
	
	//返回所对应系的题目
	public ArrayList<SubjectBean> getAllSub1(String department){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select * from  t_subject where teacher in  ( select name from t_teacher where department ='"+department+"' ) order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci";
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
			closeSourse();

		}
	}
	

	//返回各个系所得到的题目
	public int get1(String str){
		int count =0;
		SubjectBean sb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select sum(subNum) from t_teacher where department='"+str+"' ";
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		}finally{
			closeSourse();

		}
		
		
		return count;
	}
	//加入了关键字
	public ArrayList<SubjectBean> getSubjectByNameAndDept(String teacherName,String department,String k){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		try {
			String sql="select * from t_subject where teacher like '%"+teacherName+"%' and teacher in (select name from t_teacher where  department='"+department+"')";
			if("0".equals(department)){
				sql="select * from t_subject where title like '%"+k+"%'";
			}
			
			ct = new ConnDb().getConn();
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
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
			this.closeSourse();
		}
		return al;
	}
	//wxp加了年份	11.1
	public ArrayList<SubjectBean> getSubjectByYear(String teacherName,String department,String k,String year){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		Calendar date = Calendar.getInstance();
		Date d=null;
		try {
			String sql="select * from t_subject where teacher like '%"+teacherName+"%' and teacher in (select name from t_teacher where  department='"+department+"') and title like '%"+k+"%' ";
			if("0".equals(department)){
				sql="select * from t_subject where title like '%"+k+"%' and teacher like '%"+teacherName+"%'";
			}
			ct = new ConnDb().getConn();
			ps=ct.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				sb=new SubjectBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getDate(10),rs.getInt(11), rs.getInt(12));
				d=rs.getDate(10);
				if(d!=null) date.setTime(d);
				String y=date.get(Calendar.YEAR)+"";
				//System.out.println(y);
				//System.out.println(year);
				//System.out.println(year.equals(y));
				if(year.equals(y)||year.equals("")) al.add(sb);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return al;
	}
		
	
	
	//根据审核状态获取题目

	public ArrayList<SubjectBean> getSubByState(String state){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		//if(state.equals("all")){
		//	return getAllSub(yuanxi);
		//}else{
			try {
				ct=new ConnDb().getConn();
				String sql="select * from t_subject where state=?";
				ps=ct.prepareStatement(sql);
				ps.setString(1, state);
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
				closeSourse();

			}
		}
	//}
	public ArrayList<SubjectBean> getSubByState1(String state,String department){
		ArrayList<SubjectBean> al=new ArrayList<SubjectBean>();
		SubjectBean sb=null;
		if(state.equals("all")){
			return getAllSub1(department);
		}else{
			try {
				ct=new ConnDb().getConn();
				//String sql="select * from t_subject where state='"+state+"'  ";
				String sql="select * from  t_subject where state = '"+state+"' and teacher in  ( select name from t_teacher where department ='"+department+"' ) order by  convert(teacher USING gbk) COLLATE gbk_chinese_ci" ;

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
				closeSourse();

			}
		}
	}
	//通过题目id删除某个题目
	public int delSubjectById(String id) {
		// TODO Auto-generated method stub
		/*		int i=0;
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
			this.closeSourse();
		}*/
		return modifySubject("delete from t_subject where id='"+id+"'");
	}

	//修改一个题目信息成功返回1，不成功返回-1
	public int modifySubject(String sql){
		int i=0;
		try {
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);

			i = this.ps.executeUpdate(sql);

			return i;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
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

	public int[] getSubIdsByTitle(String title) {
		// TODO Auto-generated method stub
		int[] subIds=null;
		int i=0;
		try {
			ct=new ConnDb().getConn();
			String sql="select count(*) from t_subject where title=?";
			ps=ct.prepareStatement(sql);
			ps.setString(1, title);
			rs=ps.executeQuery();
			if(rs.next()) i=rs.getInt(1);
			System.out.println("title="+title+"\t i="+i);
			if(i==0){
				return null;
			}else{
				subIds = new int[i];
				sql="select id from t_subject where title=?";
				ps=ct.prepareStatement(sql);
				ps.setString(1, title);
				rs=ps.executeQuery();

				i=0;
				while(rs.next()){
					subIds[i++] = rs.getInt(1);
				}
			}
			return subIds;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	//根据题目编号单个审核
	public int verifyById(String subId,int state) {
		// TODO Auto-generated method stub
		int i=0;
		String sql = "update t_subject set state=? where id=?";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setInt(1, state);
			ps.setString(2, subId);
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
	
	//根据题目编号批量审核
	public void verifyByIds(String[] subIds , int state) {
		// TODO Auto-generated method stub
		for(int i=0;i<subIds.length;i++){
			verifyById(subIds[i],state);
		}
	}

	
}
