<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<table class="dtree"  style="vertical-align:top"height="800">
	<script type="text/javascript"  style="vertical-align:top">
			d = new dTree('d');
			/*
			dTree.add(id,pid,name,url,title,target,icon,iconOpen,open); 
			id:当前节点标识, 
			pid:父节点标识,
			name:当前节点名字,
			url:当菜单被点击时响应的超链接,
			title:提示语（鼠标放上去的提示）
			target:在目标窗口打开链接（没弄懂）
			icon:关闭时的显示图标,
			iconOpen:打开时的显示图标,
			open:默认的打开状态,
			true打开,
			false关闭(不过它会读cookie, 所以有时看不出效果)			
			*/
			d.add("root", -1, '学生操作');
			d.add("info", "root", '个人信息');
			d.add("info_view", "info", '我的信息', 'student/student.jsp?function=info_view');
			d.add("info_modify", "info", '信息编辑', 'student/student.jsp?function=info_modify');
			d.add("psw_modify", "info", '密码修改', 'student/student.jsp?function=psw_modify');
			d.add("choose","root",'选题');
			d.add("sub1_choose", "choose", '选择题目志愿', 'student/student.jsp?function=sub_all');
			d.add("sub2_choose", "choose", '选择备选题目', 'student/student.jsp?function=sub_all1');
			d.add("chakan_choss","choose",'查看已选题数','student/student.jsp?function=chakan_choose');
			//d.add("documents","choose",'毕业设计指导书','student/student.jsp?function=documents');
			
			d.add("choose_info", "root", '选题信息');
			d.add("not_info", "choose_info", '通告信息', 'student/student.jsp?function=..//common/notice_all');
			d.add("not_chooseStage", "choose_info", '选题阶段', 'student/student.jsp?function=..//common/stage');
			
			
			document.write(d);
		</script>

</table>

