<%@ page language="java" import="java.util.*,com.ax.subject.model.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" >
	
	function check(){
		var psw="<%=((StudentBean) session.getAttribute("user")).getPsw()%>";
 		var oldPsw=document.getElementById('oldPsw').value;
 		var newPsw1=document.getElementById('newPsw1').value;
 		var newPsw2=document.getElementById('newPsw2').value;
		if(psw!=oldPsw){
			alert("ԭ������������ԣ�");	
		}else if(newPsw1!=newPsw2)
		{
			alert("�������벻һ�£������ԣ�");
		}else{
			document.form1.action="UpdateDataServlet?flag=student_psw_modify";
     		document.form1.submit();
     	}

	}
</script>
<form action=""  name="form1" method="post">

<h2 >
<div style="padding-right: 63% ;padding-top: 20px; ">�޸ĵ�������</div>
<hr width="80%"> 
	<table border="0"   >
	<h3></h3>
		<%
			HttpSession hs = request.getSession(true);

			StudentBean tb = (StudentBean) hs.getAttribute("studentBean");
			
		%>
		<tr>
			<td width="100">ԭ����&nbsp&nbsp��</td>
			<td><input type="password" border="1" id="oldPsw" name="oldPsw"  ></td>
		</tr>
		<tr></tr>
		<tr>
			<td>������&nbsp&nbsp��</td>
			<td><input type="password" border="1" id="newPsw1"  name="newPsw1" ></td>
		</tr>
		<tr></tr>
		<tr>
			<td>�ٴ�����&nbsp��</td>
			<td><input type="password" border="1" id="newPsw2" name="newPsw2" ></td>
		</tr>
		<tr></tr>

		
			<tr align="center">
				<td><input type="submit" name="submit" onclick="check()" value="�޸�����"></td>
				<td><input type="reset" value="ȡ���޸�"></td>
			</tr>
	</table>
</form>