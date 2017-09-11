package com.kk.subject.model;
import java.sql.*;
import java.util.ArrayList;

import com.ax.subject.model.ConnDb;

public class StuSubTeaBeanCl {
	private Connection ct;
	private PreparedStatement ps;
	private ResultSet rs;

	static int recursion=0;
	
	/** 将此TTSB的state设置为1;
	 * 将题目Id为此subId的状态state设置为-1，表示老师选择了其他学生;
	 * 将学生Id为此stuId的状态state设置为-2，表示该学生的志愿被选中，其他志愿不能再被选;
	 * */
	public int chooseStu(String stuId, String subId) {
		// TODO Auto-generated method stub
		int r=0;
		String sql="update t_stu_sub set state=1 where stu_id=? and sub_id=?";
		try {
			ct = new ConnDb().getConn();

			//将此TTSB的state设置为1
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			r+=ps.executeUpdate();

			//将题目Id为此subId的状态state设置为-1，表示老师选择了完成此题的学生
			sql = "update t_stu_sub set state=-1 where stu_id<>? and sub_id=?";
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			r+=ps.executeUpdate();

			//将学生Id为此stuId的状态state设置为-2，表示该学生的志愿被选中，其他志愿不能再被选
			sql = "update t_stu_sub set state=-2 where stu_id=? and sub_id<>?";
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			r+=ps.executeUpdate();

			return r;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}

	/**
	 * 将此TTSB的state设置为0;
	 * 将题目Id为此subId,并且state为-1（表示老师选择了其他学生）的state设置为0;
	 * 将学生Id为此stuId,并且state为-2（表示该学生的志愿被选中）的state设置为0;
	 * */
	public int repeal(String stuId, String subId) {
		// TODO Auto-generated method stub
		int r=0;
		String sql="update t_stu_sub set state=0 where stu_id=? and sub_id=?";
		try {
			ct = new ConnDb().getConn();

			//将此TTSB的state设置为0
			ps = ct.prepareStatement(sql);
			ps.setString(1, stuId);
			ps.setString(2, subId);
			r+=ps.executeUpdate();

			// 将题目Id为此subId,并且state为-1（表示老师选择了其他学生）的state设置为0
			sql = "update t_stu_sub set state=0 where state=-1 and sub_id=?";
			ps = ct.prepareStatement(sql);
			ps.setString(1, subId);
			r+=ps.executeUpdate();

			//将学生Id为此stuId,并且state为-2（表示该学生的志愿被选中）的state设置为0
			sql = "update t_stu_sub set state=0 where state=-2 and sub_id<>?";
			ps = ct.prepareStatement(sql);
			ps.setString(1, subId);
			r+=ps.executeUpdate();

			return r;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			closeSourse();
		}
	}

	
	public ArrayList<StuSubTeaBean> getAllSSTB(String teaId){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		String sql = "select * from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?)";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, teaId);
			rs = ps.executeQuery();
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));
				sstb.setTeaName(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTeacher());
				sstb.setSubTitle(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(new StudentBeanCl().getStuById(rs.getInt(1)+"").getName());
				AllSSTB.add(sstb);
			}
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	/**
	 * 2015.11.30kangkang
	 * 查询某个老师的题目选题结果
	 * @param teaId
	 * @return
	 */
	public ArrayList<StuSubTeaBean> getMineSSTB(String teaId){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		/**获取当前选题阶段
		 * 1、老师出题阶段
		 * 2、学生选题阶段
		 * 3、老师选第1志愿阶段
		 * 4、老师选第2志愿阶段
		 * 5、老师选第3志愿阶段
		 * 6、管理员调整结果
		 */
		int stage = new StageBeanCl().getCurrentStage();
		stage -= 2;
		//查询命中的
		String sql = "select * from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?) and state='1'group by sub_id";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, teaId);
			rs = ps.executeQuery();
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));
				sstb.setTeaName(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTeacher());
				sstb.setSubTitle(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(new StudentBeanCl().getStuById(rs.getInt(1)+"").getName());
				AllSSTB.add(sstb);
			}
			//查询志愿小于等于当前阶段的
			sql = "select * from t_stu_sub where" +
					" sub_Id in (select s_id from t_teacher_sub where t_id=?) and" +
					" sub_Id not in (select sub_id from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?) and state='1' group by sub_id) and wish<=?" +
					" group by sub_id";

			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, teaId);
			ps.setString(2, teaId);
			ps.setInt(3, stage);
			rs = ps.executeQuery();
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));
				sstb.setTeaName(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTeacher());
				sstb.setSubTitle(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(new StudentBeanCl().getStuById(rs.getInt(1)+"").getName());
				AllSSTB.add(sstb);
			}
			//查询剩余的，既没有命中、志愿类型也在选择之外的题目
			sql = "select * from t_stu_sub where " +
					" sub_Id in (select s_id from t_teacher_sub where t_id=? ) and" +
					" sub_Id not in (select sub_id from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?) and state='1'group by sub_id) and" +
					" sub_Id not in (select sub_id from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?) and sub_Id not in (select sub_id from t_stu_sub where sub_Id in (select s_id from t_teacher_sub where t_id=?) and state='1' group by sub_id) and wish<=? group by sub_id)" +
					" group by sub_id ";

			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, teaId);
			ps.setString(2, teaId);
			ps.setString(3, teaId);
			ps.setString(4, teaId);
			ps.setInt(5, stage);
			rs = ps.executeQuery();
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));
				sstb.setTeaName(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTeacher());
				sstb.setSubTitle(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(new StudentBeanCl().getStuById(rs.getInt(1)+"").getName());
				AllSSTB.add(sstb);
			}
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	
	
	
	
	
	
	//得到结果值的属性值
	
	public ArrayList<StuSubTeaBean> ExcelgetAllSSTB(){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub where state='1' order by stu_Id ");
			rs = ps.executeQuery();
			
			/**
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			/**
			 * 
			 */
			
			while(rs.next()){
				
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	public ArrayList<StuSubTeaBean> getAllSSTB(){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub order by sub_id");
			rs = ps.executeQuery();
			
			/**
			 * @author kangkang574 按照题目编号排序
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			/*TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();*/
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				sstb.setTeaName("");
				sstb.setSubTitle("");
				sstb.setStuName("");
				/**
				 * 
				 */
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	public ArrayList<StuSubTeaBean> getAllSSTB2(String teaId){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub where sub_id in (select s_id from t_teacher_sub where t_id='"+teaId+"' ) ");
			rs = ps.executeQuery();
			
			/**
			 * @author kangkang574 按照题目编号排序
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			/*TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();*/
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				sstb.setTeaName("");
				sstb.setSubTitle("");
				sstb.setStuName("");
				/**
				 * 
				 */
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	public ArrayList<StuSubTeaBean> getAllSSTB3(String teaId){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from stuselecttitle where title1 in (select s_id from t_teacher_sub where t_id='"+teaId+"' ) or title2  in (select s_id from t_teacher_sub where t_id='"+teaId+"' )or title3  in (select s_id from t_teacher_sub where t_id='"+teaId+"' )or title4 in (select s_id from t_teacher_sub where t_id='"+teaId+"' or title5 in (select s_id from t_teacher_sub where t_id='"+teaId+"' )or title6  in (select s_id from t_teacher_sub where t_id='"+teaId+"' )) ");
			rs = ps.executeQuery();

			/**
			 * @author kangkang574 按照题目编号排序
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			/*TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();*/
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setTeaName("");
				sstb.setSubTitle("");
				sstb.setStuName("");
				System.out.println("查询成功");

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				/**
				 * 
				 */
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	public ArrayList<StuSubTeaBean> getAllSSTB3(){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub ");
			rs = ps.executeQuery();
			
			/**
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				String teaId = tsbc.getTeaId(sstb.getSubId());
				
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				
				sstb.setWish(rs.getInt(3));
				
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setState(rs.getInt(8));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				
				/**
				 * 
				 */
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	
	public ArrayList<StuSubTeaBean> getAllSSTB1(){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub where state='1' order by wish");
			rs = ps.executeQuery();
			
			/**
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 */
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				sstb.setTeaName("");
				sstb.setSubTitle("");
				sstb.setStuName("");
				/**
				 * 
				 */
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	public ArrayList<StuSubTeaBean> getMyAllResult(String teacherName,String department){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		
		try{
			
			String sql="select * from t_stu_sub where sub_id in( select s_id from t_teacher_sub where t_id in (select id from t_teacher where name like '%"+teacherName+"%' ))" +
					"and sub_id in (select s_id from t_teacher_sub where t_id in (select id from t_teacher where  department='"+department+"')) order by sub_id";
			if("0".equals(department)){
				sql="select * from t_stu_sub where sub_id in( select s_id from t_teacher_sub where t_id in (select id from t_teacher where name like '%"+teacherName+"%' )) order by sub_id";
			}else if(teacherName==null&&"0".equals(department)){
				sql="select * from t_stu_sub order by sub_id";
			}
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			
			/**
			 * kangkang 2015.11.11添加
			 * 由于原来的代码需要大量生成匿名类，可能导致占用过多资源
			 *//*
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();*/
			/**
			 * 
			 */
			
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));

				/**
				 * kangkang 2015.11.11 
				 * 此处查询过多，可能是影响显示速度的原因
				 * 填写老师名字、题目名字、学生名字在页面上去实现，可以只获取当前页面要显示的十来个，可以省时 
				 */				
				/*
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(stubc.getStuById(rs.getInt(1)+"").getName());
				*/
				sstb.setTeaName("");
				sstb.setSubTitle("");
				sstb.setStuName("");
				/**
				 * 
				 */
				
				AllSSTB.add(sstb);
			}
			
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}
	
	public int get1(){
		int count =0;
		StuSubTeaBean sstb=null;
		try {
			ct=new ConnDb().getConn();
			String sql="select count(*) from t_stu_sub where state='1'";
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
	
	
	public ArrayList<StuSubTeaBean> getSSTBbySubId(String subId){
		ArrayList<StuSubTeaBean> AllSSTB = new ArrayList<StuSubTeaBean>();
		StuSubTeaBean sstb;
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stu_sub where sub_id=?");
			ps.setString(1, subId);
			rs = ps.executeQuery();
			while(rs.next()){
				sstb = new StuSubTeaBean();
				sstb.setStuId(rs.getInt(1));
				sstb.setSubId(rs.getInt(2));
				sstb.setWish(rs.getInt(3));
				sstb.setState(rs.getInt(4));
				sstb.setTeaName(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTeacher());
				sstb.setSubTitle(new SubjectBeanCl().getSubjectById(rs.getInt(2)).getTitle());
				sstb.setStuName(new StudentBeanCl().getStuById(rs.getInt(1)+"").getName());
				AllSSTB.add(sstb);
			}
			return AllSSTB; 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	/**
	 * 获取所有落选的学生
	 * @return 返回包含所有落选学生的ArrayList<StudentBean>
	 */
	public ArrayList<StudentBean> getFailedStu(){
		ArrayList<StudentBean> alStuBean = new ArrayList<StudentBean>();
		StudentBean sb;
		String sql = "select * from t_student as a where id not in (select b.stu_id FROM t_stu_sub as b where state='1')";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
				alStuBean.add(sb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return alStuBean;
	}

	/**
	 * 获取所有落选的题目
	 * @return 返回包含所有落选题目的ArrayList<SubjectBean>
	 */
	public ArrayList<SubjectBean> getFailedSub(){
		ArrayList<SubjectBean> alStuBean = new ArrayList<SubjectBean>();
		SubjectBean sb;
		String sql = "select a.id from t_subject as a where id not in (select b.sub_id FROM t_stu_sub as b where state='1')";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new SubjectBeanCl().getSubjectById(rs.getInt(1));
				alStuBean.add(sb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return alStuBean;
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
	 * 管理员给学生指派备选题目
	 * @param stuId学生账号
	 * @param subId题目编号
	 * @return 1成功 , 0失败，-1出错
	 */
	public int assignWish4BySubStuId(int subId,int stuId){
		int i=0;
		String sql="update t_stu_sub set state='1' where stu_Id=? and sub_Id=? and wish='4'";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setInt(1, stuId);
			ps.setInt(2, subId);
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
	
	/**
	 * 管理员给学生指派题目
	 * @param stuId学生账号
	 * @param subId题目编号
	 * @return 1成功 , 0失败，-1出错
	 */
	public int assignByStuIdSubId(int stuId,int subId){
		int i=0;
		String sql="insert into t_stu_sub (stu_Id,sub_Id,wish,state) values (?,?,?,?)";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			ps.setInt(1, stuId);
			ps.setInt(2, subId);
			ps.setInt(3, 5);
			ps.setInt(4, 1);
			i = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			assignWish4BySubStuId(subId, stuId);
			i=-1;
		}finally{
			closeSourse();
		}
		return i;
	}
	
	/**
	 * 用贪心算法指派落选题目
	 */
	public void autoAssign() {
		
		//存在非备选志愿，优先分配
		assignWish123();
		
		int[] subStuId = getFirstSubStuId();
		if(subStuId!=null && ++recursion<1000){
			System.out.println("subId="+subStuId[0]+"\tstuId="+subStuId[1]);
			int a=assignWish4BySubStuId(subStuId[0], subStuId[1]);
			System.out.println("a="+a);
			autoAssign();
		}else{
			recursion=0;
			randomAssign();
			System.out.println("randomAssign");
		}
	}
	
	public void assignWish123() {
		String sql = "select from t_stu_sub where wish in(1,2,3)";
	}

	/**
	 * 随机分配题目
	 */
	public void randomAssign(){
		ArrayList<StudentBean> failStu = getFailedStu();
		ArrayList<SubjectBean> failSub = getFailedSub();
		if (failStu.size()>0 && failSub.size()>0 && ++recursion<1000){
			assignByStuIdSubId(((StudentBean)failStu.get(0)).getId(), ((SubjectBean)failSub.get(0)).getId());
			randomAssign();
		}else{
			recursion=0;
		}
	}

	/**
	 * 返回应该首先分配的题目、学生编号
	 * @return 长度为2的数组第一个元素是sub_id，第二个元素是stu_id
	 */
	public int[] getFirstSubStuId() {
		// TODO Auto-generated method stub
		int subStuId[] = null;
		String sql = "select t1.sub_id,t1.stu_id,count(t1.sub_id) as c from t_stu_sub as t1 where wish='4' and " +
				"t1.sub_id not in (select sub_id from t_stu_sub as t2 where t2.state='1') and " +
				"t1.stu_id not in (select stu_id from t_stu_sub as t3 where state='1')  group by sub_id order by c";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				subStuId = new int[2];
				subStuId[0] = rs.getInt(1);
				subStuId[1] = rs.getInt(2);
				return subStuId;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return null;
	}
	
	
	public ArrayList<StudentBean> getFailedStu(String major,String cls){
		ArrayList<StudentBean> alStuBean = new ArrayList<StudentBean>();
		StudentBean sb;
		String sql = "select * from t_student as a where id not in (select b.stu_id FROM t_stu_sub as b where state='1') ";
		if("0".equals(major)&&"0".equals(cls)){
			
			sql = "select * from t_student as a where id not in (select b.stu_id FROM t_stu_sub as b where state='1')";
		}
		else if("0".equals(major)){
			
			sql="select * from t_student as a where id not in (select b.stu_id FROM t_stu_sub as b where state='1')  and class = '"+cls+"'";
		}else if("0".equals(cls)){
			sql="select * from t_student as a where id not in (select b.stu_id FROM t_stu_sub as b where state='1')  and major = '"+major+"'";
		}
		
		
		
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
				alStuBean.add(sb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return alStuBean;
	}
	
}
