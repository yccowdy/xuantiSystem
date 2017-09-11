import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kk.subject.model.SubjectBeanCl;
import com.kk.subject.model.TeacherBean;

  
public class TSMServlet extends HttpServlet {

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
				String t_id=((TeacherBean)session.getAttribute("user")).getId();
				 if(flag.equals("sub_modify1")){
						String id = request.getParameter("id");
						String title = request.getParameter("title");
						String direction = request.getParameter("direction");
						String introduction = request.getParameter("introduction");
						String schedule = request.getParameter("schedule");
						String reference = request.getParameter("reference");
						String requirement = request.getParameter("requirement");
						String domain = request.getParameter("domain");
						java.sql.Date time = new java.sql.Date(System.currentTimeMillis());
						sql = "update t_subject set title='"+title+"',direction='"+direction+"',introduction='"+introduction
								+"',schedule='"+schedule+"',reference='"+reference+"',requirement='"+requirement
								+"',domain='"+domain+"',time='"+time+"',state='1' where id='"+id+"'";
						new SubjectBeanCl().modifySubject(sql);
						//跳转到我的题目
						/*response.sendRedirect("teacher.jsp?function=choose_stu1");*/
						response.sendRedirect("modify_success.jsp");
					}
	}

}
