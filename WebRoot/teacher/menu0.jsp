<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<table class="dtree"  style="vertical-align:top">
	<script type="text/javascript"  style="vertical-align:top">
			d = new dTree('d');
			d.add("root", -1, '��ʦ����');
			d.add("info", "root", '������Ϣ');
			d.add("info_view", "info", '�ҵ���Ϣ', 'teacher/teacher.jsp?function=info_view');
			d.add("info_modify", "info", '��Ϣ�༭', 'teacher/teacher.jsp?function=info_modify');
			d.add("psw_modify", "info", '�����޸�', 'teacher/teacher.jsp?function=psw_modify');
			d.add("subject", "root", '�������');
			d.add("sub_mine", "subject", '�ҵ���Ŀ', 'teacher/teacher.jsp?function=sub_mine');
			d.add("sub_add", "subject", '�����Ŀ', 'teacher/teacher.jsp?function=sub_add');
			d.add("sub_all", "subject", '������Ŀ', 'teacher/teacher.jsp?function=sub_all');
			d.add("sub_all1", "subject", '������Ŀ', 'teacher/teacher.jsp?function=sub_all1');
			//d.add("document", "subject", '��ҵ���ָ����', 'teacher/teacher.jsp?function=document');
			d.add("sub_choose", "root", 'ѡ�����');
			//d.add("choose_stu", "sub_choose", 'ѡ��ѧ��', 'teacher/teacher.jsp?function=choose_stu');
			d.add("choose_stu1", "sub_choose", 'ѡ��ѧ��', 'teacher/teacher.jsp?function=choose_stu1');
			//d.add("result", "sub_choose", 'ѡ����', 'teacher/teacher.jsp?function=choose_result');
			
			//d.add("result2", "sub_choose", 'ѡ����2', 'teacher/teacher.jsp?function=choose_result2');
			d.add("notice", "root", '֪ͨ����');
			d.add("not_chooseStage", "notice", 'ѡ��׶�', 'teacher/teacher.jsp?function=..//common/stage');
			d.add("not_info", "notice", 'ͨ����Ϣ', 'teacher/teacher.jsp?function=..//common/notice_all');
			
			document.write(d);
		</script>

</table>

