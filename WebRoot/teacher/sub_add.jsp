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
		if (title == "" || title == null || title == "�˴���д����") {
			document.getElementById("checkResult").innerHTML = "(����Ϊ��)";
		} else {
			var request = createXmlHttpRequest();//����request�Ķ���
			request.open("post",
					"ExistCheckServlet?flag=title_exist_check&title=" + title
							+ "&teaId=" + teaId);
			request.send();
			request.onreadystatechange = function() {
				if (request.readyState == 4 & request.status == 200) {
					var value = request.responseText;
					if (value == "true") {
						document.getElementById("checkResult").innerHTML = "(�Ѵ���)";
					} else if (value == "self") {
						document.getElementById("checkResult").innerHTML = "(�����ѳ������޸�)";
					} else if (value == "limited") {
						document.getElementById("checkResult").innerHTML = "(�Ѵ���������)";
					}
				} else {
					document.getElementById("checkResult").innerHTML = "(��)";
				}
			}
		}
	}

	function addSubConf() {
		var title = document.getElementsByName("title").value;
		var checkResult = document.getElementById("checkResult").innerHTML;
		if (title == "" || title == "(�˴���д����)") {
			alert("���ⲻ��Ϊ�գ�");
		} else if (checkResult == "(�Ѵ���)") {
			alert("�˱������Ŀ����������ʦ���⣬���ܳ�ͬ����Ŀ��");
		} else if (checkResult == "(�����ѳ������޸�)") {
			alert("���Ѿ��������⣬�����ڡ��������   �ҵ���Ŀ�����޸�");
		} else if (checkResult == "(��)") {
			document.form1.action = "TeaSubManageServlet?flag=sub_add";
			document.form1.submit();
		}
	}
