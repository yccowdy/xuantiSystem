<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'documents.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    
 <script type="text/javascript">
 
 function download(){
 
 
     var table=document.getElementById("printTable");
     row=table.rows.length;
     column  = table.row2(1).cells.lenght;
     var wdapp=new ActiveXObject("Word.Application");
     wdapp.visible=true;
     wddoc = wdapp.Document.Add();
     thearray=new Array();
     
     
     for(i=0;i<row;i++){
     
        thearray[i]=new Array();
        for(j=0;j<column;j++){
        
        
            thearray[i][j]=table.rows(i).innerHTML;
        }
     
     }
     
     var range=wddoc.Range(0,0);
     range.Text="自定义列表"+"\n";
     wdapp.Application.Activedocument.Paragraphs.Add(range);
     wdapp.Application.Activedocument.Paragraphs.Add();
     rngcurrent=wdapp.Application.Activedocument.Paragraphs(3).Range;
     var objTable=wddoc.Tables.add(rngcurrent,row,column);
     
     for(i=0;i<row;i++){
      for(j=0;j<column;j++){
         objTable.Cell(i+1,j+1).Range.Text=thearray[i][j].replace("&nbsp;","");
         
      }
 
  }
     wdapp.Application.ActiveDocument.SaveAs("bookList.doc",0,false,"",true,"",false,false,false,false,false,false);
     wdapp.Application.Printout();
     wdapp=null;
 
 
 
 }
 
 
 
 </script>
<table border="1" cellspacing="0" cellpadding="0" width="600">
  <tr>
    <td width="216"><p>教研室: </p></td>
    <td width="192" colspan="2"><p>指导教师： </p></td>
    <td width="192"><p>职称： </p></td>
  </tr>
  <tr>
    <td width="216"><p>导师电话： </p></td>
    <td width="192" colspan="2"><p>EMAIL:</p></td>
    <td width="192"><p>需学生人数： </p></td>
  </tr>
  <tr>
    <td width="600" colspan="4"><p>课题名称： </p></td>
  </tr>
  <tr>
    <td width="600" colspan="4"><p>课题内容及意义： <br />
    </p>
        <p>&nbsp;</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td width="600" colspan="4"><p>对学生的要求： </p>
        <p>&nbsp;</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td width="600" colspan="4"><p>进度安排： <br />
    </p>
        <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td width="600" colspan="4"><p>参考资料： <br />
    </p>
        <p>&nbsp;</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td width="301" colspan="2"><p>教研室审查意见： </p>
        <p>&nbsp;</p>
      <p>教研室主任签名： <br />
        年  月  日 </p></td>
    <td width="299" colspan="2" valign="top"><p>系审查意见： </p>
        <p>&nbsp;</p>
      <p>系主任签名： <br />
        年     月  日 </p></td>
  </tr>
</table>
 <input id="document" type="button" value="下载"
									onclick="download()">
									
									
									
  </body> -->
</html>
