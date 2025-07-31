package hostelPackage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class HostelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;

    public void init() {
        hostelDAO = new HostelDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertHostel(request, response);
                    break;
                case "/delete":
                    deleteHostel(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateHostel(request, response);
                    break;
                default:
                    listHostel(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listHostel(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Hostel> listHostel = hostelDAO.selectAllHostels();
        request.setAttribute("listHostel", listHostel);
        RequestDispatcher dispatcher = request.getRequestDispatcher("hostel-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("hostel-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Hostel existingHostel = hostelDAO.selectHostel(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("hostel-form.jsp");
        request.setAttribute("hostel", existingHostel);
        dispatcher.forward(request, response);
    }

    private void insertHostel(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("hostel_name");
        String address = request.getParameter("hostel_address");
        String rent = request.getParameter("hostel_rent");
        String contact = request.getParameter("hostel_contact");
        String image = request.getParameter("hostel_image");
        String locationUrl = request.getParameter("hostel_location_url");

        Hostel newHostel = new Hostel(0, name, address, rent, contact, image, locationUrl);
        hostelDAO.insertHostel(newHostel);
        response.sendRedirect("list");
    }

    private void updateHostel(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("hostel_name");
        String address = request.getParameter("hostel_address");
        String rent = request.getParameter("hostel_rent");
        String contact = request.getParameter("hostel_contact");
        String image = request.getParameter("hostel_image");
        String locationUrl = request.getParameter("hostel_location_url");

        Hostel hostel = new Hostel(id, name, address, rent, contact, image, locationUrl);
        hostelDAO.updateHostel(hostel);
        response.sendRedirect("list");
    }

    private void deleteHostel(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        hostelDAO.deleteHostel(id);
        response.sendRedirect("list");
    }
}
