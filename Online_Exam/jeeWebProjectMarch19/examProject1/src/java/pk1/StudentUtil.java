package pk1;

import java.util.*;
import java.sql.*;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class StudentUtil
{
    public static Student login(String username,String pwd) //from index.jsp
    {
        Connection con =null;
        PreparedStatement ps =null;

        try
        {
            con = DBUtil.getConnection();

            
            ps = con.prepareStatement("select username, sname, email from students where username=? and pwd = ?");

            ps.setString(1,username);
            ps.setString(2,pwd);

            ResultSet rs = ps.executeQuery();

            if ( rs.next())
            { // success
                Student s = new Student();
                
                s.setUsername(rs.getString("username"));
                s.setSname(rs.getString("sname"));
                s.setEmail(rs.getString("email"));
                
                return s;
            }
            else
                return null;
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
            return null;
        }
        finally
        {
            DBUtil.close(ps);
            DBUtil.close(con);
       }
    } // end of login()

  public static String getHintQuestion(String email)  //from forgot.jsp
  {
        Connection con =null;
        PreparedStatement ps =null;

        try
        {
            con = DBUtil.getConnection();
            ps = con.prepareStatement("select  hintq from students where email = ?");
            ps.setString(1,email);

            ResultSet rs = ps.executeQuery();

            if ( rs.next())
            { // success
               return rs.getString(1); // returning the hint question(of corresponding email id)
            }
            else
                return null;
           }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
            return null;
        }
        finally
        {
            DBUtil.close(ps);
            DBUtil.close(con);
       }
   } // end of getHintQuestion


   public static String processForgotPassword(String email, String hinta) //from forgot2.jsp
   {
        Connection con =null;
        PreparedStatement ps =null;

        try
        {
            con = DBUtil.getConnection();
            ps = con.prepareStatement("select  pwd from  students where email = ? and hinta = ?");
            ps.setString(1,email);
            ps.setString(2,hinta);
            ResultSet rs = ps.executeQuery();

            if ( rs.next()) // success
            {
                  try
                  {
                   // send mail
                    sendMail( email, rs.getString("pwd"));
                    return null; // success
                  }
                  catch(Exception ex)
                  {
                      return ex.getMessage(); //if not success in sending mail then returning the error message
                  }
            }
            else
                return "Invalid Hint Answer. Please Try Again!";
           }
        catch(Exception ex)
        {
            return ex.getMessage();
        }
        finally
        {
            DBUtil.close(ps);
            DBUtil.close(con);
       }
   } // processForgotPassword

   public static void sendMail(String email,String pwd) throws Exception
   {
        String from = "forJavaWebStudents@gmail.com";

        //part-3
        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");//SMTP server details
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        //part-4
        Session session = Session.getInstance(props,  new Authenticator()
        {
            @Override
            protected PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication("forJavaWebStudents@gmail.com", "mvpcolony3");
            }
        });

        Message msg = new MimeMessage(session);

        msg.setFrom(new InternetAddress(from));
        msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email));

        msg.setContent("Dear Student,<p/>Your Password: " + pwd + "<p/>Webmaster<br/>GITAMonlineExam.com","text/html"); 

        msg.setSubject("Forgot Password");
        // send message
        Transport.send(msg);
   } // end of sendMail()

} // end of StudentUtil class
