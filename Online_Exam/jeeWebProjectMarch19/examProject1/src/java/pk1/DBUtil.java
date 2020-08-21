package pk1;
import java.sql.*;

public class DBUtil
{
    public static Connection getConnection()
    {
      try
      {
          Class.forName("oracle.jdbc.driver.OracleDriver");
          Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","exam1","exam1");
          return con;
      }
      catch(Exception ex)
      {
          System.out.println(ex.getMessage());
          return null;
      }
   }

   public static void close(Connection con)
   {
       try
       {
           con.close();
       }
       catch(Exception ex) {}
   }

   public static void close(Statement st)
   {
       try
       {
           st.close();
       }
       catch(Exception ex) {}
   }
}
