package com.cis.ecart.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection createDBConnection() throws ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce_cart";
        final String USERNAME = "root";
        final String PASSWORD = "gismaster";
        Connection con = null;
        try{
            con = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            System.out.println("SUCCESS : DB Connected Successfully..");
        }catch (SQLException e){
            System.out.println("DB FAIL : " + e);
        }
        return con;
    }
}
