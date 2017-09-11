<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	HttpSession hs = request.getSession(true);
	ArrayList<StuSubTeaBean> arrSSTB = null;
	arrSSTB = (ArrayList<StuSubTeaBean>) hs.getAttribute("searchResult");
	hs.removeAttribute("searchResult");
	/* 	if (alTea == null) {
	 alTea = new TeacherBeanCl().getAllTea();
	 } */
	String selDepartment = (String) hs.getAttribute("selDepartment");
	String teacher = (String) hs.getAttribute("teacher");
	if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
	if(teacher==null) teacher="";
	
	if (arrSSTB == null) {
		/* alTea = new TeacherBeanCl().getAllTea(); */
		arrSSTB = new StuSubTeaBeanCl().getMyAllResult(teacher, selDepartment);
	}
	
	
	
	
	
	
/* 	//	HttpSession hs = request.getSession(true);
	 ArrayList<StuSubTeaBean> arrSSTB;
	//arrSSTB = (ArrayList<StuSubTeaBean>) hs.getAttribute("arrSSTB"); 
	
	//if (arrSSTB == null) {
		arrSSTB = new StuSubTeaBeanCl().getAllSSTB();
//	} */

	String[] color = { "#D3F0F3", "#E6F3FF" };//交替变色
	
	//定义4个分也会用到的变量
	int pageSize = 10; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = arrSSTB.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<script type="text/javascript">
	function handle(state, subId, stuId, wish) {

		if (state == 1) {//撤销
			if (5 == wish) {//撤销管理员的指派
				document.form1.action = "AssignServlet?flag=repeal&subId="
						+ subId + "&stuId=" + stuId;
			} else {//撤销老师的选择
				document.form1.action = "ChooseServlet?flag=repeal&subId="
						+ subId + "&stuId=" + stuId;
			}
		} else if (state == 0) {//命中此志愿
			document.form1.action = "ChooseServlet?flag=chooseStu&subId="
					+ subId + "&stuId=" + stuId;
		}
		document.form1.submit();
	}
	
	function search() {
		document.form1.action = "ChooseServlet?flag=screening";
		document.form1.submit();
	}
