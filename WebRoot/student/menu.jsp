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
			d.add("root", -1, 'ѧ������');
			d.add("info", "root", '������Ϣ');
			d.add("info_view", "info", '�ҵ���Ϣ', 'student/student.jsp?function=info_view');
			d.add("info_modify", "info", '��Ϣ�༭', 'student/student.jsp?function=info_modify');
			d.add("psw_modify", "info", '�����޸�', 'student/student.jsp?function=psw_modify');
			d.add("choose","root",'ѡ��');
			d.add("sub1_choose", "choose", 'ѡ����Ŀ־Ը', 'student/student.jsp?function=sub_all');
			d.add("sub2_choose", "choose", 'ѡ��ѡ��Ŀ', 'student/student.jsp?function=sub_all1');
			d.add("chakan_choss","choose",'�鿴��ѡ����','student/student.jsp?function=chakan_choose');
			//d.add("documents","choose",'��ҵ���ָ����','student/student.jsp?function=documents');
			
			d.add("choose_info", "root", 'ѡ����Ϣ');
			d.add("not_info", "choose_info", 'ͨ����Ϣ', 'student/student.jsp?function=..//common/notice_all');
			d.add("not_chooseStage", "choose_info", 'ѡ��׶�', 'student/student.jsp?function=..//common/stage');
			
			
			document.write(d);
		</script>

</table>

