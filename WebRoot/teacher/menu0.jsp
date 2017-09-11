<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<table class="dtree"  style="vertical-align:top">
	<script type="text/javascript"  style="vertical-align:top">
			d = new dTree('d');
			d.add("root", -1, '老师操作');
			d.add("info", "root", '个人信息');
			d.add("info_view", "info", '我的信息', 'teacher/teacher.jsp?function=info_view');
			d.add("info_modify", "info", '信息编辑', 'teacher/teacher.jsp?function=info_modify');
			d.add("psw_modify", "info", '密码修改', 'teacher/teacher.jsp?function=psw_modify');
			d.add("subject", "root", '命题管理');
			d.add("sub_mine", "subject", '我的题目', 'teacher/teacher.jsp?function=sub_mine');
			d.add("sub_add", "subject", '添加题目', 'teacher/teacher.jsp?function=sub_add');
			d.add("sub_all", "subject", '本年题目', 'teacher/teacher.jsp?function=sub_all');
			d.add("sub_all1", "subject", '往年题目', 'teacher/teacher.jsp?function=sub_all1');
			//d.add("document", "subject", '毕业设计指导书', 'teacher/teacher.jsp?function=document');
			d.add("sub_choose", "root", '选题管理');
			//d.add("choose_stu", "sub_choose", '选择学生', 'teacher/teacher.jsp?function=choose_stu');
			d.add("choose_stu1", "sub_choose", '选择学生', 'teacher/teacher.jsp?function=choose_stu1');
			//d.add("result", "sub_choose", '选题结果', 'teacher/teacher.jsp?function=choose_result');
			
			//d.add("result2", "sub_choose", '选题结果2', 'teacher/teacher.jsp?function=choose_result2');
			d.add("notice", "root", '通知公告');
			d.add("not_chooseStage", "notice", '选题阶段', 'teacher/teacher.jsp?function=..//common/stage');
			d.add("not_info", "notice", '通告信息', 'teacher/teacher.jsp?function=..//common/notice_all');
			
			document.write(d);
		</script>

</table>

