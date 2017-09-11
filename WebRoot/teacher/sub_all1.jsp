<%@ page language="java"
	import="java.util.*,com.kk.subject.model.*,com.common.controller.MyComparator"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String yuanxi=session.getAttribute("yuanxi").toString();
%>
<script type="text/javascript">
	function setSort(attiName) {
		if (attiName == "title") {
			document.form1.action = "SortServlet?attiName=title";
		}else if (attiName == "id") {
			document.form1.action = "SortServlet?attiName=id";
		}else if (attiName == "teacher") {
			document.form1.action = "SortServlet?attiName=teacher";
		}else if (attiName == "selectedNum") {
			document.form1.action = "SortServlet?attiName=selectedNum";
		}else if (attiName == "direction") {
			document.form1.action = "SortServlet?attiName=direction";
		}
		document.form1.submit();
	}
</script>
<%
	response.setCharacterEncoding("UTF-8");
	HttpSession hs = request.getSession(true);
	ArrayList<SubjectBean> al = new SubjectBeanCl().getAllSub2(yuanxi);//用链表来存放对象

	//定义4个分页会用到的变量
	int pageSize = 15; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = al.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = (request.getParameter("pageNow"));
	if (k != null) {
		pageNow = Integer.parseInt(k);
	}

	//根据用户选择，进行排序
	String attiName = (String)hs.getAttribute("attiName");
	if (attiName == null)
		attiName = "id";
	MyComparator mp = new MyComparator();
	mp.setAttiName(attiName);
	Collections.sort(al, mp);
%>
<form name="form1" method="post">
	<input type="hidden" name="url"
		value="teacher/teacher.jsp?function=sub_all">
	<table width="100%" border="1">
		<tr>
			<th colspan="6"><div align="center">所有题目</div></th>
		</tr>
		<tr>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href="javascript:setSort('id')">编号<%=attiName.equals("id")?"^":"" %></a>
			</td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href="javascript:setSort('title')">标题<%=attiName.equals("title")?"^":"" %></a>
			</td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href="javascript:setSort('teacher')">老师<%=attiName.equals("teacher")?"^":"" %></a>
			</td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href="javascript:setSort('selectedNum')">选题人数<%=attiName.equals("selectedNum")?"^":"" %></a>
			</td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href="javascript:setSort('direction')">题目方向<%=attiName.equals("direction")?"^":"" %></a>
			</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				//if(!al.isEmpty()){
				SubjectBean sb = al.get((pageNow - 1) * pageSize + i);
				//}
		%>
		<tr>
			<td><div align="center"><%=sb.getId()%></div></td>
			<td><div align="center">
					<a href=<%=path + "/common/sub_detail.jsp?id=" + sb.getId()%>
						target="_blank"><%=sb.getTitle()%></a>
				</div></td>
			<td><div align="center"><%=sb.getTeacher()%></div></td>
			<td><div align="center">
					<a><%=sb.getSelectedNum()%></a>
				</div></td>
			<td><div align="center"><%=sb.getDirection()%></div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="6"><div align="center">
					<%
						if (pageCount > 8) {
					%>
					<a href=<%="teacher/teacher.jsp?function=sub_all1&pageNow=1"%>>[首页]</a>
					<%
						}
						if (pageNow != 1) {
					%>
					<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
						+ (pageNow - 1)%>>上一页</a>
					<%
						}
						//页面总数少于8，输出所有页码标签
						if (pageCount < 8) {
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
					%>
					<label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
					<%
						}
							}
						} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
					%>
					<label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
					<%
						}
							}
						} else if (pageNow > pageCount - 4) {//输出后8页
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
					%>
					<label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
								+ (pageCount - 8 + i)%>>[<%=pageCount - 8 + i%>]</a>&nbsp;
					<%
						}
							}
						} else {
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
					%>
					<label><%=i%></label>
					<%
						} else {
					%>
					&nbsp;<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
								+ (pageNow + i - 4)%>>[<%=pageNow + i - 4%>]</a>&nbsp;
					<%
						}
							}
						}
						if (pageNow != pageCount) {
					%>
					<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
						+ (pageNow + 1)%>>下一页</a>
					<%
						}
						if (pageCount > 8) {
					%>
					<a
						href=<%="teacher/teacher.jsp?function=sub_all1&pageNow="
						+ pageCount%>>[尾页]</a>
					<%
						}
					%>
				</div>
			</td>
		</tr>
	</table>
</form>