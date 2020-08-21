<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" import="pk1.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body bgcolor="skyblue">

    <h1>Online Examination</h1>
    
    
    <center>
                <h2>Student Login Form </h2>
                <form action="index.jsp" method="post"> <!-- if failed-->
                    
                    <table>
                        <tr>
                            <th>
                                <input type=text name="username" placeholder="Enter username"/>
                    <br/>
                    
                    <input type=password name="pwd" placeholder="Enter Password"/>
                    <p/>
                    <input type=submit value="Login"/>
                                
                            </th>
                        </tr>
                    </table>
                    
                    
                    <%
                      String username = request.getParameter("username");
                      
                      
                      if ( username != null)
                      {
                            String pwd = request.getParameter("pwd");
                            Student s = StudentUtil.login(username,pwd);
                          
                            if ( s == null)
                                out.println("<br/>Invalid Login");  // if failed remains in the same page
                            else
                            {
                                session.setAttribute("student",s);
                                response.sendRedirect("home.html");  // if successful
                            }
                     } // end of if

                    %>
                </form>
                <p></p>
                <a href="forgot.html">Forgot Password </a>
                <br/>
                <a href="registerMe.html">New student? Register!</a>
           
    </center>
    
    </body>
</html>
