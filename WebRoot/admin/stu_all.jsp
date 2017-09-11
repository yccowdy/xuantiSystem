<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	//中文乱码问题
	response.setCharacterEncoding("UTF-8");
	String yuanxi=session.getAttribute("yuanxi").toString();
%>
<script type="text/javascript">

	function batchDelStu(){
		document.form4.action="StuManageServlet?flag=batch_del_stu";
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
		return window.confirm("确定要删除此学生吗？");
	}

	function setSelCls() {
		var selMajor = document.getElementById('selMajor');
		var selMajorValue = selMajor.value;
		var selCls = document.getElementById('selCls');
		selCls.options.length = 0;
		selCls.options.add(new Option("所有","0")); 
		<%

		ArrayList alCls = new ClsBeanCl().getAllCls(yuanxi);
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
	}
</script>
<%
	HttpSession hs = request.getSession(true);
	ArrayList<StudentBean> al=null;
	String selCls = (String) hs.getAttribute("selCls");
	String selMajor = (String) hs.getAttribute("selMajor");
	if (selCls == null)
		selCls = "0";
	if (selMajor == null) 
		selMajor = "0"; 
	if(!selCls.equals("0")){
		al = new StudentBeanCl().getStuByCls(selCls);
	}else if(!selMajor.equals("0")){
		al = new StudentBeanCl().getStuByMajor(selMajor);
	} else {
		al = new StudentBeanCl().getAllStu(yuanxi);
	}
	//杨春超 分页问题解决 注释下面的代码 11.3
	//hs.removeAttribute("selCls");
	//hs.removeAttribute("selMajor");
	//定义4个分也会用到的变量
	int pageSize = 15; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = al.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<form action="StuManageServlet?flag=QueryByCriteria" method="post"
	name="form4">
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="8" scope="col" height="50px" bgcolor="#E6F3FF"><div
					align="center">查看学生信息</div></th>
		</tr>
		<tr>
			<td colspan="8" scope="col" align="center" height="30px">选择专业: <select
				id="selMajor" name="selMajor" onchange="setSelCls()">

					<option value="0">所有</option>
					<%
						ArrayList<MajorBean> majorAl = new MajorBeanCl().getAllMajor(yuanxi);
						for (int i = 0; i < majorAl.size(); i++) {
							MajorBean mb = (MajorBean) majorAl.get(i);
					%>
					<option value=<%=mb.getMajor()%>
						<%=mb.getMajor().equals(selMajor) ? "selected" : ""%>><%=mb.getMajor()%></option>
					<%
						}
					%>
			</select> &nbsp;&nbsp;&nbsp;选择班级:<select id="selCls" name="selCls">
					<option value="0">所有</option>
					<%
						int[] clsArr=null;
						if (!selMajor.equals("0")) {
							clsArr = new ClsBeanCl().getClsByMajor(selMajor);
						}else{
							clsArr = new ClsBeanCl().getAllClsArr();
						}
						for (int i = 0; i < clsArr.length; i++) {
					%>
					<option value=<%=clsArr[i]%>
						<%=(clsArr[i] + "").equals(selCls) ? "selected" : ""%>><%=clsArr[i]%></option>
					<%
						}
					%>
			</select>&nbsp;&nbsp;<input type="submit" value="查询">
			</td>
		</tr>
		<tr align="center" bgcolor="">
			<td height="30px" width="6%">选择</td>
			<td width="13%">账号</td>
			<td width="13%">姓名</td>
			<td width="5%">性别</td>
			<td width="13%">班级</td>
			<td width="24%">专业</td>
			<td width="13%">权限</td>
			<td width="13%">操作</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				StudentBean sb = al.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td align="center"><input type="checkbox" name="pick"
				value=<%=sb.getId()%>></td>
			<td align="center"><%=sb.getId()%></td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href=<%=path+"/admin/admin.jsp?function=stu_modify&stuId="+sb.getId() %>><%=sb.getName().equals("")?sb.getId():sb.getName()%></a>
			</td>
			<td align="center"><%=SEX.toStringValue(sb.getSex())%></td>
			<td align="center"><%=sb.getCls()%></td>
			<td align="center"><%=sb.getMajor()%></td>
			<td align="center"><%=sb.getPrivilege()==1 ? "正常" : "禁止选题"%></td>
			<td align="center"><a
				href=<%=path+"/admin/admin.jsp?function=stu_modify&stuId="+sb.getId() %>>修改</a>/<a
				onclick="return delConf();"
				href="StuManageServlet?flag=stu_del&stuId=<%=sb.getId()%>">删除</a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<%
			if(rowCount!=0){
			%>
			<td colspan="8" scope="col" align="center" height="30px">
				<%
				if(pageCount>8){
				%> <a href=<%="admin/admin.jsp?function=stu_all&pageNow=1" %>>[首页]</a>
				<%
				}
				if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + (pageNow - 1)%>>[上一页]</a>
				<%
				}
				if (pageCount < 8) {//页面总数少于8，输出所有页码标签
					for (int i = 1; i <= pageCount; i++) {
						if(pageNow==i){
						%> <label><%=i %></label>&nbsp; <%
						 }else{
						  %> <a href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%		}
					}
				} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
					for (int i = 1; i <= 8; i++) {
				 		if(pageNow==i){%> <label><%=i%></label>&nbsp; <%}else{ %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%		}
					}
				} else if (pageNow > pageCount - 4) {//输出后8页
						for (int i = pageCount-7; i <= pageCount; i++) {
							if(pageNow==i){%> <label><%=i%></label>&nbsp; <%	}else{ %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%			}
						}
					} else {//输出前3后4
						for (int i = pageNow-3; i <= pageNow+4; i++) {
							if(pageNow==i){%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
							+ (pageNow + 1)%>>[下一页]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
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
			<td colspan="8" scope="col" align="left" height="30px"><a
				href="javascript:allCheck();">全选</a> <a href="javascript:inverse();">反选</a>&nbsp;&nbsp;&nbsp;
				<input type="button" value="删除选中"
				onclick="javascript:batchDelStu();"></td>

		</tr>
	</table>
</form>