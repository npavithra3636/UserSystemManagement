package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String dbUrl = System.getenv("DB_URL");

        if (dbUrl != null && !dbUrl.isEmpty()) {
            return DriverManager.getConnection(dbUrl);
        }

        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/user_management",
                "root",
                "devi");
    }
}