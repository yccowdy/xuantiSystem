<%@page import="com.kk.subject.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//������������
response.setCharacterEncoding("UTF-8");
%>

<script type="text/javascript">
	function delConf(){
		return window.confirm("ɾ��רҵ��ɾ����רҵ�����а༶��ȷ��Ҫɾ����");
	}
</script>

<form action="StuManageServlet?flag=add_major" method="post">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">����רҵ</div></th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">���</div></td>
			<td width="40%"><div align="center">רҵ����</div></td>
			<td width="40%"><div align="center">����</div></td>
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
						href="StuManageServlet?flag=del_major&id=<%=((MajorBean) al.get(i)).getId()%>">ɾ��</a>
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="3"><div align="left">���רҵ����</div></th>
		</tr>
		<tr>
			<td colspan="3"><div align="center">
					����רҵ���ƣ�<input type="text" name="major"><input
						type="submit" value="&nbsp;��&nbsp;��&nbsp;">
				</div></td>
		</tr>
	</table>
</form>