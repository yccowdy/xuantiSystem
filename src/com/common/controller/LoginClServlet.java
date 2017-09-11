package com.common.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ax.subject.model.*;

public class LoginClServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		// 获取session
		HttpSession session = request.getSession(true);
		// 设置有效时间，默认30分钟,可以不修改
		session.setMaxInactiveInterval(1800);

		String ver = (String) request.getSession().getAttribute("captcha");
		String ver1 = request.getParameter("ver").trim();
		String err = "";

		if (!ver.equals(ver1)) {
			err = "验证码错误！";
		} else {

			String type = request.getParameter("u_type");
			String id = request.getParameter("id").trim();
			String psw = request.getParameter("psw").trim();
			String gradute = new com.ax.subject.model.SetBeanCl().getAllinfo()
					.getGraduateGrade();
			// System.out.println(gradute);
			if (type.equals("tea")) {
				com.kk.subject.model.TeacherBeanCl tbc = new com.kk.subject.model.TeacherBeanCl();
				if (tbc.checkUser(id, psw)) {
					com.kk.subject.model.TeacherBean tb = tbc.getTeacherById(id);
					// 用户名和密码保存在session中
					session.setAttribute("user", tb);
					session.setAttribute("yuanxi", tb.getDepartment());
					response.sendRedirect("teacher/teacher.jsp?function=info_view");
					return;
				} else {
					err = "用户名或密码不正确！";
				}

			} else if (type.equals("stu")) {
				StudentBeanCl sbc = new StudentBeanCl();
//				if (sbc.checkGraduate(id, gradute)) {
//					System.out.println("sbc.checkGraduate(id, gradute)="
//							+ sbc.checkGraduate(id, gradute));
					if (sbc.checkUser(id, psw)) {
						StudentBean sb = (new StudentBeanCl()).getStudentById(id);
						session.setAttribute("user", sb);
						session.setAttribute("yuanxi", sb.getYuanxi());
						response.sendRedirect("student/student.jsp?function=info_view");
						System.out.println(gradute);
						return;
					} else {
						err = "用户名或密码不正确！";
					}
//				} else {
//					err = "不是本年级的学生，不能登入毕业选题系统";
//				}
			} else if (type.equals("admin")) {
				com.kk.subject.model.AdminBeanCl abc = new com.kk.subject.model.AdminBeanCl();
				if (abc.checkUser(id, psw)) {
					com.kk.subject.model.AdminBean ab = abc.getAdminById(id);
					session.setAttribute("user", ab);
					int t=ab.getType();
					String yuanxi=ab.getYuanxi();
					session.setAttribute("yuanxi",yuanxi);
					//System.out.println(t);
					//System.out.println(yuanxi);
					if (t==0) {
						response.sendRedirect("sadmin/admin.jsp?function=attentions");
					} else {
						response.sendRedirect("admin/admin.jsp?function=attentions");
					}

					return;
				} else {
					err = "用户名或密码不正确！";
				}
			}

		}
		if (!err.equals("")) {
			request.getRequestDispatcher("login.jsp?err=" + err).forward(
					request, response);
		}

	}

}
