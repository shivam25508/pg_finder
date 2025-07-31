import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import org.json.JSONObject;

/**
 * Servlet to handle deletion of booking requests
 * @author Talha Bin Shahid
 */
@WebServlet("/DeleteBookingReq")
public class DeleteBookingReq extends HttpServlet {
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final long serialVersionUID = 1L;
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        // Session validation
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Unauthorized access");
            out.print(jsonResponse.toString());
            return;
        }
        
        // Get the request ID to be deleted
        String requestId = request.getParameter("requestId");
        if (requestId == null || requestId.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Request ID is required");
            out.print(jsonResponse.toString());
            return;
        }
        
        // Database connection and deletion logic
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // First verify if the request belongs to a hostel managed by this manager
            String verifyQuery = "SELECT r.id FROM requests r " +
                               "JOIN hostels h ON r.hostel_id = h.hostel_id " +
                               "WHERE r.id = ? AND h.manager_id = ?";
            
            try (PreparedStatement verifyStmt = connection.prepareStatement(verifyQuery)) {
                verifyStmt.setString(1, requestId);
                verifyStmt.setString(2, (String) session.getAttribute("userID"));
                ResultSet rs = verifyStmt.executeQuery();
                
                if (!rs.next()) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Unauthorized to delete this request");
                    out.print(jsonResponse.toString());
                    return;
                }
            }
            
            // If verified, proceed with deletion
            String deleteQuery = "DELETE FROM requests WHERE id = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery)) {
                deleteStmt.setString(1, requestId);
                int rowsAffected = deleteStmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Request deleted successfully");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Request not found");
                }
            }
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error occurred");
            getServletContext().log("Error in DeleteBookingReq servlet", e);
        }
        
        out.print(jsonResponse.toString());
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported");
    }
}