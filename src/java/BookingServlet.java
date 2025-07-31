
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Booking Request Received");

        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        // Check if user is logged in
        if (userID == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Get form parameters
        String contact = request.getParameter("contact");
        String hostelId = request.getParameter("hostelId");
        String description = request.getParameter("description");
        String name = request.getParameter("name");

        try (Connection conn = DBConnection.getConnect()) {
            String sql = "INSERT INTO requests ( std_id, hostel_id, description, contact,name, timestamp) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID);
            pstmt.setString(2, hostelId);
            pstmt.setString(3, description);
            pstmt.setString(4, contact);
            pstmt.setString(5, name);
            pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Booking request successful
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Booking request submitted successfully\"}");
            } else {
                // Booking request failed
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to submit booking request\"}");
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Database error: " + ex.getMessage() + "\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Booking Servlet for hostel booking requests";
    }
}
