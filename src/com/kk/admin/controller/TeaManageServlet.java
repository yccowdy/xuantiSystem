package com.kk.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.*;

public class TeaManageServlet extends HttpServlet {

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

		HttpSession session = request.getSession(true);
		String flag=request.getParameter("flag");

		String sql="";
		if(flag.equals("tea_add")){
			String id = request.getParameter("teaId");
			String psw = request.getParameter("psw");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			String jobTitle = request.getParameter("jobTitle");
			String maxSubNum = request.getParameter("maxSubNum").trim();
			//String department = request.getParameter("department");
			String department=session.getAttribute("yuanxi").toString();
			//System.out.println(department);
			System.out.println(department);
			String type = request.getParameter("type").trim();
			TeacherBean tb = new TeacherBean(id, psw, name, SEX.toEnum(sex), phoneNum, email, jobTitle,
					0, Integer.parseInt(maxSubNum),department,Integer.parseInt(type));
			new TeacherBeanCl().insertByTb(tb);
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}else if(flag.equals("admin_add")){
			String id = request.getParameter("adminId");
			String psw = request.getParameter("psw");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			String department = request.getParameter("yuanxi").trim();
			AdminBean ad = new AdminBean(id, psw, name, 1,sex, phoneNum, email,department);
			new AdminBeanCl().insertByTb(ad);
			response.sendRedirect("sadmin/admin.jsp?function=admin_all");
		}else if(flag.equals("tea_del")){
			String teaId = request.getParameter("teaId").trim();
			new TeacherBeanCl().delTeacherById(teaId);
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}else if(flag.equals("batch_del_tea")){
			//获取选中的老师id
			String[] checkv = (String[])request.getParameterValues("pick");
			if(checkv!=null){
				for(int i=0;i<checkv.length;i++){
					new TeacherBeanCl().delTeacherById(checkv[i]);
				}
			}
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}else if(flag.equals("tea_modify")){
			String id = request.getParameter("id");
			String psw = request.getParameter("psw");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			String jobTitle = request.getParameter("jobTitle");
			String subNum = request.getParameter("subNum");
			String maxSubNum = request.getParameter("maxSubNum").trim();
			String department=session.getAttribute("yuanxi").toString();
			String type = request.getParameter("type").trim();

			TeacherBean tb = new TeacherBean(id, psw, name, SEX.toEnum(sex), phoneNum, email, jobTitle,
					Integer.parseInt(subNum), Integer.parseInt(maxSubNum),department,Integer.parseInt(type));
			new TeacherSubBeanCl().updateTeacherName(id,name);//题目表的出题人更新
			new TeacherBeanCl().modifyByTb(tb);
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}else if(flag.equals("screening")){
			
			String teacherName = request.getParameter("teacher").trim();
			String selDepartment = session.getAttribute("yuanxi").toString();
			if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
			if(teacherName==null) teacherName="";
			session.setAttribute("searchResult", new TeacherBeanCl().getTeacherByNameAndDept(teacherName,selDepartment));
			session.setAttribute("selDepartment", selDepartment);
			session.setAttribute("teacher", teacherName+"");
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}else if(flag.equals("screening1")){
			//WXP加了获取年份 getSubjectByYear JSP页面也做了相应的修改
			String teacherName = request.getParameter("teacher").trim();
			String selDepartment = request.getParameter("selDepartment").trim();
			String key=request.getParameter("key").trim();
		    String year=request.getParameter("year").trim();
			if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
			if(teacherName==null) teacherName="";
			if(key==null) key="";
			if(year==null) year="";
			//session.setAttribute("searchResult", new TeacherBeanCl().getTeacherByNameAndDept(teacherName,selDepartment));
			session.setAttribute("searchResult", new SubjectBeanCl().getSubjectByYear(teacherName,selDepartment,key,year));
			session.setAttribute("selDepartment", selDepartment);
			session.setAttribute("teacher", teacherName+"");
			session.setAttribute("key", key+"");
			session.setAttribute("year", year+"");
			response.sendRedirect("admin/admin.jsp?function=sub_all1");
		}else if(flag.equals("screening2")){
			//WXP加了获取年份
			String teacherName = request.getParameter("teacher").trim();
			String selDepartment = request.getParameter("selDepartment").trim();
			String key=request.getParameter("key").trim();
			//String year=request.getParameter("year").trim();
			if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
			if(teacherName==null) teacherName="";
			//if(year==null) year="";
			//session.setAttribute("searchResult", new TeacherBeanCl().getTeacherByNameAndDept(teacherName,selDepartment));
			session.setAttribute("searchResult", new SubjectBeanCl().getSubjectByNameAndDept(teacherName,selDepartment,key));
			session.setAttribute("selDepartment", selDepartment);
			session.setAttribute("teacher", teacherName+"");
			response.sendRedirect("admin/admin.jsp?function=choose_state");
		}else if(flag.equals("QueryByCriteria")){
			String selDepartment = request.getParameter("selDepartment").trim();
			session.setAttribute("selDepartment", selDepartment);
			response.sendRedirect("admin/admin.jsp?function=tea_all");
		}
	}

}
