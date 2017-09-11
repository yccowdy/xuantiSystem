<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<table class="dtree"  style="vertical-align:top">
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
			d.add("root", -1, '管理员');
			d.add("setup", "root", '初始设置');
			d.add("attentions", "setup", '注意事项', 'admin/admin.jsp?function=attentions');			
			d.add("psw_modify", "setup", '密码修改', 'admin/admin.jsp?function=psw_modify');
			d.add("settings", "setup", '通用设置', 'admin/admin.jsp?function=settings');
			d.add("tea_manage", "root", '老师管理');
			d.add("tea_all", "tea_manage", '老师信息', 'admin/admin.jsp?function=tea_all');
			d.add("tea_add", "tea_manage", '添加老师账号', 'admin/admin.jsp?function=tea_add');
			d.add("stu_manage", "root", '学生管理');
			d.add("major_manage", "stu_manage", '专业管理', 'admin/admin.jsp?function=major_manage');
			d.add("class_manage", "stu_manage", '班级管理', 'admin/admin.jsp?function=class_manage');
			d.add("stu_all", "stu_manage", '学生信息', 'admin/admin.jsp?function=stu_all');
			d.add("stu_add", "stu_manage", '添加学生', 'admin/admin.jsp?function=stu_add');
//			d.add("sub_Manage", "root", '题目管理');
//			d.add("sub_verify", "sub_Manage", '题目审核', 'admin/admin.jsp?function=sub_verify');
//			d.add("sub_add", "sub_Manage", '协助出题', 'admin/admin.jsp?function=sub_add');
			d.add("choose_Manage", "root", '选题统计');
			//d.add("sub_all", "choose_Manage", '所有题目', 'admin/admin.jsp?function=sub_all');
			d.add("sub_all1", "choose_Manage", '所有题目', 'admin/admin.jsp?function=sub_all1');
			d.add("choose_result", "choose_Manage", '选题状态','admin/admin.jsp?function=choose_result');
			
		//	d.add("choose_state", "choose_Manage", '选题状态1','admin/admin.jsp?function=choose_state');
			
			d.add("fail_stu", "choose_Manage", '统计落选学生','admin/admin.jsp?function=fail_stu');
			d.add("fail_sub", "choose_Manage", '统计落选题目','admin/admin.jsp?function=fail_sub');
			d.add("choose_fail", "choose_Manage", '落选与指派','admin/admin.jsp?function=fail');
			
			d.add("choose_result1","choose_Manage",'选题结果','admin/admin.jsp?function=choose_result1');
			
			d.add("notice", "root", '通知公告');
			d.add("stage", "notice", '选题阶段', 'admin/admin.jsp?function=stage');
			d.add("notice_all", "notice", '查看公告', 'admin/admin.jsp?function=notice_all');
			d.add("notice_add", "notice", '发布公告', 'admin/admin.jsp?function=notice_add');
			document.write(d);
		</script>

</table>

