
import java.io.FileWriter;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Hello");

        String username = request.getParameter("loginUsername");
        String password = request.getParameter("loginPwd");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required!");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnect()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            System.out.println("Check 1");

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userID", rs.getString("id"));
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("userType", rs.getString("type"));
                String userType = rs.getString("type");
                
                String un = rs.getString("username");

                this.writeToFile("username.txt", un);
                
                // Redirect to different JSP files based on user type
                switch (userType) {
                    case "0" -> response.sendRedirect("student_dashboard.jsp");
                    case "1" -> response.sendRedirect("manager_dashboard.jsp");
                    case "2" -> response.sendRedirect("admin_page.jsp");
                    default -> {
                        request.setAttribute("errorMessage", "Unknown user type!");
                        RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                        rd.forward(request, response);
                    }
                }

            } else {
                request.setAttribute("errorMessage", "Invalid username or password!");
                RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);

            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", "Database error occurred!");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        }
    }

    public void writeToFile(String filePath, String content) {
        try (FileWriter writer = new FileWriter(filePath, false)) {
            // Clears the file and writes the content
            writer.write(content);
            System.out.println("File written successfully.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet for user authentication";
    }
}
