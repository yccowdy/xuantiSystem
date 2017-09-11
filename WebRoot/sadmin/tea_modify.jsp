<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script type="text/javascript">
	function check() {

		var subNum = document.getElementById('subNum').value;
		var maxSubNum = document.getElementById('maxSubNum').value;
		if (subNum > maxSubNum) {
			alert("已出题数不能大于最大出题数，请重新输入！");
		} else {
			document.form1.action = "TeaManageServlet?flag=tea_modify";
			document.form1.submit();
		}

	}
</script>

<form action="" method="post" name="form1">


	<table border="1">
		<%
			response.setCharacterEncoding("UTF-8");

			String[] jtArr = new JobTitleBeanCl().getAllJT();
			ArrayList<Department> depArr = new DepartmentCl().getAllDep();

			String teaId = request.getParameter("teaId");
			TeacherBean tb = new TeacherBeanCl().getTeacherById(teaId);
		%>
		<tr>
			<th colspan="2" scope="col"><div align="left">老师信息修改</div>
			</th>
		</tr>
		<tr>
			<td width="100">账&nbsp;&nbsp;号</td>
			<td align="center"><input type="text" border="1" name="id"
				readonly="readonly" value="<%=teaId%>">
			</td>
		</tr>
		<tr>
			<td width="100">密&nbsp;&nbsp;码</td>
			<td><input type="text" border="1" name="psw"
				value="<%=tb.getPsw()%>">
			</td>
		</tr>

		<tr>
			<td>姓&nbsp;&nbsp;名</td>
			<td><input type="text" border="1" name="name"
				value="<%=tb.getName()%>">
			</td>
		</tr>
		<tr>
			<td>性&nbsp;&nbsp;别</td>
			<td align="center"><select name="sex">
					<option value="男" <%=tb.getSex() == SEX.MALE ? "selected" : ""%>>男</option>
					<option value="女" <%=tb.getSex() == SEX.FEMALE ? "selected" : ""%>>女</option>
			</select></td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><input type="text" border="1" name="phoneNum"
				value="<%=tb.getPhoneNum()%>"
				onkeyup="value=value.replace(/[^\d]/g,'') ">
			</td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><input type="text" border="1" name="email"
				value="<%=tb.getEmail()%>">
			</td>
		</tr>
		<tr>
			<td>职&nbsp;&nbsp;称</td>
			<td><select name="jobTitle">
					<%
						for (int i = 0; i < jtArr.length; i++) {
					%>
					<option value=<%=jtArr[i]%>
						<%=jtArr[i].equals(tb.getJobTitle()) ? "selected" : ""%>><%=jtArr[i]%></option>
					<%
						}
					%>
			</select></td>
		</tr>
		<tr>
			<td>已出题数</td>
			<td><input type="text" border="1" id="subNum" name="subNum"
				value="<%=tb.getSubNum()%>"
				onkeyup="value=value.replace(/[^\d]/g,'') ">
			</td>
		</tr>
		<tr>
			<td>最大出题数</td>
			<td><input type="text" border="1" id="maxSubNum"
				name="maxSubNum" value="<%=tb.getMaxSubNum()%>"
				onkeyup="value=value.replace(/[^\d]/g,'') ">
			</td>
		</tr>
		<tr>
			<td>所属系</td>
			<td><select name="department">
					<%
						for (int i = 0; i < depArr.size(); i++) {
						String dep = depArr.get(i).getDepartment();
					%>
					<option value=<%=dep%>
						<%=dep.equals(tb.getDepartment()) ? "selected" : ""%>><%=dep%></option>
					<%
						}
					%>
			</select>
			</td>
		</tr>
		<tr>
			<td>账号类型</td>
			<td><select name="type">
					<option value='0' <%=tb.getType() == 0 ? "selected" : ""%>>普通老师</option>
					<option value='1' <%=tb.getType() == 1 ? "selected" : ""%>>系主任</option>
			</select>
			</td>
		</tr>
			<tr align="center">
				<td><input type="submit" onclick="check()" value="保存修改">
				</td>
				<td><input type="reset" value="重    置"></td>
			</tr>
	</table>
</form>
