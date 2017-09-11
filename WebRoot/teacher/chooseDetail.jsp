<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";

	request.setCharacterEncoding("UTF-8");
	String subId = request.getParameter("subId").replace(".jsp", "");   
	
	int stage = new StageBeanCl().getCurrentStage();
	/**
	"1、老师出题阶段"
	"2、学生选题阶段"
	"3、老师选第1志愿阶段"
	"4、老师选第2志愿阶段"
	"5、老师选第3志愿阶段"
	"6、管理员调整结果"
	**/

	SubjectBean subBean = new SubjectBeanCl().getSubjectById(subId);
	ArrayList<StuSubTeaBean> alSSTB = new StuSubTeaBeanCl().getSSTBbySubId(subId);
	alSSTB = (ArrayList<StuSubTeaBean>) Tools.sortArrayList(alSSTB,"wish");
	
	System.out.println("123alSSTB.size="+alSSTB.size());
%>
<form name="form1" method="post">
	<table width="80%">
		<tr height="60px" align="center"></tr>
		<%
			if (stage != 5 && stage != 3 && stage != 4) {
		%>
		<tr>
			<th>现在不是选学生阶段，点击<a
				href="teacher/teacher.jsp?function=..//common/stage">选题阶段</a>查看各阶段时间详情！</th>
		</tr>
		<%
			} else if(alSSTB.size()==0){
		%>
		<tr>
			<th>没有选择此题的学生！</th>
		</tr>
		<%
			}else {
		%>
		<tr>
			<th colspan="5"><%=subBean.getTitle()%></th>
		</tr>
		<tr align="center">
			<td>班序号</td>
			<td>姓名</td>
			
			<td>志愿类型</td>
			<td>选择</td>
		</tr>
		<%
			for (int i = 0; i < alSSTB.size(); i++) {
					StuSubTeaBean sstb = alSSTB.get(i);
					/* System.out.println("state="+sstb.getState()); */
					StudentBean stuBean = new StudentBeanCl().getStuById(sstb.getStuId()+"");
		%>
		<tr align="center">
			<td><%=sstb.getStuId()%></td>
			<%-- <td><%=sstb.getStuName()%></td> --%>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href=<%=path+"/teacher/teacher.jsp?function=stu_detail&stuId="+stuBean.getId() %>><%=stuBean.getName().equals("")?stuBean.getId():stuBean.getName()%></a>
			</td>
			<td><%=sstb.getWish()%></td>
			<td>
				<%
					if (sstb.getWish()==(stage-2) && sstb.getState()==0) {
				%> <input type="radio" name="stuId" checked="checked" value="<%=sstb.getStuId()%>">
				 <%
				 	} else {
				 %> <%="×"%> <%
 	}
 %>
			</td>
		</tr>
		<%
			}
		%>
		<tr height="30px">
			<td colspan="4"><input type="hidden" name="subId"
				value=<%=subId%>>
			</td>
		</tr>
		<tr align="center">
			<td colspan="2"><input type="button" value="确认"
				onclick="chooseStu()">
			</td>
			<td colspan="2"><input type="button" value="取消"
				onclick="window.location.href='<%=path+"/teacher/"%>teacher.jsp?function=choose_stu'">
			</td>
		</tr>

		<%
			}
		%>
	</table>
</form>
<script type="text/javascript">
	function chooseStu() {
		document.form1.action = "ChooseStuServlet?flag=chooseStu";
		document.form1.submit();
	}
</script>