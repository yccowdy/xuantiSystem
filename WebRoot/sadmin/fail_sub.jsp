<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	HttpSession hs = request.getSession(true);
	ArrayList<SubjectBean> subAl = new StuSubTeaBeanCl().getFailedSub();

	//����4����Ҳ���õ��ı���
	int pageSize = 15; //ÿҳ��ʾ�ļ�¼����
	int pageNow = 1; //��ǰ��ʾ�ڼ�ҳ
	int rowCount = subAl.size(); //��¼������
	int pageCount = (rowCount - 1) / pageSize + 1; //�ܹ�����ҳ

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>

<form action="" method="post" name="form4">
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="3" scope="col" height="50px" bgcolor="#E6F3FF"><div
					align="center">&nbsp;�鿴��ѡ��Ŀ</div></th>
		</tr>
		<tr bgcolor="#50806F">
			<td width="60%" align="center">��Ŀ</td>
			<td width="20%" align="center">��ʦ</td>
			<td width="20%" align="center">����</td>
		</tr>
		<%
			if (subAl.size() <= 0) {
		%>
		<tr>
			<td align="center" colspan="4">����ѡ��Ŀ</td>
		</tr>
		<%
			} else {
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
						+ (rowCount - 1) % pageSize); i++) {
					SubjectBean subBean = subAl.get((pageNow - 1) * pageSize + i);
			/* 	for (int i = 0; i < subAl.size(); i++) {
					SubjectBean subBean = subAl.get(i); */
		%>
		<tr>
			<td align="center"><%=subBean.getTitle()%></td>
			<td align="center"><%=subBean.getTeacher()%></td>
			<td align="center"><%=subBean.getDirection()%></td>
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
				%> <a href=<%="admin/admin.jsp?function=fail_sub&pageNow=1"%>>[��ҳ]</a>
				<%
					}
						if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ (pageNow - 1)%>>[��һҳ]</a>
				<%
					}
						if (pageCount < 8) {//ҳ����������8���������ҳ���ǩ
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow <= 4) {//ҳ����������8����ǰҳ������4�����1~8
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow > pageCount - 4) {//�����8ҳ
							for (int i = pageCount - 7; i <= pageCount; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else {//���ǰ3��4
							for (int i = pageNow - 3; i <= pageNow + 4; i++) {
								if (pageNow == i) {
				%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ (pageNow + 1)%>>[��һҳ]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=fail_sub&pageNow="
							+ pageCount%>>[βҳ]</a>
				<%
					}
				%>
			</td>
			<%
				} else {
			%>
			<td colspan="8" scope="col" align="center" height="30px">��ѯ�޽��</td>
			<%
				}
			%>
		</tr>
		<tr>
			<td colspan="8" scope="col" align="left" height="30px">һ����<%=subAl.size()%>����ѡ��Ŀ��</td>

		</tr>
	</table>
</form>