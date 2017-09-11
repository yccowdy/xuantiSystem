<%@ page language="java" import="java.util.*,com.kk.subject.model.*"
	pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	response.setCharacterEncoding("UTF-8");
	HttpSession hs = request.getSession(true);
	TeacherBean tb = (TeacherBean) hs.getAttribute("user");

	int[] subIds = new TeacherSubBeanCl().getS_id(tb.getId());
%>

<body style="height:100%;">
	<table width="80%" border="1">
		<tr>
			<td colspan="5"><div align="center">我的题目</div></td>
		</tr>
		<tr>
			<td><div align="center">编号</div></td>
			<td><div align="center">标题</div></td>
			<td><div align="center">选题人数</div></td>
			<td><div align="center">选择学生</div></td>
			
		</tr>
		<%
				for (int i = 0; i < subIds.length; i++) {
					SubjectBean sb = new SubjectBeanCl().getSubjectById(subIds[i]);
			%>
		<tr>
			<td><div align="center"><%=sb.getId()%></div></td>
			<%-- <td><div align="center">
					<a href=<%=path + "/common/sub_detail.jsp?id=" + sb.getId()%>
						target="_blank"><%=sb.getTitle()%></a>
				</div></td> --%>
				
				<td><input  id="ser" name="a<%=i %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%; " value="<%=sb.getTitle()%>"  


onclick="showGaryBox('题目基本信息','teacher/sub_modify1.jsp?id=<%=sb.getId()%>')"></td>
			<td><div align="center"><%=sb.getSelectedNum()%>
				</div></td>
			<td><div align="center">
					<a href="teacher/teacher.jsp?function=chooseDetail.jsp?subId=<%=sb.getId() %>">选择学生</a>
				</div></td>
		</tr>
		<%
				}
			%>
	</table>
</body>


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
    garyBoxHead.style.cssText="height:20px;background:#369;color:#ffffff;padding:5px 0 0 5px;";
    
    garyBoxTitleText=document.getElementById("garyBoxTitleText"); 
    garyBoxTitleText.style.cssText="float:left;";
    
    garyBoxClose = document.getElementById("garyBoxClose"); 
    garyBoxClose.style.cssText="cursor:pointer;float:right; margin-right:10px;";        
    
    garyBoxIframe=document.getElementById("garyBoxIframe");     
}    
function showGaryBox(title,url,onClose,width,height)
{
      if(!garyBox)createGaryBox();
      if(!arguments[3]) width = 900;
      if(!arguments[4]) height = 450;
     
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