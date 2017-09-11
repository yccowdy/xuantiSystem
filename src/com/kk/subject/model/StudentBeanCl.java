package com.kk.subject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentBeanCl {
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

	//通过sql语句直接更新表格数据
	public int updateBySql(String sql){
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
	
	//根据班级号和学生数批量添加学生
	public int batchAddStu(String cls_id,String stuNum,String yuanxi){

		int num = Integer.parseInt(stuNum);
		int i=0,affect=0;
		String stu_id = "";
		String major = new ClsBeanCl().getMajorById(cls_id);
		while(++i<=num){
			if(i<10){
				stu_id=cls_id+"0"+i;
			}else{
				stu_id=cls_id+i;
			}
			affect+=insertById(stu_id,cls_id,major,yuanxi);
		}
		return affect;
	}

	//通过id插入一条记录
	public int insertById(String id,String cls_id,String major,String yuanxi){

		String sql="insert into t_student (id,psw,class,major,yuanxi) values ('"+id+"','"+id+"','"+cls_id+"','"+major+"','"+yuanxi+"')";
		System.out.println("sql="+sql);
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

	//通过StudentBean插入一条记录
		public int insertByStudentBean(StudentBean sb){

			String sql="insert into t_student (id,psw,name,sex,class,major,phoneNum,email,privilege,selectedNum,yuanxi) values (?,?,?,?,?,?,?,?,?,?,?)";
			int i=0;
			try {
				ct = new ConnDb().getConn();
				ps = ct.prepareStatement(sql);
				ps.setInt(1, sb.getId());
				ps.setString(2, sb.getPsw());
				ps.setString(3, sb.getName());
				ps.setString(4, SEX.toStringValue(sb.getSex()));
				ps.setString(5, sb.getCls());
				ps.setString(6, sb.getMajor());
				ps.setString(7, sb.getPhoneNum());
				ps.setString(8, sb.getEmail());
				ps.setInt(9, sb.getPrivilege());
				ps.setInt(10, sb.getSelectNum());
				ps.setString(11, sb.getYuanxi());
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
	
	//返回包含所有学生的ArrayList
	public ArrayList<StudentBean> getAllStu(String yuanxi){
		ArrayList<StudentBean> al = new ArrayList<StudentBean>();			
		StudentBean sb = null;
		String sql="select * from t_student where yuanxi='"+yuanxi+"'";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
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

	//查询某个班级的全部学生
	public ArrayList<StudentBean> getStuByCls(String cls){
		ArrayList<StudentBean> al = new ArrayList<StudentBean>();			
		StudentBean sb = null;
		String sql="select * from t_student where class='"+cls+"'";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
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

	//查询某个专业的全部学生
	public ArrayList<StudentBean> getStuByMajor(String majorName){
		ArrayList<StudentBean> al = new ArrayList<StudentBean>();			
		StudentBean sb = null;
		String sql="select * from t_student where major='"+majorName+"'";
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
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

	//通过stuId删除一个学生
	public int delStuById(String stuId) {
		// TODO Auto-generated method stub
		String sql = "delete from t_student where id='"+stuId+"'";
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

	public StudentBean getStuById(String stuId){
		String sql = "select * from t_student where id='"+stuId+"'";
		StudentBean sb=null;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				sb = new StudentBean(rs.getInt(1),rs.getString(2), rs.getString(3),
						SEX.toEnum(rs.getString(4)), rs.getString(5), rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),rs.getString(11));
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
	
	public boolean checkExist(String stuId){
		if(this.getStuById(stuId)!=null)	return true;
		else return false;
	}

	/**
	 * 删除班级的全部学生
	 * @param id 班级号
	 * @return 返回删除学生数目
	 * @author kangkang574 2015/12/02
	 */
	public int batchDelByClsId(String id) {
		// TODO Auto-generated method stub
		String sql = "delete from t_student where id like '%"+id+"%'";
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


	
}
