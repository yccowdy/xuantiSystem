<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	int id = Integer.parseInt(request.getParameter("id"));

	SubjectBean sb = new SubjectBeanCl().getSubjectById(id);
	response.setCharacterEncoding("UTF-8");
%>

<form action="" name="fm_mdf" method="post">
<script type="text/javascript">
    
    function sub(){
        
         var fm_mdf=document.getElementById("fm_mdf");
         document.fm_mdf.action="TSMServlet?flag=sub_modify1";
         document.fm_mdf.submit();
         
        
         
    }


</script>
	<table width="100%" height="482" border="1" bgcolor="#FFFFFF" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="2" scope="row" bgcolor="#FFFFFF">�޸���Ŀ��Ϣ</th>
		</tr>
		
		<tr>
			<th colspan="2" scope="row"> <input type=hidden name="id" value=<%=sb.getId() %>> </th>
		</tr>
		<tr>
			<th width="30%" scope="row" height="30px">�� ��</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="title"><%=sb.getTitle() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="30px">������</th>
			<td><%=sb.getTeacher() %></td>
		</tr>
		<tr>
			<th scope="row" height="30px">��Ŀ����</th>
			<td><select name="direction">
				<%
				ArrayList al = new DirectionCl().getAllDirec();
				for (int i = 0; i < al.size(); i++) {
				%>
					<option value="<%=((Direction) al.get(i)).getDirection()%>" <%=((Direction) al.get(i)).getDirection().equals(sb.getDirection())?"selected":"" %>><%=((Direction) al.get(i)).getDirection()%></option>
				<%} %>
			</select></td>
		</tr>
		<tr>
			<th scope="row" height="120px">��Ŀ���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="introduction"><%=sb.getIntroduction() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">���̰���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="schedule"><%=sb.getSchedule() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">�ο�����</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="reference"><%=sb.getReference() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="120px">ѧ��Ҫ��</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="requirement"><%=sb.getRequirement() %></textarea></td>
		</tr>
		<tr>
			<th scope="row" height="40px">��������</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px; font-size: 14"
					name="domain"><%=sb.getDomain() %></textarea></td>
		</tr>
		<tr>
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr>
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><input
				type="button" value="�����޸�"  onclick="sub()">
			</th>
		</tr>
	</table>
</form>
