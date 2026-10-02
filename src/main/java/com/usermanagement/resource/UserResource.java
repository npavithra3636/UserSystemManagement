package com.usermanagement.resource;

import com.usermanagement.model.User;
import com.usermanagement.service.UserService;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("/users")
public class UserResource {

    private final UserService userService = new UserService();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUsers(@QueryParam("search") String search) {
        List<User> users;
        if (search != null && !search.trim().isEmpty()) {
            users = userService.searchUsers(search);
        } else {
            users = userService.getAllUsers();
        }
        return Response.ok(users).build();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserById(@PathParam("id") int id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return Response.ok(user).build();
        } else {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "User not found.");
            return Response.status(Response.Status.NOT_FOUND).entity(error).build();
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addUser(User user) {
        Map<String, Object> result = userService.addUser(user);
        boolean success = (boolean) result.getOrDefault("success", false);

        if (success) {
            return Response.status(Response.Status.CREATED).entity(result).build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity(result).build();
        }
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUser(@PathParam("id") int id, User user) {
        if (user == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "User data is missing.");
            return Response.status(Response.Status.BAD_REQUEST).entity(error).build();
        }

        user.setId(id);
        Map<String, Object> result = userService.updateUser(user);
        boolean success = (boolean) result.getOrDefault("success", false);

        if (success) {
            return Response.ok(result).build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity(result).build();
        }
    }

    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteUser(@PathParam("id") int id) {
        Map<String, Object> result = userService.deleteUser(id);
        boolean success = (boolean) result.getOrDefault("success", false);

        if (success) {
            return Response.ok(result).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity(result).build();
        }
    }
}
