<%@ page import="java.sql.*, java.util.*, pk1.*" %>

<html>
    <head>
        <link href="styles.css" rel="stylesheet" />
    </head>
    <body>
        <%
        Connection con = DBUtil.getConnection();
        PreparedStatement ps = con.prepareStatement("insert into students values(?,?,?,?,?,?)");
        
        try
        {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String pwd = request.getParameter("pwd");
            String sname = request.getParameter("sname");
            String hintq = request.getParameter("hintq");
            String hinta = request.getParameter("hinta");

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3,pwd);
            ps.setString(4,sname);      // in order of fields in the actual table in Oracle DB
            ps.setString(5,hintq);
            ps.setString(6, hinta);


            int x = ps.executeUpdate();
            out.println("Student - " + sname  + " registered successfully");
        
        }
        catch(Exception exp)
        {
            out.println("Sorry, this Username already used by another student, give a diffent one");  // if primary key constraint violated
        }
        
        DBUtil.close(ps);
        DBUtil.close(con);
        
        %>
        
        <p/>
        <a href="index.jsp">Go to Login Page</a>
    </body>
</html>