<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<table border="1">
	<%
		HttpSession hs = request.getSession(true);

		TeacherBean tb = (TeacherBean) hs.getAttribute("user");

	%>
	<tr>
		<td>账&nbsp&nbsp号</td>
		<td><%=tb.getId() %></td>
	</tr>
	<tr>
		<td>姓&nbsp&nbsp名</td>
		<td><%=tb.getName() %></td>
	</tr>
	<tr>
		<td>性&nbsp&nbsp别</td>
		<td><%=SEX.toStringValue(tb.getSex())+"" %></td>
	</tr>
	<tr>
		<td>电话号码</td>
		<td><%=tb.getPhoneNum() %></td>
	</tr>
	<tr>
		<td>电子邮箱</td>
		<td><%=tb.getEmail() %></td>
	</tr>
	<tr>
		<td>职&nbsp&nbsp称</td>
		<td><%=tb.getJobTitle() %></td>
	</tr>
	<tr>
		<td>最大出题数</td>
		<td><%=tb.getMaxSubNum() %></td>
	</tr>

</table>
