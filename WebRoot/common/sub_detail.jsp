<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>��Ŀ��ϸ��Ϣ</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>

<%
int s_id=Integer.parseInt(request.getParameter("id"));
SubjectBean sb = new SubjectBeanCl().getSubjectById(s_id);

 %>
  
<form action="javascript:self.close()" method="post">
	<table width="70%" height="482" border="1" cellpadding="0"
		cellspacing="0" align="center">
		<tr>
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><%=sb.getTitle() %></th>
		</tr>
		<tr>
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr>
			<th width="30%" scope="row">�� ��</th>
			<td align="center"><%=sb.getTitle() %><%-- <textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="title" readonly="readonly"><%=sb.getTitle() %></textarea> --%></td>
		</tr>
		<!-- 11.5�ؼ��� -->
		<tr>
			<th width="30%" scope="row">�ؼ���</th>
			<td align="center"><%=sb.getkey() %><%-- <textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="title" readonly="readonly"><%=sb.getTitle() %></textarea> --%></td>
		</tr>
		<tr>
			<th scope="row">������</th>
			<td align="center"><%=sb.getTeacher()%></td>
		</tr>
		<tr>
			<th scope="row">��Ŀ����</th>
			<td align="center"><%=sb.getDirection() %></td>
		</tr>
		<tr>
			<th scope="row" height="120px">��Ŀ���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="introduction" readonly><%=sb.getIntroduction() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">���̰���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="schedule" readonly><%=sb.getSchedule() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">�ο�����</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="reference" readonly><%=sb.getReference() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">ѧ��Ҫ��</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="requirement" readonly><%=sb.getRequirement() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="50px">��������</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="domain" readonly><%=sb.getDomain() %></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row">����ʱ��</th>
			<td><%=sb.getTime() %></td>
		</tr>
		<tr>
			<th scope="row">&nbsp;</th>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><input type="submit" value="�ر�">
			</th>
		</tr>
	</table>
</form>
</html>
