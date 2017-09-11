<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <form action="StuManageServlet?flag=stu_modify" method="post">

	<table border="1">
		<%
			String stuId = request.getParameter("stuId");
			StudentBean sb = new StudentBeanCl().getStuById(stuId);
			response.setCharacterEncoding("UTF-8");
		%>
		<tr>
			<td width="100">账&nbsp;&nbsp;号</td>
			<td><%=sb.getId() %></td>
		</tr>
		<tr>
			<td width="100">密&nbsp;&nbsp;码</td>
			<td><%=sb.getPsw() %></td>
		</tr>
		<tr>
			<td>姓&nbsp;&nbsp;名</td>
			<td><%=sb.getName()%></td>
		</tr>
		<tr>
			<td>性&nbsp;&nbsp;别</td>
			<td><%=sb.getSex()%></td>
		</tr>
		<tr>
			<td>班&nbsp;&nbsp;级</td>
			<td><%=sb.getCls() %></td>
		</tr>
		<tr>
			<td>专&nbsp;&nbsp;业</td>
			<td><%=sb.getMajor() %></td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><%=sb.getPhoneNum()%></td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><%=sb.getEmail()%></td>
		</tr>
		<tr>
			<td>选题权限</td>
			<td><%=sb.getPrivilege()==1 ? "正常":"禁止选题" %></td>
		</tr>
		<tr>
			<td>已选题数</td>
			<td><%=sb.getSelectNum() %></td>
		</tr>
	</table>
</form>
