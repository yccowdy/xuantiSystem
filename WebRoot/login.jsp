<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<title>毕业设计选题系统-用户登录</title>
<style type="text/css">
.STYLE4 {
	color: #FFFFFF;
	font-family: "楷体_GB2312";
	font-size: 24px;
	font-weight: bold;
}

.STYLE5 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 16px;
}

.STYLE7 {
	color: #0000FF;
	font-size: 16px;
}

.STYLE3 {
	font-size: 12px;
	color: #FFFFFF;
	text-decoration: none;
}
</style>

</head>
<script type="text/javascript">

	function reloadVer() {
	
	
		var verImage = document.getElementById("verImage");
		
		verImage.src = "verification_code.jsp"+"?" +new Date().getTime();
		
	 	}
</script>

<%
	request.setCharacterEncoding("UTF-8");
	String err = request.getParameter("err");
	if (err == null) {
		err = "";
	}
	//System.out.println("err=" + err);
%>
<%
  if(application.getAttribute("counter")==null)
  application.setAttribute("counter", "1");
  else{
  String strnum=null;
  strnum=application.getAttribute("counter").toString();
  int icount=0;
  icount=Integer.valueOf(strnum).intValue();
  icount++;
  application.setAttribute("counter", Integer.toString(icount));
  } %>
<body class="bg">
	<table width="100%" height="100%" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td align="center" valign="middle">
				<table width="817" height="384" border="0" cellpadding="0"
					cellspacing="0" background="images/login2.jpg">
					<tr>
						<td>&nbsp;</td>
						<td>
							<p align="left">
								<br> <br> <br>
							</p>
                           浏览量：<%=application.getAttribute("counter")%>
							<table width="95%" height="14" border="0" align="left"
								cellpadding="0" cellspacing="0">
								<tr>
									<td><span class="STYLE4 STYLE1">毕业设计选题系统</span></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td width="100">&nbsp;</td>
						<td height="239">
							<form action="LoginClServlet" method="post">

								<table width="85%" border="0" align="left" cellspacing="3">
									<tr>
										<td class="FontWit">&nbsp;</td>
										<td>&nbsp;</td>
										<td class="STYLE3">
											<div align="center" class="STYLE5"></div></td>
										<td width="8%" rowspan="5" class="STYLE3"></td>
									</tr>
									<tr>
										<td width="16%" class="FontWit">
											<div align="right">账号：</div></td>
										<td width="29%">
											<div align="left">
												<input name="id" type="text" size="19" />
											</div></td>
										<td width="47%" class="STYLE3"></td>
									</tr>
									<tr>
										<td class="FontWit">
											<div align="right">密 码：</div></td>
										<td>
											<div align="left">
												<input name="psw" type="password" size="19" />
											</div>
											</div></td>
										<td class="STYLE3"><a href="Found.jsp">忘记密码？</a><%=err%></td>
									</tr>


									<tr>
										<td class="FontWit">
											<div align="right">用户类型：</div></td>
										<td>
											<div align="left">
												<select name="u_type" id="u_type">

													<option value="stu">学 生</option>

													<option value="tea">教师</option>

													<option value="admin">管理员</option>
												</select>
											</div></td>
										<td class="STYLE3"><input name="ver" type="text"
											size="8"> <img id="verImage" src="verification_code.jsp"
											width="63" height="20" onclick="javascript:reloadVer()"/>
										
										</td>
									</tr>
									<tr>
										<td height="24" class="FontWit">
											<div align="right"></div></td>
										<td>
											<div align="left">
												<input type="submit" value=" 登 录 " /> <input type="reset"
													value=" 重 置 ">
											</div></td>
										<td class="STYLE3"></td>
									</tr>
									<tr>
									</tr>
									<tr>
										<td height="72"></td>
										<td>&nbsp;</td>
										<td colspan="2"></td>
									</tr>
								</table>
							</form></td>
					</tr>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<div align="center" class="FontWit">
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TBODY>
											<TR>
												<TD>
													<DIV align="center" class="FontWit">
														<p>
															武汉锐智图文www.paperlayout.com 鄂ICP备1509号 <A href="Found.jsp" target="_blank"
																class="STYLE3"></A> &nbsp;<a
																href="tencent://message/?uin=634411829"><img
																border="0" src="images/QQ.png"
																title="点击这里给我发消息" /> </a><br>
														</p>
													</DIV></TD>
											</TR>
										</TBODY>
									</TABLE>
								</div></td>
						</tr>
					</table>

				</table>
			</td>
		</tr>
	</table>


</body>
</html>
