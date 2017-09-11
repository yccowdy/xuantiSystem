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

	<%-- function setSelCls() {
		var selMajor = document.getElementById('selMajor');
		var selMajorValue = selMajor.value;
		var selCls = document.getElementById('selCls');
		selCls.options.length = 0;
		selCls.options.add(new Option("所有", "0"));
<%
		ArrayList alCls = new ClsBeanCl().getAllCls();
		%>
		if(selMajorValue == "0"){
			<%for(int k=0;k<alCls.size();k++){%>
				selCls.options.add(new Option("<%=((ClsBean)alCls.get(k)).getId()%>","<%=((ClsBean)alCls.get(k)).getId()%>"));
			<%}%>
		}else{
			<%
			for(int i=0;i<alCls.size();i++){
				ClsBean cb = (ClsBean)alCls.get(i);
			%>
				if(selMajorValue=="<%=cb.getMajorName()%>"){
				selCls.options.length = 0;
				selCls.options.add(new Option("所有","0")); 
					<%
					int[] ClsArray = new ClsBeanCl().getClsByMajor(cb.getMajorName());
					for(int j=0;j<ClsArray.length;j++){%>
						selCls.options.add(new Option("<%=ClsArray[j]%>","<%=ClsArray[j]%>"));
					<%
					}
					%>
					
				}
			<%}%>
		}
	} --%>
</script>
<%
	HttpSession hs = request.getSession(true);
	ArrayList<TeacherBean> alTea = null;
	alTea = (ArrayList<TeacherBean>) hs.getAttribute("searchResult");
	hs.removeAttribute("searchResult");
	/* 	if (alTea == null) {
	 alTea = new TeacherBeanCl().getAllTea();
	 } */
	String selDepartment = (String) hs.getAttribute("yuanxi");
	String teacher = (String) hs.getAttribute("teacher");
	if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
	if(teacher==null) teacher="";
	
	if (alTea == null) {
		/* alTea = new TeacherBeanCl().getAllTea(); */
		alTea = new TeacherBeanCl().getTeacherByNameAndDept(teacher,selDepartment);
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
				align="center">查看老师信息</th>
		</tr>
		<!-- <tr>
			<td colspan="10" align="center">
				<table>
					<tr>
						<td><div>
								老师:<input name="teacher" type="text" size="10" value="<%=teacher %>"> &nbsp;
								&nbsp;&nbsp;&nbsp;所属系:<select id="selDepartment"
									name="selDepartment">
									<option value="0">所有</option>
									<%
										ArrayList<String> deptNameArr = new ArrayList<String>();
										
										deptNameArr = new DepartmentCl().getAllDepartments();
										
										for (int i = 0; i < deptNameArr.size(); i++) {
									%>
									<option value=<%=deptNameArr.get(i) %>
										<%=(deptNameArr.get(i)).equals(selDepartment) ? "selected": ""%>><%=deptNameArr.get(i)%></option>
									<%
										}
									%>
								</select>
							</div></td>
						<td><div>
								&nbsp;&nbsp;&nbsp;&nbsp;<input id="ser" type="button" value="确定"
									onclick="search()">
							</div></td>
					</tr>
				</table>
			</td>
		</tr> -->
		<tr align="center" bgcolor="">
			<td height="30px" width="6%">选择</td>
			<td width="15%">所属系</td>
			<td width="10%">姓名</td>
			<td width="10%">账号</td>

			<td width="6%">性别</td>
			<td width="12%">已出题数</td>
			<td width="12%">最大出题数</td>
			<td width="10%">职称</td>
			<td width="8%">备注</td>
			<td width="25%">操作</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				TeacherBean tb = alTea.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td align="center"><input type="checkbox" name="pick"
				value=<%=tb.getId()%>>
			</td>
			<td align="center"><%=tb.getDepartment()%></td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href=<%=path + "/admin/admin.jsp?function=tea_modify&teaId="
						+ tb.getId()%>><%=tb.getName()%></a>
			</td>
			<td align="center"><%=tb.getId()%></td>


			<td align="center"><%=SEX.toStringValue(tb.getSex())%></td>
			<td align="center"><%=tb.getSubNum()%></td>
			<td align="center"><%=tb.getMaxSubNum()%></td>
			<td align="center"><%=tb.getJobTitle()%></td>
			<td align="center"><%=tb.getType() == 1 ? "系主任" : ""%></td>
			<td align="center"><a
				href=<%=path + "/admin/admin.jsp?function=tea_modify&teaId="
						+ tb.getId()%>>修改</a>/<a
				onclick="return delConf();"
				href="TeaManageServlet?flag=tea_del&teaId=<%=tb.getId()%>">删除</a>
			</td>
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
		<tr>
			<td colspan="9" scope="col" align="left" height="30px"><a
				href="javascript:allCheck();">全选</a> <a href="javascript:inverse();">反选</a>&nbsp;&nbsp;&nbsp;
				<input type="button" value="删除选中"
				onclick="javascript:batchDelTea();">
			</td>

		</tr>
	</table>
</form>