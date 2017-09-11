<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	ArrayList<NoticeBean> al = new NoticeBeanCl().getAllNotice();

	String[] color = { "#D3F0F3", "#E6F3FF" };
	
	String userUri = path;
	if(request.getRequestURI().contains("teacher")) {
		userUri+="/teacher/teacher.jsp";
	}else if(request.getRequestURI().contains("student")){
		userUri+="/student/student.jsp";
	}
	//����4����ҳ���õ��ı���
	int pageSize = 12; //ÿҳ��ʾ�ļ�¼����
	int pageNow = 1; //��ǰ��ʾ�ڼ�ҳ
	int rowCount = al.size(); //��¼������
	int pageCount = (rowCount - 1) / pageSize + 1; //�ܹ�����ҳ

	String k = (request.getParameter("pageNow"));
	if (k != null) {
		pageNow = Integer.parseInt(k);
	}
%>
<table width="90%" border="0">
	<tr height="30px"></tr>
	<tr height="70px">
		<th colspan="3" height="50px" bgcolor="#E6F3FF"><div
				align="center" style="font-size: 35px">ͨ&nbsp;&nbsp;&nbsp;֪</div>
		</th>
	</tr>
	<tr height="10px"></tr>
	<%
		int j = 0;
		for (; j < (pageNow != pageCount ? pageSize : 1 + (rowCount - 1)
				% pageSize); j++) {
			NoticeBean nb = al.get((pageNow - 1) * pageSize + j);
	%>
	<tr bgcolor=<%=color[j % 2]%>>
		<td align="left" colspan="2"><a style="text-decoration:none; color: #2F492F;"
			href=<%=userUri
						+ "?function=../common/notice_detail&noticeId="
						+ nb.getId()%>><%=nb.getTitle()%></a>
		</td>
		<td><div align="center"><%=nb.getTime()%></div>
		</td>
	</tr>
	<%
		}
		do {
	%>
	<tr bgcolor=<%=color[j % 2]%>>
		<td colspan="3">&nbsp;</td>
	</tr>
	<%
		} while (j++ < pageSize);
	%>
	<tr bgcolor="#E6F3FF">
		<td colspan="3" height="30px"><div align="center">
				<%
					if (pageCount > 1) {
						if (pageNow != 1) {
							if (pageCount > 8) {
				%>
				<a href=<%=userUri+"?function=..//common/notice_all&pageNow=1"%>>[��ҳ]</a>
				<%
					}
				%>
				<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
							+ (pageNow - 1)%>>��һҳ</a>
				<%
					}
						//ҳ����������8���������ҳ���ǩ
						if (pageCount < 8) {
							for (int i = 1; i <= pageCount; i++) {
								if (pageNow == i) {
				%><label><%=i%></label>
				<%
					} else {
				%>
				&nbsp;<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow <= 4) {//ҳ����������8����ǰҳ������4�����1~8
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
				%><label><%=i%></label>
				<%
					} else {
				%>
				&nbsp;<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						} else if (pageNow > pageCount - 4) {//�����8ҳ
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
				%><label><%=i%></label>
				<%
					} else {
				%>
				&nbsp;<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
									+ (pageCount - 8 + i)%>>[<%=pageCount - 8 + i%>]</a>&nbsp;
				<%
					}
							}
						} else {
							for (int i = 1; i <= 8; i++) {
								if (pageNow == i) {
				%><label><%=i%></label>
				<%
					} else {
				%>
				&nbsp;<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
									+ (pageNow + i - 4)%>>[<%=pageNow + i - 4%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%>
				<a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
							+ (pageNow + 1)%>>��һҳ</a>
				<%
					if (pageCount > 8) {
				%><a
					href=<%=userUri+"?function=..//common/notice_all&pageNow="
								+ pageCount%>>[βҳ]</a>
				<%
					}
						}
					}
				%>
			</div></td>
	</tr>
</table>