package com.kk.subject.model;

import java.util.ArrayList;
import java.util.Collections;

import com.common.controller.MyComparator;

public class Tools {

	/**
     * @param 返回java.sql.Date格式的
     * */
	public static java.sql.Date strToDate(String strDate) {
       /*SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
        java.util.Date d = null;
        try {
            d = format.parse(strDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        java.sql.Date date = new java.sql.Date(d.getTime());
        return date;*/
		return java.sql.Date.valueOf(strDate);
    }
	
	/**
	 * 对ArrayList按照元素属性排序
	 * @param al 要排序的ArrayList
	 * @param attiName 按照元素的attiName属性排序
	 * @return 返回已经排序的ArrayList
	 */
	public static ArrayList sortArrayList(ArrayList al,String attiName){
		MyComparator mp = new MyComparator();
		mp.setAttiName(attiName);
		Collections.sort(al, mp);
		return al;
	}
	public static String getDescribeOfState(int state){
		switch(state){
		case -2:return "其他题目命中";
		case -1:return "老师已选其他学生";
		case 0:return "正在选题";
		case 1:return "命中";
		default:return "参数出错";
		}
	}
	
	public static String getDescribeOfState1(int state){
		switch(state){
		case -2:return "其他题目命中";
		case -1:return "老师已选其他学生";
		case 0:return "正在选题";
		case 1:return "命中";
		default:return "参数出错";
		}
	}
	/**
	 * 管理员根据选题状态获取操作的描述
	 *   正在选题：选择
	 *   其他题命中/已选其他学生/命中：撤销
	 * @param state 选题状态
	 * @return 对应操作的描述
	 */
	public static String getHandleDescribe(int state){
		switch(state){
		case -2:
		case -1:return "";
		case 1:return "撤销";
		case 0:return "命中";
		default:return "参数出错";
		}
	}
	
	/**
	 * 生成滚动通知内容
	 * @return 生成滚动通知内容
	 */
	public static String getScrollNotice(){
		
		int stage = new StageBeanCl().getCurrentStage();
		String describeOfStage = "";
		if(stage!=0){
			describeOfStage = new StageBeanCl().getdescribeOfStage(stage);
			describeOfStage = describeOfStage.replace("、", "").replace(stage+"", "");
			describeOfStage = "现在是"+describeOfStage+"";
		}else{
			//describeOfStage = "现在不在选题阶段，所有信息仅供浏览！";
	describeOfStage = "学生选题阶段，所有信息仅供浏览！";
		}
		return describeOfStage;
	}

}
