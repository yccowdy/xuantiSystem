package com.kk.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kk.subject.model.*;

import java.sql.Date;;
public class NoticeManageServlet extends HttpServlet {

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
		String flag = request.getParameter("flag");
		if(flag.equals("add_notice")){
			String title = request.getParameter("title");
			String publisher = request.getParameter("publisher");
			String strTime = request.getParameter("time");
			String detail = request.getParameter("detail");
			Date time = Tools.strToDate(strTime);
			NoticeBean nb = new NoticeBean(title,publisher,time,detail);
			int noticeId = new NoticeBeanCl().insertNoticeBean(nb);
			response.sendRedirect("admin/admin.jsp?function=../common/notice_detail&noticeId="+noticeId);
		}else if(flag.equals("batch_del_notice")){
			String[] checkv = (String[])request.getParameterValues("pick");
			if(checkv!=null){
				for(int i=0;i<checkv.length;i++){
					new NoticeBeanCl().delMoticeById(checkv[i]);
				}
			}
			response.sendRedirect("admin/admin.jsp?function=notice_all");
		}
	}

}
