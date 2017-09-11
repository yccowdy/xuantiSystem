<%@ page language="java" import="java.util.*,com.kk.subject.model.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
    <title>projectGovPlace_list.jsp</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <link href="css/strongpt.css" rel="stylesheet" type="text/css">
    </head>
    <body>
    <p align="center"><strong>计算机学院2011届本科毕业设计指导书 </strong></p>
    <table width="600" border="1" align="center" cellpadding="0" cellspacing="0">
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
        <td width="600" colspan="4"><p>课题内容及意义： <br>
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
        <td width="600" colspan="4"><p>进度安排： <br>
        </p>
            <p>&nbsp;</p></td>
      </tr>
      <tr>
        <td width="600" colspan="4"><p>参考资料： <br>
        </p>
            <p>&nbsp;</p>
          <p>&nbsp;</p></td>
      </tr>
      <tr>
        <td width="301" colspan="2"><p>教研室审查意见： </p>
            <p>&nbsp;</p>
          <p>教研室主任签名： <br>
            年  月  日 </p></td>
        <td width="299" colspan="2" valign="top"><p>系审查意见： </p>
            <p>&nbsp;</p>
          <p>系主任签名： <br>
            年     月  日 </p></td>
      </tr>
    </table>
    </body>
</html>



