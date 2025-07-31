import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.*;

/**
 * Servlet to fetch and return booking requests associated with a manager's hostels in JSON format.
 */
@WebServlet("/ManagerRequestDispServ")
public class ManagerRequestDispServ extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";
    private static final long serialVersionUID = 1L;
    
    // Load JDBC driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("index.jsp"); // Redirect to login if session is invalid
            return;
        }
        
        String userID = (String) session.getAttribute("userID");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Modified query to include hostel name
            String query = "SELECT r.*, h.hostel_name FROM requests r " +
                         "JOIN hostels h ON r.hostel_id = h.hostel_id " +
                         "WHERE h.manager_id = ? " +
                         "ORDER BY r.timestamp DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, userID);
                ResultSet rs = stmt.executeQuery();
                
                JSONArray requestsArray = new JSONArray();
                while (rs.next()) {
                    JSONObject requestObj = new JSONObject();
                    requestObj.put("id", rs.getInt("id"));
                    requestObj.put("hostel_id", rs.getInt("hostel_id"));
                    requestObj.put("hostel_name", rs.getString("hostel_name"));
                    requestObj.put("std_id", rs.getString("std_id"));
                    requestObj.put("name", rs.getString("name"));
                    requestObj.put("contact", rs.getString("contact"));
                    requestObj.put("description", rs.getString("description")); // Using correct column name
                    requestObj.put("timestamp", rs.getTimestamp("timestamp").toString());
                    requestsArray.put(requestObj);
                }
                
                PrintWriter out = response.getWriter();
                out.print(requestsArray.toString());
                out.flush();
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            JSONObject errorObj = new JSONObject();
            errorObj.put("error", "Database error occurred");
            errorObj.put("message", e.getMessage());
            out.print(errorObj.toString());
        }
    }
}