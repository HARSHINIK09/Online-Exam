<%@page import="pk1.Student"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="pk1.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Store Marks</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Coming from displayQuestions.jsp-->
        <h2>Hello</h2>
        
        <%
            Connection con =  DBUtil.getConnection();
            
            String userSelections[] = new String[10];

            int j;
            String param ="";

            // now storing the choosen answers in an array
            for(int i = 0; i< 10; i++)
            {
                j = i + 1;  // because group names starts from 1
                param = "answer" + j;
                userSelections[i] = request.getParameter(param);
            }
            
            //if user doesn't answer any of the questions, then just put "0" or "5" for that question ( ie., other than 1 , 2, 3, & 4)
            
            for(int i = 0; i < 10; i++)
                if(userSelections[i] == null)
                    userSelections[i] = "0";
            
        
            out.print("Your Answers are:<br/>");
            for(int i = 0; i< 10; i++)
            {
                if(userSelections[i].equals("0"))
                    out.print("<b style=color:red>" + (i+1) + ". Not answered </b><br/>");
                else
                   out.print((i+1) + ". &nbsp; &nbsp;"+ userSelections[i] + "<br/>");
            }

            String subject =  request.getParameter("subject");
            
            String tableName = "";
            String subjectName = "";
            
            if(subject.equals("subject1"))
            {
                tableName = "cquestions";
                subjectName = "C";
            }
            else if(subject.equals("subject2"))
            {
                tableName = "cppquestions";
                subjectName = "C++";
            }
            else if(subject.equals("subject3"))
            {
                tableName = "javaquestions";
                subjectName = "Java";
            }
            
            %>
            
            <%
                //Now calculating Marks
            String actualAnswers[] = new String[10];
            String userSelectedAnswers[] = new String[10];
            
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            
      
            ResultSet rs1 = st2.executeQuery("select * from " + tableName);

            int i = 0;
            while(rs1.next())
            {
                actualAnswers[i] = rs1.getString(7);
                i++;
            }

            // refreshing
            rs1 = st1.executeQuery("select * from " + tableName);

            i = 0;
            int correctAnswersCount = 0;
            while( rs1.next())
            {
//                out.print("<h3>Question:" + rs1.getInt(1) + "</h3>");
//                out.print("User Selected: " + userSelections[i] + "<br>");
//                out.print("Actual Answer is: " + actualAnswers[i] + "<br>");
//
//                out.print("<p/>");
//                
                // comparing the choosen answers with the actual answers
                if(userSelections[i].equals(actualAnswers[i]))
                    correctAnswersCount++;

                i++;
            }

            out.print("<h2>Your Marks in " + subjectName + ": " + correctAnswersCount + "</h2>");
            %>
            
            <%
                //Now storing marks in the marks table - here we have to consider three cases
                //case1. this is the 1st exam by the user                                                                       :insert record
                //case2. whether exam taken for any of the other subjects but not in this subject       :update record
                //case3. whether retake                                                                                                :update record
                
               Student s = (Student) session.getAttribute("student");
               String username =  s.getUsername();
               
            
               Statement st3 =  con.createStatement();
               ResultSet rs4 = st3.executeQuery("select * from marks where username= '" + username + "' ");

                if(rs4.next() == false)   //case1 is matched, ie.:this is the 1st exam by the user         :insert record
                {
                    st3.executeUpdate("insert into marks(examid,  username, " + subject + ") values(examid_seq.nextval, '" + username + "' , " + correctAnswersCount +")");
                    out.print("<h3>Thanks for taking your first exam, Marks of " + subjectName + " saved in the database</h3>");
                }
                else  //record is present , ie already exam taken in one / more subjects
                {
                    rs4 = st3.executeQuery("select " + subject + " from marks where username= '" + username + "' ");
                    
                    rs4.next();

                    //don't use rs4.getInt("subject1"), then we can't check it against null
                   if(rs4.getString(subject) == null) //case2 is matched, whether exam taken for any of the other subjects but not in this subject       :update record
                   {
                       st3.executeUpdate("update marks set " + subject + " = " + correctAnswersCount + " where username = '" + username +"' ");
                       out.print("<h3>Thanks for taking the exam, Marks of " + subjectName + " saved in the database</h3>");
                   }
                   else //case3 is matched, whether retake      :update record
                   {
                       st3.executeUpdate("update marks set " + subject + " = " + correctAnswersCount + " where username = '" + username +"' ");
                       out.print("<h3>Thanks for retaking the exam, Marks of " + subjectName + " updated in the database</h3>");
                   }
                }
              
            %>
            <p/>
            <a href="takeExam.jsp">Take another Exam!</a>
    </body>
</html>
