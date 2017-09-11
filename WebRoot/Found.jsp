<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<form action="SendEmailServlet" method="post">
	<%
    request.setCharacterEncoding("UTF-8");
	String err = request.getParameter("err");
  	if(err==null){
  		err="";
  	}
  	
  	
 %>

	<div align="center">
		<span>帐号</span> <input name="id" type="text" size="19" />
	</div>

	&nbsp;&nbsp;

	<div align="center">
		<span>邮箱</span> <input type="text" name="email" size="19" />

	</div>
	&nbsp;&nbsp;
	<div align="center"><%=err %>
	</div>

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div align="center">
		<input type="submit" value=" 确 定 "> <input type="reset"
			value=" 重 置 ">

	</div>
</form>

