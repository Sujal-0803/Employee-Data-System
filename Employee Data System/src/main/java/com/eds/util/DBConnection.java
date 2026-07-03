package com.eds.util;

import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;

public class DBConnection {
	public static void main(String[] args) throws Exception{
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        if(conn != null) {
        	System.out.println("Database is connected");
        }
        else {
        	System.out.println("Database is not connected");
        }
    }
}