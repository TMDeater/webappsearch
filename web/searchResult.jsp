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
            padding-top: 15px;
            color: white;
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
        <div id="content">
            <div class="innertube">
                <h1>Heading</h1>
                <form method="post" action="searchResult.jsp">
                    <p>Please input your query here:</p>
                    <input type="text" size="100" name="txtname">
                    <input type="submit" value="Enter">
                </form>
                <%--<% System.out.println("aaa"); %>--%>
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
                                out.println("<tr><td valign=\"top\">"+temp.getScore()+"</td>");
                                out.println("<td>");
                                out.println("<a href=\""+temp.getURL()+"\"> "+temp.getTitle()+"</a><br/>");
                                out.println("<a href=\""+temp.getURL()+"\"> "+temp.getURL()+"</a><br/>");
                                out.println(temp.getLastUpdate()+", "+temp.getPageSize()+"<br/>");
                                Vector<Word> wordVector = temp.getKeyword();
                                for(int j = 0; j < wordVector.size(); j++){
                                    out.print(wordVector.elementAt(j).getText()+" "+wordVector.elementAt(j).getFreq()+"; ");
                                    if(j==4){
                                        out.println("<br/>");
                                        break;
                                    }
                                }
                                Vector<String> parent = temp.getParentLk();
                                if (parent.elementAt(0).equals("-1")){
                                    out.println("No Parent Link"+"<br/>");
                                } else {
                                    for (int j = 0; j < parent.size(); j++) {
                                        out.println(parent.elementAt(j) + "<br/>");
                                    }
                                }
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
    </main>

    <nav id="nav">
        <div class="innertube">
            <h3>Stem Word List</h3>
            <ul>
                <li><a href="#">Link 1</a></li>
                <li><a href="#">Link 2</a></li>
                <li><a href="#">Link 3</a></li>
                <li><a href="#">Link 4</a></li>
                <li><a href="#">Link 5</a></li>
            </ul>
            <h3>Left heading</h3>
            <ul>
                <li><a href="#">Link 1</a></li>
                <li><a href="#">Link 2</a></li>
                <li><a href="#">Link 3</a></li>
                <li><a href="#">Link 4</a></li>
                <li><a href="#">Link 5</a></li>
            </ul>
            <h3>Left heading</h3>
            <ul>
                <li><a href="#">Link 1</a></li>
                <li><a href="#">Link 2</a></li>
                <li><a href="#">Link 3</a></li>
                <li><a href="#">Link 4</a></li>
                <li><a href="#">Link 5</a></li>
            </ul>
        </div>
    </nav>

</div>

<footer id="footer">
    <div class="innertube">
        <p>Production of Group JSD_4321</p>
    </div>
</footer>

</body>
</html>


