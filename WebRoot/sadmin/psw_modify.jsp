<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript">
	
	function check(){
	
		var psw="<%=((AdminBean) session.getAttribute("user")).getPsw()%>";
		var oldPsw = document.getElementById('oldPsw').value;
		var newPsw1 = document.getElementById('newPsw1').value;
		var newPsw2 = document.getElementById('newPsw2').value;
		if (newPsw1.length < 6) {
			alert("���볤������6λ��");
		} else if (psw != oldPsw) {
			alert("ԭ������������ԣ�");
		} else if (newPsw1 != newPsw2) {
			alert("�������벻һ�£������ԣ�");
		} else {
			document.form1.action = "SettingsServlet?flag=admin_psw_modify";
			document.form1.submit();
		}

	}
</script>
<form action="" name="form1" method="post">

	<table border="1">
		<%
			HttpSession hs = request.getSession(true);

			AdminBean ab = (AdminBean) hs.getAttribute("user");
		%>
		<tr>
			<td width="100">ԭ����</td>
			<td><input type="password" border="1" name="oldPsw" id="oldPsw">
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td>������</td>
			<td><input type="password" border="1" name="newPsw1"
				id="newPsw1"></td>
		</tr>
		<tr></tr>
		<tr>
			<td>�ٴ�����</td>
			<td><input type="password" border="1" name="newPsw2"
				id="newPsw2"></td>
		</tr>
		<tr></tr>

		<h1>
			<tr align="center">
				<td><input type="submit" name="submit" onclick="check()"
					value="�޸�����"></td>
				<td><input type="reset" value="ȡ���޸�"></td>
			</tr>
	</table>
</form>
