<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<form action="InfoManageServlet?flag=teacher_info_modify" method="post">

	<table border="1">
		<%
			HttpSession hs = request.getSession(true);

			TeacherBean tb = (TeacherBean) hs.getAttribute("user");

			response.setCharacterEncoding("UTF-8");

			String[] jtArr = new JobTitleBeanCl().getAllJT();
			
		%>
		<tr>
			<td width="100">账&nbsp&nbsp号</td>
			<td><input type="text" border="1" name="id"
				value=<%=tb.getId()%> readonly="readonly"></td>
		</tr>
		<tr>
			<td>姓&nbsp&nbsp名</td>
			<td><input type="text" border="1" name="name"
				value=<%=tb.getName()%>></td>
		</tr>
		<tr>
			<td>性&nbsp&nbsp别</td>
			<td><select name="sex">
					<option value="男" <%=tb.getSex() == SEX.MALE ? "selected" : ""%>>男</option>
					<option value="女" <%=tb.getSex() == SEX.FEMALE ? "selected" : ""%>>女</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><input type="text" border="1" name="phoneNum"
				value=<%=tb.getPhoneNum()%>></td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><input type="text" border="1" name="email"
				value=<%=tb.getEmail()%>></td>
		</tr>
		<tr>
			<td>职&nbsp&nbsp称</td>
			<td><select name="jobTitle">
					<%
						for (int i = 0; i < jtArr.length; i++) {
					%>
					<option value=<%=jtArr[i]%>	<%=jtArr[i].equals(tb.getJobTitle()) ? "selected" : ""%>><%=jtArr[i]%></option>
					<%
						}
					%>
			</select>
			</td>
		</tr>
		<tr>
			<td>最大出题数</td>
			<td><%=tb.getMaxSubNum()%></td>
		</tr>

		<h1>
			<tr align="center">
				<td><input type="submit" value="保存修改">
				</td>
				<td><input type="reset" value="重    置">
				</td>
			</tr>
	</table>
</form>