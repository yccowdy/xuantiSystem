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
			id:��ǰ�ڵ��ʶ, 
			pid:���ڵ��ʶ,
			name:��ǰ�ڵ�����,
			url:���˵������ʱ��Ӧ�ĳ�����,
			title:��ʾ�������ȥ����ʾ��
			target:��Ŀ�괰�ڴ����ӣ�ûŪ����
			icon:�ر�ʱ����ʾͼ��,
			iconOpen:��ʱ����ʾͼ��,
			open:Ĭ�ϵĴ�״̬,
				true��,
				false�ر�(���������cookie, ������ʱ������Ч��)			
			*/
			d.add("root", -1, '����Ա');
			d.add("setup", "root", '��ʼ����');
			d.add("attentions", "setup", 'ע������', 'admin/admin.jsp?function=attentions');			
			d.add("psw_modify", "setup", '�����޸�', 'admin/admin.jsp?function=psw_modify');
			d.add("settings", "setup", 'ͨ������', 'admin/admin.jsp?function=settings');
			d.add("tea_manage", "root", '��ʦ����');
			d.add("tea_all", "tea_manage", '��ʦ��Ϣ', 'admin/admin.jsp?function=tea_all');
			d.add("tea_add", "tea_manage", '�����ʦ�˺�', 'admin/admin.jsp?function=tea_add');
			d.add("stu_manage", "root", 'ѧ������');
			d.add("major_manage", "stu_manage", 'רҵ����', 'admin/admin.jsp?function=major_manage');
			d.add("class_manage", "stu_manage", '�༶����', 'admin/admin.jsp?function=class_manage');
			d.add("stu_all", "stu_manage", 'ѧ����Ϣ', 'admin/admin.jsp?function=stu_all');
			d.add("stu_add", "stu_manage", '���ѧ��', 'admin/admin.jsp?function=stu_add');
//			d.add("sub_Manage", "root", '��Ŀ����');
//			d.add("sub_verify", "sub_Manage", '��Ŀ���', 'admin/admin.jsp?function=sub_verify');
//			d.add("sub_add", "sub_Manage", 'Э������', 'admin/admin.jsp?function=sub_add');
			d.add("choose_Manage", "root", 'ѡ��ͳ��');
			//d.add("sub_all", "choose_Manage", '������Ŀ', 'admin/admin.jsp?function=sub_all');
			d.add("sub_all1", "choose_Manage", '������Ŀ', 'admin/admin.jsp?function=sub_all1');
			d.add("choose_result", "choose_Manage", 'ѡ��״̬','admin/admin.jsp?function=choose_result');
			
		//	d.add("choose_state", "choose_Manage", 'ѡ��״̬1','admin/admin.jsp?function=choose_state');
			
			d.add("fail_stu", "choose_Manage", 'ͳ����ѡѧ��','admin/admin.jsp?function=fail_stu');
			d.add("fail_sub", "choose_Manage", 'ͳ����ѡ��Ŀ','admin/admin.jsp?function=fail_sub');
			d.add("choose_fail", "choose_Manage", '��ѡ��ָ��','admin/admin.jsp?function=fail');
			
			d.add("choose_result1","choose_Manage",'ѡ����','admin/admin.jsp?function=choose_result1');
			
			d.add("notice", "root", '֪ͨ����');
			d.add("stage", "notice", 'ѡ��׶�', 'admin/admin.jsp?function=stage');
			d.add("notice_all", "notice", '�鿴����', 'admin/admin.jsp?function=notice_all');
			d.add("notice_add", "notice", '��������', 'admin/admin.jsp?function=notice_add');
			document.write(d);
		</script>

</table>

