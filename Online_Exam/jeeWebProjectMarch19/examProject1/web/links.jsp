<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Options</title>
        <%-- using internal style sheet only for this page--%>
        <style>
             body {font-weight:700; font-size:12pt; font-family:verdana; color:yellow}
             a { color:white}
        </style>
    </head>
    <body bgcolor="maroon">
        <%-- accessing a session attribute in JSP--%>

         <%@page import="pk1.*" %>
            
            <%
                            Student s = (Student)session.getAttribute("student");
                            out.print("Hello " + s.getSname() + "!");
            %>
        
                      
     <p/> 
        <a href="takeExam.jsp" target="details">Take an Exam</a>
        <p></p>
        <a href="myMarks.jsp" target="details">Show my Marks </a>
        <p></p>
       
        <p></p>       
        <a href="logout.jsp" target="_top">Logout</a>
       
    </body>
</html>
