<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String yuanxi=session.getAttribute("yuanxi").toString();
	//System.out.println(yuanxi+"111");
%>
<script type="text/javascript">
	function createXmlHttpRequest() {
		var xmlreq = false;
		if (window.XMLHttpRequest) {
			xmlreq = new XMLHttpRequest();
		} else if (window.ActiveXobject) {
			try {
				xmlreq = new ActiveXobject("Msxm12.XMLHTTP");
			} catch (e1) {
				try {
					xmlreq = new ActiveXobject("Miscoft.XMLHTTP");
				} catch (e2) {
				}
			}
		}
		return xmlreq;
	}

	//检测类型是否已经存在
	function chenkExist() {

		var teaId = document.getElementById("teaId").value;
		//alert(newID);
		if (teaId == "" || teaId == null) {
			document.getElementById("checkResult").innerHTML = "不能为空";
		} else {
			var request = createXmlHttpRequest();//创建request的对象
			request.open("post",
					"ExistCheckServlet?flag=tea_exist_check&teaId=" + teaId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true") {
						document.getElementById("checkResult").innerHTML = "账号已存在";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "√";
				}
			}
		}
	}

	function teaAddConf() {
		var checkResult = document.getElementById('checkResult').innerHTML;
		if (checkResult == "账号已存在") {
			alert("账号已存在");
		} else if (checkResult == "不能为空") {
			alert("账号不能为空");
		} else if (checkResult == "√") {
			document.form1.action = "TeaManageServlet?flag=tea_add";
			document.form1.submit();
		}
	}
</script>
<form name="form1" method="post">
	<table border="1">
		<%
			HttpSession hs = request.getSession(true);

			response.setCharacterEncoding("UTF-8");

			String[] jtArr = new JobTitleBeanCl().getAllJT();
			ArrayList<Department> depArr = new DepartmentCl().getAllDep();
		%>
		<tr>
			<td width="100">账&nbsp;&nbsp;号</td>
			<td><input type="text" border="1" name="teaId" id="teaId"
				onblur="chenkExist()"> <label id="checkResult"
				style="color:#FF6600;">*</label>
			</td>
		</tr>
		<tr>
			<td width="100">密&nbsp;&nbsp;码</td>
			<td><input type="text" border="1" name="psw">
			</td>

		</tr>

		<tr>
			<td>姓&nbsp;&nbsp;名</td>
			<td><input type="text" border="1" name="name">
			</td>
		</tr>
		<tr>
			<td>性&nbsp;&nbsp;别</td>
			<td align="center"><select name="sex">
					<option value="男">男</option>
					<option value="女">女</option>
			</select></td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><input type="text" border="1" name="phoneNum"
				onkeyup="value=value.replace(/[^\d]/g,'') ">
			</td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><input type="text" border="1" name="email">
			</td>
		</tr>
		<tr>
			<td>职&nbsp;&nbsp;称</td>
			<td align="center"><select name="jobTitle">
					<%
						for (int i = 0; i < jtArr.length; i++) {
					%>
					<option value=<%=jtArr[i]%>><%=jtArr[i]%></option>
					<%
						}
					%>
			</select></td>
		</tr>
		<tr>
			<td>最大出题数</td>
			<td align="center"><input type="text" border="0"
				name="maxSubNum" onkeyup="value=value.replace(/[^\d]/g,'') "
				value="6">
			</td>
		</tr>
		<tr>
			<td>所属院</td>
			<td align="center">
			<input type="text" border="0" id="q"  value=<%=yuanxi%> readonly="true"/>
			</td>
		</tr>
		<tr>
			<td>账号类型</td>
			<td align="center"><select name="type">
					<option value='0'>普通老师</option>
					<option value='1'>系主任</option>
			</select>
			</td>
		</tr>
		<tr align="center">
			<td><input type="reset" value="重    置"></td>
			<td><input type="submit" onclick="teaAddConf()" value="提    交">
			</td>
		</tr>
	</table>
</form>

