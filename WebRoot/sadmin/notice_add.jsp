<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			response.setCharacterEncoding("UTF-8");
%>
<form action="NoticeManageServlet?flag=add_notice" method="post">
	<table width="100%" height="800" border="1" cellpadding="0"
		cellspacing="0">
		<tr height="30">
			<th colspan="3" scope="row" bgcolor="#E6F3FF">发布新通知</th>
		</tr>
		<tr height="30">
			<th colspan="3" scope="row">&nbsp;</th>
		</tr>
		<tr>
			<td align="center" width="20%">标题</td>
			<th width="80%" height="37" colspan="2" scope="col"><div
					align="center">
					<textarea
						style="width: 100%; height: 100%; overflow: auto; border: 0px;"
						name="title"></textarea>
				</div>
			</th>
		</tr>
		<tr height="35" align="center">
			<td colspan="3" align="center">发布者：<textarea
					style="width: 20%; height: 80%; overflow: auto; border:solid 1px; resize:none;"
					name="publisher">管理员</textarea> &nbsp;&nbsp;&nbsp;发布时间： <input
				name="time" type="text" value="<%=(new java.sql.Date(System.currentTimeMillis())) %>" onClick="WdatePicker()" />
			</td>
		</tr>
		<tr height="200">
			<td colspan="3" height="100%"><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="detail"></textarea></td>
		</tr>
		<tr height="30" align="center">
			<td colspan="3" scope="row" bgcolor="#E6F3FF"><input
				type="submit" value="发&nbsp;&nbsp;布">
			</td>
		</tr>
	</table>
</form>