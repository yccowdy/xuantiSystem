package com.kk.subject.model;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.GregorianCalendar;

import com.common.controller.MyComparator;

public class TEST {

	/**
	 * @param args
	 */
	private Connection ct=null;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/*
		TeacherBeanCl tbc=new TeacherBeanCl();
		TeacherBean tb=tbc.getTeacherById("test");

		String sql="insert into T_Teacher (id,psw,sex) values ('test1','abc123','女')";
		sql="update t_teacher set sex='女',psw='123' where id='test1'";
		System.out.println(tbc.updateData(sql));

		System.out.println(SEX.FEMALE==tb.getSex());
		System.out.println(tb.getSex()==SEX.MALE?"selected":"21");

		String sql="insert into t_subject (title,direction) values('myTitle',' ')";
		new TEST().insert(sql);*/
		/*		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
		String time=sdf.format(new Date());// new Date()为获取当前系统时间

		try {
			java.util.Date date = sdf.parse(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

/*		TEST t = new TEST();
		String rootPath=t.getClass().getResource("/").getFile().toString(); 
		//取得根目录路径  
		String rootPath1=t.getClass().getResource("/").getFile().toString();  
		//当前目录路径  
		String currentPath1=t.getClass().getResource(".").getFile().toString();  
		String currentPath2=t.getClass().getResource("").getFile().toString();  
		//当前目录的上级目录路径  
		String parentPath=t.getClass().getResource("../../../../").getFile().toString();
		
		System.out.println("Path="+parentPath);*/
		
		
		/*//测试对ArrayList的对象按对象的某个值排序
		ArrayList<StudentBean> arrSb =  new StudentBeanCl().getAllStu();
		MyComparator mp = new MyComparator();
		mp.setAttiName("name");
		System.out.println("before");
		for(int i=0;i<5;i++){
			StudentBean sb = (StudentBean)arrSb.get(i);
			System.out.println(sb.getId()+"\t"+sb.getName());
		}
		Collections.sort(arrSb,mp);
		System.out.println("after");
		for(int i=0;i<5;i++){
			StudentBean sb = (StudentBean)arrSb.get(i);
			System.out.println(sb.getId()+"\t"+sb.getName());
		}*/
		
		//得到当前阶段信息
		/*StageBeanCl sbc = new StageBeanCl();
		ArrayList<StageBean> alStage = sbc.getAllStage();
		int currentStage = sbc.getCurrentStage();
		for (int i = 0; i < alStage.size(); i++) {
			StageBean sb = alStage.get(i);
			System.out.println(sb.getName()+"\t"+sb.getStartTime()+"\t"+sb.getEndTime());
		}
		System.out.println("currentStage="+currentStage);*/
		
		/*
		Date currentTime = new Date(System.currentTimeMillis());
		System.out.println(currentTime.compareTo(Tools.strToDate("2015-4-6")));
		*/
		
		//清空选题结果
		new TeacherBeanCl().updateData("update t_stu_sub set state=0");
		
		Tools.getScrollNotice();
	}

	public void query(){
	}

	public void insert(String sql){
		ConnDb cd=new ConnDb();
		Connection ct=cd.getConn();
		try {
			Statement sm = ct.createStatement();
			sm.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
