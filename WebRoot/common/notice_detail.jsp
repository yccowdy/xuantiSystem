<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String noticeId = request.getParameter("noticeId");
	NoticeBean nb = new NoticeBeanCl().getNoticeById(noticeId);
 %>
<table width="90%" height="800" border="0" cellpadding="0"
	cellspacing="0">
	<tr height="30px"></tr>
	<tr height="50px">
		<th colspan="3" bgcolor="#E6F3FF" align="center"><%=nb.getTitle() %>
		</th>
	</tr>
	<tr height="35" align="center">
		<td colspan="3" align="center">发布者：<%=nb.getPublisher() %>&nbsp;&nbsp;&nbsp;发布时间：<%=nb.getTime() %>
		</td>
	</tr>
	<tr height="200">
		<td colspan="3" height="100%"><textarea
				style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size:14px;"
				name="detail" readonly="readonly"><%=nb.getDetail() %></textarea></td>
	</tr>
	<tr height="30" align="center">
		<td colspan="3" scope="row" bgcolor="#E6F3FF"></td>
	</tr>
</table>