</script>
<form name="form1" method="post">
	<table width="100%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr height="30px"></tr>
		<tr height="70px">
			<th colspan="7" height="50px" bgcolor="#E6F3FF"><div
					align="center" style="font-size: 35px">选&nbsp;题&nbsp;状&nbsp;态</div>
			</th>
		</tr>
		<tr>

			<td colspan="10" align="center">
				<table>
					<tr>
						<td><div>
								老师:<input name="teacher" type="text" size="10" value="<%=teacher %>"> &nbsp;
								<!-- 所属系:<input name="department" type="text" size="10"> -->
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
						<!-- <td><div>
								所属系：<input name="direction" type="text" size="10">
							</div>
						</td> -->
						<td><div>
								&nbsp;&nbsp;&nbsp;&nbsp;<input id="ser" type="button" value="确定"
									onclick="search()">
							</div></td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr bgcolor="#50806F">
			<td height="30px" width="6%" align="center">编号</td>
			<td width=50% align="center">题目</td>
			<td width=8% align="center">老师</td>
			<td  width=8% align="center">学生</td>
			<td width=8% align="center">志愿</td>
			<td  width=8% align="center">状态</td>
			<td width=8% align="center">操作</td>
		</tr>
		<%
			int j = 0;
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl(); 
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			for (; j < (pageNow != pageCount ? pageSize : 1 + (rowCount - 1)
					% pageSize); j++) {
				StuSubTeaBean sstb = arrSSTB.get((pageNow-1)*pageSize+j);
				/*
				kangkang 2015.11.11
				在这里获取老师学生题目名字等信息
				 */ 
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(sstb.getSubId()).getTitle());
				sstb.setStuName(stubc.getStuById(sstb.getStuId() + "").getName());
		%>
		<tr height="30px" bgcolor=<%=color[j % 2]%>>
			<td align="center"><%=sstb.getSubId()%></td>
			<td align="center"><%=sstb.getSubTitle()%></td>
			<td align="center"><%=sstb.getTeaName()%></td>
			<td align="center"><%=sstb.getStuName()%></td>
			<td align="center"><%=sstb.getWish()%></td>
			<td align="center"><%=Tools.getDescribeOfState(sstb.getState())%></td>
			<td align="center"><a
				href="javascript:handle(<%=sstb.getState()%>,<%=sstb.getSubId()%>,<%=sstb.getStuId()%>,<%=sstb.getWish()%>)"><%=Tools.getHandleDescribe(sstb.getState())%></a>
			</td>
		</tr>
		<%
			}
		%>
		<%-- <tr>
			<%
				if (rowCount != 0) {
			%>
			<td colspan="8" scope="col" align="center" height="30px">
				<%
					if (pageCount > 8) {
				%> <a href=<%="admin/admin.jsp?function=choose_result&pageNow=1"%>>[首页]</a>
				<%
					}
						if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+ (pageNow - 1)%>>[上一页]</a>
				<%
					}
						if (pageCount < 8) {//页面总数少于8，输出所有页码标签
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
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
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
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
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
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
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+ (pageNow + 1)%>>[下一页]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=choose_result&pageNow="
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
		</tr> --%>
		<td colspan="7" height="30px"><div align="center">
			<%-- 	<%
					if (pageNow != 1) {
						if(pageCount>8){
				%> <a href=<%="admin/admin.jsp?function=choose_result&pageNow=1" %>>[首页]</a>
				<%} %>
						<a href=<%="admin/admin.jsp?function=choose_result&pageNow=" + (pageNow - 1)%>>上一页</a>
				<%
					}
					//页面总数少于8，输出所有页码标签
					if (pageCount < 8) {
						for (int i = 1; i <= pageCount; i++) {
						if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
				&nbsp;<a	href=<%="admin/admin.jsp?function=choose_result&pageNow="	+ i%>>[<%=i%>]</a>&nbsp;
				<%}
						}
					}else if(pageNow<=4){//页面总数大于8，当前页不大于4，输出1~8
						for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=choose_result&pageNow="	+ i%>>[<%=i%>]</a>&nbsp;
							<%
						}
						}
					}else if(pageNow>pageCount-4){//输出后8页
							for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=choose_result&pageNow="	+ (pageCount-8+i)%>>[<%=pageCount-8+i%>]</a>&nbsp;
							<%
							}
						}
					}else{
						for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=choose_result&pageNow="	+ (pageNow+i-4)%>>[<%=pageNow+i-4%>]</a>&nbsp;
							<%
							}
						}
					}
					if (pageNow != pageCount) {
				%>
				<a href=<%="admin/admin.jsp?function=choose_result&pageNow="	+ (pageNow + 1)%>>下一页</a>
				<%
						if(pageCount>8){
				%><a href=<%="admin/admin.jsp?function=choose_result&pageNow="+pageCount %>>[尾页]</a>
				<%}		
					}
				%>
			</div> --%>
			<a href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+1%>>首页</a>
			 
					<%
					  
					
					
						if (pageNow != 1) {
								//out.println("pageNow=" + pageNow);
					%>
					
					<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+ (pageNow - 1)%>>上一页</a>
					<%
						}
							//页面总数少于8，输出所有页码标签
							if (pageCount < 8) {
								for (int i = 1; i <= pageCount; i++) {
					%>
					&nbsp<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
								+ i%>><%=i%></a>&nbsp
					<%
						}
							} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
								+ i%>><%=i%></a>&nbsp
					<%
						}
							} else if (pageNow > pageCount - 4) {//输出后8页
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
								+ (pageCount - 8 + i)%>><%=pageCount - 8 + i%></a>&nbsp
					<%
						}
							} else {
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
								+ (pageNow + i - 4)%>><%=pageNow + i - 4%></a>&nbsp
					<%
						}
							}
							if (pageNow != pageCount) {
					%>
					<a
						href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+ (pageNow + 1)%>>下一页</a>
							
							
					<%
						}
					%>
					
					<a href=<%="admin/admin.jsp?function=choose_result&pageNow="
							+ pageCount%>>尾页</a>
						
							<!--  <input type="text" name="pages" id="pages"  >
							 
							 <a href="#" onClick="test()">跳转</a> -->
							
							
			
		</td>
	</table>
</form>