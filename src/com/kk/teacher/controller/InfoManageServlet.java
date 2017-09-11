package com.kk.teacher.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ax.subject.model.SubjectBeanCl;
import com.kk.subject.model.*;

public class InfoManageServlet extends HttpServlet {

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
		//老师信息修改
		if (flag.equals("teacher_info_modify")) {

			String id = request.getParameter("id");
			String name = request.getParameter("name").trim();
			String sex = request.getParameter("sex");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			String jobTitle = request.getParameter("jobTitle");

			sql = "update t_teacher set name='"+name+"',sex='"+sex+"',phoneNum='"+phoneNum+"',email='"+email+"',jobTitle='"+jobTitle+"' where id='"+id+"'";

			TeacherBeanCl tbc = new TeacherBeanCl();
			//判断名字是否改变
			String oldName = tbc.getTeacherById(id).getName();
			if(!oldName.equals(name)){
				//更改已出题目的出题人名字
				new TeacherSubBeanCl().updateTeacherName(id,name);
			}
			//更新老师信息
			tbc.updateData(sql);
			TeacherBean tb = tbc.getTeacherById(id);
			
			//修改之后更新session中的值
			session.setAttribute("user", tb);
			response.sendRedirect("teacher/teacher.jsp?function=info_view");
		}else if(flag.equals("teacher_psw_modify")){
			String id = ((TeacherBean)session.getAttribute("user")).getId();
			String newPsw = request.getParameter("newPsw1");
			sql = "update t_teacher set psw='"+newPsw+"' where id='"+id+"'";

			System.out.println("sql="+sql);

			TeacherBeanCl tbc = new TeacherBeanCl();
			tbc.updateData(sql);

			//修改之后更新session中的值
			session.setAttribute("user", tbc.getTeacherById(id));

			request.getRequestDispatcher("teacher/teacher.jsp?function=info_view").forward(request, response);
		}
	}

}
