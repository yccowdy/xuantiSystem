package com.kk.subject.model;

import java.sql.*;
import java.util.ArrayList;

import com.ax.subject.model.ConnDb;
import com.common.controller.Md5;



public class TeacherBeanCl {

	private Connection ct=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private TeacherBean tb=null;

	private Statement sm=null;


	//通过id获取一个teacher的信息
	public TeacherBean getTeacherById(String id){
		tb = null;
		try {
			String sql="select * from T_Teacher where id='"+id+"'";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);

			this.rs = ps.executeQuery();

			if(rs.next()){
				this.tb = new TeacherBean();

				tb.setId(rs.getString(1));
				tb.setPsw(rs.getString(2));
				tb.setName(rs.getString(3));
				tb.setSex(SEX.toEnum(rs.getString(4)));
				tb.setPhoneNum(rs.getString(5));
				tb.setEmail(rs.getString(6));
				tb.setJobTitle(rs.getString(7));
				tb.setSubNum(rs.getShort(8));
				tb.setMaxSubNum(rs.getShort(9));
				tb.setDepartment(rs.getString(10));
				tb.setType(rs.getInt(11));
			}
			return this.tb;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{
			this.closeSourse();
		}

	}

	//返回包含所有老师的ArrayList
	public ArrayList<TeacherBean> getAllTea(){
		ArrayList<TeacherBean> alTea = new ArrayList<TeacherBean>();
		try {
			String sql="select * from T_Teacher ";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);

			this.rs = ps.executeQuery();

			while(rs.next()){
				this.tb = new TeacherBean();

				tb.setId(rs.getString(1));
				tb.setPsw(rs.getString(2));
				tb.setName(rs.getString(3));
				tb.setSex(SEX.toEnum(rs.getString(4)));
				tb.setPhoneNum(rs.getString(5));
				tb.setEmail(rs.getString(6));
				tb.setJobTitle(rs.getString(7));
				tb.setSubNum(rs.getShort(8));
				tb.setMaxSubNum(rs.getShort(9));
				tb.setDepartment(rs.getString(10));
				tb.setType(rs.getInt(11));
				alTea.add(tb);
			}

			return alTea;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{
			this.closeSourse();
		}
	}

	/**
	 * 查询所属系为department的老师
	 * @param department 系名
	 * @return 包含老师信息的ArrayList
	 * @author kangkang574 2015/12/02
	 */
	public ArrayList<TeacherBean> getTeaByDepartment(String department){
		ArrayList<TeacherBean> alTea = new ArrayList<TeacherBean>();
		try {
			String sql="select * from T_Teacher where department=?";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);
			ps.setString(1, department);
			this.rs = ps.executeQuery();

			while(rs.next()){
				this.tb = new TeacherBean();

				tb.setId(rs.getString(1));
				tb.setPsw(rs.getString(2));
				tb.setName(rs.getString(3));
				tb.setSex(SEX.toEnum(rs.getString(4)));
				tb.setPhoneNum(rs.getString(5));
				tb.setEmail(rs.getString(6));
				tb.setJobTitle(rs.getString(7));
				tb.setSubNum(rs.getShort(8));
				tb.setMaxSubNum(rs.getShort(9));
				tb.setDepartment(rs.getString(10));
				tb.setType(rs.getInt(11));
				alTea.add(tb);
			}

			return alTea;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{
			this.closeSourse();
		}
	}

