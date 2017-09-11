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
			d.add("attentions", "setup", '注意事项', 'sadmin/admin.jsp?function=attentions');			
			d.add("psw_modify", "setup", '密码修改', 'sadmin/admin.jsp?function=psw_modify');
			d.add("admin_manage", "root", '管理');
			d.add("tea_all", "admin_manage", '管理员信息', 'sadmin/admin.jsp?function=admin_all');
			d.add("tea_add", "admin_manage", '添加管理员账号', 'sadmin/admin.jsp?function=admin_add');
			d.add("notice", "root", '通知公告');
			d.add("stage", "notice", '选题阶段', 'sadmin/admin.jsp?function=stage');
			d.add("notice_all", "notice", '查看公告', 'sadmin/admin.jsp?function=notice_all');
			d.add("notice_add", "notice", '发布公告', 'sadmin/admin.jsp?function=notice_add');
			document.write(d);
		</script>

</table>

