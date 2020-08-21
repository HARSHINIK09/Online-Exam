<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="pk1.StudentUtil"%>
<%@page import="pk1.Student"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="pk1.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>For Android</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body>

        <h2>Result For Android</h2>
        
        
        <%
                String username = request.getParameter("username");
                String pwd = request.getParameter("password");

                Student s = StudentUtil.login(username,pwd);

                if ( s == null)  //login failed
                {
                    out.println("failed<br/>");  
                    return;
                }
                else
                {
                    try
                    {
                            
                        Connection con = DBUtil.getConnection();
                        Statement st =  con.createStatement();

                        ResultSet rs1 =  st.executeQuery("select sname from students where username = '" + username + "' ");

                        out.print("success<br/>");  //login success, ie., such a user exists
                        
                        rs1.next();

                        String studentName  = rs1.getString(1);
                        out.print("(" + studentName + ")<br/>");

                        ResultSet rs2 =  st.executeQuery("select subject1, subject2, subject3 from marks where username = '" + username + "' ");

                         if( rs2.next() == false)  //if no record available for that student (if not yet taken any exam)
                        {
                            out.print("C#<br/>");
                            out.print("CPP#<br/>");
                            out.print("Java#<br/>");
                        }
                        else
                         {

                            String cMarks  = rs2.getString(1);
                            if(cMarks == null)
                                out.print("C#<br/>");
                            else
                                out.print("CMarks[c"+cMarks + "c]<br/>");

                            String cppMarks  = rs2.getString(2);
                            if(cppMarks == null)
                                out.print("CPP#<br/>");
                            else
                                out.print("CPPMarks[d"+cppMarks + "d]<br/>");

                            String javaMarks  = rs2.getString(3);
                            if(javaMarks == null)
                                out.print("Java#<br/>");
                            else
                                out.print("JavaMarks[j"+ javaMarks + "j]<br/>");
                         }
                }
                catch(Exception exp)
                 {
                      out.print("Catch: " + exp.getMessage());
                 }
                }
                //-----------------------------------------------------------------
               // out.print("<br/>--------------------------------------------------------<br/>");
                
                //Enhancement
                
                String finalResult = "FR@";
                //part1
                Connection con = DBUtil.getConnection();
                Statement st2 =  con.createStatement();

                ResultSet rs2 =  st2.executeQuery("select count(*) from marks");  //to find no. of records in marks table
                rs2.next();
                int totalRecordsInMarksTable =  rs2.getInt(1);
                
                int marksOfAllStudents[] = new int[totalRecordsInMarksTable];
                
                ResultSet rs3 =  st2.executeQuery("select subject1, subject2, subject3 from marks");
                
                int i = 0;
                while(rs3.next())
                {
                    marksOfAllStudents[i] =  rs3.getInt(1) + rs3.getInt(2) + rs3.getInt(3);
                    i++;
                }
                    
//                out.print("Scores of individual Students:<br/>");
//                for( int m : marksOfAllStudents)
//                {
//                        out.print(m + "<br/>");
//                }
                
                //Now Sort the scores (descending order , highest marks to lowest marks)
                //part2
                int j, t;
                int n = marksOfAllStudents.length;
                
                for(i =0; i < n-1; i++)
                {
                    for(j=0;j<n-1-i;j++)
                    {
                        if(marksOfAllStudents[j] < marksOfAllStudents[j+1])
                        {
                            t = marksOfAllStudents[j];
                            marksOfAllStudents[j] = marksOfAllStudents[j+1];
                            marksOfAllStudents[j+1] = t;
                        }
                    }
                }
                
//                out.print("Scores after Sorting:<br/>");
//                for( int m : marksOfAllStudents)
//                {
//                        out.print(m + "<br/>");
//                }
//                
                //Now get the marks of current Student
                //part3
                ResultSet rs4 =  st2.executeQuery("select subject1, subject2, subject3 from marks where username ='" + username + "' ");
                
                int marksOfCurrentStudent, flag = 1;
                
                if(rs4.next())
                    marksOfCurrentStudent =  rs4.getInt(1) + rs4.getInt(2) + rs4.getInt(3);
                else
                {
                   marksOfCurrentStudent =0;
                   flag = 0;  //indicating that the student has not taken any of the exams
                }
                
                if(flag == 0)
                {
                   // out.print("<br/>You  have not taken any exam, hence no rank");
                    finalResult += "<br/>You  have not taken any exam, hence no rank";
                }
                else
                {
                    //out.print("<br/>Your total marks: " + marksOfCurrentStudent);
                    finalResult += "<br/>Your total marks: " + marksOfCurrentStudent;
                
                    //Now find the Rank
                    int rank=0;
                    for(i = 0; i< marksOfAllStudents.length; i++)
                    {
                        if(marksOfCurrentStudent == marksOfAllStudents[i])
                        {
                            rank = i+1;
                            break;
                        }
                    }
                    
                    //out.print("<br/>Your Rank: " + rank);
                    finalResult += "<br/>Your Rank: " + rank;
                    
                }
                
                //out.print("<br/>No. of students attempted any exam:" + totalRecordsInMarksTable);
                finalResult += "<br/>No. of students attempted any exam:" + totalRecordsInMarksTable;
                    
                //finding total no. of registered students
                ResultSet rs5 =  st2.executeQuery("select count(*) from students");  //to find no. of records in marks table
                rs5.next();
                int totalRecordsInStudentsTable =  rs5.getInt(1);
                //out.print("<br/>No. of registered students:" + totalRecordsInStudentsTable);
                
                finalResult += "<br/>No. of registered students:" + totalRecordsInStudentsTable;
                    
                out.print(finalResult);
                
        %>
           
       
    </body>
</html>