	//通过TeacherBean添加一个老师账号
	public int insertByTb(TeacherBean tb1){
		int i=0;

		try {
			String sql="insert into t_teacher (id,psw,name,sex,phoneNum,email,jobTitle,subNum,maxSubNum,department,type) values (?,?,?,?,?,?,?,?,?,?,?)";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);
			ps.setString(1, tb1.getId());
			ps.setString(2, tb1.getPsw());
			ps.setString(3, tb1.getName());
			ps.setString(4, SEX.toStringValue(tb1.getSex()));
			ps.setString(5, tb1.getPhoneNum());
			ps.setString(6, tb1.getEmail());
			ps.setString(7, tb1.getJobTitle());
			ps.setInt(8, tb1.getSubNum());
			ps.setInt(9, tb1.getMaxSubNum());
			ps.setString(10, tb1.getDepartment());
			ps.setInt(11, tb1.getType());
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

	//通过TeacherBean修改老师信息
	public int modifyByTb(TeacherBean tb2) {
		// TODO Auto-generated method stub
		int i=0;

		try {
			String sql="update t_teacher set psw=?,name=?,sex=?,phoneNum=?,email=?,jobTitle=?,subNum=?,maxSubNum=?,department=?,type=? where id=?";
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);

			ps.setString(1, tb2.getPsw());
			ps.setString(2, tb2.getName());
			ps.setString(3, SEX.toStringValue(tb2.getSex()));
			ps.setString(4, tb2.getPhoneNum());
			ps.setString(5, tb2.getEmail());
			ps.setString(6, tb2.getJobTitle());
			ps.setInt(7, tb2.getSubNum());
			ps.setInt(8, tb2.getMaxSubNum());
			ps.setString(9, tb2.getDepartment());
			ps.setInt(10, tb2.getType());
			ps.setString(11, tb2.getId());
			i = ps.executeUpdate();
			System.out.println(i+"\t"+tb2.getType()+"\t"+tb2.getDepartment());
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}finally{
			this.closeSourse();
		}
	}

	//通过id删除一个老师信息（先获取该老师所有题目的编号，然后从关联表中删除，然后从题目表中删除，再从老师表中删除）
	public int delTeacherById(String teaId){
		int j=0;
		int[] subIds = new TeacherSubBeanCl().getS_id(teaId);
		String sql;
		if(subIds==null) System.out.println("subIds.length=0");
		try {
			ct = new ConnDb().getConn();
			if(subIds!=null){
				//从老师题目关联表中删除
				sql = "delete from T_Teacher_Sub where t_id=?";
				ps = ct.prepareStatement(sql);
				ps.setString(1, teaId);
				ps.executeUpdate();
				//从题目表中删除题目
				sql = "delete from t_subject where id=?";
				ps = ct.prepareStatement(sql);
				for(int i=0;i<subIds.length;i++){
					ps.setInt(1, subIds[i]);
					ps.executeUpdate();
				}
			}
			//从老师表中删除老师
			sql = "delete from t_teacher where id=?";
			ps = ct.prepareStatement(sql);
			ps.setString(1, teaId);
			j = ps.executeUpdate();
			return j;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return j;
		}finally{
			closeSourse();
		}
	}

