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
		return window.confirm("ɾ����Ŀ����ɾ�����и÷������Ŀ��ȷ��Ҫɾ����");
	}
	function delJtConf(){
		return window.confirm("ɾ��ְ�ƻ��������и�ְ�ƽ�ʦ��ְ����Ϣ��ȷ��Ҫɾ����");
	}
	function delDepConf(){
		return window.confirm("ɾ��ϵ�����������и�ϵ��ʦ������ϵ��Ϣ��ȷ��Ҫɾ����");
	}
</script>
<style>
span{
	color:#850B4B;
	font-size:15px;
}
</style>
<!-- ��������ѡ�⾯������  -->
<form action="SettingsServlet?flag=warnNum" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">־Ը��������</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">��ǰ�����½�</div></td>
			<td width="35%"><%=s.getWarnNum()%></td>
		</tr>
		<tr align="center">
			<td><div>���������½�</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="warnNum" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>��ע��������������־Ը������ѡ��ĳһ��Ŀ��ѧ�������������½�ʱ��ѡ������ѧ�����յ����ѣ�������Ȼ����ѡ����⡣��</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;" /></td>
		</tr>
	</table>
</form>

<!-- ÿ�����ܹ���ѡ������ -->
<form action="SettingsServlet?flag=maxSelNum" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">ÿ���ⱻѡ����</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">��ǰ��Ŀ��ѡ����</div></td>
			<td width="35%"><%=s.getMaxSelNum()%></td>
		</tr>
		<tr align="center">
			<td><div>������Ŀ��ѡ����</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="maxSelNum" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>��ע������ÿ���ⱻѡ���ޣ���ĳ���ⱻѡ���ѧ������������ʱ������ѧ��������ѡ����⡣��</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;" /></td>
		</tr>
	</table>

</form>

<!-- ���ɾ����Ŀ���� -->
<form action="SettingsServlet?flag=add_direc" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">��Ŀ����</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">���</div></td>
			<td width="40%"><div align="center">��Ŀ����</div></td>
			<td width="40%"><div align="center">����</div></td>
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
						href="SettingsServlet?flag=del_direc&id=<%=((Direction) al.get(i)).getId()%>">ɾ��</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">�����Ŀ����</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					������Ŀ��������<input type="text" name="direction"><input
						type="submit" value="&nbsp;��&nbsp;��&nbsp;">
				</div></td>
		</tr>
	</table>
</form>
<!-- ���ɾ�� ϵ�� -->
<form action="SettingsServlet?flag=add_dep" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">ϵ��</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">���</div></td>
			<td width="40%"><div align="center">ϵ��</div></td>
			<td width="40%"><div align="center">����</div></td>
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
						href="SettingsServlet?flag=del_dep&id=<%=(depArr.get(i)).getId()%>">ɾ��</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">���ϵ��</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					����ϵ����<input type="text" name="department"><input
						type="submit" value="&nbsp;��&nbsp;��&nbsp;">
				</div></td>
		</tr>
	</table>
</form>

<!-- ���ɾ����ʦְ�� -->
<form action="SettingsServlet?flag=add_jobTitle" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">��ʦְ��</div></th>
		</tr>
		<tr height="50">
			<td width="70%"><div align="center">ְ����</div></td>
			<td width="30%"><div align="center">����</div></td>
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
						href="SettingsServlet?flag=del_jobTitle&jobTitle=<%=jtArr[i]%>">ɾ��</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">��ӽ�ʦְ����</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					�����ʦְ������<input type="text" name="jobTitle"><input
						type="submit" value="&nbsp;��&nbsp;��&nbsp;">
				</div></td>
		</tr>
	</table>
</form>

<!-- ���ñ�ҵ���꼶  -->
<form action="SettingsServlet?flag=graduateGrade" method="post">
	<table width="50%" height="255" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="col"><div align="left">���ñ�ҵ���꼶</div></th>
		</tr>
		<tr align="center">
			<td width="65%"><div align="center">��ǰ��ҵ���꼶</div></td>
			<td width="35%"><%=s.getGraduateGrade()%>��</td>
		</tr>
		<tr align="center">
			<td><div>���ñ�ҵ���꼶</div></td>
			<td><input style="width: 100%;  border=0; align=center;"
				name="graduateGrade" /></td>
		</tr>
		<tr>
			<td colspan="2"><span>��ע�����ñ�ҵ���꼶֮�������꼶��ѧ�����ܵ�¼ʹ�ô˱�ҵѡ��ϵͳ����</span></td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="submit"
				value="&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;" /></td>
		</tr>
	</table>
</form>