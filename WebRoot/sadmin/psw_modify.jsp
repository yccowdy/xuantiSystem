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
			alert("密码长度至少6位！");
		} else if (psw != oldPsw) {
			alert("原密码错误，请重试！");
		} else if (newPsw1 != newPsw2) {
			alert("两次输入不一致，请重试！");
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
			<td width="100">原密码</td>
			<td><input type="password" border="1" name="oldPsw" id="oldPsw">
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td>新密码</td>
			<td><input type="password" border="1" name="newPsw1"
				id="newPsw1"></td>
		</tr>
		<tr></tr>
		<tr>
			<td>再次输入</td>
			<td><input type="password" border="1" name="newPsw2"
				id="newPsw2"></td>
		</tr>
		<tr></tr>

		<h1>
			<tr align="center">
				<td><input type="submit" name="submit" onclick="check()"
					value="修改密码"></td>
				<td><input type="reset" value="取消修改"></td>
			</tr>
	</table>
</form>
