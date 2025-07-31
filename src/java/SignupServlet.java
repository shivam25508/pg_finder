

import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignupServlet.class.getName());

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "JDBC Driver not found", e);
            throw new ServletException("JDBC Driver not found", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("uname");
        String email = request.getParameter("email");
        String password = request.getParameter("pwd");

        if (username == null || email == null || password == null
                || username.trim().isEmpty()
                || email.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required!");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
            return;
        }

            String tableName = "users";
            String emailColumn = "email";
            String usernameColumn = "username";
            String passwordColumn = "password";
            String type = "type";


        String jdbcUrl = "jdbc:mysql://localhost:3306/numl_hostel_finder";
        String dbUsername = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword); PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO " + tableName + " (" + emailColumn + ", " + usernameColumn + ", " + passwordColumn +", " +type +") VALUES (?, ?, ?, ?)")) {

            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, password); 
            ps.setInt(4, 0);

            int count = ps.executeUpdate();

            if (count > 0) {
                request.setAttribute("successMessage", "Registered Successfully!");
            } else {
                request.setAttribute("errorMessage", "Registration failed due to an unknown error!");
            }

            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during signup", e);

            if (e.getErrorCode() == 1062) {
                request.setAttribute("errorMessage", "Email or username already exists!");
            } else {
                request.setAttribute("errorMessage", "An error occurred during registration: " + e.getMessage());
            }

            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user registration handling";
    }
}
