<%@ page language="java" import="java.util.*,com.ax.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<script type="text/javascript">
function changeMajor(){
	var cls = document.getElementById("selCls");

	var major = document.getElementById("major");
<%
	ArrayList<ClassMajorBean> ACMB = new ClassMajorBeanCl().getAllClassMajorBean();
	int index=0;
	%>
	<%
	for(int i=0;i<ACMB.size() ;i++){
		
			ClassMajorBean cmb = ACMB.get(index++);
		%>
		if(cls.value==<%=cmb.getId() %>){
			major.value='<%=cmb.getMajorname() %>';
			index=0;
		}
	<%}%>
	
}
	function createXmlHttpRequest() {
		var xmlreq = false;
		if (window.XMLHttpRequest) {
			xmlreq = new XMLHttpRequest();
		} else if (window.ActiveXobject) {
			try {
				xmlreq = new ActiveXobject("Msxm12.XMLHTTP");
			} catch (e1) {
				try {
					xmlreq = new ActiveXobject("Miscoft.XMLHTTP");
				} catch (e2) {
				}
			}
		}
		return xmlreq;
	}
function checkPhoneExist() {
		var pm = document.getElementById("phoneNum").value;
		var id = document.getElementById("id").value;
		
		var request = createXmlHttpRequest();//创建request的对象
			request.open("post",
					"ExistCheckServlet?flag=phoneNum_exist_check&phoneNum=" + pm
							+ "&id=" + id);
			request.send();
			request.onreadystatechange = function(){
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true"&&pm!='') {
						alert("电话号码已存 在请重新输入！");
					}else if(pm=='')
					{    
					    alert("电话号码不能为空！");
					}
	            }
	       }
	      
		
	}
	function checkEmailExist(){
	var id = document.getElementById("id").value;
	var email = document.getElementById("email").value;
	var request = createXmlHttpRequest();//创建request的对象
			request.open("post",
					"ExistCheckServlet?flag=email_exist_check&email=" + email
							+ "&id=" + id);
			request.send();
			request.onreadystatechange = function(){
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true"&&email!='') {
						alert("邮箱已存在 请重新输入！");
					}else if(email=='')
					{    
					    alert("邮箱不能为空！");
					    
					}
					
	            }
	       }
	      
		
	}

</script> 
<form  action="UpdateDataServlet?flag=student_info_modify" method="post">
<h2 >
<div style="padding-right: 63% ;padding-top: 20px; ">个人信息编辑</div>
<hr width="80%"> 
	<table border="0">

<h3></h3>
		<%
			HttpSession hs = request.getSession(true);
			ClassMajorBeanCl cmbc = new ClassMajorBeanCl();
			StudentBean tb = (StudentBean) hs.getAttribute("user");
			response.setCharacterEncoding("UTF-8");
		%>
		<tr>
			<td width="100">账&nbsp&nbsp&nbsp&nbsp号：</td>
			<td><input type="text" border="1" name="id" id="id"
				readonly="readonly" value=<%=tb.getId()%>></td>
		</tr>
		<tr></tr>
		<tr>
			<td>姓&nbsp&nbsp&nbsp&nbsp名：</td>
			<td><input type="text" border="1" name="name"
				value=<%=tb.getName()==null?"":tb.getName()%>>
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td>性&nbsp&nbsp&nbsp&nbsp别：</td>
			<td><select name="sex">
					<option value="男" <%=tb.getSex() == SEX.MALE ? "selected" : ""%>>男</option>
					<option value="女" <%=tb.getSex() == SEX.FEMALE ? "selected" : ""%>>女</option>
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td>班&nbsp&nbsp&nbsp&nbsp级：</td>
			<td><select id="selCls" name="selCls" onchange="changeMajor()">
					<% 
					int []AllClassId = cmbc.getClassId();
					for(int i=0;i<cmbc.getClassId().length;i++){
					
					%><option value=<%=AllClassId[i] %>
						<%=tb.getCls().equals(AllClassId[i]+"") ? "selected":"" %>><%=AllClassId[i] %></option>
					<% 
					}
					    %>
			</select>
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td>专&nbsp&nbsp&nbsp&nbsp业：</td>
			<td><input id="major" type="text" border="1" name="major"
				value=<%=tb.getMajor()%> readonly="readonly"></td>

		</tr>
		<tr></tr>
		<tr>

			<td>电话号码：</td>
			<td><input type="text" border="1" name="phoneNum" id="phoneNum"
				value="<%=tb.getPhoneNum()==null?"":tb.getPhoneNum()%>"
				onblur="checkPhoneExist()"></td>
		</tr>

        <tr></tr>
		<tr>
			<td>电子邮箱：</td>
			<td><input type="text" border="1" name="email" id="email"
				value="<%=tb.getEmail()==null?"":tb.getEmail()%>"  
				onblur="checkEmailExist()"></td>
		</tr>
        <tr></tr>
		<tr>
			<td><input type="submit" value="保存修改" ></td>
		</tr>

	</table>
</form>