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
     <%
     String email = request.getParameter("email");
     
     String hintq = pk1.StudentUtil.getHintQuestion(email);
     if ( hintq == null ) //if invalid email is passed to getHintQuestion()
     {
          out.println("Email Adresss " + email +", Not found in database. Please try again!");
          return;
     }
     %>
     <form action="forgot2.jsp">
         <table>
             <tr>
                 <td>Email Address 
                 <td><input type="text" name="email" readonly  value="${param.email}" />
             </tr>
             
                         <tr>
                 <td>Hint Question
                 <td><input type="text" name="hintq" readonly  value="<%=hintq%>" readonly />
             </tr>
                                      <tr>
                 <td>Answer
                 <td><input type="text" name="hinta" size="20"/>
             </tr>

         </table>
         <input type="submit" value="Submit" />
      </form>
    
    </body>
</html>