</script>
<%
	HttpSession hs = request.getSession(true);
	TeacherBean tb = (TeacherBean) hs.getAttribute("user");

	int[] s_id = new TeacherSubBeanCl().getS_id(tb.getId()); //��ȡ��ʦ������Ŀ��id
	int stage = new StageBeanCl().getCurrentStage(); //��ȡ��ǰ�Ľ׶�

	if (s_id != null && s_id.length >= tb.getMaxSubNum()) {
%>
<table>
	<tr></tr>
	<tr></tr>
	<tr></tr>
	<tr>
		<th>���Ѿ������<%=s_id.length%>���⣬�ﵽ�������ޣ������ٳ��⡣������������ϵ ϵͳ����Ա��</th>
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
		<th>���ڲ��ǳ���׶Σ����<a
			href="teacher/teacher.jsp?function=..//common/stage">ѡ��׶�</a>�鿴���׶�ʱ�����飡</th>
	</tr>

</table>

<%
	} else {
%>
<form name="form1" method="post">
	<table width="100%" border="1" cellpadding="0" cellspacing="0">
		<tr height="30">
			<th colspan="2" scope="row" bgcolor="#E6F3FF">����Ŀ��ϸ��Ϣ</th>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
		</tr>
		<tr height="30">
			<th width="30%" scope="row">�� ��<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					id="title" name="title" onfocus="if(value=='�˴���д����'){value=''}"
					onblur="if (value ==''){value='�˴���д����'} chenkExist()">�˴���д����</textarea>
				<input type="hidden" id="teaId" value=<%=tb.getId()%>>
			</td>
		</tr>
		<!-- 11.5��ӹؼ��� -->
		<tr height="30">
			<th width="30%" scope="row">�ؼ���<label id="checkResult"
				style="color:#FF6600;">*</label>
			</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					id="key" name="key" onfocus="if(value=='�˴���д�ؼ���'){value=''}"
					onblur="if (value ==''){value='�˴���д�ؼ���'}">�˴���д�ؼ���</textarea>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">������</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="teacher" readonly="readonly"><%=tb.getName()%></textarea>
			</td>
		</tr>
		<tr height="30">
			<th scope="row">��Ŀ����</th>
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
			<th scope="row">��Ŀ���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="introduction" onfocus="if(value=='�˴���д��Ŀ���'){value=''}"
					onblur="if (value ==''){value='�˴���д��Ŀ���'}">�˴���д��Ŀ���</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">���̰���</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="schedule" onfocus="if(value=='�˴���д���̰���'){value=''}"
					onblur="if (value ==''){value='�˴���д���̰���'}">�˴���д���̰���</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">�ο�����</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="reference" onfocus="if(value=='�˴���д�ο�����'){value=''}"
					onblur="if (value ==''){value='�˴���д�ο�����'}">�˴���д�ο�����</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">ѧ��Ҫ��</th>
			<td><textarea
					style="width: 100%; height: 100%; overflow: auto; border: 0px;"
					name="requirement" onfocus="if(value=='�˴���дѧ��Ҫ��'){value=''}"
					onblur="if (value ==''){value='�˴���дѧ��Ҫ��'}">�˴���дѧ��Ҫ��</textarea>
			</td>
		</tr>
		<tr height="100">
			<th scope="row">��������</th>
			<td>
			 <label>
<input type="checkbox" name="domain" value="���ܼ��㡢�����ھ������ѧϰ" />
���ܼ��㡢�����ھ������ѧϰ</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="��ѧ��Ϣ����"  />
         ��ѧ��Ϣ����</label>
	 
			    <label>
			      <input type="checkbox" name="domain" value="ͼ��ͼ�����ѧ������ӻ�"  />
			      ͼ��ͼ�����ѧ������ӻ�</label>
	
			    <label>
			      <input type="checkbox" name="domain" value="ͨ�Ű�ȫ���������簲ȫ" />
			      ͨ�Ű�ȫ���������簲ȫ</label>

			    <label>
			      <input type="checkbox" name="domain" value="�����ܼ���" />
			      �����ܼ���</label>
	   
			    
	 
			    <label>
			      <input type="checkbox" name="domain" value="�ݻ�Ӳ����Ƕ��ʽϵͳ���ܻ�����" />
			      �ݻ�Ӳ����Ƕ��ʽϵͳ���ܻ�����</label>

			    <label>
			      <input type="checkbox" name="domain" value="��ý��ͨ�Ű�ȫ"  />
			      ��ý��ͨ�Ű�ȫ</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="���ܼ��㰲ȫӦ��"  />
			      ���ܼ��㰲ȫӦ��</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="�ռ���Ϣ��ȫ" />
			      �ռ���Ϣ��ȫ</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="����ѧӦ�ü���"  />
			      ����ѧӦ�ü���</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="��Դ������������ȫ"  />
			      ��Դ������������ȫ</label>
	  
			    <label>
			      <input type="checkbox" name="domain" value="���ֹ������������뼼��" />
			      ���ֹ������������뼼��</label>
	 
			    <label>
			      <input type="checkbox" name="domain" value="��ά���ӻ���ѧ��ģ"  />
			      ��ά���ӻ���ѧ��ģ</label>
	  
			    <label>
			      <input type="checkbox" name="domain" value="�����ھ򼰵�ѧӦ��"  />
			      �����ھ򼰵�ѧӦ��</label>
	    
			    <label>
			      <input type="checkbox" name="domain" value="��Ŀ��滮��ѧӦ��" />
			      ��Ŀ��滮��ѧӦ��</label>

			    <label>
			      <input type="checkbox" name="domain" value="���ܼ��㼰��Ӧ��"  />
			      ���ܼ��㼰��Ӧ��</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="�����ھ������ѧϰ"  />
			      �����ھ������ѧϰ</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="�ռ����ݿ⼼��" />
			      �ռ����ݿ⼼��</label>
	     
			    <label>
			      <input type="checkbox" name="domain" value="ͼ��ͼ���������ӻ�"/>
			      ͼ��ͼ���������ӻ���</label>
	   
			    <label>
			      <input type="checkbox" name="domain" value="���繤�̼�Ӧ��" />
			      ���繤�̼�Ӧ��</label>
	    
			    <label>
			      <input type="checkbox" name="domain" value="���ֹ�������" />
			      ���ֹ�������</label>
	      ���ֹ�������</label>
	    
			</td>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row">&nbsp;</th>
			<td>&nbsp;</td>
		</tr>
		<tr height="30">
			<th colspan="2" scope="row" bgcolor="#E6F3FF"><input
				type="button" onclick="addSubConf()" value="�ύ"></th>
		</tr>
	</table>
</form>
<%}%>