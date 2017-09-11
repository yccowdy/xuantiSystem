package com.ax.subject.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Tools {

	public static Date stringToDate(String time){
		Date date=null;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			date=sdf.parse(time);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return date;
	}
}
