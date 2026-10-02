package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQLDATABASE");
        String username = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                System.out.println("HOST = " + System.getenv("MYSQLHOST"));
System.out.println("PORT = " + System.getenv("MYSQLPORT"));
System.out.println("DATABASE = " + System.getenv("MYSQLDATABASE"));
System.out.println("USER = " + System.getenv("MYSQLUSER"));

        return DriverManager.getConnection(url, username, password);
    }
}