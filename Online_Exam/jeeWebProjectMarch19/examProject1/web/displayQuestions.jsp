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
        <title>Display Questions</title>
        <link href="styles.css" rel="stylesheet" />
        
        
    </head>
    <body>
        
                <!-- coming from retakeExam.jsp-->
        <%
            String subject = request.getParameter("subject");
            
            String displayName = "";
            
            if(subject.equals("subject1"))
            {
                displayName = "C";
                out.print("<h2>Subject Selected: C</h2>");
            }
            else if(subject.equals("subject2"))
            {
                displayName = "C++";
                out.print("<h2>Subject Selected: C++</h2>");
            }
            else if( subject.equals("subject3"))
            {
                displayName = "Java";
                out.print("<h2>Subject Selected: Java</h2>");      
            }
            
            Connection con =  DBUtil.getConnection();
            Statement st =  con.createStatement();
            
            Student s  = (Student) session.getAttribute("student");
            String username = s.getUsername();
            
            ResultSet rs = null;
            
            if(displayName.equals("C"))
            {
                rs =  st.executeQuery("select qid, question, option1, option2, option3, option4 from cquestions");
                
            }
            else if(displayName.equals("C++"))
            {
                rs =  st.executeQuery("select qid, question, option1, option2, option3, option4 from cppquestions");
                
            }
            else if(displayName.equals("Java"))
            {
                rs =  st.executeQuery("select qid, question, option1, option2, option3, option4 from javaquestions");
                
            }
            %>
            
            <form action="storeStudentAnswers.jsp">
            <%
            
                int i = 1;
                while(rs.next())
               {
                   out.println("<h3 style=color:maroon>" + rs.getString("qid") + ". ");
                   out.println(rs.getString("question") + "</h3>");

                   %>

                   <input type="radio" name="answer<%= i%>" value="1" class="required"/><%= rs.getString(3) %>  <br/>
                   <input type="radio" name="answer<%= i%>" value="2"/><%= rs.getString(4) %> <br/>
                   <input type="radio" name="answer<%= i%>" value="3"/><%= rs.getString(5) %> <br/>
                   <input type="radio" name="answer<%= i%>" value="4"/><%= rs.getString(6) %> <br/>

                   <p/>
            <%
                   i++;
               }
            %>
            
            <p/>
            
            <input type="hidden" name="subject" value="${param.subject}">
            
            <input type ="submit" value="Submit Answers">
            
        </form>
            <p/>
            <a href="takeExam.jsp">Not interested!, select another Subject</a>
    </body>
</html>
