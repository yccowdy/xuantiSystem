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
			d.add("attentions", "setup", 'ע������', 'sadmin/admin.jsp?function=attentions');			
			d.add("psw_modify", "setup", '�����޸�', 'sadmin/admin.jsp?function=psw_modify');
			d.add("admin_manage", "root", '����');
			d.add("tea_all", "admin_manage", '����Ա��Ϣ', 'sadmin/admin.jsp?function=admin_all');
			d.add("tea_add", "admin_manage", '��ӹ���Ա�˺�', 'sadmin/admin.jsp?function=admin_add');
			d.add("notice", "root", '֪ͨ����');
			d.add("stage", "notice", 'ѡ��׶�', 'sadmin/admin.jsp?function=stage');
			d.add("notice_all", "notice", '�鿴����', 'sadmin/admin.jsp?function=notice_all');
			d.add("notice_add", "notice", '��������', 'sadmin/admin.jsp?function=notice_add');
			document.write(d);
		</script>

</table>

