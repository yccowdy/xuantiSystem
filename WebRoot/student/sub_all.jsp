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
		String yuanxi=session.getAttribute("yuanxi").toString();
		String[] color = { "#CFDFF4", "#DFEAF8" };
		response.setCharacterEncoding("UTF-8");
		ArrayList<SubjectBean> al = null;
		
		al = (ArrayList<SubjectBean>) hs.getAttribute("searchResult");
		//分页问题解决 注释下面的代码 11.3
		//hs.removeAttribute("searchResult");
		if(al==null){
			
		al = new SubjectBeanCl().getAllSub(tb.getId(),yuanxi);
		}
		int pageSize = 15; //每页显示的记录条数
		int pageNow = 1; //当前显示第几页
		int rowCount = al.size(); //记录总条数
		int pageCount = (rowCount-1)/pageSize + 1; //总共多少页
		SetBeanCl setBeanCl = new SetBeanCl();
		
		//int s_page=Integer.getInteger(request.getParameter("pages"));
		SetBean setBean = setBeanCl.getAllinfo();
		
		String k=request.getParameter("pageNow");
		if(k!=null){
			pageNow = Integer.parseInt(k);
		}
	%>

	<script type="text/javascript">
	    function subm(i,selectedNum){
	    var subId = document.getElementById("subId"+i);
		subId.name="subId";
		var wish_type=document.getElementById("wish_type"+i);
		wish_type.name="wish_type";
		
		if(1!=<%=stubc.getStudentById(tb.getId()).getPrivilege()%>){
		    alert("你没有选题权限!请联系管理员修改你的选题权限。")
		    return ;
		}
	    if(2!=<%=new com.kk.subject.model.StageBeanCl().getCurrentStage()%>){
			alert("非选题阶段!");
			return ;
		} 
		
	    if(<%=new SetBeanCl().getAllinfo().getWarnNum()%>>selectedNum){
	    	document.form1.action = "UpdateDataServlet?flag=select_sub1";
			//document.form1.action = "UpdateDataServlet?flag=select_sub";
			document.form1.submit();
		}else if(<%=new SetBeanCl().getAllinfo().getWarnNum()%><=selectedNum && <%=new SetBeanCl().getAllinfo().getMaxSelNum()%>>=selectedNum){
		      if(window.confirm("此题已选人数过多,请选择其它题目以确保你能选上,如要继续选择此题请点击确定，不选择此题请点击取消"))
			{
			    document.form1.action = "UpdateDataServlet?flag=select_sub";
				document.form1.submit();
			}
		}else {
			alert("选择此题人数已满，请选择其它题目");
		
		} 
	}

    function search(){
    document.form1.action = "UpdateDataServlet?flag=screening";
    document.form1.submit();
   }
   
   function test(){
//这里还需要实现一些对于输入页码的安全性验证。比如不能为空，必须是数字这些。
  var pages = document.getElementById("pages").value; 
  var num = parseInt(pages); 
  window.open("student/student.jsp?function=sub_all&pageNow="+num);

 }
</script>


	<table width="100%" border="1">
		<%
			if (!stubc.Fill_Info(tb.getId() + "")) {
		%>
		<tr>
			<a href="student/student.jsp?function=info_modify">请先完善信息</a>
		<tr>
			<%
				} else {
			%>
		
		<tr>
			<th colspan="7"><div align="center">所有题目</div></th>
		</tr>

		<tr>
			<td colspan="7" align="center">
				<table>
					<tr>
						<td><div>
								老师:<input name="teacher" type="text" size="10" >
							</div>
						</td>
						<td><div>
								题目方向：<input name="direction" type="text" size="5">
							</div>
						</td>
							<td><div>
								题目搜索：<input name="title" type="text" size="10" >
							</div>
						</td>
						<td><div>
								&nbsp;&nbsp;&nbsp;&nbsp;<input id="ser" type="button" value="确定"
									onclick="search()">
							</div>
						</td>
					</tr>
				</table></td>

		</tr>

		<tr  bgcolor="#50806F">
			<td width="5%"><div align="center">编号</div></td>
			<td width="50%"><div align="center">标题</div></td>
			<td width="10%"><div align="center">出题人</div></td>
			<td width="5%"><div align="center">已选人数</div></td>
			<td width="10%"><div align="center">题目方向</div></td>
			<td width="20%"><div align="center">志愿</div></td>
		</tr>



		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
						+ (rowCount - 1) % pageSize); i++) {
					sb = al.get((pageNow - 1) * pageSize + i);
		%>
		<tr bgcolor=<%=color[i % 2]%>>
			<td align="center"><%=sb.getId()%><input id="subId<%=i%>"
				name="" type="hidden" value=<%=sb.getId()%>>
			</td>
			<td align="center"><a
				href=<%=path + "/common/sub_detail.jsp?id=" + sb.getId()%>
				target="_blank"><%=sb.getTitle()%></a></td>
			<td><div align="center"><%=sb.getTeacher()%></div></td>
			<td align="center"><%=sb.getSelectedNum()%><input type="hidden"
				id="selectedNum<%=i%>" value=<%=sb.getSelectedNum()%>></td>
			<td><div align="center"><%=sb.getDirection()%></div></td>


			<td><div align="center">



					<select id="wish_type<%=i%>" name="">

						<option value="0"></option>
						<option value="1">第一志愿</option>

						<option value="2">第二志愿</option>

						<option value="3">第三志愿</option>
						<option value="4">第四志愿</option>
						<option value="5">第五志愿</option>
						<option value="6">第六志愿</option>


					</select> <input type="button" value="提交"
						onclick="subm(<%=i%>,<%=sb.getSelectedNum()%>)">
				</div></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="7"><div align="center">
			 
			 
			 
			 <a href=<%="student/student.jsp?function=sub_all&pageNow="
							+1%>>首页</a>
			 
					<%
					  
					
					
						if (pageNow != 1) {
								//out.println("pageNow=" + pageNow);
					%>
					
					<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
							+ (pageNow - 1)%>>上一页</a>
					<%
						}
							//页面总数少于8，输出所有页码标签
							if (pageCount < 8) {
								for (int i = 1; i <= pageCount; i++) {
					%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
								+ i%>><%=i%></a>&nbsp
					<%
						}
							} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
								+ i%>><%=i%></a>&nbsp
					<%
						}
							} else if (pageNow > pageCount - 4) {//输出后8页
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
								+ (pageCount - 8 + i)%>><%=pageCount - 8 + i%></a>&nbsp
					<%
						}
							} else {
								for (int i = 1; i <= 8; i++) {
					%>
					&nbsp<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
								+ (pageNow + i - 4)%>><%=pageNow + i - 4%></a>&nbsp
					<%
						}
							}
							if (pageNow != pageCount) {
					%>
					<a
						href=<%="student/student.jsp?function=sub_all&pageNow="
							+ (pageNow + 1)%>>下一页</a>
							
							
					<%
						}
					%>
					
					<a href=<%="student/student.jsp?function=sub_all&pageNow="
							+ pageCount%>>尾页</a>
						
							<!--  <input type="text" name="pages" id="pages"  >
							 
							 <a href="#" onClick="test()">跳转</a> -->
							
							
							
				</div> 
			</td>
		</tr>
		<%} %>
	</table>
</form>
