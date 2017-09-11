package com.common.controller;



import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kk.subject.model.SubjectBean;
import com.kk.subject.model.SubjectBeanCl;
import com.kk.subject.model.ExportExcel;

/**
 * @author leno 使用servlet导出动态生成的excel文件，数据可以来源于数据库
 *         这样，浏览器客户端就可以访问该servlet得到一份用java代码动态生成的excel文件
 */
public class ExportServlet extends HttpServlet {
    static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        /*File file = new File(getServletContext()
                .getRealPath("WEB-INF/book.jpg"));*/
        response.setContentType("aapplication/x-xls;charset=utf-8");
        /*response.addHeader("Content-Disposition",
                "attachment;filename=test.xls");*/
        response.addHeader("content-type","application/x-xls");//
        response.addHeader("Content-Disposition",
        		"attachment;filename="+"\""+ new String(("毕业题目表.xls").getBytes("GB2312"),
        				"iso8859-1")+ "\""); 
        // 测试图书
        ExportExcel<SubjectBean> ex = new ExportExcel<SubjectBean>();
        String[] headers = { "编号", "题目名称", "出题老师", "方向", "介绍", "计划",
                "参考文献" ,"学生要求","所属领域","出题时间","审核状态","已经选题人数"};
        ArrayList<SubjectBean> alsb =new SubjectBeanCl().getAllSub(yuanxi);
        
        try {
/*            BufferedInputStream bis = new BufferedInputStream(
                    new FileInputStream(file));
            byte[] buf = new byte[bis.available()];
            while ((bis.read(buf)) != -1) {
                // 将图片数据存放到缓冲数组中
            }*/
          
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
