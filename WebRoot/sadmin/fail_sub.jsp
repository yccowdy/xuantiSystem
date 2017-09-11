<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	HttpSession hs = request.getSession(true);
	ArrayList<SubjectBean> subAl = new StuSubTeaBeanCl().getFailedSub();

	//定义4个分也会用到的变量
	int pageSize = 15; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = subAl.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>

<form action="" method="post" name="form4">
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="3" scope="col" height="50px" bgcolor="#E6F3FF"><div
					align="center">&nbsp;查看落选题目</div></th>
		</tr>
		<tr bgcolor="#50806F">
			<td width="60%" align="center">题目</td>
			<td width="20%" align="center">老师</td>
			<td width="20%" align="center">方向</td>
		</tr>
		<%
			if (subAl.size() <= 0) {
		%>
		<tr>
			<td align="center" colspan="4">无落选题目</td>
		</tr>
		<%
			} else {
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
						+ (rowCount - 1) % pageSize); i++) {
					SubjectBean subBean = subAl.get((pageNow - 1) * pageSize + i);
			/* 	for (int i = 0; i < subAl.size(); i++) {
					SubjectBean subBean = subAl.get(i); */
		%>
		<tr>
			<td align="center"><%=subBean.getTitle()%></td>
			<td align="center"><%=subBean.getTeacher()%></td>
			<td align="center"><%=subBean.getDirection()%></td>
		</tr>
		<%
			}
			}
		%>
		<tr>
			<%
				if (rowCount != 0) {
			%>
			<td colspan="8" scope="col" align="center" height="30px">
				<%
					if (pageCount > 8) {
				%> <a href=<%="admin/admin.jsp?function=fail_sub&pageNow=1"%>>[首页]</a>
				<%
					}
						if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ (pageNow - 1)%>>[上一页]</a>
				<%
					}
						if (pageCount < 8) {//页面总数少于8，输出所有页码标签
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow > pageCount - 4) {//输出后8页
							for (int i = pageCount - 7; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else {//输出前3后4
							for (int i = pageNow - 3; i <= pageNow + 4; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ (pageNow + 1)%>>[下一页]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ pageCount%>>[尾页]</a>
				<%
					}
				%>
			</td>
			<%
				} else {
			%>
			<td colspan="8" scope="col" align="center" height="30px">查询无结果</td>
			<%
				}
			%>
		</tr>
		<tr>
			<td colspan="8" scope="col" align="left" height="30px">一共有<%=subAl.size()%>个落选题目。</td>

		</tr>
	</table>
</form>