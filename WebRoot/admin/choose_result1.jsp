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

	String[] color = { "#D3F0F3", "#E6F3FF" };//�����ɫ
	
	//����4����Ҳ���õ��ı���
	int pageSize = 10; //ÿҳ��ʾ�ļ�¼����
	int pageNow = 1; //��ǰ��ʾ�ڼ�ҳ
	int rowCount = arrSSTB.size(); //��¼������ 
	
	
	
	int pageCount = (rowCount - 1) / pageSize + 1; //�ܹ�����ҳ

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<script type="text/javascript">

    function exportExcel(){
	    document.form1.action="ExportServlet1";
	    document.form1.submit();
		/* alert('�����ƣ�'); */
	}

	function handle(state, subId, stuId, wish) {

		if (state == 1) {//����
			if (5 == wish) {//��������Ա��ָ��
				document.form1.action = "AssignServlet?flag=repeal&subId="
						+ subId + "&stuId=" + stuId;
			} else {//������ʦ��ѡ��
				document.form1.action = "ChooseServlet?flag=repeal&subId="
						+ subId + "&stuId=" + stuId;
			}
		} else if (state == 0) {//���д�־Ը
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
					align="center" style="font-size: 35px">ѡ&nbsp;��&nbsp;��&nbsp;��</div>
			</th>
		</tr>
		<!-- 		<tr>
			<td colspan="7" scope="col" align="center" height="30px">ѡ��רҵ: <select
				id="selMajor" name="selMajor" onchange="setSelCls()">

					<option value="0">����</option>

			</select> &nbsp;&nbsp;&nbsp;ѡ��༶:<select id="selCls" name="selCls">
					<option value="0">����</option>

			</select>&nbsp;&nbsp;<input type="button" value="ɸѡ">
			</td>
		</tr> -->
		<tr bgcolor="#50806F">
			<td height="30px" width="6%" align="center">���</td>
			<td width=50% align="center">��Ŀ</td>
			<td width=8% align="center">��ʦ</td>
			<td width=8% align="center">ѧ��</td>
			<td width=8% align="center">־Ը</td>
			<td width=8% align="center">״̬</td>
			<td width=8% align="center">����</td>
		</tr>
		<%
			int j = 0;
			
			String a="����";
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl();
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			for (; j < (pageNow != pageCount ? pageSize : 1 + (rowCount - 1)
					% pageSize); j++) {
				//��ȡ��ǰҳ������������ 
				StuSubTeaBean sstb = arrSSTB.get((pageNow-1)*pageSize+j);
				/*
				kangkang 2015.11.11
				�������ȡ��ʦѧ����Ŀ���ֵ���Ϣ
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
							+1%>>��ҳ</a>

				<%
					  
					
					
						if (pageNow != 1) {
								//out.println("pageNow=" + pageNow);
					%>

				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+ (pageNow - 1)%>>��һҳ</a>
				<%
						}
							//ҳ����������8���������ҳ���ǩ
							if (pageCount < 8) {
								for (int i = 1; i <= pageCount; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ i%>><%=i%></a>&nbsp
				<%
						}
							} else if (pageNow <= 4) {//ҳ����������8����ǰҳ������4�����1~8
								for (int i = 1; i <= 8; i++) {
					%>
				&nbsp<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
								+ i%>><%=i%></a>&nbsp
				<%
						}
							} else if (pageNow > pageCount - 4) {//�����8ҳ
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
							+ (pageNow + 1)%>>��һҳ</a>


				<%
						}
					%>

				<a
					href=<%="admin/admin.jsp?function=choose_result1&pageNow="
							+ pageCount%>>βҳ</a>

				<!--  <input type="text" name="pages" id="pages"  >
							 
							 <a href="#" onClick="test()">��ת</a> -->
		</td>
		<tr>
			<td colspan="7"><input type="button" value='����Excel��(����WPS���ϰ汾��)' onclick="exportExcel();">��ѡ����Ŀ��:<%=new StuSubTeaBeanCl().get1() %>&nbsp;ͬѧ��ѡ������:<%=new StuSubTeaBeanCl().get1()%></td>
		</tr>
	</table>
</form>