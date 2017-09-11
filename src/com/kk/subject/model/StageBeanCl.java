package com.kk.subject.model;

import java.sql.*;
import java.util.ArrayList;

public class StageBeanCl {
	private Connection ct;
	private PreparedStatement ps;
	private ResultSet rs;
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
	
	public ArrayList<StageBean> getAllStage(){
		ArrayList<StageBean> arrSb = new ArrayList<StageBean>();
		StageBean sb;
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("select * from t_stage");
			rs = ps.executeQuery();
			while(rs.next()){
				sb = new StageBean();
				sb.setName(rs.getString(1));
				sb.setStartTime(rs.getDate(2));
				sb.setEndTime(rs.getDate(3));
				arrSb.add(sb);
			}
			return arrSb;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}finally{
			closeSourse();
		}
	}

	public void setStage(String[] strStartTime, String[] strEndTime) {
		// TODO Auto-generated method stub
		Date[] sTimes = this.strTimesToDateTimes(strStartTime);
		Date[] eTimes = this.strTimesToDateTimes(strEndTime);
		String[] names = {"1、老师出题阶段","2、学生选题阶段","3、老师选第1志愿阶段","4、老师选第2志愿阶段","5、老师选第3志愿阶段","6、管理员调整结果阶段"};
		try {
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement("update t_stage set startTime=?,endTime=? where name=?");
			for(int i=0;i<sTimes.length;i++){
				ps.setDate(1, sTimes[i]);
				ps.setDate(2, eTimes[i]);
				ps.setString(3, names[i]);
				ps.executeUpdate();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		
	}
	
	/**
	 * 获取当前阶段
	 * 1、老师出题阶段
	 * 2、学生选题阶段
	 * 3、老师选第1志愿阶段
	 * 4、老师选第2志愿阶段
	 * 5、老师选第3志愿阶段
	 * 6、管理员调整结果
	 * @return 1-6：正常		0：参数出错
	 */
	public int getCurrentStage(){
		int i=0;
		Date currentTime = new Date(System.currentTimeMillis());
		String strTime = currentTime.toString();	//转化为String会丢掉时分秒信息
		currentTime = Date.valueOf(strTime);		//丢掉时分秒之后的转化为java.sql.Date默认0时0分0秒（简直机智）
		ArrayList<StageBean> alStage = getAllStage();
		if(null==alStage) return 0;
		for(;i<alStage.size();i++){
			StageBean sb = alStage.get(i);
			if(currentTime.compareTo(sb.getStartTime())>=0 && currentTime.compareTo(sb.getEndTime())<=0) break;
		}
		if(i>=alStage.size()) i=-1;
		return i+1;
	}

	private Date[] strTimesToDateTimes(String[] strtimes) {
		// TODO Auto-generated method stub
		Date[] dates = new Date[strtimes.length];
		for(int i=0;i<strtimes.length;i++){
			dates[i] = Date.valueOf(strtimes[i]);
		}
		return dates;
	}

	/**
	 * 
	 * @param stage 当前阶段（int类型）
	 * @return 当前阶段的文字描述
	 */
	public String getdescribeOfStage(int stage) {
		// TODO Auto-generated method stub
		String sql = "select * from t_stage where name like '%"+stage+"%'";
		String describeOfStage = "不在选题阶段";
		try{
			ct = new ConnDb().getConn();
			ps = ct.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) describeOfStage = rs.getString(1);
//			else describeOfStage = "";
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			closeSourse();
		}
		return describeOfStage;
	}
}