<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: MSI
  Date: 2017/5/1
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cookieName = "txtname";
    Cookie cookies [] = request.getCookies ();

    String txtname=request.getParameter("txtname");
    if(txtname==null){
        txtname="";
    }
    Cookie cookie = new Cookie ("txtname"+cookies.length, URLEncoder.encode(txtname,"UTF-8"));
    cookie.setMaxAge(24 * 60 * 60);
    Cookie queryCookie = new Cookie ("query", URLEncoder.encode(txtname,"UTF-8"));
    queryCookie.setMaxAge(24 * 60 * 60);
    response.addCookie(cookie);
    response.addCookie(queryCookie);
%>
<html>
<head>
    <title>Set Cookie</title>
</head>
<body>
<%
    String redirectURL = "searchResult.jsp";
    response.sendRedirect(redirectURL);
%>
</body>
</html>
