package com.usermanagement.resource;

import com.usermanagement.model.User;
import com.usermanagement.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.Map;

@Path("/login")
public class LoginResource {

    private final UserService userService = new UserService();

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(Map<String, String> credentials, @Context HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        if (credentials == null || credentials.get("email") == null || credentials.get("password") == null) {
            response.put("success", false);
            response.put("message", "Email and password are required.");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }

        String email = credentials.get("email");
        String password = credentials.get("password");

        Map<String, Object> loginResult = userService.login(email, password);
        boolean success = (boolean) loginResult.getOrDefault("success", false);

        if (success) {
            User user = (User) loginResult.get("user");
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());

            response.put("success", true);
            response.put("message", "Login successful.");
            response.put("redirect", "home.jsp");
            return Response.ok(response).build();
        } else {
            response.put("success", false);
            response.put("message", loginResult.getOrDefault("message", "Invalid email or password."));
            return Response.status(Response.Status.UNAUTHORIZED).entity(response).build();
        }
    }

    @POST
    @Path("/logout")
    @Produces(MediaType.APPLICATION_JSON)
    public Response logout(@Context HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Logged out successfully.");
        response.put("redirect", "login.jsp");
        return Response.ok(response).build();
    }

    @GET
    @Path("/logout")
    @Produces(MediaType.APPLICATION_JSON)
    public Response logoutGet(@Context HttpServletRequest request) {
        return logout(request);
    }
}
