package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Database connection credentials
    // You can also override via -Ddb.url=..., -Ddb.user=..., -Ddb.password=... or Environment variables
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/user_management?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "devi";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = System.getProperty("db.url", System.getenv().getOrDefault("DB_URL", DEFAULT_URL));
        String username = System.getProperty("db.user", System.getenv().getOrDefault("DB_USER", DEFAULT_USERNAME));
        String password = System.getProperty("db.password", System.getenv().getOrDefault("DB_PASSWORD", DEFAULT_PASSWORD));
        return DriverManager.getConnection(url, username, password);
    }
}
