package com.ax.subject.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ax.subject.model.*;

public class UpdateDataServlet extends HttpServlet {

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
		//获取操作指令
		String flag=request.getParameter("flag");
		String sql="";
		HttpSession session = request.getSession(true);
		if (flag.equals("student_info_modify")) {
			int id=Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			String cls = request.getParameter("selCls");
			String major = request.getParameter("major");
			String phoneNum = request.getParameter("phoneNum");
			String email = request.getParameter("email");
			sql = "update t_student set name='"+name+"',sex='"+sex+"',class = '"+cls+"',major = '"+major+"',phoneNum='"+phoneNum+"',email='"+email+"' where id='"+id+"'";
			System.out.println(sql);
			StudentBeanCl sbc = new StudentBeanCl();

			sbc.updateData(sql);   
			//修改之后更新session中的值
			session.setAttribute("user", sbc.getStudentById(id));
			request.getRequestDispatcher("student/student.jsp?function=info_view").forward(request, response);
		}else if(flag.equals("student_psw_modify")){
			int id = ((StudentBean)session.getAttribute("user")).getId();
			String newPsw = request.getParameter("newPsw1");
			sql = "update t_student set psw='"+newPsw+"' where id='"+id+"'";
			System.out.println("sql="+sql);
			StudentBeanCl sbc = new StudentBeanCl();
			sbc.updateData(sql);
			//修改之后更新session中的值
			session.setAttribute("user", sbc.getStudentById(id));
			request.getRequestDispatcher("student/student.jsp?function=info_view").forward(request, response);
		}
		else if(flag.equals("select_sub1")){
			StudentBean stuBean =(StudentBean) session.getAttribute("user") ;
			String stuId = stuBean.getId()+"";
			String wish = request.getParameter("wish_type");
			String subId = request.getParameter("subId");
			System.out.println("wish=="+wish);
			StudentSubjectBeanCl ssbc = new StudentSubjectBeanCl();
			ssbc.insertByStuIdWish1(subId,stuId, wish);
			response.sendRedirect("student/student.jsp?function=sub_all");
		}
		else if(flag.equals("select_sub"))
		{
			SubjectBeanCl sbc = new SubjectBeanCl();
			String subId = request.getParameter("subId");
			SubjectBean sb = sbc.getSubjectById(subId);
			int seledNum = sb.getSelectedNum();
			System.out.println("seledNum"+seledNum);
			String wish = request.getParameter("wish_type");
			StudentBean stuBean =(StudentBean) session.getAttribute("user") ;
			String stuId = stuBean.getId()+"";
			StudentSubjectBeanCl ssbc = new StudentSubjectBeanCl();
			if(ssbc.existSubIdStuId(subId, stuId)){//该学生已经选过该题
				if(wish.equals(ssbc.getWishBySubIdStuId(subId, stuId)))
				{//志愿与原来相同

				}else{//题目已选过，更改志愿类型
					int temp = ssbc.getSubIdByWish(wish, stuId);
					if(subId.equals(temp+""))
					{

					}else{
						//selectedNum-1
						sbc.updateSelectedNum(temp+"",-1);
					}
					ssbc.deleteByStuIdWish(stuId,wish);
					ssbc.updateWish(subId,stuId,wish);
				}
			}else{
				if(ssbc.getExistWish(wish, stuId)){
					int temp = ssbc.getSubIdByWish(wish, stuId);
					//selectedNum-1
					sbc.updateSelectedNum(temp+"",-1);
					ssbc.deleteByStuIdWish(stuId,wish);
					ssbc.insertByStuIdWish(subId,stuId,wish);
					sbc.updateSelectedNum(subId, +1);
					//selectNum+
				}else{
					ssbc.insertByStuIdWish(subId,stuId,wish);
					//selectNum+
					sbc.updateSelectedNum(subId, 1);
				}
			}
			response.sendRedirect("student/student.jsp?function=sub_all");
		}else if(flag.equals("screening")){
			String teacherName = request.getParameter("teacher");
			
			String Direction = request.getParameter("direction");
			String Title = request.getParameter("title");
			if(teacherName!=null && Direction==null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeacher(teacherName));

			}
			else if(teacherName==null&&Direction!=null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromDirection(Direction));
            }
			else if(teacherName==null&&Direction==null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTitle(Title));
            }
			else if(teacherName==null&&Direction!=null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromDirandTit(Direction,Title));
            }
			else if(teacherName!=null&&Direction!=null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDir(teacherName,Direction));
            }
			else if(teacherName!=null&&Direction==null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDir(teacherName,Title));
            }
			else if(teacherName!=null && Direction!=null&&Title!=null)
			{
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDirandTit(teacherName,Direction,Title));

			}

			response.sendRedirect("student/student.jsp?function=sub_all");
		}else if(flag.equals("screening1")){
            String teacherName = request.getParameter("teacher");
			
			String Direction = request.getParameter("direction");
			String Title = request.getParameter("title");
			if(teacherName!=null && Direction==null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeacher(teacherName));

			}
			else if(teacherName==null&&Direction!=null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromDirection(Direction));
            }
			else if(teacherName==null&&Direction==null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTitle(Title));
            }
			else if(teacherName==null&&Direction!=null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromDirandTit(Direction,Title));
            }
			else if(teacherName!=null&&Direction!=null&&Title==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDir(teacherName,Direction));
            }
			else if(teacherName!=null&&Direction==null&&Title!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDir(teacherName,Title));
            }
			else if(teacherName!=null && Direction!=null&&Title!=null)
			{
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDirandTit(teacherName,Direction,Title));

			}

			/*String teacherName = request.getParameter("teacher");
			
			String Direction = request.getParameter("direction");
			if(teacherName!=null && Direction==null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeacher(teacherName));

			}else if(teacherName==null&&Direction!=null){
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromDirection(Direction));

			}else if(teacherName!=null&&Direction!=null)
			{
				session.setAttribute("searchResult", new SubjectBeanCl().getAllSubFromTeaandDir(teacherName,Direction));

			}
*/
			response.sendRedirect("student/student.jsp?function=sub_all1");
			
		}else if(flag.equals("alternative")){
			int stuId=((StudentBean)session.getAttribute("user")).getId();
			StudentSubjectBeanCl ssbc =new StudentSubjectBeanCl();
			String[] checkv = (String[])request.getParameterValues("pick");

			if(checkv!=null){
				for(int i=0;i<checkv.length;i++){
					sql =" insert into t_stu_sub (sub_Id,stu_Id,wish) values ('"+checkv[i]+"','"+stuId+"','"+4+"')";
					new StudentSubjectBeanCl().updateData(sql);
				}
				response.sendRedirect("student/student.jsp?function=sub_all1");
			}
		}else if(flag.equals("deleteSub")){
			int stuId=((StudentBean)session.getAttribute("user")).getId();
			String subId = request.getParameter("subId");
			
			/*String wish =request.getParameter("wish");
			System.out.println("wish="+wish);*/
			SubjectBeanCl  sbc =new SubjectBeanCl();
			StudentSubjectBeanCl ssbc = new StudentSubjectBeanCl();
			ssbc.getWish(Integer.parseInt(subId), stuId);
			//调用函数删除题目
			if(ssbc.getWish(Integer.parseInt(subId), stuId)!=4){
			if(sbc.delSubjectById(stuId+"", subId)){
				//删除成功
				
					sbc.updateSelectedNum(subId, -1);
				
				response.sendRedirect("student/student.jsp?function=chakan_choose");
			}
			}else{
				if(sbc.delSubjectById(stuId+"", subId)){
					//删除成功
					
						
					
					response.sendRedirect("student/student.jsp?function=chakan_choose");
				}
			}
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
