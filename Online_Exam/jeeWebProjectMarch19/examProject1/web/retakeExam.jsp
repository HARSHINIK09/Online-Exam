<%@page import="java.sql.ResultSet"%>
<%@page import="pk1.Student"%>
<%@page import="java.sql.Statement"%>
<%@page import="pk1.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Re Take Exam</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <!-- coming from takeExam.jsp-->
    <body>
        <%
            Connection con =  DBUtil.getConnection();
            Statement st =  con.createStatement();
            
            Student s  = (Student) session.getAttribute("student");
            String username = s.getUsername();
            
            String subjectSelected =  request.getParameter("subject");
            
            String displayName = "";
            
            if(subjectSelected.equals("subject1"))
                displayName = "C";
            else if(subjectSelected.equals("subject2"))
                displayName = "C++";
            else if( subjectSelected.equals("subject3"))
                displayName = "Java";
                
            ResultSet rs = st.executeQuery("select " + subjectSelected + " from marks where username= '" + username + "' ");
            if(rs.next()) //would be false if the student has no record in the marks table
            {
                if(rs.getString(1) != null)   //would be false if the student has not taken exam on the subject
                {
                    out.print("You have already taken exam on " + displayName +", your marks were: " + rs.getString(1) + "<br/>");
                    %>
                    
                   <a href=displayQuestions.jsp?subject=<%= subjectSelected %> > Re Take Exam </a>
                   <%
                }
                else
                {
                    response.sendRedirect("displayQuestions.jsp?subject=" + subjectSelected);
                }
            }
            else
                response.sendRedirect("displayQuestions.jsp?subject=" + subjectSelected);  
            %>
            
            
            
            <p/>
            
            <a href="takeExam.jsp"> Go Back </a>

    </body>
</html>
