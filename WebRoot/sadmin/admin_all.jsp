<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	//中文乱码问题
	response.setCharacterEncoding("UTF-8");
%>
<script type="text/javascript">

	function batchDelTea(){
		document.form4.action="TeaManageServlet?flag=batch_del_tea";
		document.form4.submit();
	}

	function allCheck() {
		var checkbox=document.getElementsByName("pick");

		for(var i=0;i<checkbox.length;i++){
			checkbox[i].checked="checked";
		}
	}
	

	function inverse() {
		var checkbox = document.getElementsByName("pick");

		for ( var i = 0; i < checkbox.length; i++) {
			if (checkbox[i].checked)
				checkbox[i].checked = "";
			else
				checkbox[i].checked = "checked";
		}
	}

	function delConf() {
		return window.confirm("确定要删除此老师账号吗？");
	}

	function search() {
		document.form4.action = "TeaManageServlet?flag=screening";
		document.form4.submit();
	}

</script>
<%
	HttpSession hs = request.getSession(true);
	ArrayList<AdminBean> alTea = null;
	alTea = (ArrayList<AdminBean>) hs.getAttribute("searchResult");
	hs.removeAttribute("searchResult");
	/* 	if (alTea == null) {
	 alTea = new TeacherBeanCl().getAllTea();
	 } */
	String selDepartment = (String) hs.getAttribute("selDepartment");
	String teacher = (String) hs.getAttribute("teacher");
	if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
	if(teacher==null) teacher="";
	
	if (alTea == null) {
		/* alTea = new TeacherBeanCl().getAllTea(); */
		alTea = new AdminBeanCl().getAll();
	}

	//定义4个分也会用到的变量 
	int pageSize = 10; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = alTea.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<form action="" method="post" name="form4">
<!-- <form action="TeaManageServlet?flag=QueryByCriteria" method="post" name="form4"> -->
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="10" scope="col" height="50px" bgcolor="#E6F3FF"
				align="center">查看管理员信息</th>
		</tr>
		<tr align="center" bgcolor="">
			<td height="30px" width="6%">选择</td>
			<td width="15%">所属系</td>
			<td width="10%">姓名</td>
			<td width="10%">账号</td>
			<td width="6%">性别</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				AdminBean ad = alTea.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td align="center"><input type="checkbox" name="pick"
				value=<%=ad.getId()%>>
			</td>
			<td align="center"><%=ad.getYuanxi()%></td>
			<td align="center"><%=ad.getName()%></td>
			<td align="center"><%=ad.getId()%></td>
			<td align="center"><%=ad.getSex()%></td>
		</tr>
		<%
			}
		%>
		<tr>

			<td colspan="9" scope="col" align="center" height="30px">
				<%
					if (pageCount > 8) {
				%> <a href=<%="admin/admin.jsp?function=tea_all&pageNow=1"%>>[首页]</a>
				<%
					}
					if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
						+ (pageNow - 1)%>>[上一页]</a>
				<%
					}

					if (pageCount < 8) {//页面总数少于8，输出所有页码标签
						for (int i = 1; i <= pageCount; i++) {
				%> &nbsp; <%
 	if (pageNow == i) {
 %> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>><%=i%></a>&nbsp;
				<%
					} else {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
						}
					} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
						for (int i = 1; i <= 8; i++) {
				%> &nbsp; <%
 	if (pageNow == i) {
 %> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>><%=i%></a>&nbsp;
				<%
					} else {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
						}
					} else if (pageNow > pageCount - 4) {//输出后8页
						for (int i = pageCount - 7; i <= pageCount; i++) {
				%> &nbsp; <%
 	if (pageNow == i) {
 %> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>><%=i%></a>&nbsp;
				<%
					} else {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
						}
					} else {//输出前3后4
						for (int i = pageNow - 3; i <= pageNow + 4; i++) {
				%> &nbsp; <%
 	if (pageNow == i) {
 %> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>><%=i%></a>&nbsp;
				<%
					} else {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
								+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
						}
					}
					if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
						+ (pageNow + 1)%>>[下一页]</a>
				<%
					}
					if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=tea_all&pageNow="
						+ pageCount%>>[尾页]</a>
				<%
					}
				%>
			</td>
		</tr>
		<!--  <tr>
			<td colspan="9" scope="col" align="left" height="30px"><a
				href="javascript:allCheck();">全选</a> <a href="javascript:inverse();">反选</a>&nbsp;&nbsp;&nbsp;
				<input type="button" value="删除选中"
				onclick="javascript:batchDelTea();">
			</td>
		</tr>-->
	</table>
</form>