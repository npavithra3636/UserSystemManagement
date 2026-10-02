package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url != null && !url.isEmpty()) {
            return DriverManager.getConnection(url, user, password);
        }

        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/user_management",
                "root",
                "devi");
    }
}