<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link rel="stylesheet" href="styles.css" />
    </head>
    <body>
    <h2>Forgot Password</h2>
    <h4>
     <%
     String email = request.getParameter("email");
     String hinta = request.getParameter("hinta");
     String msg= pk1.StudentUtil.processForgotPassword(email,hinta);
     if ( msg == null)
         out.print("<script> window.alert('Your password has been sent to ur email id'); window.location.href ='index.jsp' </script>");
     else //if wrong hint answer
         out.println("Sorry! Error : " + msg);
     %> 
     </h4>
    </body>
</html>
