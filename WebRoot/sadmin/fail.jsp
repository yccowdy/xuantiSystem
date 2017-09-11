<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";

	ArrayList<StudentBean> stuAl = new StuSubTeaBeanCl().getFailedStu();
	ArrayList<SubjectBean> subAl = new StuSubTeaBeanCl().getFailedSub();
	response.setCharacterEncoding("UTF-8");
%>
<script type="text/javascript">
	function setStuInfo(stuId,stuName,stuCls,stuMajor,i){//设置下方表格中选中的学生信息
		var pickStu = document.getElementsByName('pickStu');
		var pickedStuId = document.getElementById("pickedStuId");
		var pickedStuName = document.getElementById("pickedStuName");
		var pickedStuCls = document.getElementById("pickedStuCls");
		var pickedStuMajor = document.getElementById("pickedStuMajor");
		pickStu[i].checked = "checked";
		pickedStuId.innerHTML='账号：'+stuId;
		pickedStuName.innerHTML='姓名：'+stuName;
		pickedStuCls.innerHTML='班级：'+stuCls+'班';
		pickedStuMajor.innerHTML='专业：'+stuMajor;
	}
	
	//选中某行改背景色
	function setStuBgc(stuTrId) {
 		var stuRadioId = document.getElementById("stuRadioId").value;
		if (stuRadioId) {
			document.getElementById(stuRadioId).style.background = "";
		} 
		if (stuTrId) {
			document.getElementById(stuTrId).style.background = "#85B5E7";
			document.getElementById("stuRadioId").value = stuTrId;
		}
	}
	
	//选中某行改背景色
	function setSubBgc(subTrId) {
 		var subRadioId = document.getElementById("subRadioId").value;
		if (subRadioId) {
			document.getElementById(subRadioId).style.background = "";
		} 
		if (subTrId) {
			document.getElementById(subTrId).style.background = "#85B5E7";
			document.getElementById("subRadioId").value = subTrId;
		}
	}
	function setSubInfo(i){//设置下方表格中选中的题目的信息
		var pickSub = document.getElementsByName('pickSub');
		var subIntroduction = document.getElementsByName("subIntroduction");
		var subTitle = document.getElementsByName("subTitle");
		var pickedSubTitle = document.getElementById("pickedSubTitle");
		pickSub[i].checked = "checked";
		var pickedSubIntroduction = document.getElementById("pickedSubIntroduction");
		pickedSubTitle.innerHTML = '题目：'+subTitle[i].value;
		pickedSubIntroduction.innerHTML='题目简介：'+subIntroduction[i].value;
	}
	
	function getCheckedValue(radioObj) {
    if(!radioObj)
        return "";
    var radioLength = radioObj.length;
    if(radioLength == undefined)
        if(radioObj.checked)
            return radioObj.value;
        else
            return "";
    for(var i = 0; i < radioLength; i++) {
        if(radioObj[i].checked) {
            return radioObj[i].value;
        }
    }
    return "";
}
	function assign(){
		var pickStu = document.getElementsByName("pickStu");
		var pickStu = document.getElementsByName("pickStu");

		if(6!=<%=new StageBeanCl().getCurrentStage()%>){
			alert('现在不是调整结果阶段！');
			return;
		}
		
		if(getCheckedValue(document.getElementsByName("pickStu"))==""){
			alert('请选择一个学生！');
			return;
		}
		if(getCheckedValue(document.getElementsByName("pickSub"))==""){
			alert('请选择一个题目！');
			return;
		}

		document.form1.action="AssignServlet?flag=assign";
		document.form1.submit();
	}
	function autoAssign(){
		if(6!=<%=new StageBeanCl().getCurrentStage()%>){
//			alert('现在不是调整结果阶段！');
//			return;
		}
		if (<%=subAl.size()%> <= 0 || <%=stuAl.size() %><=0){
			alert('无落选题目或落选学生！');
			return;
		}
		document.form1.action="AssignServlet?flag=autoAssign";
		document.form1.submit();
	}
	function randomAssign(){
		if(6!=<%=new StageBeanCl().getCurrentStage()%>){
//			alert('现在不是调整结果阶段！');
//			return;
		}
		if (<%=subAl.size()%> <= 0 || <%=stuAl.size() %><=0){
			alert('无落选题目或落选学生！');
			return;
		}
		document.form1.action="AssignServlet?flag=randomAssign";
		document.form1.submit();
	}
