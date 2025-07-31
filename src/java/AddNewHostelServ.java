
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "AddNewHostelServ", urlPatterns = {"/AddNewHostelServ"})
public class AddNewHostelServ extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddNewHostelServ.class.getName());
    private static final long serialVersionUID = 1L;

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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String hostelName = request.getParameter("hostelName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        Double price = Double.parseDouble(request.getParameter("price"));
        String googleMapsUrl = request.getParameter("googleMapsUrl");
        String uname = request.getParameter("username");
        String pwd = request.getParameter("password");
        String email = request.getParameter("email");

        if (hostelName == null || address == null || contact == null || price == null || googleMapsUrl == null
                || hostelName.trim().isEmpty() || address.trim().isEmpty() || contact.trim().isEmpty()
                || googleMapsUrl.trim().isEmpty()) {

            // Send error message back as JSON response
            response.getWriter().write("{\"success\": false, \"errorMessage\": \"All fields are required!\"}");
            return;
        }

        String jdbcUrl = "jdbc:mysql://localhost:3306/numl_hostel_finder";
        String dbUsername = "root";
        String dbPassword = "";
        String sql = "INSERT INTO hostels (hostel_name, hostel_address, hostel_contact, hostel_rent, hostel_location_url,manager_id) VALUES (?, ?, ?, ?, ?,?)";
        String sql2 = "INSERT into users (username,password,type,email) values (?,?,?,?)";
        String sqlget = "Select id from users where username = ?";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword); PreparedStatement ps = conn.prepareStatement(sql2)) {

            ps.setString(1, uname);
            ps.setString(2, pwd);
            ps.setInt(3, 1);
            ps.setString(4, email);
            int count = ps.executeUpdate();

            if (count > 0) {
                PreparedStatement ps2 = conn.prepareStatement(sqlget);
                ps2.setString(1, uname);

                ResultSet rs = ps2.executeQuery(); // Correct usage for SELECT query
                if (rs.next()) {
                    int id = rs.getInt("id");

                    PreparedStatement ps3 = conn.prepareStatement(sql);
                    ps3.setString(1, hostelName);
                    ps3.setString(2, address);
                    ps3.setString(3, contact);
                    ps3.setDouble(4, price);
                    ps3.setString(5, googleMapsUrl);
                    ps3.setInt(6, id);

                    count = ps3.executeUpdate(); // Correct usage for INSERT query
                    if (count > 0) {
                        response.getWriter().write("{\"success\": true, \"message\": \"Hostel added successfully!\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"errorMessage\": \"Failed to add hostel!\"}");
                    }
                } else {
                    response.getWriter().write("{\"success\": false, \"errorMessage\": \"User ID not found!\"}");
                }
            } else {
                response.getWriter().write("{\"success\": false, \"errorMessage\": \"Failed to add user!\"}");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception", e);
            response.getWriter().write("{\"success\": false, \"errorMessage\": \"An error occurred: " + e.getMessage() + "\"}");
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding a new hostel";
    }
}
