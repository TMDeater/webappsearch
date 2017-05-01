<%@ page import="Pack.SearchTool" %>
<%@ page import="Pack.Webpage" %>
<%--<%@ page import="jdbm.RecordManagerFactory" %>--%>
<%@ page import="jdbm.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: MSI
  Date: 2017/4/30
  Time: 01:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
  <%--String txtname=request.getParameter("txtname");--%>
  <%--if(txtname==null) txtname="";--%>
  <%--Cookie cookie = new Cookie ("txtname",txtname);--%>
  <%--cookie.setMaxAge(365 * 24 * 60 * 60);--%>
  <%--response.addCookie(cookie);--%>

<%--%>--%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>The Ultimate Epic Search Engine Course Project</title>
  <style type="text/css">

    body {
      margin:0;
      padding:0;
      font-family: Sans-Serif;
      line-height: 1.5em;
    }


    #header {
      background: #87CEEB;
      height: 50px;
    }

    #header h1 {
      margin: 0;
      padding-top: 10px;
      color: white;
    }

    #sidebar{
      height: 100%;
      padding: 10px;
    }

    .maxheight{
      overflow: auto;
    }

    #panelGp{
      padding-right: 0px;
    }

    main {
    }

    #footer {
      clear: left;
      width: 100%;
      background: #ccc;
      text-align: center;
      padding: 4px 0;
    }

    #wrapper {
      overflow: hidden;
    }

    #content {
      margin-left: 0px; /* Same as 'nav' width */
    }

    .innertube {
      margin: 0px; /* Padding for content */
      margin-top: 0;
    }

    p {
      color: #555;
    }

    nav ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
    }

    nav ul a {
      color: darkgreen;
      text-decoration: none;
    }

  </style>

  <%--bootstrap--%>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


  <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
              (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-269964-1', 'quackit.com');
      ga('send', 'pageview');

  </script>
</head>

<body>

<header id="header">
  <div class="innertube">
    <h1>The Ultimate Epic Search Engine Course Project</h1>
  </div>
</header>

<div id="wrapper">
  <main>
      <div class="row">

        <div class="col-sm-2" >
          <div id="sidebar" class="maxheight" >
            <h3>Stem Word</h3>
            <p style="font-size: 12px;">Click on to see available word</p>
            <div class="panel-group">
              <div id="panelGp" class="panel panel-default">
                <%
                  List<String> availableWord = SearchTool.giveAllWords();
                  out.write("<div class=\"panel-heading\">");
                  out.write("<p class=\"panel-title\">");
                  out.write("<a data-toggle=\"collapse\" href=\"#collapse1\">"+availableWord.get(1).charAt(0)+"</a>");
                  out.write("</p>");
                  out.write("</div>");
                  out.write("<div id=\"collapse1\" class=\"panel-collapse collapse\"> ");
                  out.write("<ul class=\"list-group\">");
                  //out.write("<li class=\"list-group-item\">"+availableWord.get(1)+"</li>");
//                  out.write("<li class=\"list-group-item\"><div onclick=\"" +
//                          "document.forms['searchform']['txtname'].value +="+availableWord.get(1)+" "+"\"" +
//                          ">"+availableWord.get(1)+"</div></li>");
                  out.write("<li style=\"cursor:pointer\" class=\"list-group-item\" onclick=\"\n" +
                          "              document.forms['searchform']['txtname'].value +='"+ availableWord.get(1)+" ' \"\n" +
                          "              >"+ availableWord.get(1)+"</li>");
                  for (int i = 2; i<availableWord.size();i++){
                    if (availableWord.get(i).charAt(0)!=availableWord.get(i-1).charAt(0)){
                      out.write("</ul>");
                      out.write("</div>");
                      out.write("<div class=\"panel-heading\">");
                      out.write("<p class=\"panel-title\">");
                      out.write("<a data-toggle=\"collapse\" href=\"#collapse"+String.valueOf(i)+"\">"+availableWord.get(i).charAt(0)+"</a>");
                      out.write("</p>");
                      out.write("</div>");
                      out.write("<div id=\"collapse" +String.valueOf(i)+ "\" class=\"panel-collapse collapse\"> ");
                      out.write("<ul class=\"list-group\">");
                      out.write("<li style=\"cursor:pointer\" class=\"list-group-item\" onclick=\"\n" +
                              "              document.forms['searchform']['txtname'].value +='"+ availableWord.get(i)+" ' \"\n" +
                              "              >"+ availableWord.get(i)+"</li>");

                    } else {
                      out.write("<li style=\"cursor:pointer\" class=\"list-group-item\" onclick=\"\n" +
                              "              document.forms['searchform']['txtname'].value +='"+ availableWord.get(i)+" ' \"\n" +
                              "              >"+ availableWord.get(i)+"</li>");
                    }
                  }
                  out.println("</ul>\n" +
                          "              </div>");
                %>

              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-10">
          <div id="sidebar">
                <h1>Search</h1>
                <form name="searchform" method="post" action="searchResult.jsp">
                  <p>Please input your query here:</p>
                  <input type="text" size="100" name="txtname" style="width:300px;">
                  <input type="submit" value="Enter">
                </form>
          </div>
        </div>
      </div>

    </div>
  </main>
</div>

<footer id="footer">
  <div class="innertube">
    <p>Production of Group JSD_4321</p>
  </div>
</footer>

</body>
</html>


