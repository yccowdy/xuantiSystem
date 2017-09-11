<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			response.setCharacterEncoding("UTF-8");
			String yuanxi=session.getAttribute("yuanxi").toString();
%>
<script type="text/javascript">

	function createXmlHttpRequest(){
	 	var xmlreq=false;
	 	if(window.XMLHttpRequest){
	 	xmlreq=new XMLHttpRequest();
	 	}else if(window.ActiveXobject){
		 	try{
			 xmlreq = new ActiveXobject("Msxm12.XMLHTTP");
			}catch(e1){
			 	try{
				 xmlreq = new ActiveXobject("Miscoft.XMLHTTP");
				 }catch(e2){
			 	}
		 	}
	 	}
	 	return xmlreq;	 
	}


	//����Ƿ��Ѿ�����
	function chenkExist() {

		var stuId = document.getElementById("stuId").value;
		if (stuId == "" || stuId == null) {
			document.getElementById("checkResult").innerHTML = "����Ϊ��";
		} else {
			var request = createXmlHttpRequest();//����request�Ķ���
			request.open("post", "ExistCheckServlet?flag=stu_exist_check&stuId=" + stuId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true") {
						document.getElementById("checkResult").innerHTML = "�˺��Ѵ���";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "��";
				}
			}
		}
	}

	function setStuNum() {
		var stuNum = document.getElementById('stuNum');
		var cls = document.getElementById('cls').value;
<%ArrayList clsAl1 = new ClsBeanCl().getAllCls(yuanxi);
			for (int i = 0; i < clsAl1.size(); i++) {
				ClsBean cb1 = (ClsBean) clsAl1.get(i);%>
				if (cls =="<%=cb1.getId()%>") {
			stuNum.value =
<%=cb1.getStuNum()%>
	;
			return;
		}
<%}%>
	}

	function batchAddConf() {
		var stuNum = document.getElementById('stuNum').value;
		if (stuNum == "" || stuNum == "0") {
			alert("����ȷ����ѧ��������");
		} else {
			document.form3.action = "StuManageServlet?flag=batch_add_stu";
			document.form3.submit();
		}
	}

	function stuAddConf(){
		var checkResult = document.getElementById('checkResult').innerHTML;
		if(checkResult=="�˺��Ѵ���"){
			alert("�˺��Ѵ���");
		}else if(checkResult=="����Ϊ��"){
			alert("�˺Ų���Ϊ��");
		}else if(checkResult=="��"){
			document.form4.action="StuManageServlet?flag=add_stu";
			document.form4.submit();
		}
	}
	
	function setMajor(){
		var cls = document.getElementById('class').value;
		var major = document.getElementById('major');
		<%ArrayList clsAl2 = new ClsBeanCl().getAllCls(yuanxi);
			for (int i = 0; i < clsAl2.size(); i++) {
				ClsBean cb2 = (ClsBean) clsAl2.get(i);%>
				if (cls =="<%=cb2.getId()%>") {
			major.value ="<%=cb2.getMajorName() %>"
	;
			return;
		}
<%}%>
	}
</script>
<style>
span{
	color:#850B4B;
	font-size:15px;
}
</style>
<form name="form3" method="post">
	<table width="65%" height="120" border="1" cellpadding="0"
		cellspacing="0">
		<tr>
			<th colspan="3" scope="col"><div align="left">���༶�������ѧ��</div></th>
		</tr>
		<tr>
			<td width="30%" align="center">ѡ��༶��<select name="cls" id="cls"
				onchange="setStuNum()">
					<%
						ArrayList clsAl = new ClsBeanCl().getAllCls(yuanxi);
						for (int i = 0; i < clsAl.size(); i++) {
							ClsBean cb = (ClsBean) clsAl.get(i);
					%>
					<option value=<%=cb.getId()%>><%=cb.getId()%></option>
					<%
						}
					%>
			</select></td>
			<td width="50%" align="center">
					����ѧ��������<input type="text" width="100%" style="text-align:center;" name="stuNum" id="stuNum"
						value=<%=((ClsBean) clsAl.get(0)).getStuNum()%>
						onkeyup="value=value.replace(/[^\d]/g,'') " >
				</td>
			<td width="20%" align="center"><input type="submit"
				onclick="batchAddConf()" value="&nbsp;��&nbsp;��&nbsp;"></td>
		</tr>
		<tr>
			<td colspan="3"><span>��ע��ѡ��ѧ���༶����191101������������31��֮�󣬻����31��ѧ���˺ţ���19110101-19110131����</span></td>
		</tr>
	</table>
</form>


<form name="form4" method="post">

	<table border="1" width="65%">

		<tr>
			<th colspan="3" scope="col"><div align="left">������ѧ���˺�</div></th>
		</tr>
		<tr>
			<td>��&nbsp;&nbsp;��</td>
			<td><input type="text" id="stuId" name="stuId" onkeyup="value=value.replace(/[^\d]/g,'') " onblur="chenkExist()">
			<label id="checkResult" style="color:#FF6600;">*</label></td>
		</tr>
		<tr>
			<td>��&nbsp;&nbsp;��</td>
			<td><input type="text" name="name" value="">
			</td>
		</tr>
		<tr>
			<td>��&nbsp;&nbsp;��</td>
			<td><select name="sex">
					<option value="��">��</option>
					<option value="Ů">Ů</option>
			</select></td>
		</tr>
		<tr>
			<td>��&nbsp;&nbsp;��</td>
			<td><select name="class" id="class" onchange="setMajor()">
					<%
						for (int i = 0; i < clsAl.size(); i++) {
							ClsBean cb = (ClsBean) clsAl.get(i);
					%>
					<option value=<%=cb.getId()%>><%=cb.getId()%></option>
					<%
						}
					%>
			</select>
			</td>
		</tr>
		<tr>
			<td>ר&nbsp;&nbsp;ҵ</td>
			<td><input type="text" id="major" name="major" readonly="readonly" value=<%=((ClsBean)clsAl.get(0)).getMajorName() %>></td>
		</tr>
		<tr>
			<td>�绰����</td>
			<td><input type="text" name="phoneNum">
			</td>
		</tr>
		<tr>
			<td>��������</td>
			<td><input type="text" name="email">
			</td>
		</tr>
		<tr>
			<td>ѡ��Ȩ��</td>
			<td><select name="privilege">
					<option value="1">����ѡ��</option>
					<option value="-1">��ֹѡ��</option>
			</select></td>
		</tr>
		<tr>
			<td colspan="2"><span>��ע���˺Ÿ�ʽΪxxxYYxx..�����е�4��5λYYΪ��ѧ����ҵ�꼶����00011000��������Ϊ11��ѧ��������2015���ҵ��Ĭ�ϳ�ʼ�������˺���ͬ����</span></td>
		</tr>
		<tr align="center">
			<td><input type="submit" onclick="stuAddConf()" value="��    ��">
			</td>
			<td><input type="reset" value="��    ��"></td>
		</tr>
		
	</table>
</form>
