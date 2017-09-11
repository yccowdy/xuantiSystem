<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	//������������
	response.setCharacterEncoding("UTF-8");
	String yuanxi=session.getAttribute("yuanxi").toString();
%>
<script type="text/javascript">

	function batchDelStu(){
		document.form4.action="StuManageServlet?flag=batch_del_stu";
		document.form4.submit();
	}

	function allCheck() {
		var checkbox=document.getElementsByName("pick");

		for(var i=0;i<checkbox.length;i++){
			checkbox[i].checked="checked";
		}
	}
	

	function inverse() {
		var checkbox = document.getElementsByName("pick");

		for ( var i = 0; i < checkbox.length; i++) {
			if (checkbox[i].checked)
				checkbox[i].checked = "";
			else
				checkbox[i].checked = "checked";
		}
	}

	function delConf() {
		return window.confirm("ȷ��Ҫɾ����ѧ����");
	}

	function setSelCls() {
		var selMajor = document.getElementById('selMajor');
		var selMajorValue = selMajor.value;
		var selCls = document.getElementById('selCls');
		selCls.options.length = 0;
		selCls.options.add(new Option("����","0")); 
		<%

		ArrayList alCls = new ClsBeanCl().getAllCls(yuanxi);
		%>
		if(selMajorValue == "0"){
			<%for(int k=0;k<alCls.size();k++){%>
				selCls.options.add(new Option("<%=((ClsBean)alCls.get(k)).getId()%>","<%=((ClsBean)alCls.get(k)).getId()%>"));
			<%}%>
		}else{
			<%
			for(int i=0;i<alCls.size();i++){
				ClsBean cb = (ClsBean)alCls.get(i);
			%>
				if(selMajorValue=="<%=cb.getMajorName()%>"){
				selCls.options.length = 0;
				selCls.options.add(new Option("����","0")); 
					<%
					int[] ClsArray = new ClsBeanCl().getClsByMajor(cb.getMajorName());
					for(int j=0;j<ClsArray.length;j++){%>
						selCls.options.add(new Option("<%=ClsArray[j]%>","<%=ClsArray[j]%>"));
					<%
					}
					%>
					
				}
			<%}%>
		}
	}
