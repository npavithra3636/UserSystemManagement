package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/user_management?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "devi";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = System.getenv("DB_URL");
        String username = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        // Use local MySQL when running on your computer
        if (url == null || url.isEmpty()) {
            url = DEFAULT_URL;
        }

        if (username == null || username.isEmpty()) {
            username = DEFAULT_USERNAME;
        }

        if (password == null || password.isEmpty()) {
            password = DEFAULT_PASSWORD;
        }

        if (url.startsWith("mysql://")) {
    url = "jdbc:" + url;
}

return DriverManager.getConnection(url, username, password);
    }
}