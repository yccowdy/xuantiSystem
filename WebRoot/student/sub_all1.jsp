<%@ page language="java" import="java.util.*,com.ax.subject.model.*"
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<form name="form1" action="" method="post">
	<%
	SubjectBean sb = null;
	HttpSession hs = request.getSession(true);
	StudentBean tb = (StudentBean) hs.getAttribute("user");
	StudentBeanCl stubc = new StudentBeanCl();
	
	response.setCharacterEncoding("UTF-8");
	ArrayList<SubjectBean> al = null;
	String[] color = { "#CFDFF4", "#DFEAF8" };
	al = (ArrayList<SubjectBean>) hs.getAttribute("searchResult");
	//杨春超 分页问题解决 注释下面的代码 11.3
	//hs.removeAttribute("searchResult");
	if(al==null){
	al = new SubjectBeanCl().getAlternativeSub(tb.getId());
	}
	int pageSize = 10; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = al.size(); //记录总条数
	int pageCount = (rowCount-1)/pageSize + 1; //总共多少页
	SetBeanCl setBeanCl = new SetBeanCl();
	
	
	SetBean setBean = setBeanCl.getAllinfo();
	
	String k=request.getParameter("pageNow");
	if(k!=null){
		pageNow = Integer.parseInt(k);
	}
%>

<script type="text/javascript">
	function subm(){
	    
	    if(1!=<%=stubc.getStudentById(tb.getId()).getPrivilege() %>){
		    alert("你没有选题权限!请联系管理员修改你的选题权限。")
		    return ;
		}
	    if(2!=<%=new com.kk.subject.model.StageBeanCl().getCurrentStage()%>){
			alert("非选题阶段!");
			return ;
		} 
	    if(count()<=<%=(new SetBeanCl().getAllinfo().getAlternative()-new StudentSubjectBeanCl().getSelectedAlternativeByStuId(tb.getId()))%>)
	    {
	    document.form1.action = "UpdateDataServlet?flag=alternative";
	    
		document.form1.submit();
	    }else{
	    alert("超过选题最大数");
	    }
	    
	}
	
	function count(){
		/* var pick = document.getElementsByName("pick"); */
		var pick = document.forms[0].pick;
		var n=0;
		for(var i=0;i<pick.length;i++){
		    
			if(pick[i].checked) n++	;
		}
		
		return n;
	}
	
    function search(){
    document.form1.action = "UpdateDataServlet?flag=screening1";
    document.form1.submit();
   }
</script>


	<table width="100%" border="1">
	<%if(!stubc.Fill_Info(tb.getId()+"")){
	%>
	<tr><a href="student/student.jsp?function=info_modify">请先完善信息</a><tr>
	<% }else{%>
		<tr>
			<th colspan="7"><div align="center">所有题目</div>
			</th>
		</tr>
		
		<tr>
		  <td colspan="7" align="center">
		    <table>
		        <tr>
		          <td ><div>老师:<input name="teacher" type="text" size="10" > </div></td>
		          <td ><div> 题目方向：<input name="direction" type="text" size="10" >
		              <!--  <select name="direction"  >
		              <option  value=""></option>
		              <option  value="应用方向"></option>
		              <option  value="理论方向"></option>
		              
		              
		              </select>-->
		          		          </div></td>
				  <td><div>题目搜索：<input name="title" type="text" size="10" ></div></td>
		          <td><div> &nbsp;&nbsp;&nbsp;&nbsp;<input id="ser" type="button" value="确定" onclick="search()"></div></td>
		        </tr>
		    </table>
		  </td>
		 
		</tr>                                                                                                                                                               
		
		<tr bgcolor="#50806F">
		    <td width="8%"><div align="center">选择</div></td>
			<td width="8%"><div align="center">编号</div></td>
			<td width="60%"><div align="center">标题</div></td>
			<td width="10%"><div align="center">出题人</div></td>
			<td width="8%"><div align="center">已选人数</div></td>
			<td width="10%"><div align="center">题目方向</div></td>
			
		</tr>



		<%for(int i=0;i<(pageNow!=pageCount?pageSize:1+(rowCount-1)%pageSize);i++){ 
   sb=al.get((pageNow-1)*pageSize+i);
  %>
		<tr bgcolor=<%=color[i % 2]%>>
			<td align="center"><input type="checkbox" name="pick"  value=<%=sb.getId()%>></td>
			<td align="center"><%=sb.getId()%></td>
			<td align="center"><a href=<%=path+"/common/sub_detail.jsp?id="+sb.getId() %> target="_blank"><%=sb.getTitle() %></a>
			</td>
			<td><div align="center"  ><%=sb.getTeacher() %></div>
			</td>
			<td align="center"><%=sb.getSelectedNum()%><input  type="hidden" id="selectedNum<%=i%>"  value=<%=sb.getSelectedNum() %>>
			</td>
			<td><div align="center"><%=sb.getDirection() %></div>
			</td>

		</tr>
		<%} %>
		<tr>
			<td colspan="7"><div align="center">
					<%
					if (pageNow != 1) {
						System.out.println("pageNow=" + pageNow);
				%>
					<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="
						+ (pageNow - 1)%>>上一页</a>
					<%
					}
					//页面总数少于8，输出所有页码标签
					if (pageCount < 8) {
						for (int i = 1; i <= pageCount; i++) {
				%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="	+ i%>><%=i%></a>&nbsp
					<%
						}
					}else if(pageNow<=4){//页面总数大于8，当前页不大于4，输出1~8
						for(int i=1;i<=8;i++){
							%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="	+ i%>><%=i%></a>&nbsp
					<%
						}
					}else if(pageNow>pageCount-4){//输出后8页
							for(int i=1;i<=8;i++){
							%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="	+ (pageCount-8+i)%>><%=pageCount-8+i%></a>&nbsp
					<%
						}
					}else{
						for(int i=1;i<=8;i++){
							%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="	+ (pageNow+i-4)%>><%=pageNow+i-4%></a>&nbsp
					<%
						}
					}
					if (pageNow != pageCount) {
				%>
					<a
						href=<%="student/student.jsp?function=sub_all1&pageNow="	+ (pageNow + 1)%>>下一页</a>
					<%
					}
				%>
				</div></td>
		</tr>
	
	<tr><td colspan="7"><div align="center"><input type="button" value="提交" onclick="subm()"></div></td></tr>
	<%} %>	
	</table>
	
	
</form>
