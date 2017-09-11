<%@ page language="java" import="java.util.*,com.ax.subject.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<h2 >
<div style="padding-right: 63% ;padding-top: 20px; ">个人信息查询</div>
<hr width="80%"> 
<table border="0" width="20%" >
<h3></h3>
	<%
		HttpSession hs = request.getSession(true);

		StudentBean tb = (StudentBean) hs.getAttribute("user");
	  
	    System.out.println(tb.getId());

	%>
	
	<tr>
		<td width="100%">账&nbsp&nbsp号：</td>
		<td><%=tb.getId() %></td>
	</tr>
	<tr></tr>
	<tr>
		<td>姓&nbsp&nbsp名：</td>
		<td><%=tb.getName()==null?"":tb.getName() %></td>
	</tr>
	<tr></tr>
	<tr>
		<td>性&nbsp&nbsp别：</td>
		<td><%=SEX.toStringValue(tb.getSex())+"" %></td>
	</tr>
	<tr></tr>
	<tr>
		<td>班&nbsp&nbsp级：</td>
		<td><%=tb.getCls()%></td>
	</tr>
	<tr></tr>
	<tr>
		<td>专&nbsp&nbsp业：</td>
		<td><%=tb.getMajor()%></td>
	</tr>
	<tr></tr>
	<tr>
		<td>电话号码：</td>
		<td><%=tb.getPhoneNum()==null?"":tb.getPhoneNum()%></td>
	</tr>
	<tr></tr>
	<tr>
		<td>电子邮箱：</td>
		<td><%=tb.getEmail()==null?"":tb.getEmail()%></td>
	</tr>
	

</table>
