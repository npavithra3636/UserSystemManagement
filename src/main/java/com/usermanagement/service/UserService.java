package com.usermanagement.service;

import com.usermanagement.dao.UserDAO;
import com.usermanagement.model.User;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public Map<String, Object> login(String email, String password) {
        Map<String, Object> response = new HashMap<>();

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Email and password are required.");
            return response;
        }

        try {
            User user = userDAO.validateLogin(email.trim(), password.trim());
            if (user != null) {
                response.put("success", true);
                response.put("user", user);
                response.put("message", "Login successful.");
            } else {
                response.put("success", false);
                response.put("message", "Invalid email or password.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Database Error: " + e.getMessage() + ". Please check MySQL credentials in DBConnection.java.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "JDBC Driver Error: " + e.getMessage());
        }

        return response;
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public List<User> searchUsers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return userDAO.getAllUsers();
        }
        return userDAO.searchUsers(keyword.trim());
    }

    public Map<String, Object> addUser(User user) {
        Map<String, Object> response = new HashMap<>();

        if (user.getName() == null || user.getName().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Name is required.");
            return response;
        }

        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Email is required.");
            return response;
        }

        if (userDAO.isEmailTaken(user.getEmail().trim(), 0)) {
            response.put("success", false);
            response.put("message", "Email already exists.");
            return response;
        }

        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Password is required.");
            return response;
        }

        user.setName(user.getName().trim());
        user.setEmail(user.getEmail().trim());
        user.setPassword(user.getPassword().trim());

        boolean success = userDAO.addUser(user);
        response.put("success", success);
        response.put("message", success ? "User added successfully." : "Failed to add user.");
        return response;
    }

    public Map<String, Object> updateUser(User user) {
        Map<String, Object> response = new HashMap<>();

        if (user.getName() == null || user.getName().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Name is required.");
            return response;
        }

        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Email is required.");
            return response;
        }

        if (userDAO.isEmailTaken(user.getEmail().trim(), user.getId())) {
            response.put("success", false);
            response.put("message", "Email already exists.");
            return response;
        }

        user.setName(user.getName().trim());
        user.setEmail(user.getEmail().trim());

        boolean success = userDAO.updateUser(user);
        response.put("success", success);
        response.put("message", success ? "User updated successfully." : "Failed to update user.");
        return response;
    }

    public Map<String, Object> deleteUser(int id) {
        Map<String, Object> response = new HashMap<>();
        boolean success = userDAO.deleteUser(id);
        response.put("success", success);
        response.put("message", success ? "User deleted successfully." : "Failed to delete user.");
        return response;
    }
}
