/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
/**
 *
 * @author Talha Bin Shahid
 */
@WebServlet("/DeleteHostelServlet")
public class DeleteHostelServlet extends HttpServlet {
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the hostel ID to be deleted from the request
        String hostelId = request.getParameter("hostelId");

        // Set response type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Database connection and deletion logic
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//            String deleteQuery = "DELETE FROM hostels WHERE hostel_id = ?;";
            String deleteQuery = "DELETE u, h FROM users u JOIN hostels h ON u.id = h.manager_id WHERE h.hostel_id = ?;";
//            String deleteQuery = "Delete from users where id = (Select manager_id from hostels where hostel_id=?);  " +"Delete from hostels where hostel_id=?;";
            
            try (PreparedStatement statement = connection.prepareStatement(deleteQuery)) {
                statement.setString(1, hostelId);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    // Send success response
                    out.write("{\"success\": true}");
                } else {
                    // Send error response if hostel not found
                    out.write("{\"success\": false, \"message\": \"Hostel not found.\"}");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Error deleting hostel.\"}");
        }
    }
}
