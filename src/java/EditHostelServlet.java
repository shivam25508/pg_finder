/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.sql.*;
import javax.servlet.annotation.WebServlet;
import org.json.*;


@WebServlet("/EditHostelServlet")
public class EditHostelServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String hostelId = request.getParameter("hostelId");
        String hostelName = request.getParameter("hostelName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        String price = request.getParameter("price");
        String googleMapsUrl = request.getParameter("googleMapsUrl");

        if (hostelId == null || hostelName == null || address == null || contact == null || price == null || googleMapsUrl == null) {
            out.write("{\"success\": false, \"message\": \"All fields are required!\"}");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String updateQuery = "UPDATE hostels SET hostel_name = ?, hostel_address = ?, hostel_contact = ?, hostel_rent = ?, hostel_location_url = ? WHERE hostel_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                ps.setString(1, hostelName);
                ps.setString(2, address);
                ps.setString(3, contact);
                ps.setString(4, price);
                ps.setString(5, googleMapsUrl);
                ps.setInt(6, Integer.parseInt(hostelId));

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    out.write("{\"success\": true, \"message\": \"Hostel updated successfully!\"}");
                } else {
                    out.write("{\"success\": false, \"message\": \"Failed to update hostel.\"}");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}
