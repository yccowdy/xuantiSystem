<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	//中文乱码问题
	response.setCharacterEncoding("UTF-8");
%>
<script type="text/javascript">
	
	function search() {
		document.form4.action = "StuManageServlet?flag=screening";
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
	ArrayList<StudentBean> al = null;
	al=(ArrayList<StudentBean>) hs.getAttribute("searchResult");
	hs.removeAttribute("searchResult");
	
	String selCls = (String) hs.getAttribute("selClass");
	String selMajor = (String) hs.getAttribute("selMajor");
   if(selCls==null || "".equals(selCls)) selCls="0";
   if(selMajor==null || "".equals(selMajor)) selMajor="0";
	
	if (al == null) {
		/* alTea = new TeacherBeanCl().getAllTea(); */
		al = new StuSubTeaBeanCl().getFailedStu(selMajor, selCls);
	}
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
<form action="" method="post" name="form4">
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="5" scope="col" height="50px" bgcolor="#E6F3FF"><div
					align="center">&nbsp;查看落选学生</div>
			</th>
		</tr>
		<!-- <tr>
			<td colspan="5" scope="col" align="center" height="30px">选择专业: <select
				id="selMajor" name="selMajor" onchange="setSelCls()">

					<option value="0">所有</option>
			</select> &nbsp;&nbsp;&nbsp;选择班级:<select id="selCls" name="selCls">
					<option value="0">所有</option>
			</select>&nbsp;&nbsp;<input type="submit" value="查询"></td>
		</tr> -->
		<tr>

			<td colspan="5" align="center">
				<table>
		<tr>
		   <td>
		<div>
			选择专业:<select id="selMajor"name="selMajor">
				 <option value="0">所有</option>
					<%
						ArrayList<String> major = new ArrayList<String>();
										
						major = new MajorBeanCl().getAllMajor1();
										
					    for (int i = 0; i < major.size(); i++) {
					%>
						<option value=<%=major.get(i) %>
					<%=(major.get(i)).equals(selMajor) ? "selected": ""%>><%=major.get(i)%></option>
					<%
						}
					%>
				</select>
								&nbsp;&nbsp;&nbsp;选择班级:<select id="selClass"
									name="selClass">
									<option value="0">所有</option>
									<%
										ArrayList<String> cls = new ArrayList<String>();
										
										cls = new ClsBeanCl().getAllCls1();
										
										for (int i = 0; i < cls.size(); i++) {
									%>
									<option value=<%=cls.get(i) %>
										<%=(cls.get(i)).equals(selCls) ? "selected": ""%>><%=cls.get(i)%></option>
									<%
										}
									%>
								</select>
							</div>
		         
		   </td>
		   <td><div>
								&nbsp;&nbsp;&nbsp;&nbsp;<input id="ser" type="button" value="确定"
									onclick="search()">
							</div></td>
        </tr>
        </table>
        </td>
        </tr>
		<tr align="center" bgcolor="">
			<td height="30px" width="15%">账号</td>
			<td width="15%">姓名</td>
			<td width="5%">性别</td>
			<td width="15%">班级</td>
			<td width="25%">专业</td>
		</tr>
		<%
			if (al.size() <= 0) {
		%>
		<tr>
			<td align="center" colspan="5">无落选学生</td>
		</tr>
		<%
			} else {
				for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
						+ (rowCount - 1) % pageSize); i++) {
					StudentBean sb = al.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td align="center"><%=sb.getId()%></td>
			<td align="center"><%=sb.getName().equals("") ? sb.getId() : sb
							.getName()%></td>
			<td align="center"><%=SEX.toStringValue(sb.getSex())%></td>
			<td align="center"><%=sb.getCls()%></td>
			<td align="center"><%=sb.getMajor()%></td>
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
				%> <a href=<%="admin/admin.jsp?function=fail_stu&pageNow=1"%>>[首页]</a>
				<%
					}
						if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
							+ (pageNow - 1)%>>[上一页]</a>
				<%
					}
						if (pageCount < 8) {//页面总数少于8，输出所有页码标签
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
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
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
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
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
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
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
							+ (pageNow + 1)%>>[下一页]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_stu&pageNow="
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
			<td colspan="8" scope="col" align="left" height="30px">一共有<%=al.size()%>个落选学生</td>

		</tr>
	</table>
</form>