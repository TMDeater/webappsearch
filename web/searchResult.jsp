<%--
  Created by IntelliJ IDEA.
  User: MSI
  Date: 2017/4/29
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Pack.*" %>
<%@page import="java.util.*" %>
<%@page import="jdbm.*" %>
<%--
  Created by IntelliJ IDEA.
  User: MSI
  Date: 2017/4/29
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<!-- Template by quackit.com -->
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
            padding-left: 0px;
        }

        .maxheight{
            max-height:100vh;
            overflow: auto;
        }

        #panelGp{
            padding-right: 0px;
        }

        main {
            padding-bottom: 10010px;
            margin-bottom: -10000px;
            float: left;
            width: 100%;
        }

        #nav {
            padding-bottom: 10010px;
            margin-bottom: -10000px;
            float: left;
            width: 230px;
            margin-left: -100%;
            background: #eee;
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
            margin-left: 230px; /* Same as 'nav' width */
        }

        .innertube {
            margin: 15px; /* Padding for content */
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

    <script type="text/javascript">
        /* =============================
         This script generates sample text for the body content.
         You can remove this script and any reference to it.
         ============================= */
        var bodyText=["The smaller your reality, the more convinced you are that you know everything.", "If the facts don't fit the theory, change the facts.", "The past has no power over the present moment.", "This, too, will pass.", "</p><p>You will not be punished for your anger, you will be punished by your anger.", "Peace comes from within. Do not seek it without.", "<h3>Heading</h3><p>The most important moment of your life is now. The most important person in your life is the one you are with now, and the most important activity in your life is the one you are involved with now."]
        function generateText(sentenceCount){
            for (var i=0; i<sentenceCount; i++)
                document.write(bodyText[Math.floor(Math.random()*7)]+" ")
        }
    </script>


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

        <div class="container">
            <div class="row">

                <div class="col-sm-2 pull left">
                    <div id="sidebar" class="sidebar-nav maxheight" style="padding-right: 20px">
                        <h3>Stem Word</h3>
                        <p style="font-size: 12px;">Click on to see available word</p>
                        <div class="panel-group">
                            <div class="panel panel-default">
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
                                %>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div>
                <div id="content" class="maxheight">
                    <div class="innertube">
                        <h1>Heading</h1>
                        <form name="searchform" method="post" action="searchResult.jsp">
                            <p>Please input your query here:</p>
                            <input type="text" size="100" name="txtname">
                            <input id="enterButton" type="submit" value="Enter">
                        </form>
                        <%
                            out.println("Your query: "+request.getParameter("txtname")+"<br/>");

                            if(request.getParameter("txtname")!=null)
                            {

                                String string1 = request.getParameter("txtname");

                                String[] str1 = string1.split(" ");
                                List<String> list = Arrays.asList(str1);
                                Vector<String> vector = new Vector<String>(list);

                                Vector<Webpage> result = SearchTool.search(vector);
                                out.println("Total pages found: "+result.size()+"<br/>");
                                out.println("The results are:<hr/>");
                                if(result.size() > 0){
                                    out.println("<table>");

                                    for(int i = 0; i < result.size(); i++){
                                        Webpage temp = result.elementAt(i);
                                        Vector<Word> wordVector = temp.getKeyword();
                                        String mostFiveWord = new String(wordVector.elementAt(0).getText());
                                        for(int j = 1; j < wordVector.size(); j++){
                                            mostFiveWord = mostFiveWord+" "+wordVector.elementAt(j).getText();
                                            if(j==4){
                                                break;
                                            }
                                        }
                                        out.println("<tr><td valign=\"top\">Score: &nbsp<br/>"+temp.getScore()+"&nbsp<br/>\n"+
                                                "            <button type=\"submit\" class=\"btn btn-default\" onmousedown=\"\n" +
                                                "              document.forms['searchform']['txtname'].value ='"+ mostFiveWord +" ' \"\n" +
                                                "              onmouseup=\"document.getElementById('enterButton').click();  \">Similar page</button>&nbsp\n"+
                                                "               </td>");
                                        out.println("<td>");
                                        out.println("<a href=\""+temp.getURL()+"\"> "+temp.getTitle()+"</a><br/>");

                                        out.println("<a href=\""+temp.getURL()+"\"> "+temp.getURL()+"</a><br/>");
                                        out.println("Last Update: "+temp.getLastUpdate()+", Page Size: "+temp.getPageSize()+"<br/>");
                                        out.write("Keyword: <br/>");
                                        for(int j = 0; j < wordVector.size(); j++){
                                            out.print(wordVector.elementAt(j).getText()+" "+wordVector.elementAt(j).getFreq()+"; ");
                                            if(j==4){
                                                out.println("<br/>");
                                                break;
                                            }
                                        }
                                        out.write("Parent Link: <br/>");
                                        Vector<String> parent = temp.getParentLk();
                                        if (parent.elementAt(0).equals("-1")){
                                            out.println("No Parent Link"+"<br/>");
                                        } else {
                                            for (int j = 0; j < parent.size(); j++) {
                                                out.println(parent.elementAt(j) + "<br/>");
                                            }
                                        }
                                        out.write("Child Link: <br/>");
                                        Vector<String> child = temp.getChildLk();
                                        if (child.elementAt(0).equals("-1")){
                                            out.println("No Child Link"+"<br/>");
                                        } else {
                                            for (int j = 0; j < child.size(); j++) {
                                                out.println(child.elementAt(j) + "<br/>");
                                            }
                                        }
                                        out.println("<br/></td></tr>");
                                        if(i >= 30)break;
                                    }
                                    out.println("</table>");
                                }else{
                                    out.println("No match result");
                                }
                            }
                            else
                            {
                                out.println("You input nothing");
                            }

                        %>
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


