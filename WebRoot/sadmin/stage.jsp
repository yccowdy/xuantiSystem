<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<script type="text/javascript">
	function conf() {
		var s = document.getElementsByName("startTime");
		var e = document.getElementsByName("endTime");
		var err = "";
		for ( var i = 0; i < s.length; i++) {
			if (s[i].value > e[i].value) {
				switch (i) {
				case 0:
					err = "1����ʦ����׶�";
					break;
				case 1:
					err = "2��ѧ��ѡ��׶�";
					break;
				case 2:
					err = "3����ʦѡ��1־Ը�׶�";
					break;
				case 3:
					err = "4����ʦѡ��2־Ը�׶�";
					break;
				case 4:
					err = "5����ʦѡ��3־Ը�׶�";
					break;
				case 5:
					err = "6������Ա��������׶�";
					break;
				}
				alert(err + '<����ʱ��>��������<��ʼʱ��>!');
				return;
			}
		}
		for ( var i = 0; i < s.length - 1; i++) {

			if (s[i + 1].value <= e[i].value) {
				alert((i + 2) + '��<��ʼʱ��>����������һ�׶�<����ʱ��>��');
				return;
			}
		}
		document.form1.action = "SettingsServlet?flag=setStage";
		document.form1.submit();
	}
</script>
<%
	ArrayList<StageBean> arrSb = new StageBeanCl().getAllStage();
	response.setCharacterEncoding("UTF-8");
%>
<form name="form1" method="post">
	<h5 height="10px">&nbsp;</h5>
	<table width="80%" height="190" border="1" cellpadding="0"
		cellspacing="0">
		<th height="50px" align="center" colspan="3" bgcolor="#E6F3FF">ѡ��׶�����</th>
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
			<td align="center"><input name="startTime" type="text"
				value="<%=sb.getStartTime()%>" onClick="WdatePicker()" />
			</td>
			<td align="center"><input name="endTime" type="text"
				value="<%=sb.getEndTime()%>" onClick="WdatePicker()" />
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3" align="center"><input type="button"
				onclick="conf()" value="�ύ�޸�">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="reset" value="��&nbsp;&nbsp;��">
			</td>
		</tr>
	</table>
</form>