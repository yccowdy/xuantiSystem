package com.kk.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kk.subject.model.*;

public class AssignServlet extends HttpServlet {

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

		request.setCharacterEncoding("UTF-8");
		//获取操作指令
		String flag=request.getParameter("flag");
		
		if(flag.equals("assign")){//指定学生和题目的指派
			String stuId = request.getParameter("pickStu");
			String subId = request.getParameter("pickSub");
			int i=new StuSubBeanCl().assignByStuIdSubId(stuId, subId);
			
			response.sendRedirect("admin/admin.jsp?function=fail");
		}else if(flag.equals("repeal")){
			String stuId = request.getParameter("stuId");
			String subId = request.getParameter("subId");
			int i = new StuSubBeanCl().repealAssign(stuId, subId);
			
			response.sendRedirect("admin/admin.jsp?function=choose_result");
		}else if(flag.equals("repeal1")){
			String stuId = request.getParameter("stuId");
			String subId = request.getParameter("subId");
			int i = new StuSubBeanCl().repealAssign(stuId, subId);
			
			response.sendRedirect("teacher/teacher.jsp?function=choose_stu1");
		}else if(flag.equals("autoAssign")){
			new StuSubTeaBeanCl().autoAssign();
			response.sendRedirect("admin/admin.jsp?function=fail");
		}else if(flag.equals("randomAssign")){
			new StuSubTeaBeanCl().randomAssign();
			response.sendRedirect("admin/admin.jsp?function=fail");
		} 
	}

}
