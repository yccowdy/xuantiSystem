<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	HttpSession hs = request.getSession(true); 
	TeacherBean tb = (TeacherBean)hs.getAttribute("user");
	ArrayList<StuSubTeaBean> arrSSTB;
	arrSSTB = new StuSubTeaBeanCl().getMineSSTB(tb.getId());
	arrSSTB = (ArrayList<StuSubTeaBean>) Tools.sortArrayList(arrSSTB,"subId");
	
	int stage = new StageBeanCl().getCurrentStage();
	
%>

<form name="form1" method="post">
<table width="100%" height="269" border="1" cellpadding="0"
	cellspacing="0">
	<tr>
		<th colspan="6" scope="col" height="50px" bgcolor="#E6F3FF"><h1>选题结果1</h1>
		</th>
	</tr>
	<tr align="center">
		<td height="30px" width="5%">编号</td>
		<td width="58%">题目</td>
		<td width="8%">学生</td>
		<td width="8%">志愿类型</td>
		<td width="13%">状态</td>
		<td width="8%">操作</td>
		
	</tr>
	<%
	
	StuSubTeaBean sstb;
	String a="命中";
	String b="正在选题";
	
	  for(int i=0;i<arrSSTB.size();i++){
	  
	   sstb = arrSSTB.get(i);
	  /*  if(a.equals(Tools.getDescribeOfState(sstb.getState()))||(sstb.getWish()==(stage-2)||(sstb.getWish()==(stage-1)))
	   &&b.equals(Tools.getDescribeOfState(sstb.getState())))  */
	   {
	 %>
	<tr height="30px" align="center">
		<td><%=sstb.getSubId()%></td>
		<td><%=sstb.getSubTitle()%></td>
		<td> 
<input id="ser" name="a<%=i %>" type="text" style= "background:transparent;border-style:none; " value="<%=sstb.getStuName()%>"  


onclick="showGaryBox('弹窗','teacher/studentinfo.jsp?stu_id=<%=sstb.getStuId() %>>')"></td> 
		<%-- <td><%=sstb.getStuName()%></td> --%>
		<td><%=sstb.getWish()%></td>
		<td><%=Tools.getDescribeOfState(sstb.getState())%></td>
		<td>
		<%if(sstb.getState()==1 && 3<= stage && 5>= stage){ %>
		<a href="javascript:repeal(<%=sstb.getSubId() %>,<%=sstb.getStuId() %>)">撤销</a>
		<%}%>
		</td>
		
	</tr>
	
	<%} %>
	<%} %>
</table></form>


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
    garyBoxHead.style.cssText="height:20px;background:#369;color:#fff;padding:5px 0 0 5px;";
    
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
    garyBoxBg.style.background = "#000"; 
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

<script type="text/javascript">

	function repeal(subId,stuId) {
		document.form1.action = "ChooseStuServlet?flag=repeal&subId="+subId+"&stuId="+stuId;
		document.form1.submit();
	}
</script>