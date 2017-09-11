package com.kk.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.StudentBeanCl;
import com.kk.subject.model.SubjectBean;
import com.kk.subject.model.SubjectBeanCl;
import com.kk.subject.model.TeacherBeanCl;
import com.kk.subject.model.TeacherSubBeanCl;

public class SubManageServlet extends HttpServlet {

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

		this.doPost(request, response);
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
		String flag = request.getParameter("flag");
		HttpSession session = request.getSession(true);

		if(flag.equals("sub_add")){
			String title=request.getParameter("title");
			String teaId=request.getParameter("teacher");
			String direction=request.getParameter("direction").trim();
			String introduction=request.getParameter("introduction").trim();
			String schedule=request.getParameter("schedule").trim();
			String reference=request.getParameter("reference").trim();
			String requirement=request.getParameter("requirement").trim();
			String domain=request.getParameter("domain").trim();
			//11.5
			String key=request.getParameter("key").trim();;
			String yuanxi=(String)session.getAttribute("yuanxi");
			String teaName = new TeacherBeanCl().getTeacherById(teaId).getName();

			SubjectBean subBean=new SubjectBean(title, teaName, direction, introduction, schedule, reference, requirement, domain, 0, 0,key,yuanxi);
			int subId = new SubjectBeanCl().insertSubject(subBean);	//题目表中插入一条记录,同时返回题目id
			new TeacherSubBeanCl().insertSubject(teaId, subId);		//题目老师关联表插入一条记录
			new TeacherBeanCl().updateData(" update t_teacher set subNum=subNum+1 where id='"+teaId+"'");//老师出题数目+1

			response.sendRedirect("admin/admin.jsp?function=sub_add");
		}else if(flag.equals("screeningSub")){//筛选显示的题目（审核状态）
			String viewType = request.getParameter("viewType");
			session.setAttribute("viewType", viewType);
			response.sendRedirect("teacher/teacher.jsp?function=sub_verify");
		}else if(flag.equals("batch_verify_sub")){//批量审核通过
			String[] checkv = (String[])request.getParameterValues("pick");
			if(checkv!=null)	new SubjectBeanCl().verifyByIds(checkv,1);

			response.sendRedirect("teacher/teacher.jsp?function=sub_verify");
		}else if(flag.equals("batch_not_pass")){//批量不通过
			String[] checkv = (String[])request.getParameterValues("pick");
			if(checkv!=null)	new SubjectBeanCl().verifyByIds(checkv,-1);

			response.sendRedirect("teacher/teacher.jsp?function=sub_verify");
		}
	}

}