</script>
<input type="hidden" name="stuRadioId" value="" id="stuRadioId" />
<input type="hidden" name="subRadioId" value="" id="subRadioId" />
<form name="form1" method="post">
	<table width="100%">
		<tr>
			<th colspan="5" width="46%">落选学生</th>
			<td width="6%"></td>
			<th colspan="4" width="48%">落选题目</th>
		</tr>
		<tr>
			<td width="6%" align="center">选择</td>
			<td width="7%" align="center">账号</td>
			<td width="7%" align="center">姓名</td>
			<td width="7%" align="center">班级</td>
			<td width="10%" align="center">专业</td>
			<td width="10%"></td>
			<td width="6%" align="center">选择</td>
			<td width="30%" align="center">题目</td>
			<td width="7%" align="center">老师</td>
			<td width="10%" align="center">方向</td>
		</tr>
		<tr>
			<td width="37%" colspan="5"><div
					style="overflow:auto;height:300px">
					<table border="0" width="100%" cellpadding="0" cellspacing="0">
						<%
							if (stuAl.size() <= 0) {
						%>
						<tr>
							<td align="center" colspan="5">无落选学生</td>
						</tr>
						<%
							} else {
								for (int i = 0; i < stuAl.size(); i++) {
									StudentBean sb = stuAl.get(i);
						%>
						<tr id="stuTr<%=i%>"
							onclick="setStuInfo('<%=sb.getId()%>','<%=sb.getName()%>','<%=sb.getCls()%>','<%=sb.getMajor()%>',<%=i%>);setStuBgc('stuTr'+<%=i%>)">
							<td align="center" width="6%"><input type="radio"
								name="pickStu" value="<%=sb.getId()%>"></td>
							<td align="center" width="10%"><%=sb.getId()%></td>
							<td align="center" width="10%"><%=sb.getName()%></td>
							<td align="center" width="10%"><%=sb.getCls()%></td>
							<td align="center" width="10%"><%=sb.getMajor()%></td>
						</tr>
						<%
							}
							}
						%>
					</table>
				</div>
			</td>
			<td width="10%"></td>
			<td width="53%" colspan="4"><div
					style="overflow:auto;height:300px">
					<table border="0" width="100%" cellpadding="0" cellspacing="0">
						<%
							if (subAl.size() <= 0) {
						%>
						<tr>
							<td align="center" colspan="4">无落选题目</td>
						</tr>
						<%
							} else {
								for (int i = 0; i < subAl.size(); i++) {
									SubjectBean subBean = subAl.get(i);
						%>
						<tr id="subTr<%=i%>"
							onclick="setSubInfo(<%=i%>);setSubBgc('subTr'+<%=i%>)">
							<td align="center" width="6%"><input type="radio"
								name="pickSub" value="<%=subBean.getId()%>"><input
								name="subIntroduction" type="hidden"
								value="<%=subBean.getIntroduction()%>"> <input
								name="subTitle" type="hidden"
								value="<%=subBean.getTitle()%>(<%=subBean.getTeacher()%>,<%=subBean.getDirection()%>) ">
							</td>
							<td align="center" width="30%"><%=subBean.getTitle()%></td>
							<td align="center" width="7%"><%=subBean.getTeacher()%></td>
							<td align="center" width="10%"><%=subBean.getDirection()%></td>
						</tr>
						<%
							}
							}
						%>
					</table>
				</div>
			</td>
		</tr>
		<tr height="50px"></tr>
		<tr>
			<td colspan="7"><div>
					<table border="1" width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<th colspan="4">指派题目</th>
						</tr>
						<tr>
							<td width="7%" align="center" id="pickedStuId">学生账号</td>
							<td width="7%" align="center" id="pickedStuName">姓名</td>
							<td width="7%" align="center" id="pickedStuCls">班级</td>
							<td width="7%" align="center" id="pickedStuMajor">专业</td>
						</tr>
						<tr>
							<td align="center" colspan="4" id="pickedSubTitle">题目</td>
						</tr>
						<tr>
							<td align="center" id="pickedSubIntroduction" colspan="4">题目简介</td>
						</tr>
					</table>
				</div></td>
			<td colspan="3"><div>
					<table border="0" width="60%" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><input type="button" value="确认指派"
								onclick="assign()"></td>
						</tr>
					</table>
				</div></td>
		</tr>
		<tr height="50px"></tr>
		<tr>
			<td align="center" colspan="3"><input type="button"
				value="随机指派落选学生" onclick="randomAssign()"></td>
			<td align="center"><input type="button" value="智能指派落选学生"
				onclick="autoAssign()"></td>
		</tr>
	</table>
</form>