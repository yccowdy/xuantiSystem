<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setCharacterEncoding("UTF-8");
%>
<style>
span{
	color:#850B4B;
	font-size:15px;
}
</style>
<script type="text/javascript">
function updateConf(){
	if(window.confirm("该班级原有的学生信息删除不可恢复，确认提交？")){
		document.form2.action="StuManageServlet?flag=cls_modify";
		document.form2.submit();
	}
}
</script>
<form action="" method="post" name="form2">
	<%
	//通过传入的参数获取要修改的班级ID
		String cls_id = request.getParameter("cls_id");
	//通过班级ID获取返回CLSBEAN对象	
	ClsBean cb = new ClsBeanCl().getClsById(cls_id);
		response.setCharacterEncoding("UTF-8");
	%>
	<table width="50%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th colspan="4"><div align="left">修改班级</div>
			</th>
		</tr>
		<tr>
			<td colspan="4"><div align="left">
					班级代号：<input type="text" name="cls_id" id="cls_id" value=<%=cb.getId() %> readonly="readonly">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4"><div align="left">
					班级人数：<input type="text" name="stuNum" id="stuNum" value=<%=cb.getStuNum() %>
						onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4"><div align="left">
					选择专业：<select id="major" name="major">
						<%
						String yuanxi=session.getAttribute("yuanxi").toString();
							ArrayList majorAl = new MajorBeanCl().getAllMajor(yuanxi);
							for (int i = 0; i < majorAl.size(); i++) {
								MajorBean mb = (MajorBean) majorAl.get(i);
								System.out.println(cb.getMajorName()+"\t"+mb.getMajor());
						%>
						<option value=<%=mb.getMajor()%> <%=(mb.getMajor().trim().equals(cb.getMajorName().trim())?"selected":"") %> ><%=mb.getMajor()%></option>
						<%
							}
						%>
					</select>
				</div>
			</td>
		</tr>
		<!-- <tr>
			<td><div align="left">
			是否保留原有学生信息？
			<input type="radio" name="remain" value="true" checked >保留&nbsp;
			<input type="radio" name="remain" value="false"> 不保留
			</div>
			</td>
		</tr> -->
		<tr>
			<td><div align="center">
					<input type="button" onclick="updateConf()" value="&nbsp;提&nbsp;交&nbsp;">
					<a href=<%=path+"/admin/admin.jsp?function=class_manage" %>><input type="button" onclick="" value="&nbsp;返&nbsp;回&nbsp;"></a>
				</div>
			</td>
		</tr>
		<tr>
			<td><span>注：如果没有要选的专业，可以先在专业管理中添加专业。</span></td>
		</tr>
	</table>
</form>