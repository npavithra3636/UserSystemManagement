# User Management Web Application

A clean, responsive, and professional Java Web Application for managing user records, credentials, and directory operations. Built using **JSP, jQuery AJAX, Jersey RESTful Web Services, JDBC, and MySQL**.

---

## 1. Technologies Used

- **Frontend:** JSP, HTML5, CSS3, Bootstrap 5.3, Bootstrap Icons, jQuery 3.7.1, AJAX
- **Backend:** Java, Jersey RESTful Web Services (JAX-RS), JDBC, HTTP Session, Java Servlet Filter
- **Database:** MySQL
- **Build & Dependency Management:** Apache Maven

---

## 2. Architecture & Application Flow

The application follows a clean 4-tier layered architecture:

```
[ JSP Pages / Browser UI ]
          │
      (jQuery AJAX / JSON)
          │
[ Jersey REST Resource Layer ] (LoginResource, UserResource)
          │
[ Service Layer ]              (UserService - Business Logic & Validation)
          │
[ DAO Layer (JDBC) ]           (UserDAO, DBConnection - SQL PreparedStatements)
          │
[ MySQL Database ]             (user_management.users)
```

### Key Request Flows:

1. **Login & Session Authentication:**
   - User enters credentials on `login.jsp`.
   - `login.js` sends an asynchronous AJAX POST request to `/api/login`.
   - `LoginResource` validates credentials via `UserService` and `UserDAO` against MySQL.
   - On successful validation, a server-side `HttpSession` is created and the browser redirects to `home.jsp`.

2. **Session Guarding via AuthenticationFilter:**
   - `AuthenticationFilter` intercepts all incoming web and API requests.
   - Unauthenticated requests to protected pages (`home.jsp`, `users.jsp`, `add-user.jsp`) are redirected to `login.jsp`.
   - Unauthenticated requests to protected REST endpoints (`/api/users/*`) return HTTP 401 Unauthorized.
   - Logout invalidates the `HttpSession` and safely redirects the user to `login.jsp`.

3. **CRUD & Search Operations:**
   - **Create (Add):** Form on `add-user.jsp` submits JSON payload via AJAX POST to `/api/users`.
   - **Read (List):** `users.jsp` retrieves directory records via AJAX GET from `/api/users`.
   - **Search:** `users.jsp` queries `/api/users?search={keyword}` dynamically.
   - **Update (Edit):** Edit modal fetches existing details via AJAX GET `/api/users/{id}` and updates via AJAX PUT to `/api/users/{id}`.
   - **Delete:** Delete modal confirms and executes AJAX DELETE on `/api/users/{id}`.

---

## 3. Project Structure

```
UserHub/
├── src/main/java/com/usermanagement/
│   ├── model/
│   │   └── User.java                    # Entity model with getters/setters
│   ├── dao/
│   │   ├── DBConnection.java            # JDBC connection manager
│   │   └── UserDAO.java                 # Pure JDBC operations with PreparedStatement
│   ├── service/
│   │   └── UserService.java             # Business validation & rules
│   ├── resource/
│   │   ├── LoginResource.java           # Authentication REST endpoints
│   │   └── UserResource.java            # User CRUD REST endpoints
│   └── filter/
│       └── AuthenticationFilter.java    # HttpSession route & API guard
│
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml                      # Servlet container & filter mappings
│   ├── css/
│   │   └── style.css                    # Professional custom styles
│   ├── js/
│   │   ├── login.js                     # Login AJAX logic & credentials autofill
│   │   └── users.js                     # CRUD, search, modals & dashboard AJAX logic
│   ├── login.jsp                        # Split-screen login portal
│   ├── home.jsp                         # Dashboard & directory metrics
│   ├── users.jsp                        # User table, live search & modals
│   └── add-user.jsp                     # User creation form
│
├── database.sql                         # MySQL database schema & sample seed data
├── pom.xml                              # Maven configuration
└── README.md                            # Documentation
```

---

## 4. Database Setup & Sample Data

### MySQL Script (`database.sql`)
Run the following script in MySQL Workbench or MySQL CLI:

```sql
-- 1. Create Database
CREATE DATABASE IF NOT EXISTS user_management;
USE user_management;

-- 2. Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

-- 3. Insert Initial Sample Users
INSERT INTO users (name, email, phone, address, password) VALUES
('System Administrator', 'admin@userhub.com', '9876543210', 'Plot 42, Cyber Towers, HITEC City, Hyderabad, Telangana', 'admin123'),
('Ravi Kumar', 'ravi.kumar@example.com', '9848012345', '12-4-56, Banjara Hills, Hyderabad, Telangana', 'password123'),
('Priya Sharma', 'priya.sharma@example.com', '9880123456', '74/A, Indiranagar, Bengaluru, Karnataka', 'password123'),
('Arjun Reddy', 'arjun.reddy@example.com', '9701234567', '45-2-10, MG Road, Vijayawada, Andhra Pradesh', 'password123'),
('Sneha Patel', 'sneha.patel@example.com', '9825012345', '88, SG Highway, Ahmedabad, Gujarat', 'password123'),
('Karthik Rao', 'karthik.rao@example.com', '9444012345', '23, Anna Nagar, Chennai, Tamil Nadu', 'password123');
```

> **Database Configuration:** Connection parameters can be configured in `src/main/java/com/usermanagement/dao/DBConnection.java`.

---

## 5. REST API Endpoints

| HTTP Method | Endpoint | Description | Request Body | Response |
|---|---|---|---|---|
| `POST` | `/api/login` | Authenticate user & start session | `{"email":"...","password":"..."}` | JSON status & redirect |
| `POST` / `GET` | `/api/login/logout` | Invalidate session & logout | None | JSON status & redirect |
| `GET` | `/api/users` | List all users | None | JSON array of users |
| `GET` | `/api/users?search={keyword}` | Filter users by keyword | None | JSON array of users |
| `GET` | `/api/users/{id}` | Retrieve specific user by ID | None | JSON user object |
| `POST` | `/api/users` | Create a new user record | `{"name":"...","email":"...","phone":"...","address":"...","password":"..."}` | JSON status |
| `PUT` | `/api/users/{id}` | Update existing user details | `{"name":"...","email":"...","phone":"...","address":"...","password":"..."}` | JSON status |
| `DELETE` | `/api/users/{id}` | Delete user by ID | None | JSON status |

---

## 6. How to Build & Run

### Option 1: Run with Embedded Jetty Plugin (Recommended)
From the project root:
```bash
mvn clean compile jetty:run
```
Access in browser:
```
http://localhost:8080/UserManagementSystem/
```

### Option 2: Deploy WAR to Apache Tomcat
1. Package the project:
   ```bash
   mvn clean package
   ```
2. Copy `target/UserManagementSystem.war` into Tomcat's `webapps/` directory.
3. Start Tomcat and navigate to `http://localhost:8080/UserManagementSystem/`.

---

## 7. Default Login Credentials

| Role | Email | Password |
|---|---|---|
| **Administrator** | `admin@userhub.com` | `admin123` |
| **Demo User** | `ravi.kumar@example.com` | `password123` |
