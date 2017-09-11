package com.ax.subject.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class SetBeanCl {
	private Connection ct=null;
	private Statement sm=null;
	private ResultSet rs=null;
	SetBean sb = new SetBean();
	/**
	 * 
	 */
	public SetBean getAllinfo()
	{
		try {
			String sql = "select * from t_settings";
			ct = new ConnDb().getConn();
			sm = ct.createStatement();
			rs = sm.executeQuery(sql);
			if(rs.next()){
				sb.setId(rs.getString(1));
				sb.setWarnNum(rs.getInt(2));
				sb.setMaxSelNum(rs.getInt(3));
				sb.setGraduateGrade(rs.getString(4));
				sb.setAlternative(rs.getInt(5));
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			
		}
		return sb;
	}
	
	
}