	//验证用户是否存在
	public boolean checkUser(String u,String p)
	{
		boolean b=false;
		Md5 md5 = new Md5();
		try {
			//链接和创建
			this.ct = (new ConnDb()).getConn();
			ps = ct.prepareStatement("select psw from T_Teacher where id='"+u+"'");
			//this.sm = this.ct.createStatement();
			//查询
			rs=ps.executeQuery("select psw from T_Teacher where id='"+u+"'");
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

	//更新数据
	public int updateData(String sql){
		int i=0;
		try {
			this.ct = (new ConnDb()).getConn();
			this.ps = this.ct.prepareStatement(sql);
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

	public boolean checkExist(String teaId) {
		// TODO Auto-generated method stub
		if(this.getTeacherById(teaId)!=null) return true;
		else return false;
	}

	public boolean checkEmail(String id, String email) {
		// TODO Auto-generated method stub
		String sql = "select * from t_teacher where id=? and email=?";
		boolean b = false;
		try {
			ct = (new ConnDb()).getConn();
			ps = ct.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, email);
			rs = ps.executeQuery();
			if(rs.next()) b=true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return b;
	}

	//根据出题人的名字得到所对应的系
	public String getTeaDepartment(String teaName ){
		String teaDepa = null;
		try {
			ct = new ConnDb().getConn();
			sm = ct.createStatement();
			rs = sm.executeQuery("select department from t_teacher where name='"+teaName+"'");
			if(rs.next())	teaDepa = rs.getString(1);


			return teaDepa;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}

	}
	//根据老师的名字查找他的记录
	public ArrayList<TeacherBean> getAllTeacherByName(String teacherName){
		ArrayList<TeacherBean> al = new ArrayList<TeacherBean>();
		TeacherBean tb = null;
		try {
			String sql="select *from t_teacher where name like '%"+teacherName+"%'";
			ct = new ConnDb().getConn();
			sm=ct.createStatement();
			rs=sm.executeQuery(sql);
			while(rs.next()){
				tb=new TeacherBean(rs.getString(1),rs.getString(2),rs.getString(3),
						SEX.toEnum(rs.getString(4)),rs.getString(5),rs.getString(6),
						rs.getString(7),rs.getInt(8),rs.getInt(9),
						rs.getString(10),rs.getInt(11));
				al.add(tb);
			}


		} catch (Exception e) {

			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return al;
	}

	/*
	 * 通过系找到老师信息
	 */
	public ArrayList<TeacherBean> getAllTeacherByDirection(String direction){

		ArrayList<TeacherBean> al = new ArrayList<TeacherBean>();
		TeacherBean tb = null;
		try {
			String sql="select *from t_teacher where department like '%"+direction+"%'";
			ct = new ConnDb().getConn();
			sm=ct.createStatement();
			rs=sm.executeQuery(sql);
			while(rs.next()){
				tb=new TeacherBean(rs.getString(1),rs.getString(2),rs.getString(3),
						SEX.toEnum(rs.getString(4)),rs.getString(5),rs.getString(6),
						rs.getString(7),rs.getInt(8),rs.getInt(9),
						rs.getString(10),rs.getInt(11));
				al.add(tb);
			}


		} catch (Exception e) {

			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return al;
	}
	/*
	 * teacherName,direction 都不为空
	 */
	public ArrayList<TeacherBean> getAllTeacherByTeacherNameandDirection(String teacherName,String direction){

		ArrayList<TeacherBean> al = new ArrayList<TeacherBean>();
		TeacherBean tb = null;
		try {
			String sql="select * from t_teacher where name like '%"+teacherName+"%' and department like'%"+direction+"%'";
			ct = new ConnDb().getConn();
			sm=ct.createStatement();
			rs=sm.executeQuery(sql);
			while(rs.next()){
				tb=new TeacherBean(rs.getString(1),rs.getString(2),rs.getString(3),
						SEX.toEnum(rs.getString(4)),rs.getString(5),rs.getString(6),
						rs.getString(7),rs.getInt(8),rs.getInt(9),
						rs.getString(10),rs.getInt(11));
				al.add(tb);
			}


		} catch (Exception e) {

			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return al;
	}

	/**
	 * 根据老师名字（模糊查询）和系名（精确查询），获取老师信息列表
	 * @param teacherName 老师姓名中包含的字
	 * @param department 系名
	 * @return 包含老师信息的链表
	 * @author kangkang574 2015/12/02
	 */
	public ArrayList<TeacherBean> getTeacherByNameAndDept(String teacherName,String department) {
		// TODO Auto-generated method stub
		ArrayList<TeacherBean> al = new ArrayList<TeacherBean>();
		TeacherBean tb = null;
		try {
			String sql="select * from t_teacher where name like '%"+teacherName+"%' and department='"+department+"'";
			if("0".equals(department)){
				sql="select * from t_teacher where name like '%"+teacherName+"%'";
			}
			
			ct = new ConnDb().getConn();
			sm=ct.createStatement();
			rs=sm.executeQuery(sql);
			while(rs.next()){
				tb=new TeacherBean(rs.getString(1),rs.getString(2),rs.getString(3),
						SEX.toEnum(rs.getString(4)),rs.getString(5),rs.getString(6),
						rs.getString(7),rs.getInt(8),rs.getInt(9),
						rs.getString(10),rs.getInt(11));
				al.add(tb);
			}


		} catch (Exception e) {

			// TODO: handle exception
			e.printStackTrace();
		}finally{
			this.closeSourse();
		}
		return al;
	}
}
