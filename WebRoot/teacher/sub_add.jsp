<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	response.setCharacterEncoding("UTF-8");
%>

<script type="text/javascript">
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

	function chenkExist() {
		var title = document.getElementById("title").value;
		var teaId = document.getElementById("teaId").value;
		if (title == "" || title == null || title == "此处填写标题") {
			document.getElementById("checkResult").innerHTML = "(不能为空)";
		} else {
			var request = createXmlHttpRequest();//创建request的对象
			request.open("post",
					"ExistCheckServlet?flag=title_exist_check&title=" + title
							+ "&teaId=" + teaId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true") {
						document.getElementById("checkResult").innerHTML = "(已存在)";
					} else if (value == "self") {
						document.getElementById("checkResult").innerHTML = "(此题已出，可修改)";
					} else if (value == "limited") {
						document.getElementById("checkResult").innerHTML = "(已达最大出题数)";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "(√)";
				}
			}
		}
	}

	function addSubConf() {
		var title = document.getElementsByName("title").value;
		var checkResult = document.getElementById("checkResult").innerHTML;
		if (title == "" || title == "(此处填写标题)") {
			alert("标题不能为空！");
		} else if (checkResult == "(已存在)") {
			alert("此标题的题目已有其他老师出题，不能出同名题目！");
		} else if (checkResult == "(此题已出，可修改)") {
			alert("您已经出过此题，可以在“出题管理   我的题目”中修改");
		} else if (checkResult == "(√)") {
			document.form1.action = "TeaSubManageServlet?flag=sub_add";
			document.form1.submit();
		}
	}
</script>
<%
	HttpSession hs = request.getSession(true);
	TeacherBean tb = (TeacherBean) hs.getAttribute("user");

	int[] s_id = new TeacherSubBeanCl().getS_id(tb.getId()); //获取老师所有题目的id
	int stage = new StageBeanCl().getCurrentStage(); //获取当前的阶段

	if (s_id != null && s_id.length >= tb.getMaxSubNum()) {
%>
<table>
	<tr></tr>
	<tr></tr>
	<tr></tr>
	<tr>
		<th>您已经添加了<%=s_id.length%>道题，达到出题上限，不能再出题。如有疑问请联系 系统管理员！</th>
	</tr>

</table>

<%
	} else if (stage != 1) {
%>
<table>
	<tr></tr>
	<tr></tr>
	<tr></tr>
	<tr>
		<th>现在不是出题阶段，点击<a
			href="teacher/teacher.jsp?function=..//common/stage">选题阶段</a>查看各阶段时间详情！</th>
	</tr>

</table>

<%
	} else {
%>
<form name="form1" method="post">
	<table width="100%" border="1" cellpadding="0" cellspacing="0">
		<tr height="30">
			<th colspan="2" scope="row" bgcolor="#E6F3FF">新题目详细信息</th>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr height="30">
			<th width="30%" scope="row">标 题<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					id="title" name="title" onfocus="if(value=='此处填写标题'){value=''}"
					onblur="if (value ==''){value='此处填写标题'} chenkExist()">此处填写标题</textarea>
				<input type="hidden" id="teaId" value=<%=tb.getId()%>>
			</td>
		</tr>
		<!-- 11.5添加关键字 -->
		<tr height="30">
			<th width="30%" scope="row">关键词<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					id="key" name="key" onfocus="if(value=='此处填写关键字'){value=''}"
					onblur="if (value ==''){value='此处填写关键字'}">此处填写关键字</textarea>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">出题人</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="teacher" readonly="readonly"><%=tb.getName()%></textarea>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">题目方向</th>
			<td><select name="direction">
					<%
						ArrayList al = new DirectionCl().getAllDirec();
							for (int i = 0; i < al.size(); i++) {
					%>
					<option value="<%=((Direction) al.get(i)).getDirection()%>"><%=((Direction) al.get(i)).getDirection()%></option>
					<%
						}
					%>
			</select></td>
		</tr>
		<tr height="100">
			<th scope="row">题目简介</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="introduction" onfocus="if(value=='此处填写题目简介'){value=''}"
					onblur="if (value ==''){value='此处填写题目简介'}">此处填写题目简介</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">进程安排</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="schedule" onfocus="if(value=='此处填写进程安排'){value=''}"
					onblur="if (value ==''){value='此处填写进程安排'}">此处填写进程安排</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">参考文献</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="reference" onfocus="if(value=='此处填写参考文献'){value=''}"
					onblur="if (value ==''){value='此处填写参考文献'}">此处填写参考文献</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">学生要求</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="requirement" onfocus="if(value=='此处填写学生要求'){value=''}"
					onblur="if (value ==''){value='此处填写学生要求'}">此处填写学生要求</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">所属领域</th>
			<td>
			 <label>
<input type="checkbox" name="domain" value="智能计算、数据挖掘与机器学习" />
智能计算、数据挖掘与机器学习</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="地学信息处理"  />
         地学信息处理</label>
	 
			    <label>
			      <input type="checkbox" name="domain" value="图形图像与科学计算可视化"  />
			      图形图像与科学计算可视化</label>
	
			    <label>
			      <input type="checkbox" name="domain" value="通信安全和数据网络安全" />
			      通信安全和数据网络安全</label>

			    <label>
			      <input type="checkbox" name="domain" value="高性能计算" />
			      高性能计算</label>
	   
			    
	 
			    <label>
			      <input type="checkbox" name="domain" value="演化硬件、嵌入式系统智能机器人" />
			      演化硬件、嵌入式系统智能机器人</label>

			    <label>
			      <input type="checkbox" name="domain" value="多媒体通信安全"  />
			      多媒体通信安全</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="智能计算安全应用"  />
			      智能计算安全应用</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="空间信息安全" />
			      空间信息安全</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="密码学应用技术"  />
			      密码学应用技术</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="资源环境物联网安全"  />
			      资源环境物联网安全</label>
	  
			    <label>
			      <input type="checkbox" name="domain" value="数字国土工程理论与技术" />
			      数字国土工程理论与技术</label>
	 
			    <label>
			      <input type="checkbox" name="domain" value="三维可视化地学建模"  />
			      三维可视化地学建模</label>
	  
			    <label>
			      <input type="checkbox" name="domain" value="数据挖掘及地学应用"  />
			      数据挖掘及地学应用</label>
	    
			    <label>
			      <input type="checkbox" name="domain" value="多目标规划地学应用" />
			      多目标规划地学应用</label>

			    <label>
			      <input type="checkbox" name="domain" value="智能计算及其应用"  />
			      智能计算及其应用</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="数据挖掘与机器学习"  />
			      数据挖掘与机器学习</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="空间数据库技术" />
			      空间数据库技术</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="图形图像与计算可视化"/>
			      图形图像与计算可视化框</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="网络工程及应用" />
			      网络工程及应用</label>
	    
			    <label>
			      <input type="checkbox" name="domain" value="数字国土工程" />
			      数字国土工程</label>
	      数字国土工程</label>
	    
			</td>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
			<td>&nbsp;</td>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><input
				type="button" onclick="addSubConf()" value="提交"></th>
		</tr>
	</table>
</form>
<%}%>