package com.kk.teacher.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kk.subject.model.StuSubTeaBeanCl;

public class ChooseStuServlet extends HttpServlet {

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
		
		StuSubTeaBeanCl sstbc = new StuSubTeaBeanCl();
		
		if(flag.equals("chooseStu")){
			String subId = request.getParameter("subId");
			String stuId = request.getParameter("stuId");
			
			sstbc.chooseStu(stuId,subId);
			response.sendRedirect("teacher/teacher.jsp?function=choose_stu");
			
		}else if(flag.equals("repeal")){//撤销已选中的学生
			String subId = request.getParameter("subId");
			String stuId = request.getParameter("stuId");
			
			sstbc.repeal(stuId,subId);
			
			response.sendRedirect("teacher/teacher.jsp?function=choose_stu");
		}
	}

}
