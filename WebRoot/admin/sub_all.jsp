<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	function exportExcel(){
	    document.form1.action="ExportServlet";
	    document.form1.submit();
		/* alert('待完善！'); */
	}
	
	function search() {
		document.form4.action = "TeaManageServlet?flag=screening";
		document.form4.submit();
	}
</script>
<%

    HttpSession hs = request.getSession(true);
    String selDepartment = (String) hs.getAttribute("selDepartment");
	String teacher = (String) hs.getAttribute("teacher");
	if(selDepartment==null || "".equals(selDepartment)) selDepartment="0";
	if(teacher==null) teacher="";
	
    ArrayList<SubjectBean> all = new SubjectBeanCl().getAllSub();
    
    SubjectBeanCl sbbc = new SubjectBeanCl();
    
	ArrayList<SubjectBean> al = new SubjectBeanCl().getAllSub();
	int count=0;
	
	//定义4个分页会用到的变量
	int pageSize = 10; //每页显示的记录条数
	int pageNow = 1;	//当前显示第几页
	int rowCount = al.size(); //记录总条数
	int pageCount = (rowCount-1)/pageSize + 1; //总共多少页
	
	String k = (request.getParameter("pageNow"));
	if (k != null) {
		pageNow = Integer.parseInt(k);
	}
%>
<form  name="form1" action="">
<table width="100%" border="1" >
  <tr>
    <th colspan="8" height="50px" bgcolor="#E6F3FF"><div align="center">所有题目</div></th>
   
  </tr>
 <%--  <tr><td colspan="8"  >计算机科学与技术系已出题:<%= %>网络工程系已出题:<%= %>信息安全系已出题:<%= %>计算机应用系已出题:<%= %></td></tr> --%>
 <%--  <tr>
  
  <td><div align="center">计算机科学与技术系已出题<%= %></div></td>
  <td><div align="center">网络工程系已出题<%= %></div></td>
  <td><div align="center">信息安全系已出题<%= %></div></td>
  <td><div align="center">计算机应用系已出题<%= %></div></td>
  
  
  </tr> --%>
  
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
  
  <tr colspan="8" height="10px"></tr>
	<tr>
		<td width=5%><div align="center">编号</div>
		</td>
		<td width=10%><div align="center">所属系</div>
		</td>
			<td width=8%><div align="center">出题人</div>
		</td>
		<td width=53%><div align="center">标题</div>
		</td>
	
		<td width=8%><div align="center">选题人数</div>
		</td>
		<td width=8%><div align="center">题目方向</div>
		</td>
		<td width=8%><div align="center">审核状态</div>
		</td>
	</tr>
	<%for(int i=0;i<(pageNow!=pageCount?pageSize:1+(rowCount-1)%pageSize);i++){ 
  SubjectBean sb=al.get((pageNow-1)*pageSize+i);
  
  %>
  <tr>
    <td><div align="center"><%=sb.getId() %></div></td>
    <td><div align="center"><%=new TeacherBeanCl().getTeaDepartment(sb.getTeacher()) %></div></td>
    <td><div align="center"><%=sb.getTeacher() %></div></td>
    <td><div align="center"><a href=<%=path+"/common/sub_detail.jsp?id="+sb.getId() %> target="_blank"><%=sb.getTitle() %></a></div></td>
    
    <td><div align="center"><a ><%=sb.getSelectedNum() %></a></div></td>
    <td><div align="center"><%=sb.getDirection() %></div></td>
    <td><div align="center"><%=(sb.getState()==-1)?"审核未通过":(sb.getState()==0?"待审核":"审核通过") %></div></td>
  </tr>
  <%} %>
  
	<tr>
		<td colspan="7" height="30px"><div align="center">
				<%
					if (pageNow != 1) {
						if(pageCount>8){
				%> <a href=<%="admin/admin.jsp?function=sub_all&pageNow=1" %>>[首页]</a>
				<%} %>
						<a href=<%="admin/admin.jsp?function=sub_all&pageNow=" + (pageNow - 1)%>>上一页</a>
				<%
					}
					//页面总数少于8，输出所有页码标签
					if (pageCount < 8) {
						for (int i = 1; i <= pageCount; i++) {
						if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
				&nbsp;<a	href=<%="admin/admin.jsp?function=sub_all&pageNow="	+ i%>>[<%=i%>]</a>&nbsp;
				<%}
						}
					}else if(pageNow<=4){//页面总数大于8，当前页不大于4，输出1~8
						for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=sub_all&pageNow="	+ i%>>[<%=i%>]</a>&nbsp;
							<%
						}
						}
					}else if(pageNow>pageCount-4){//输出后8页
							for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=sub_all&pageNow="	+ (pageCount-8+i)%>>[<%=pageCount-8+i%>]</a>&nbsp;
							<%
							}
						}
					}else{
						for(int i=1;i<=8;i++){
							if(pageNow==i){
				%><label><%=i %></label>
						<%}else{ %>
							&nbsp;<a	href=<%="admin/admin.jsp?function=sub_all&pageNow="	+ (pageNow+i-4)%>>[<%=pageNow+i-4%>]</a>&nbsp;
							<%
							}
						}
					}
					if (pageNow != pageCount) {
				%>
				<a href=<%="admin/admin.jsp?function=sub_all&pageNow="	+ (pageNow + 1)%>>下一页</a>
				<%
						if(pageCount>8){
				%><a href=<%="admin/admin.jsp?function=sub_all&pageNow="+pageCount %>>[尾页]</a>
				<%}		
					}
				%>
			</div>
		</td>
	</tr>
	<tr><td colspan="7"><input type="button" value='导出Excel表' onclick="exportExcel();">计算机科学与技术系共出题:<%=sbbc.get1("计算机科学系") %>&nbsp;网络工程系共出题:<%=sbbc.get1("网络工程系")%>&nbsp;信息安全系共出题:<%=sbbc.get1("信息安全系")%>&nbsp;计算机应用系共出题:<%=sbbc.get1("计算机应用系") %></td></tr>
</table>
</form>