</script>
<%
	HttpSession hs = request.getSession(true);
	ArrayList<StudentBean> al=null;
	String selCls = (String) hs.getAttribute("selCls");
	String selMajor = (String) hs.getAttribute("selMajor");
	if (selCls == null)
		selCls = "0";
	if (selMajor == null) 
		selMajor = "0"; 
	if(!selCls.equals("0")){
		al = new StudentBeanCl().getStuByCls(selCls);
	}else if(!selMajor.equals("0")){
		al = new StudentBeanCl().getStuByMajor(selMajor);
	} else {
		al = new StudentBeanCl().getAllStu(yuanxi);
	}
	//��� ��ҳ������ ע������Ĵ��� 11.3
	//hs.removeAttribute("selCls");
	//hs.removeAttribute("selMajor");
	//����4����Ҳ���õ��ı���
	int pageSize = 15; //ÿҳ��ʾ�ļ�¼����
	int pageNow = 1; //��ǰ��ʾ�ڼ�ҳ
	int rowCount = al.size(); //��¼������
	int pageCount = (rowCount - 1) / pageSize + 1; //�ܹ�����ҳ

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<form action="StuManageServlet?flag=QueryByCriteria" method="post"
	name="form4">
	<table width="90%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="8" scope="col" height="50px" bgcolor="#E6F3FF"><div
					align="center">�鿴ѧ����Ϣ</div></th>
		</tr>
		<tr>
			<td colspan="8" scope="col" align="center" height="30px">ѡ��רҵ: <select
				id="selMajor" name="selMajor" onchange="setSelCls()">

					<option value="0">����</option>
					<%
						ArrayList<MajorBean> majorAl = new MajorBeanCl().getAllMajor(yuanxi);
						for (int i = 0; i < majorAl.size(); i++) {
							MajorBean mb = (MajorBean) majorAl.get(i);
					%>
					<option value=<%=mb.getMajor()%>
						<%=mb.getMajor().equals(selMajor) ? "selected" : ""%>><%=mb.getMajor()%></option>
					<%
						}
					%>
			</select> &nbsp;&nbsp;&nbsp;ѡ��༶:<select id="selCls" name="selCls">
					<option value="0">����</option>
					<%
						int[] clsArr=null;
						if (!selMajor.equals("0")) {
							clsArr = new ClsBeanCl().getClsByMajor(selMajor);
						}else{
							clsArr = new ClsBeanCl().getAllClsArr();
						}
						for (int i = 0; i < clsArr.length; i++) {
					%>
					<option value=<%=clsArr[i]%>
						<%=(clsArr[i] + "").equals(selCls) ? "selected" : ""%>><%=clsArr[i]%></option>
					<%
						}
					%>
			</select>&nbsp;&nbsp;<input type="submit" value="��ѯ">
			</td>
		</tr>
		<tr align="center" bgcolor="">
			<td height="30px" width="6%">ѡ��</td>
			<td width="13%">�˺�</td>
			<td width="13%">����</td>
			<td width="5%">�Ա�</td>
			<td width="13%">�༶</td>
			<td width="24%">רҵ</td>
			<td width="13%">Ȩ��</td>
			<td width="13%">����</td>
		</tr>
		<%
			for (int i = 0; i < (pageNow != pageCount ? pageSize : 1
					+ (rowCount - 1) % pageSize); i++) {
				StudentBean sb = al.get((pageNow - 1) * pageSize + i);
		%>
		<tr>
			<td align="center"><input type="checkbox" name="pick"
				value=<%=sb.getId()%>></td>
			<td align="center"><%=sb.getId()%></td>
			<td align="center"><a
				style="text-decoration:none; color: #2F492F;"
				href=<%=path+"/admin/admin.jsp?function=stu_modify&stuId="+sb.getId() %>><%=sb.getName().equals("")?sb.getId():sb.getName()%></a>
			</td>
			<td align="center"><%=SEX.toStringValue(sb.getSex())%></td>
			<td align="center"><%=sb.getCls()%></td>
			<td align="center"><%=sb.getMajor()%></td>
			<td align="center"><%=sb.getPrivilege()==1 ? "����" : "��ֹѡ��"%></td>
			<td align="center"><a
				href=<%=path+"/admin/admin.jsp?function=stu_modify&stuId="+sb.getId() %>>�޸�</a>/<a
				onclick="return delConf();"
				href="StuManageServlet?flag=stu_del&stuId=<%=sb.getId()%>">ɾ��</a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<%
			if(rowCount!=0){
			%>
			<td colspan="8" scope="col" align="center" height="30px">
				<%
				if(pageCount>8){
				%> <a href=<%="admin/admin.jsp?function=stu_all&pageNow=1" %>>[��ҳ]</a>
				<%
				}
				if (pageNow != 1) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + (pageNow - 1)%>>[��һҳ]</a>
				<%
				}
				if (pageCount < 8) {//ҳ����������8���������ҳ���ǩ
					for (int i = 1; i <= pageCount; i++) {
						if(pageNow==i){
						%> <label><%=i %></label>&nbsp; <%
						 }else{
						  %> <a href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%		}
					}
				} else if (pageNow <= 4) {//ҳ����������8����ǰҳ������4�����1~8
					for (int i = 1; i <= 8; i++) {
				 		if(pageNow==i){%> <label><%=i%></label>&nbsp; <%}else{ %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%		}
					}
				} else if (pageNow > pageCount - 4) {//�����8ҳ
						for (int i = pageCount-7; i <= pageCount; i++) {
							if(pageNow==i){%> <label><%=i%></label>&nbsp; <%	}else{ %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow=" + i%>>[<%=i%>]</a>&nbsp;
				<%			}
						}
					} else {//���ǰ3��4
						for (int i = pageNow-3; i <= pageNow+4; i++) {
							if(pageNow==i){%> <label><%=i%></label>&nbsp; <%
 	} else {
 %> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
									+ i%>>[<%=i%>]</a>&nbsp;
				<%
					}
							}
						}
						if (pageNow != pageCount) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
							+ (pageNow + 1)%>>[��һҳ]</a>
				<%
					}
						if (pageCount > 8) {
				%> <a
				href=<%="admin/admin.jsp?function=stu_all&pageNow="
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
			<td colspan="8" scope="col" align="left" height="30px"><a
				href="javascript:allCheck();">ȫѡ</a> <a href="javascript:inverse();">��ѡ</a>&nbsp;&nbsp;&nbsp;
				<input type="button" value="ɾ��ѡ��"
				onclick="javascript:batchDelStu();"></td>

		</tr>
	</table>
</form>