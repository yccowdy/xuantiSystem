package com.common.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.*;

public class ExistCheckServlet extends HttpServlet {

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

		String b="false";

		if(flag.equals("stu_exist_check")){
			String stuId = request.getParameter("stuId");
			if(new StudentBeanCl().checkExist(stuId)) b="true";
		}else if(flag.equals("tea_exist_check")){
			String teaId = request.getParameter("teaId");
			if(new TeacherBeanCl().checkExist(teaId)) b="true";
		}else if(flag.equals("admin_exist_check")){
			String adminId = request.getParameter("adminId");
			if(new AdminBeanCl().checkExist(adminId)) b="true";
		}
		else if(flag.equals("title_exist_check")){
			/*返回检测结果：
			 * limited:已达最大出题数
			 * false：题目不存在，可以出题
			 * self：自己已经出了这道题，可以修改
			 * true：其他老师已经出了这道题
			 */
			String teaId = request.getParameter("teaId").trim();
			String title = request.getParameter("title").trim();
			System.out.println("title="+title);
			TeacherBean tb = new TeacherBeanCl().getTeacherById(teaId);
			if(tb.getMaxSubNum()<=tb.getSubNum()){
				b="limited";
			}else{
				b = new TeacherSubBeanCl().titleExistCheck(teaId,title);
			}
		}else if(flag.equals("phoneNum_exist_check")) {
			/*
			 * 
			 */
			String id = request.getParameter("id").trim();
			String pm = request.getParameter("phoneNum").trim();
			b = new com.ax.subject.model.StudentBeanCl().phoneNumberExitCheck(id,pm);
		}else if(flag.equals("email_exist_check")){
			
			String id = request.getParameter("id").trim();
			String email = request.getParameter("email").trim();
			b = new com.ax.subject.model.StudentBeanCl().emaliExitCheck(id,email);
		}
			

		response.getWriter().print(b);

	}
}
