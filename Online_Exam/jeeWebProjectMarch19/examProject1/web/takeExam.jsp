<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Select Subject</title>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- coming from click on the hyperlink on the Left Frame after login-->
       
        <form action="retakeExam.jsp">
            

            Select a Subject: 
            <select name="subject">
                <option value="subject1">C</option>
                <option value="subject2">C++</option>
                <option value="subject3">Java</option>
            </select>
            
            <p/>
            
            <input type="submit" value="Start Exam">
            
        </form>
        
    </body>
</html>
