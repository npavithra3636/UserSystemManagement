package com.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DEFAULT_URL =
        "jdbc:mysql://localhost:3306/user_management";

private static final String DEFAULT_USERNAME = "root";

private static final String DEFAULT_PASSWORD = "devi";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQLDATABASE");
        String username = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");

        String url;
        

        if (host != null && !host.isEmpty()) {

            url = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        } else {

            url = DEFAULT_URL;
            username = DEFAULT_USERNAME;
            password = DEFAULT_PASSWORD;
        }
        
        return DriverManager.getConnection(url, username, password);
    }
}