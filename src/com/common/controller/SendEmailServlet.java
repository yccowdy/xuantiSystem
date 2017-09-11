package com.common.controller;
import com.ax.*;
import com.ax.subject.model.StudentBean;
import com.ax.subject.model.StudentBeanCl;
import com.kk.subject.model.TeacherBeanCl;

import email.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import java.sql.*;
import javax.mail.*;
import javax.activation.*;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;


public class SendEmailServlet extends HttpServlet {


	//Process the HTTP Post request
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id=request.getParameter("id");
		String email = request.getParameter("email");
		StudentBeanCl sbc = new StudentBeanCl();
		TeacherBeanCl tbc = new TeacherBeanCl();
		if(sbc.checkEmail(id, email) || tbc.checkEmail(id,email)){
			String psw="";
			if(tbc.checkEmail(id,email)) {
				psw = tbc.getTeacherById(id).getPsw();
			}else{
				psw = sbc.getStudentById(id).getPsw();
			}
			MailSenderInfo mailInfo = new MailSenderInfo();
			mailInfo.setMailServerHost("smtp.sina.com.cn"); 
			mailInfo.setMailServerPort("25"); 
			mailInfo.setValidate(true); 
			mailInfo.setUserName("a20101001698@sina.com"); 
			mailInfo.setPassword("ts9unha8");//您的邮箱密码 
			mailInfo.setFromAddress("a20101001698@sina.com"); 
			mailInfo.setToAddress(email); 
			mailInfo.setSubject("密码找回"); 
			mailInfo.setContent("你的密码为"+psw+",请妥善保管好您的密码。\n\n\t\t\t此为系统邮件，请勿回复!"); 
			
			//这个类主要来发送邮件　　
			SimpleMailSender sms = new SimpleMailSender();
			sms.sendTextMail(mailInfo);//发送文体格式 
//			sms.sendHtmlMail(mailInfo);//发送html格式　

			
			request.getRequestDispatcher("login.jsp").forward(request, response);
			//System.out.println("你的密码为"+psw+",请妥善保管好您的密码。\n\n\t\t\t此为系统邮件，请勿回复!");

		}else{

			//邮箱与用户名不匹配
			String err="账号与邮箱不匹配 ！请重新输入";
			request.getRequestDispatcher("Found.jsp?err="+err).forward(request, response);

		}


	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}
	//Clean up resources
	public void destroy() {
	}

}
