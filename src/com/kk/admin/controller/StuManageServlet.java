package com.kk.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.*;

public class StuManageServlet extends HttpServlet {

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
		//解决中文乱码的问题
		request.setCharacterEncoding("UTF-8");

		String flag = request.getParameter("flag");

		HttpSession session = request.getSession(true);

		if(flag.equals("add_major")){
			String major = request.getParameter("major").trim();
			String yuanxi=session.getAttribute("yuanxi").toString();
			if(!major.equals("")) new MajorBeanCl().insertMajor(major,yuanxi);
			response.sendRedirect("admin/admin.jsp?function=major_manage");
		}else if(flag.equals("del_major")){
			String id = request.getParameter("id").trim();
			if(!id.equals("")) new MajorBeanCl().delMajorById(id);
			response.sendRedirect("admin/admin.jsp?function=major_manage");
		}else if(flag.equals("add_cls")){
			String cls_id = request.getParameter("cls_id").trim();
			String major = request.getParameter("major").trim();
			String stuNum = request.getParameter("stuNum").trim();
			String yuanxi=session.getAttribute("yuanxi").toString();
			if(!cls_id.equals("")) new ClsBeanCl().insert(cls_id ,major, stuNum,yuanxi);
			response.sendRedirect("admin/admin.jsp?function=class_manage");
		}else if(flag.equals("del_cls")){
			String cls_id = request.getParameter("cls_id").trim();
			if(!cls_id.equals("")) new ClsBeanCl().delClsById(cls_id);
			response.sendRedirect("admin/admin.jsp?function=class_manage");
		}else if(flag.equals("batch_add_stu")){
			String cls = request.getParameter("cls").trim();
			String stuNum = request.getParameter("stuNum").trim();
			String yuanxi=session.getAttribute("yuanxi").toString();
			if(!cls.equals(""))	new StudentBeanCl().batchAddStu(cls, stuNum,yuanxi);
			response.sendRedirect("admin/admin.jsp?function=stu_add");
		}else if(flag.equals("add_stu")){
			int stuId = Integer.parseInt(request.getParameter("stuId").trim());
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String cls = request.getParameter("class");
			String major = request.getParameter("major");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			int privilege = Integer.parseInt(request.getParameter("privilege"));
			String yuanxi=session.getAttribute("yuanxi").toString();
			StudentBean sb = new StudentBean(stuId, stuId+"", name, SEX.toEnum(sex), cls, major, phoneNum, email, privilege, 0,yuanxi);
			new StudentBeanCl().insertByStudentBean(sb);
			response.sendRedirect("admin/admin.jsp?function=stu_add");
		}else if(flag.equals("QueryByCriteria")){
			String selMajor = request.getParameter("selMajor").trim();
			String selCls = request.getParameter("selCls").trim();
			session.setAttribute("selMajor", selMajor);
			session.setAttribute("selCls", selCls);
			response.sendRedirect("admin/admin.jsp?function=stu_all");
		}else if(flag.equals("stu_del")){
			String stuId = request.getParameter("stuId").trim();
			if(!stuId.equals("")) new StudentBeanCl().delStuById(stuId);
			response.sendRedirect("admin/admin.jsp?function=stu_all");
		}else if(flag.equals("stu_modify")){
			String id = request.getParameter("id");
			String psw = request.getParameter("psw");
			String name = request.getParameter("name");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			String privilege = request.getParameter("privilege");
			String sex = request.getParameter("sex");

			String sql = "update t_student set psw='"+psw+"',name='"+name+"',sex='"+sex+"',phoneNum='"+phoneNum+"',email='"+email+"',privilege='"+privilege+"' where id='"+id+"'";
			new StudentBeanCl().updateBySql(sql);
			response.sendRedirect("admin/admin.jsp?function=stu_all");
		}else if(flag.equals("batch_del_stu")){
			String[] checkv = (String[])request.getParameterValues("pick");
			String sql = "";
			if(checkv!=null){
				for(int i=0;i<checkv.length;i++){
					new StudentBeanCl().delStuById(checkv[i]);
				}
			}
			response.sendRedirect("admin/admin.jsp?function=stu_all");
		}else if(flag.equals("cls_modify")){
			//获取要输入的班级ID
			String cls_id = request.getParameter("cls_id");
			//获取输入的班级人数
			int stuNum = Integer.parseInt(request.getParameter("stuNum"));
			//获取输入的专业
			String major = request.getParameter("major");
			String yuanxi=session.getAttribute("yuanxi").toString();
			ClsBeanCl cbc = new ClsBeanCl();
//			1、删除班级(包含删除学生)
//			2、删除学生
//			3、插入学生
			//cbc.delClsById(cls_id);// WXP发现有问题，没有删除student表中原有的学生信息
			//new StudentBeanCl().batchDelByClsId(cls_id);
			cbc.insertCls(cls_id, major, stuNum+"",yuanxi);//WXP发现有问题，插入信息没有学生的姓名
			response.sendRedirect("admin/admin.jsp?function=class_manage");
		}else if(flag.equals("screening")){
			
			
			String major = request.getParameter("selMajor").trim();
			String cls = request.getParameter("selClass").trim();
			if(major==null || "".equals(major)) major="0";
			if(cls==null || "".equals(cls)) cls="0";
			//session.setAttribute("searchResult", new TeacherBeanCl().getTeacherByNameAndDept(teacherName,selDepartment));
			session.setAttribute("searchResult", new StuSubTeaBeanCl().getFailedStu(major, cls));
			session.setAttribute("selMajor", major);
			session.setAttribute("selClass", cls);
			response.sendRedirect("admin/admin.jsp?function=fail_stu");
		}

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

		doGet(request, response);
	}

}
