<%@page import="com.kk.subject.model.StuSubTeaBeanCl"%>
<%@ page language="java" import="java.util.*,com.ax.subject.model.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	    HttpSession hs = request.getSession(true);
		StudentBean sb = (StudentBean)hs.getAttribute("user");
		ArrayList<StudentSubjectBean> ssbAl = new StudentSubjectBeanCl().getSubAlByStuId(sb.getId());
	   	SubjectBean subBean;
	   	
	   	
	 
	   	int wish = new com.kk.subject.model.StageBeanCl().getCurrentStage();
	   	
	   	
 		for(int i=0;i<ssbAl.size();i++){
			
			subBean = new SubjectBeanCl().getSubjectById(ssbAl.get(i).getSub_id());
		
		}
%>

<script type="text/javascript">
function submit(id){

  if(2==<%=new com.kk.subject.model.StageBeanCl().getCurrentStage()%>){
			
			document.form.action="UpdateDataServlet?flag=deleteSub&subId="+id;
			document.form.submit();
			
			
		}else{
		
		    alert("非选题阶段!");
			return ;
		}
  

}



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
<form name="form" method = "post" action="">
<table width="100%" border="1">
	<tr>
		<th colspan="7"><div align="center">已选题数</div></th>
	</tr>
	<tr bgcolor="#50806F">
	<td><div align="center">编号</div></td>
		<td><div align="center">标题</div>
		</td>
		<td><div align="center">出题人</div>
		</td>

        
      
		<td><div align="center">题目方向</div>
		</td>

		<td><div align="center">志愿</div>
		</td>
		<td><div align="center">题目是否选中</div>
		</td>
		<td><div align="center">操作</div></div></td>
	</tr>

	<%
		for(int i=0;i<ssbAl.size();i++){
			subBean = new SubjectBeanCl().getSubjectById(ssbAl.get(i).getSub_id());
	
	
	if(wish==2){
	
	
	%>
	<tr>
	<td><div align="center"><%=subBean.getId() %></div></td>
		<td><div align="center"><%=subBean.getTitle()%></div>
		</td>
		<%-- <td><div align="center"><%=subBean.getTeacher()%></div>
		</td> --%>
		
		<td ><input  id="ser" name="a<%=i %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%;  "  value="<%=subBean.getTeacher()%>"  


onclick="showGaryBox('老师基本信息','student/teainfo.jsp?sub_id=<%=subBean.getId() %>')"></td>
		<td><div align="center"><%=subBean.getDirection()%></div>
		</td>
		<td><div align="center"><%=((StudentSubjectBean)ssbAl.get(i)).getWish()%></div>
		</td>
		<td><div align="center"><%=com.kk.subject.model.Tools.getDescribeOfState(((StudentSubjectBean)ssbAl.get(i)).getState()) %></div>
	    <td><div align="center"><a href="javascript:submit(<%=subBean.getId() %>);">撤销</a></div></td>
	</tr>
	<%  
	
		} else {
		
		
		
		
	%>
	<tr>
	<td><div align="center"><%=subBean.getId() %></div></td>
		<td><div align="center"><%=subBean.getTitle()%></div>
		</td>
		<%-- <td><div align="center"><%=subBean.getTeacher()%></div>
		</td> --%>
		
		<td ><input  id="ser" name="a<%=i %>" type="text" style= "background:transparent;border-style:none;width:100%;height:100%;  "  value="<%=subBean.getTeacher()%>"  


onclick="showGaryBox('老师基本信息','student/teainfo.jsp?sub_id=<%=subBean.getId() %>')"></td>
		<td><div align="center"><%=subBean.getDirection()%></div>
		</td>
		<td><div align="center"><%=((StudentSubjectBean)ssbAl.get(i)).getWish()%></div>
		</td>
		<td><div align="center"><%=com.kk.subject.model.Tools.getDescribeOfState(((StudentSubjectBean)ssbAl.get(i)).getState()) %></div>
	    <td><div align="center">无</div></td>
	</tr>
	
	
	<%} %>
	<%} %>


</table>

<table border="0"  align="center" >
	<td  colspan="7" align="center">
					 (注意：点击导师可查看导师基本信息)
			</td>
	</table>
</form>
</html>
