<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	ArrayList<StageBean> arrSb = new StageBeanCl().getAllStage();
%>
<table width="80%" height="190" border="1" cellpadding="0"
	cellspacing="0">
	<th height="50px" align="center" colspan="3" bgcolor="#E6F3FF">ѡ��׶�</th>
	<tr height="30px">
		<td align="center">�׶�</td>
		<td align="center">��ʼʱ��</td>
		<td align="center">����ʱ��</td>
	</tr>
	<%
		for (int i = 0; i < arrSb.size(); i++) {
			StageBean sb = arrSb.get(i);
	%>
	<tr height="30px">
		<td align="left"><%=sb.getName()%></td>
		<td align="center"><%=sb.getStartTime()%></td>
		<td align="center"><%=sb.getEndTime()%></td>
	</tr>
	<%
		}
	%>
	<tr><td height="20px" colspan="3" bgcolor="#E6F3FF"></td></tr>
</table>