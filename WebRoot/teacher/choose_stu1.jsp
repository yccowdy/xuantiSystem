<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	//	HttpSession hs = request.getSession(true);
	HttpSession hs = request.getSession(true);
	TeacherBean tb = (TeacherBean)hs.getAttribute("user");
	 ArrayList<StuSubTeaBean> arrSSTB;
	//arrSSTB = (ArrayList<StuSubTeaBean>) hs.getAttribute("arrSSTB"); 
	
	//if (arrSSTB == null) {
		arrSSTB = new StuSubTeaBeanCl().getAllSSTB2(tb.getId());
//	}

	String[] color = { "#D3F0F3", "#E6F3FF" };//交替变色
	
	//定义4个分也会用到的变量
	int pageSize = 10; //每页显示的记录条数
	int pageNow = 1; //当前显示第几页
	int rowCount = arrSSTB.size(); //记录总条数
	int pageCount = (rowCount - 1) / pageSize + 1; //总共多少页

	String k = request.getParameter("pageNow");
	if (k != null) {
		pageNow = Integer.parseInt(k.trim());
	}
%>
<script type="text/javascript">
	function handle(state, subId, stuId, wish) {

		if (state == 1) {//撤销
			if (5 == wish) {//撤销管理员的指派
				document.form1.action = "AssignServlet?flag=repeal1&subId="
						+ subId + "&stuId=" + stuId;
			} else {//撤销老师的选择
				document.form1.action = "ChooseServlet?flag=repeal1&subId="
						+ subId + "&stuId=" + stuId;
			}
		} else if (state == 0) {//命中此志愿
			document.form1.action = "ChooseServlet?flag=chooseStu1&subId="
					+ subId + "&stuId=" + stuId;
		}
		document.form1.submit();
	}
</script>

<script tyep="text/javascript">
var garyBox ;
var garyBoxHead;
var garyBoxTitleText;
var garyBoxClose;
var garyBoxIframe;

function createGaryBox()
{
document.body.innerHTML+="<div id=\"garyBox\" style=\"display:none\"><div id=\"garyBoxHead\"><h4 ><span id=\"garyBoxTitleText\">title</span></h4><h4><span id=\"garyBoxClose\">关闭</span></h4></div><div><iframe id=\"garyBoxIframe\" name=\"garyBoxIframe\"  width=\"100%\" height=\"100%\" frameBorder=\"0\" frameSpacing=\"0\" scrolling=\"auto\" marginHeight=\"0\" marginWidth=\"0\" ></iframe></div></div>";
    garyBox = document.getElementById("garyBox");
    garyBox.style.cssText="border:1px solid #369;width:400px;height:250px;background:#e2ecf5;z-index:1000;position:absolute;display:none;"; 

    garyBoxHead=document.getElementById("garyBoxHead"); 
    garyBoxHead.style.cssText="height:20px;background:#369;color:#000000;padding:5px 0 0 5px;";
    
    garyBoxTitleText=document.getElementById("garyBoxTitleText"); 
    garyBoxTitleText.style.cssText="float:left;";
    
    garyBoxClose = document.getElementById("garyBoxClose"); 
    garyBoxClose.style.cssText="cursor:pointer;float:right; margin-right:10px;";        
    
    garyBoxIframe=document.getElementById("garyBoxIframe");     
}    
function showGaryBox(title,url,onClose,width,height)
{
      if(!garyBox)createGaryBox();
      if(!arguments[3]) width = 600;
      if(!arguments[4]) height = 300;
     
    garyBoxTitleText.innerHTML=title;
     
    garyBox.style.display = "block"; 
    garyBox.style.position = "absolute"; 
    garyBox.style.top = "50%"; 
    garyBox.style.left = "50%"; 
    garyBox.style.marginTop = (-height/2)+"px"; 
    garyBox.style.marginLeft = (-width/2)+"px";
    
    garyBox.style.width=width+'px';
    garyBox.style.height=height+'px'; 
    
    garyBoxIframe.style.width=garyBox.style.width;
    garyBoxIframe.style.height=garyBox.style.height;
 
    
    var garyBoxBg = document.createElement("div"); 
    garyBoxBg.setAttribute("id","garyBoxBg"); 
    garyBoxBg.style.background = "#ffffff"; 
    garyBoxBg.style.width = "100%"; 
    garyBoxBg.style.height = "100%"; 
    garyBoxBg.style.position = "absolute"; 
    garyBoxBg.style.top = "0"; 
    garyBoxBg.style.left = "0"; 
    garyBoxBg.style.zIndex = "500"; 
    garyBoxBg.style.opacity = "0.3"; 
    garyBoxBg.style.filter = "Alpha(opacity=30)"; 
    document.body.appendChild(garyBoxBg);
    document.body.style.overflow = "hidden"; 
    
    garyBoxClose.onclick = function() 
    { 
        garyBox.style.display = "none"; 
        garyBoxBg.style.display = "none";     
        if(onClose)
        {
            onClose();
        }    
    }    
    garyBoxIframe.style.margin=0;
    garyBoxIframe.style.padding=0;
    garyBoxIframe.src=url;
    garyBoxIframe.onload=function(){
        
    }
}

