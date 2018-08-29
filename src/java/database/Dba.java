package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import static java.time.Clock.system;

public class Dba {
    private String base_datos;
    private Connection dbcon;
    public Statement query;
    
    public Dba(String base_datos){
        this.base_datos = base_datos;
    }

    public void setBase_datos(String base_datos) {
        this.base_datos = base_datos;
    }        
    
   public void conectar(){
       
       try  {
           Class.forName("oracle.jdbc.driver.OracleDriver");
           String driver = "jdbc:oracle:thin:@";
           dbcon = DriverManager.getConnection(driver + base_datos,"ing","ing");
           query = dbcon.createStatement();
       } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
   
   public void desconectar() {
        try {
            query.close();
            dbcon.close();
        } catch (Exception e) {
        }
    }
   
   public void commit(){
       try{
           dbcon.commit();
       }catch(Exception e){
           e.printStackTrace();
       }
   }
    
    
}
