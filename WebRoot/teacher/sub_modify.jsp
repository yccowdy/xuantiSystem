<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	int id = Integer.parseInt(request.getParameter("id"));

	SubjectBean sb = new SubjectBeanCl().getSubjectById(id);
	response.setCharacterEncoding("UTF-8");
%>

<form action="TeaSubManageServlet?flag=sub_modify" method="post">
	<table width="100%" height="482" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="row" bgcolor="#E6F3FF">修改题目信息</th>
		</tr>
		
		<tr>
			<th colspan="2" scope="row"> <input type=hidden name="id" value=<%=sb.getId() %>> </th>
		</tr>
		<tr>
			<th width="30%" scope="row" height="30px">标 题</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="title"><%=sb.getTitle() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="30px">出题人</th>
			<td><%=sb.getTeacher() %></td>
		</tr>
		<!-- 11.5添加关键字 -->
		<tr height="30">
			<th width="30%" scope="row">关键词<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					id="key" name="key" ><%=sb.getkey() %></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row" height="30px">题目方向</th>
			<td><select name="direction">
				<%
				ArrayList al = new DirectionCl().getAllDirec();
				for (int i = 0; i < al.size(); i++) {
				%>
					<option value="<%=((Direction) al.get(i)).getDirection()%>" <%=((Direction) al.get(i)).getDirection().equals(sb.getDirection())?"selected":"" %>><%=((Direction) al.get(i)).getDirection()%></option>
				<%} %>
			</select></td>
		</tr>
		<tr>
			<th scope="row" height="120px">题目简介</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="introduction"><%=sb.getIntroduction() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">进程安排</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="schedule"><%=sb.getSchedule() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">参考文献</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="reference"><%=sb.getReference() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">学生要求</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="requirement"><%=sb.getRequirement() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="40px">所属领域</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="domain"><%=sb.getDomain() %></textarea></td>
		</tr>
		<tr>
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr>
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><input
				type="submit" value="保存修改">
			</th>
		</tr>
	</table>
</form>
