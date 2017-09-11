<%@page import="com.kk.subject.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//中文乱码问题
response.setCharacterEncoding("UTF-8");
%>

<script type="text/javascript">
	function delConf(){
		return window.confirm("删除专业将删除该专业的所有班级，确定要删除吗？");
	}
</script>

<form action="StuManageServlet?flag=add_major" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">所有专业</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">编号</div></td>
			<td width="40%"><div align="center">专业名称</div></td>
			<td width="40%"><div align="center">操作</div></td>
		</tr>
		<%
		String yx=session.getAttribute("yuanxi").toString();
			ArrayList al = new MajorBeanCl().getAllMajor(yx);
			for (int i = 0; i < al.size(); i++) {
		%>
		<tr>
			<td><div align="center"><%=((MajorBean) al.get(i)).getId()%></div>
			</td>
			<td><div align="center"><%=((MajorBean) al.get(i)).getMajor()%></div>
			</td>
			<td><div align="center">
					<a onclick="return delConf();"
						href="StuManageServlet?flag=del_major&id=<%=((MajorBean) al.get(i)).getId()%>">删除</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">添加专业名称</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					输入专业名称：<input type="text" name="major"><input
						type="submit" value="&nbsp;提&nbsp;交&nbsp;">
				</div></td>
		</tr>
	</table>
</form>