<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<script type="text/javascript">
	function screening() {
		document.form1.action = "SubManageServlet?flag=screeningSub";
		document.form1.submit();
	}
	//批量通过审核
	function batchVerifySub() {
		document.form1.action = "SubManageServlet?flag=batch_verify_sub";
		document.form1.submit();
	}
	//批量审核不通过
	function batchNotPass() {
		document.form1.action = "SubManageServlet?flag=batch_not_pass";
		document.form1.submit();
	}

	//全选
	function allCheck() {
		var checkbox = document.getElementsByName("pick");

		for ( var i = 0; i < checkbox.length; i++) {
			checkbox[i].checked = "checked";
		}
	}

	//反选
	function inverse() {
		var checkbox = document.getElementsByName("pick");

		for ( var i = 0; i < checkbox.length; i++) {
			if (checkbox[i].checked)
				checkbox[i].checked = "";
			else
				checkbox[i].checked = "checked";
		}
	}
</script>
<%
	HttpSession hs = request.getSession(true);
	TeacherBean tb = (TeacherBean) hs.getAttribute("user");
	String tbDepa = tb.getDepartment();
	String viewType = (String) hs.getAttribute("viewType");
	if (viewType == null)
		viewType = "0";
	/* ArrayList<SubjectBean> al = new SubjectBeanCl()
			.getSubByState(viewType); */
			
			ArrayList<SubjectBean> al = new SubjectBeanCl()
			.getSubByState1(viewType,tbDepa);

	//定义4个分页会用到的变量
	int pageSize = 15; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = al.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k);
	}
%>
<form name="form1" method="post">
	<table width="80%" align="left" border="1">
		<tr>
			<th colspan="7" height="50px" bgcolor="#E6F3FF"><div
					align="center">所有题目</div></th>
		</tr>
		<tr height="30px" align="center">
			<td colspan="6"><select name="viewType">
					<option value="0" <%=viewType.equals("0") ? "selected" : ""%>>只显示待审核题目</option>
					<option value="-1" <%=viewType.equals("-1") ? "selected" : ""%>>只显示审核未通过题目</option>
					<option value="1" <%=viewType.equals("1") ? "selected" : ""%>>只显示审核通过题目</option>
					<option value="all" <%=viewType.equals("all") ? "selected" : ""%>>显示所有</option>
			</select> <input type="button" value="筛选" onclick="screening()">
			</td>
		</tr>
		<tr>
			<td><div align="center">编号</div>
			</td>
			<td><div align="center">标题</div>
			</td>
			<td><div align="center">出题人</div>
			</td>
			<td><div align="center">题目方向</div>
			</td>
			<td><div align="center">审核状态</div>
			</td>
			<td height="30px" width="6%">选择</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				SubjectBean sb = al.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td><div align="center"><%=sb.getId()%></div></td>
			<%-- <td><div align="center">
					<a href=<%=path + "/common/sub_detail.jsp?id=" + sb.getId()%>
						target="_blank"><%=sb.getTitle()%></a>
				</div></td> --%>
			<td><div align="center"><%=sb.getTitle()%></div></td>	
			<td><div align="center"><%=sb.getTeacher()%></div></td>

			<td><div align="center"><%=sb.getDirection()%></div></td>
			<td><div align="center"><%=(sb.getState() == -1) ? "未通过"
						: (sb.getState() == 0 ? "待审核" : "通过")%></div></td>
			<td align="center"><input type="checkbox" name="pick"
				value=<%=sb.getId()%>></td>
		</tr>
		<%
			}
		%>

		<tr>
			<td colspan="7" height="30px"><div align="center">
					<%
						if (rowCount == 0) {
					%>
					<label>查询无结果！</label>
					<%
						} else {
							if (pageNow != 1) {
								if (pageCount > 8) {
					%>
					<a href=<%="teacher/teacher.jsp?function=sub_verify&pageNow=1"%>>[首页]</a>
					<%
						}
					%>
					<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
							+ (pageNow - 1)%>>上一页</a>
					<%
						}
							//页面总数少于8，输出所有页码标签
							if (pageCount < 8) {
								for (int i = 1; i <= pageCount; i++) {
									if (pageNow == i) {
					%><label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
					<%
						}
								}
							} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
								for (int i = 1; i <= 8; i++) {
									if (pageNow == i) {
					%><label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
					<%
						}
								}
							} else if (pageNow > pageCount - 4) {//输出后8页
								for (int i = 1; i <= 8; i++) {
									if (pageNow == i) {
					%><label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
									+ (pageCount - 8 + i)%>>[<%=pageCount - 8 + i%>]</a>&nbsp;
					<%
						}
								}
							} else {
								for (int i = 1; i <= 8; i++) {
									if (pageNow == i) {
					%><label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
									+ (pageNow + i - 4)%>>[<%=pageNow + i - 4%>]</a>&nbsp;
					<%
						}
								}
							}
							if (pageNow != pageCount) {
					%>
					<a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
							+ (pageNow + 1)%>>下一页</a>
					<%
						if (pageCount > 8) {
					%><a
						href=<%="teacher/teacher.jsp?function=sub_verify&pageNow="
								+ pageCount%>>[尾页]</a>
					<%
						}
							}
						}
					%>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="8" scope="col" align="right" height="30px"><input
				type="button" value="不通过" onclick="javascript:batchNotPass();">
				<input type="button" value="通过"
				onclick="javascript:batchVerifySub();"> <a
				href="javascript:allCheck();">全选</a> <a href="javascript:inverse();">反选</a>&nbsp;
			</td>
		</tr>
	</table>
</form>