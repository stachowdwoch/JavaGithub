/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Admin
 */

import java.sql.*;
import javax.swing.JOptionPane;


public class DatabaseConnection {
    Connection conn;
    
    public static Connection connectDB(){
        try{            
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Maks", "maks95");
            //Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "janusz", "janusz");
            return conn;
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, e);
            return null;
        }
    }
}
