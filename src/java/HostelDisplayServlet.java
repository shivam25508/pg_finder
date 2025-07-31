import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.*;

/**
 * Servlet to fetch and return hostel data in JSON format.
 * Author: Talha Bin Shahid
 */
@WebServlet("/HostelDisplayServlet")
public class HostelDisplayServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Create a connection to the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Prepare and execute SQL query
            String query = "SELECT * FROM hostels";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            // Create a JSON array to store hostel data
            JSONArray hostelArray = new JSONArray();

            // Iterate through the result set and build the JSON response
            while (rs.next()) {
                JSONObject hostelObj = new JSONObject();
                hostelObj.put("id", rs.getInt("hostel_id")); // Add unique ID
                hostelObj.put("name", rs.getString("hostel_name"));
                hostelObj.put("address", rs.getString("hostel_address"));
                hostelObj.put("url", rs.getString("hostel_location_url"));
                hostelObj.put("contact", rs.getString("hostel_contact"));
                hostelObj.put("rent", rs.getDouble("hostel_rent"));
                hostelArray.put(hostelObj);
            }

            // Send the JSON response
            PrintWriter out = response.getWriter();
            out.print(hostelArray.toString());
            out.flush();

        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
