package com.kk.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.*;

public class SettingsServlet extends HttpServlet {

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
		System.out.println("SettingsServlet：flag="+flag);

		HttpSession session = request.getSession(true);

		if(flag.equals("admin_psw_modify")){
			String id = ((AdminBean)session.getAttribute("user")).getId();
			String newPsw = request.getParameter("newPsw1");
			String sql = "update t_admin set psw='"+newPsw+"' where id='"+id+"'";

			AdminBeanCl abc = new AdminBeanCl();
			abc.updateData(sql);

			//修改之后更新session中的值
			session.setAttribute("user", abc.getAdminById(id));
			response.sendRedirect("admin/admin.jsp?function=attentions");
		}else if(flag.equals("setStage")){
			String[] strStartTime = request.getParameterValues("startTime");
			String[] strEndTime = request.getParameterValues("endTime");
			/*for(int i=0;i<strStartTime.length;i++){
				System.out.println(strStartTime[i]+"|+i+|"+strEndTime[i]);
			}*/
			new StageBeanCl().setStage(strStartTime,strEndTime);
			response.sendRedirect("admin/admin.jsp?function=stage");

		}else {
			if(flag.equals("warnNum")){
				String warnNum = request.getParameter("warnNum").trim();
				if(!warnNum.equals(""))	new SettingsCl().setWarnNum(warnNum);
			}else if(flag.equals("maxSelNum")){
				String maxSelNum = request.getParameter("maxSelNum").trim();
				if(!maxSelNum.equals(""))	new SettingsCl().setMaxSelNum(maxSelNum);
			}else if(flag.equals("del_direc")){
				String d_id = request.getParameter("id");
				int id = Integer.parseInt(d_id);
				new DirectionCl().delById(id);
			}else if(flag.equals("add_direc")){
				String direction = request.getParameter("direction").trim();
				if(!direction.equals("")) new DirectionCl().insertDirec(direction);
			}else if(flag.equals("graduateGrade")){
				String graduateGrade = request.getParameter("graduateGrade").trim();
				if(!graduateGrade.equals(""))	new SettingsCl().setGraduateGrade(graduateGrade);
			}else if(flag.equals("add_jobTitle")){
				String jobTitle = request.getParameter("jobTitle").trim();
				if(!jobTitle.equals("") && !(new JobTitleBeanCl()).jtExist(jobTitle)) new JobTitleBeanCl().insertJt(jobTitle);
			}else if(flag.equals("del_jobTitle")){
				String jobTitle = request.getParameter("jobTitle").trim();
				if(!jobTitle.equals("")) new JobTitleBeanCl().delJt(jobTitle);
			}else if(flag.equals("add_dep")){
				String department = request.getParameter("department");
				if(null!=department && !"".equals(department)) new DepartmentCl().addDep(department);
			}else if(flag.equals("del_dep")){
				String id = request.getParameter("id");
				if(null!=id && !"".equals(id)) new DepartmentCl().delDepById(id);
			}
			response.sendRedirect("admin/admin.jsp?function=settings");
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

		this.doGet(request, response);
	}

}
