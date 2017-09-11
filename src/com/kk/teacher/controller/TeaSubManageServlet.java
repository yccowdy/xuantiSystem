package com.kk.teacher.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.SubjectBean;
import com.kk.subject.model.SubjectBeanCl;
import com.kk.subject.model.TeacherBean;
import com.kk.subject.model.TeacherBeanCl;
import com.kk.subject.model.TeacherSubBeanCl;

public class TeaSubManageServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//解决中文乱码的问题
		request.setCharacterEncoding("UTF-8");
		
		//获取操作指令
		String flag=request.getParameter("flag");
		String sql="";

		HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(1800);//11.7WXP
		String t_id=((TeacherBean)session.getAttribute("user")).getId();
		if(flag.equals("sub_modify")){
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String direction = request.getParameter("direction");
			String introduction = request.getParameter("introduction");
			String schedule = request.getParameter("schedule");
			String reference = request.getParameter("reference");
			String requirement = request.getParameter("requirement");
			String domain = request.getParameter("domain");
			String key=request.getParameter("key");//11.5
			java.sql.Date time = new java.sql.Date(System.currentTimeMillis());
			sql = "update t_subject set title='"+title+"',direction='"+direction+"',introduction='"+introduction
					+"',schedule='"+schedule+"',reference='"+reference+"',requirement='"+requirement
					+"',domain='"+domain+"',time='"+time+"',keyNum='"+key+"' where id='"+id+"'";//11.5
			new SubjectBeanCl().modifySubject(sql);

			//跳转到我的题目
			response.sendRedirect("teacher/teacher.jsp?function=sub_mine");
		}else if(flag.equals("sub_modify1")){
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String direction = request.getParameter("direction");
			String introduction = request.getParameter("introduction");
			String schedule = request.getParameter("schedule");
			String reference = request.getParameter("reference");
			String requirement = request.getParameter("requirement");
			String domain = request.getParameter("domain");
			java.sql.Date time = new java.sql.Date(System.currentTimeMillis());
			sql = "update t_subject set title='"+title+"',direction='"+direction+"',introduction='"+introduction
					+"',schedule='"+schedule+"',reference='"+reference+"',requirement='"+requirement
					+"',domain='"+domain+"',time='"+time+"',state='1' where id='"+id+"'";
			new SubjectBeanCl().modifySubject(sql);
			//跳转到我的题目
			response.sendRedirect("teacher/sub_modify1.jsp");
		}
		
		
		else if(flag.equals("sub_add")){
			String title=request.getParameter("title");
			String teacher=request.getParameter("teacher");
			String direction=request.getParameter("direction");
			String introduction=request.getParameter("introduction");
			String schedule=request.getParameter("schedule");
			String reference=request.getParameter("reference");
			String requirement=request.getParameter("requirement");
			//wxp 11.5号加入关键字
			String key=request.getParameter("key");
			String yuanxi=session.getAttribute("yuanxi").toString();
			String aa[]=request.getParameterValues("domain");
			String domain="";
			int i;
			for(i=0;i<aa.length-1;i++)
			{  domain=domain.concat(aa[i])+",";
			
			}
			if(i==aa.length-1) domain=domain.concat(aa[i]);
			SubjectBean subBean=new SubjectBean(title, teacher, direction, introduction, schedule, reference, requirement, domain, 0, 0,key,yuanxi);
			int s_id = new SubjectBeanCl().insertSubject(subBean);	//题目表中插入一条记录,同时返回题目id
			new TeacherSubBeanCl().insertSubject(t_id, s_id);		//题目老师关联表插入一条记录
			new TeacherBeanCl().updateData(" update t_teacher set subNum=subNum+1 where id='"+t_id+"'");//老师出题数目+1

			//添加成功后跳转到我的题目
			response.sendRedirect("teacher/teacher.jsp?function=sub_mine");
		}else if(flag.equals("sub_del")){
			String id=request.getParameter("id");
			new SubjectBeanCl().delSubjectById(id);
			new TeacherBeanCl().updateData("update t_teacher set subNum=subNum-1 where id='"+t_id+"'");//老师出题数目-1
			//删除成功后跳转到我的题目
			response.sendRedirect("teacher/teacher.jsp?function=sub_mine");
		}
	}

}
