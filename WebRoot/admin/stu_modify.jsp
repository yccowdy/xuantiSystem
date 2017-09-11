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
			<td><input type="text" border="1" name="id" value=<%=sb.getId() %> ></td>
		</tr>
		<tr>
			<td width="100">密&nbsp;&nbsp;码</td>
			<td><input type="text" border="1" name="psw" value=<%=sb.getPsw() %> >
			</td>
		</tr>
		<tr>
			<td>姓&nbsp;&nbsp;名</td>
			<td><input type="text" border="1" name="name" value=<%=sb.getName()%> >
			</td>
		</tr>
		<tr>
			<td>性&nbsp;&nbsp;别</td>
			<td><select name="sex">
					<option value="男" <%=sb.getSex()==SEX.MALE?"selected":"" %>>男</option>
					<option value="女" <%=sb.getSex()==SEX.FEMALE?"selected":"" %>>女</option>
			</select></td>
		</tr>
		<tr>
			<td>班&nbsp;&nbsp;级</td>
			<td>&nbsp;&nbsp;<%=sb.getCls() %></td>
		</tr>
		<tr>
			<td>专&nbsp;&nbsp;业</td>
			<td>&nbsp;&nbsp;<%=sb.getMajor() %></td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><input type="text" border="1" name="phoneNum"
				value=<%=sb.getPhoneNum()%>>
			</td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><input type="text" border="1" name="email"
				value=<%=sb.getEmail()%>>
			</td>
		</tr>
		<tr>
			<td>选题权限</td>
			<td><select name="privilege">
				<option value="1" <%=sb.getPrivilege()==1 ? "selected":"" %> >正常</option>
				<option value="-1" <%=sb.getPrivilege()==-1 ? "selected":"" %>>禁止选题</option>
			</select></td>
		</tr>
		<tr>
			<td>已选题数</td>
			<td><%=sb.getSelectNum() %></td>
		</tr>

		<tr><td colspan="2" scope="col" height="20px"></td></tr>
			<tr align="center">
				<td><input type="submit" value="保存修改"></td>
				<td><input type="reset" value="重    置"></td>
			</tr>
	</table>
</form>
