<%@page import="pk1.Student"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Marks</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body topmargin="50px">
        <%@page import="pk1.DBUtil" %>
        
        <h4>Max Marks for each subject: 10</h4>
        <%
            Connection con =  DBUtil.getConnection();
            Statement st =  con.createStatement();
            
            Student s  = (Student) session.getAttribute("student");
            String username = s.getUsername();
            
            
            ResultSet rs = st.executeQuery("select subject1, subject2, subject3 from marks where username= '" + username + "' ");
            if(rs.next()) //would be false if the student has no record in the marks table
            {
                if(rs.getString(1) != null)   //would be false if the student has not taken exam on "C"
                    out.print("C:" + rs.getString(1) + "<br/>");
                else
                    out.print("C: Exam not yet taken<br/>");  
                
                 if(rs.getString(2) != null)   //would be false if the student has not taken exam on "C"
                    out.print("C++:" + rs.getString(2) + "<br/>");
                else
                    out.print("C++: Exam not yet taken<br/>");  
                 
                  if(rs.getString(3) != null)   //would be false if the student has not taken exam on "C"
                    out.print("Java:" + rs.getString(3) + "<br/>");
                else
                    out.print("Java: Exam not yet taken<br/>");  
                
            }
            else
                out.print("Exam not yet taken on any of the subjects<br/>");
            
            %>
    </body>
</html>
