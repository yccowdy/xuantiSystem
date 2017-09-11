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


	//检测是否已经存在
	function chenkExist() {

		var stuId = document.getElementById("stuId").value;
		if (stuId == "" || stuId == null) {
			document.getElementById("checkResult").innerHTML = "不能为空";
		} else {
			var request = createXmlHttpRequest();//创建request的对象
			request.open("post", "ExistCheckServlet?flag=stu_exist_check&stuId=" + stuId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true") {
						document.getElementById("checkResult").innerHTML = "账号已存在";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "√";
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
			alert("请正确输入学生人数！");
		} else {
			document.form3.action = "StuManageServlet?flag=batch_add_stu";
			document.form3.submit();
		}
	}

	function stuAddConf(){
		var checkResult = document.getElementById('checkResult').innerHTML;
		if(checkResult=="账号已存在"){
			alert("账号已存在");
		}else if(checkResult=="不能为空"){
			alert("账号不能为空");
		}else if(checkResult=="√"){
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
			<th colspan="3" scope="col"><div align="left">按班级批量添加学生</div></th>
		</tr>
		<tr>
			<td width="30%" align="center">选择班级：<select name="cls" id="cls"
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
					输入学生人数：<input type="text" width="100%" style="text-align:center;" name="stuNum" id="stuNum"
						value=<%=((ClsBean) clsAl.get(0)).getStuNum()%>
						onkeyup="value=value.replace(/[^\d]/g,'') " >
				</td>
			<td width="20%" align="center"><input type="submit"
				onclick="batchAddConf()" value="&nbsp;提&nbsp;交&nbsp;"></td>
		</tr>
		<tr>
			<td colspan="3"><span>（注：选择学生班级（如191101）和人数（如31）之后，会添加31个学生账号，从19110101-19110131。）</span></td>
		</tr>
	</table>
</form>


<form name="form4" method="post">

	<table border="1" width="65%">

		<tr>
			<th colspan="3" scope="col"><div align="left">逐个添加学生账号</div></th>
		</tr>
		<tr>
			<td>账&nbsp;&nbsp;号</td>
			<td><input type="text" id="stuId" name="stuId" onkeyup="value=value.replace(/[^\d]/g,'') " onblur="chenkExist()">
			<label id="checkResult" style="color:#FF6600;">*</label></td>
		</tr>
		<tr>
			<td>姓&nbsp;&nbsp;名</td>
			<td><input type="text" name="name" value="">
			</td>
		</tr>
		<tr>
			<td>性&nbsp;&nbsp;别</td>
			<td><select name="sex">
					<option value="男">男</option>
					<option value="女">女</option>
			</select></td>
		</tr>
		<tr>
			<td>班&nbsp;&nbsp;级</td>
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
			<td>专&nbsp;&nbsp;业</td>
			<td><input type="text" id="major" name="major" readonly="readonly" value=<%=((ClsBean)clsAl.get(0)).getMajorName() %>></td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td><input type="text" name="phoneNum">
			</td>
		</tr>
		<tr>
			<td>电子邮箱</td>
			<td><input type="text" name="email">
			</td>
		</tr>
		<tr>
			<td>选题权限</td>
			<td><select name="privilege">
					<option value="1">正常选题</option>
					<option value="-1">禁止选题</option>
			</select></td>
		</tr>
		<tr>
			<td colspan="2"><span>（注：账号格式为xxxYYxx..，其中第4、5位YY为该学生毕业年级，如00011000表明该生为11级学生，将于2015年毕业。默认初始密码与账号相同。）</span></td>
		</tr>
		<tr align="center">
			<td><input type="submit" onclick="stuAddConf()" value="提    交">
			</td>
			<td><input type="reset" value="重    置"></td>
		</tr>
		
	</table>
</form>
