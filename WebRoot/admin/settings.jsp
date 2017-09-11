<%@page import="com.kk.subject.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Settings s = new SettingsCl().getSettings();
	response.setCharacterEncoding("UTF-8");
%>
<script type="text/javascript">
	function delConf(){
		return window.confirm("删除题目方向将删除所有该方向的题目，确定要删除吗？");
	}
	function delJtConf(){
		return window.confirm("删除职称会重置所有该职称教师的职称信息，确定要删除吗？");
	}
	function delDepConf(){
		return window.confirm("删除系名会重置所有该系教师的所属系信息，确定要删除吗？");
	}
</script>
<style>
span{
	color:#850B4B;
	font-size:15px;
}
</style>
<!-- 设置扎堆选题警告下限  -->
<form action="SettingsServlet?flag=warnNum" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">志愿扎堆提醒</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">当前提醒下界</div></td>
			<td width="35%"><%=s.getWarnNum()%></td>
		</tr>
		<tr align="center">
			<td><div>设置提醒下界</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="warnNum" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>（注：设置扎堆提醒志愿数，当选择某一题目的学生数超过提醒下界时，选择该题的学生将收到提醒，但是仍然可以选择此题。）</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;" /></td>
		</tr>
	</table>
</form>

<!-- 每道题能够被选的上限 -->
<form action="SettingsServlet?flag=maxSelNum" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">每道题被选上限</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">当前题目被选上限</div></td>
			<td width="35%"><%=s.getMaxSelNum()%></td>
		</tr>
		<tr align="center">
			<td><div>设置题目被选上限</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="maxSelNum" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>（注：设置每道题被选上限，当某道题被选择的学生数超过限制时，其他学生不能再选择该题。）</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;" /></td>
		</tr>
	</table>

</form>

<!-- 添加删除题目方向 -->
<form action="SettingsServlet?flag=add_direc" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">题目方向</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">编号</div></td>
			<td width="40%"><div align="center">题目方向</div></td>
			<td width="40%"><div align="center">操作</div></td>
		</tr>
		<%
			ArrayList al = new DirectionCl().getAllDirec();
			for (int i = 0; i < al.size(); i++) {
		%>
		<tr>
			<td><div align="center"><%=((Direction) al.get(i)).getId()%></div>
			</td>
			<td><div align="center"><%=((Direction) al.get(i)).getDirection()%></div>
			</td>
			<td><div align="center">
					<a onclick="return delConf();"
						href="SettingsServlet?flag=del_direc&id=<%=((Direction) al.get(i)).getId()%>">删除</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">添加题目方向</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					输入题目方向名：<input type="text" name="direction"><input
						type="submit" value="&nbsp;提&nbsp;交&nbsp;">
				</div></td>
		</tr>
	</table>
</form>
<!-- 添加删除 系名 -->
<form action="SettingsServlet?flag=add_dep" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">系名</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">编号</div></td>
			<td width="40%"><div align="center">系名</div></td>
			<td width="40%"><div align="center">操作</div></td>
		</tr>
		<%
			ArrayList<Department> depArr = new DepartmentCl().getAllDep();
			for (int i = 0; i < depArr.size(); i++) {
		%>
		<tr>
			<td><div align="center"><%=(depArr.get(i)).getId() %></div>
			</td>
			<td><div align="center"><%=(depArr.get(i)).getDepartment() %></div>
			</td>
			<td><div align="center">
					<a onclick="return delDepConf();"
						href="SettingsServlet?flag=del_dep&id=<%=(depArr.get(i)).getId()%>">删除</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">添加系名</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					输入系名：<input type="text" name="department"><input
						type="submit" value="&nbsp;提&nbsp;交&nbsp;">
				</div></td>
		</tr>
	</table>
</form>

<!-- 添加删除教师职称 -->
<form action="SettingsServlet?flag=add_jobTitle" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">教师职称</div></th>
		</tr>
		<tr height="50">
			<td width="70%"><div align="center">职称名</div></td>
			<td width="30%"><div align="center">操作</div></td>
		</tr>
		<%
			String[] jtArr = new JobTitleBeanCl().getAllJT();
			for (int i = 0; i < jtArr.length; i++) {
		%>
		<tr>
			<td><div align="center"><%=jtArr[i]%></div>
			</td>
			<td><div align="center">
					<a onclick="return delJtConf();"
						href="SettingsServlet?flag=del_jobTitle&jobTitle=<%=jtArr[i]%>">删除</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">添加教师职称名</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					输入教师职称名：<input type="text" name="jobTitle"><input
						type="submit" value="&nbsp;提&nbsp;交&nbsp;">
				</div></td>
		</tr>
	</table>
</form>

<!-- 设置毕业生年级  -->
<form action="SettingsServlet?flag=graduateGrade" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">设置毕业生年级</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">当前毕业生年级</div></td>
			<td width="35%"><%=s.getGraduateGrade()%>级</td>
		</tr>
		<tr align="center">
			<td><div>设置毕业生年级</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="graduateGrade" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>（注：设置毕业生年级之后，其他年级的学生不能登录使用此毕业选题系统。）</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;" /></td>
		</tr>
	</table>
</form>