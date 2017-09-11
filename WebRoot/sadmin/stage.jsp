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
					err = "1、老师出题阶段";
					break;
				case 1:
					err = "2、学生选题阶段";
					break;
				case 2:
					err = "3、老师选第1志愿阶段";
					break;
				case 3:
					err = "4、老师选第2志愿阶段";
					break;
				case 4:
					err = "5、老师选第3志愿阶段";
					break;
				case 5:
					err = "6、管理员调整结果阶段";
					break;
				}
				alert(err + '<结束时间>必须晚于<开始时间>!');
				return;
			}
		}
		for ( var i = 0; i < s.length - 1; i++) {

			if (s[i + 1].value <= e[i].value) {
				alert((i + 2) + '、<开始时间>必须晚于上一阶段<结束时间>！');
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
		<th height="50px" align="center" colspan="3" bgcolor="#E6F3FF">选题阶段设置</th>
		<tr height="30px">
			<td align="center">阶段</td>
			<td align="center">开始时间</td>
			<td align="center">结束时间</td>
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
				onclick="conf()" value="提交修改">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="reset" value="重&nbsp;&nbsp;置">
			</td>
		</tr>
	</table>
</form>