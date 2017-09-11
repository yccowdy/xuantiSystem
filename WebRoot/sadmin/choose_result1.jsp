<%@ page language="java" import="java.util.*,com.kk.subject.model.*,com.common.controller.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	//HttpSession hs = request.getSession(true);
	 ArrayList<StuSubTeaBean> arrSSTB;
	
	//arrSSTB = (ArrayList<StuSubTeaBean>) hs.getAttribute("arrSSTB"); 
	
	//if (arrSSTB == null) {
		arrSSTB = new StuSubTeaBeanCl().getAllSSTB1();
//	}

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

    function exportExcel(){
	    document.form1.action="ExportServlet1";
	    document.form1.submit();
		/* alert('待完善！'); */
	}

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
	
	
	
	
</script>
<form name="form1" method="post">
	<table id="testList" width="100%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr height="30px"></tr>
		<tr height="70px">
			<th colspan="7" height="50px" bgcolor="#E6F3FF"><div
					align="center" style="font-size: 35px">选&nbsp;题&nbsp;结&nbsp;果</div>
			</th>
		</tr>
		<!-- 		<tr>
			<td colspan="7" scope="col" align="center" height="30px">选择专业: <select
				id="selMajor" name="selMajor" onchange="setSelCls()">

					<option value="0">所有</option>

			</select> &nbsp;&nbsp;&nbsp;选择班级:<select id="selCls" name="selCls">
					<option value="0">所有</option>

			</select>&nbsp;&nbsp;<input type="button" value="筛选">
			</td>
		</tr> -->
		<tr bgcolor="#50806F">
			<td height="30px" width="6%" align="center">编号</td>
			<td width=50% align="center">题目</td>
			<td width=8% align="center">老师</td>
			<td width=8% align="center">学生</td>
			<td width=8% align="center">志愿</td>
			<td width=8% align="center">状态</td>
			<td width=8% align="center">操作</td>
		</tr>
		<%
			int j = 0;
			
			String a="命中";
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			for (; j < (pageNow != pageCount ? pageSize : 1 + (rowCount - 1)
					% pageSize); j++) {
				//获取当前页面的所有类对象 
				StuSubTeaBean sstb = arrSSTB.get((pageNow-1)*pageSize+j);
				/*
				kangkang 2015.11.11
				在这里获取老师学生题目名字等信息
				 */
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(sstb.getSubId()).getTitle());
				sstb.setStuName(stubc.getStuById(sstb.getStuId() + "").getName());
				if(a.equals(Tools.getDescribeOfState(sstb.getState()))){
				
				
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
		<%}
         %>

		<td colspan="7" height="30px"><div align="center">

				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+1%>>首页</a>

				<%
					  
					
					
						if (pageNow != 1) {
								//out.println("pageNow=" + pageNow);
					%>

				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+ (pageNow - 1)%>>上一页</a>
				<%
						}
							//页面总数少于8，输出所有页码标签
							if (pageCount < 8) {
								for (int i = 1; i <= pageCount; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ i%>><%=i%></a>&nbsp
				<%
						}
							} else if (pageNow <= 4) {//页面总数大于8，当前页不大于4，输出1~8
								for (int i = 1; i <= 8; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ i%>><%=i%></a>&nbsp
				<%
						}
							} else if (pageNow > pageCount - 4) {//输出后8页
								for (int i = 1; i <= 8; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ (pageCount - 8 + i)%>><%=pageCount - 8 + i%></a>&nbsp
				<%
						}
							} else {
								for (int i = 1; i <= 8; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ (pageNow + i - 4)%>><%=pageNow + i - 4%></a>&nbsp
				<%
						}
							}
							if (pageNow != pageCount) {
					%>
				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+ (pageNow + 1)%>>下一页</a>


				<%
						}
					%>

				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+ pageCount%>>尾页</a>

				<!--  <input type="text" name="pages" id="pages"  >
							 
							 <a href="#" onClick="test()">跳转</a> -->
		</td>
		<tr>
			<td colspan="7"><input type="button" value='导出Excel表(请用WPS以上版本打开)' onclick="exportExcel();">被选中题目数:<%=new StuSubTeaBeanCl().get1() %>&nbsp;同学已选中人数:<%=new StuSubTeaBeanCl().get1()%></td>
		</tr>
	</table>
</form>