</script>
<form name="form1" method="post">
	<table width="100%" height="269" border="1" cellpadding="0"
		cellspacing="0">
		<tr height="30px"></tr>
		<tr height="70px">
			<th colspan="7" height="50px" bgcolor="#E6F3FF"><div
					align="center" style="font-size: 35px">选&nbsp;题&nbsp;状&nbsp;态</div>
			</th>
			
		</tr>
		
		<tr bgcolor="#50806F">
			<td height="30px" width="6%" align="center">编号</td>
			<td width=50% align="center">题目</td>
			<td width=8% align="center">老师</td>
			<td  width=8% align="center">学生</td>
			<td width=8% align="center">志愿</td>
			<td  width=8% align="center">状态</td>
			<td width=8% align="center">操作</td>
		</tr>
		<%
			int j = 0;
			String a="命中";
			String b="正在选题";
			String c="老师已选其他学生";
			
			int ss=0;
			int wish= new StageBeanCl().getCurrentStage();
			TeacherSubBeanCl tsbc = new TeacherSubBeanCl(); 
			TeacherBeanCl tbc = new TeacherBeanCl();
			SubjectBeanCl sbc = new SubjectBeanCl();
			StudentBeanCl stubc = new StudentBeanCl();
			
			for (; j <rowCount ; j++) {
				StuSubTeaBean sstb = arrSSTB.get((pageNow-1)*pageSize+j);
				/*
				kangkang 2015.11.11
				在这里获取老师学生题目名字等信息
				 */ 
				
				String teaId = tsbc.getTeaId(sstb.getSubId());
				sstb.setTeaName((tbc.getTeacherById(teaId)).getName());
				sstb.setSubTitle(sbc.getSubjectById(sstb.getSubId()).getTitle());
				sstb.setStuName(stubc.getStuById(sstb.getStuId() + "").getName());
				if(a.equals(Tools.getDescribeOfState1(sstb.getState()))||b.equals((Tools.getDescribeOfState1(sstb.getState())))){
		
		if(wish==(sstb.getWish()+2)){
		%>
		<%-- <tr height="30px" bgcolor=<%=color[j % 2]%>> --%>
		  <tr height="30px">
			<td align="center"><%=sstb.getSubId()%></td>
			<%-- <td align="center"><%=sstb.getSubTitle()%></td> --%>
			<td ><input  id="ser" name="a<%=j %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%; " value="<%=sstb.getSubTitle()%>"  


onclick="showGaryBox('题目基本信息','teacher/sub_modify1.jsp?id=<%=sstb.getSubId()%>')"></td>
			<td align="center"><%=sstb.getTeaName()%></td>
			<%-- <td align="center"><%=sstb.getStuName()%></td> --%>
			<td ><input  id="ser" name="a<%=j %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%;  "  value="<%=sstb.getStuName()%>"  


onclick="showGaryBox('学生基本信息','teacher/studentinfo.jsp?stu_id=<%=sstb.getStuId() %>>')"></td>
			<td align="center"><%=sstb.getWish()%></td>
			<td align="center"><%=Tools.getDescribeOfState1(sstb.getState())%></td>
			<td align="center"><a
				href="javascript:handle(<%=sstb.getState()%>,<%=sstb.getSubId()%>,<%=sstb.getStuId()%>,<%=sstb.getWish()%>)"><%=Tools.getHandleDescribe(sstb.getState())%></a>
			</td>
		</tr>
		<%} else  {%>
		
		<tr height="30px">
			<td align="center"><%=sstb.getSubId()%></td>
			<%-- <td align="center"><%=sstb.getSubTitle()%></td> --%>
			<td ><input  id="ser" name="a<%=j %>" type="text"  style= "background:transparent;border-style:none;width:100%;height:100%; " value="<%=sstb.getSubTitle()%>"  


onclick="showGaryBox('题目基本信息','teacher/sub_modify1.jsp?id=<%=sstb.getSubId()%>')"></td>
			<td align="center"><%=sstb.getTeaName()%></td>
			<%-- <td align="center"><%=sstb.getStuName()%></td> --%>
			<td ><input  id="ser" name="a<%=j %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%;  " value="<%=sstb.getStuName()%>"  


onclick="showGaryBox('学生基本信息','teacher/studentinfo.jsp?stu_id=<%=sstb.getStuId() %>>')"></td>
			<td align="center"><%=sstb.getWish()%></td>
			<td align="center"><%=Tools.getDescribeOfState1(sstb.getState())%></td>
			<%-- <td align="center"><a
				href="javascript:handle(<%=sstb.getState()%>,<%=sstb.getSubId()%>,<%=sstb.getStuId()%>,<%=sstb.getWish()%>)"><%=Tools.getHandleDescribe(sstb.getState())%></a>
			</td> --%>
			<td align="center">无</td>
			
		</tr>
			<%} %>
			
		<%} %>
		<%} %>
	

	</table>
	<table border="0"  align="center" >
	<td  colspan="7" align="center">
					 (注意：点击题目可修改，点击学生可查看学生基本信息)
			</td>
	</table>
</form>