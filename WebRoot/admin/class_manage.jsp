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
	function delConf(){
		return window.confirm("ɾ���༶��ɾ���ð༶������ѧ����ȷ��Ҫɾ����");
	}
	
	function addConf(){
		var stuNum = document.getElementById('stuNum').value;
		var cls_id = document.getElementById('cls_id').value;
		var major = document.getElementById('major').value;
		if(stuNum==""){
			alert("������༶������");
		}else if(checkClsExist(cls_id)){
			alert("�༶�Ѵ��ڣ�");
		}else if(major==""){
			alert("������רҵ���������רҵ��");
		}else{
			document.form2.action="StuManageServlet?flag=add_cls";
			document.form2.submit();
		}
	}
		
	function checkClsExist(cls_id){
		<%

		ArrayList al2 = new ClsBeanCl().getAllCls(yuanxi);
			for (int i = 0; i < al2.size(); i++) {%>
				if(cls_id=="<%=((ClsBean) al2.get(i)).getId()%>"){
					return true;
				}
		<%}%>
	
		return false;
	}
</script>

<form method="post" name="form2">
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="4" scope="col"><div align="left">�༶��Ϣ</div>
			</th>
		</tr>
		<tr height="50">
			<td width="20%"><div align="center">���</div>
			</td>
			<td width="40%"><div align="center">רҵ����</div>
			</td>
			<td width="20%"><div align="center">�༶����</div>
			</td>
			<td width="20%"><div align="center">����</div>
			</td>
		</tr>
		<%
			ArrayList al = new ClsBeanCl().getAllCls(yuanxi);
			for (int i = 0; i < al.size(); i++) {
		%>
		<tr>
			<td><div align="center"><%=((ClsBean) al.get(i)).getId()%></div>
			</td>
			<td><div align="center"><%=((ClsBean) al.get(i)).getMajorName()%></div>
			</td>
			<td><div align="center"><%=((ClsBean) al.get(i)).getStuNum()%></div>
			</td>
			<td><div align="center">
					<a  href=<%=path + "/admin/admin.jsp?function=class_modify&cls_id="+ ((ClsBean) al.get(i)).getId()%>>�޸�</a>/
					
					<a onclick="return delConf();"
						href="StuManageServlet?flag=del_cls&cls_id=<%=((ClsBean) al.get(i)).getId()%>">ɾ��</a>
				</div>
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="4"><div align="left">��Ӱ༶</div>
			</th>
		</tr>
		<tr>
			<td colspan="4"><div align="center">
					����༶�ţ�<input type="text" name="cls_id" id="cls_id"
						onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4"><div align="center">
					����༶������<input type="text" name="stuNum" id="stuNum"
						onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4"><div align="center">
					ѡ��רҵ���ƣ�<select id="major" name="major">
						<%
							ArrayList majorAl = new MajorBeanCl().getAllMajor(yuanxi);
							for (int i = 0; i < majorAl.size(); i++) {
								MajorBean mb = (MajorBean) majorAl.get(i);
						%>
						<option value=<%=mb.getMajor()%>><%=mb.getMajor()%></option>
						<%
							}
						%>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4"><div align="center">
					<input type="button" onclick="return addConf()" value="&nbsp;��&nbsp;��&nbsp;">
				</div>
			</td>
		</tr>
	</table>
</form>