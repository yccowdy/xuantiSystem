package com.common.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kk.subject.model.ExportExcel;
import com.kk.subject.model.StuSubTeaBean;
import com.kk.subject.model.StuSubTeaBeanCl;
import com.kk.subject.model.SubjectBean;
import com.kk.subject.model.SubjectBeanCl;

public class ExportServlet1 extends HttpServlet {

	 static final long serialVersionUID = 1L;

	    protected void doGet(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        /*File file = new File(getServletContext()
	                .getRealPath("WEB-INF/book.jpg"));*/
	        response.setContentType("application/x-xls;charset=utf-8");//"octets/stream"
	        /*response.addHeader("Content-Disposition",
	                "attachment;filename=test.xls");*/
	        response.addHeader("Content-Disposition",
	        		"attachment;filename="+"\""+ new String(("毕业生选题结果表.xls").getBytes("GB2312"),
	        				"iso8859-1")+ "\""); 
	        ExportExcel ex = new ExportExcel();
	        String[] headers = { "班级序号","题目编号", "志愿", "学生姓名", "教师姓名","题目","状态"};
	        ArrayList alsb =new StuSubTeaBeanCl().ExcelgetAllSSTB();
	        
	        try {        
	          
	            OutputStream out = response.getOutputStream();
	            ex.exportExcel(headers, alsb, out);
	            out.close();
	            System.out.println("excel导出成功！");
	        } catch (FileNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }

	    protected void doPost(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        doGet(request, response);
	    }

}
