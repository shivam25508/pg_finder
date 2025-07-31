import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LogoutServlet.class.getName());
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Logout request received");
        
        HttpSession session = request.getSession(false);
        
        try {
            if (session != null) {
                // Get username before invalidating session (for logging purposes)
                String username = (String) session.getAttribute("username");
                
                // Invalidate the session
                session.invalidate();
                
                LOGGER.log(Level.INFO, "User {0} logged out successfully", username);
                
                // Set a success message
                request.setAttribute("successMessage", "Logged out successfully!");
            }
            
            // Redirect to login page
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
            
        } catch (IOException | ServletException ex) {
            LOGGER.log(Level.SEVERE, "Error during logout", ex);
            request.setAttribute("errorMessage", "Error occurred during logout!");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet for handling user logout";
    }
}