<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	HttpSession hs = request.getSession(true);

	response.setCharacterEncoding("UTF-8");

	ArrayList alTea = new TeacherBeanCl().getAllTea();
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

	//检测是否已经存在
	function chenkExist() {
		var title = document.getElementById("title").value;
		var teaId = document.getElementById("teacher").value;
		if (title == "" || title == null || title == "此处填写标题") {
			document.getElementById("checkResult").innerHTML = "(不能为空)";
		} else {
			var request = createXmlHttpRequest();//创建request的对象
			request.open("post","ExistCheckServlet?flag=title_exist_check&title=" + title+ "&teaId=" + teaId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true" || value == "self") {
						document.getElementById("checkResult").innerHTML = "(已存在)";
					} else if (value == "limited") {
						document.getElementById("checkResult").innerHTML = "(已达最大出题数)";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "(√)";
				}
			}
		}
	}

	function addSubConf() {
		var title = document.getElementsByName("title").value;
		var checkResult = document.getElementById("checkResult").innerHTML;
		if (title == "" || title == "(此处填写标题)") {
			alert("标题不能为空！");
		} else if (checkResult == "(已存在)") {
			alert("此标题的题目已存在,可以联系对应老师修改！");
		} else if (checkResult == "(已达最大出题数)") {
			alert("该老师出题数受限！");
		} else if (checkResult == "(√)") {
			document.form1.action = "SubManageServlet?flag=sub_add";
			document.form1.submit();
		}
	}
</script>

<form name="form1" method="post">
	<table width="100%" border="1" cellpadding="0" cellspacing="0">
		<tr height="30">
			<th colspan="2" scope="row" bgcolor="#E6F3FF">新题目详细信息</th>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr height="30">
			<th width="30%" scope="row">标 题<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><div>
					<textarea
						style="width: 100%; height: 100%; overflow: auto; border: 0px;"
						name="title" id="title" onfocus="if(value=='此处填写标题'){value=''}"
						onblur="if (value ==''){value='此处填写标题'} chenkExist()">此处填写标题</textarea>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">出题人</th>
			<td>&nbsp;&nbsp;&nbsp;<select id="teacher" name="teacher"
				onchange="chenkExist()">
					<%
						TeacherBean tb = null;
						for (int i = 0; i < alTea.size(); i++) {
							tb = (TeacherBean) alTea.get(i);
					%>
					<option value=<%=tb.getId()%>><%=tb.getName()%>&nbsp;(<%=tb.getId()%>)
					</option>
					<%
						}
					%>
			</select>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">题目方向</th>
			<td>&nbsp;&nbsp;&nbsp;<select name="direction">
					<%
						ArrayList al = new DirectionCl().getAllDirec();
						for (int i = 0; i < al.size(); i++) {
							String direction = ((Direction) al.get(i)).getDirection();
					%>
					<option value="<%=direction%>"><%=direction%></option>
					<%
						}
					%>
			</select></td>
		</tr>
		<tr height="100">
			<th scope="row">题目简介</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="introduction" onfocus="if(value=='此处填写题目简介'){value=''}"
					onblur="if (value ==''){value='此处填写题目简介'}">此处填写题目简介</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">进程安排</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="schedule" onfocus="if(value=='此处填写进程安排'){value=''}"
					onblur="if (value ==''){value='此处填写进程安排'}">此处填写进程安排</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">参考文献</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="reference" onfocus="if(value=='此处填写参考文献'){value=''}"
					onblur="if (value ==''){value='此处填写参考文献'}">此处填写参考文献</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">学生要求</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="requirement" onfocus="if(value=='此处填写学生要求'){value=''}"
					onblur="if (value ==''){value='此处填写学生要求'}">此处填写学生要求</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">所属领域</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="domain" onfocus="if(value=='此处填写题目所属领域'){value=''}"
					onblur="if (value ==''){value='此处填写题目所属领域'}">此处填写题目所属领域</textarea>
			</td>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr height="30" align="center">
			<td colspan="2" scope="row" bgcolor="#E6F3FF"><input
				type="submit" onclick="addSubConf()" value="提&nbsp;&nbsp;交">
			</td>
		</tr>
	</table>
</form>