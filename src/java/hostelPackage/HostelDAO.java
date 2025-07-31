package hostelPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HostelDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/numl_hostel_finder";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_HOSTEL_SQL = "INSERT INTO hostels (hostel_name, hostel_address, hostel_rent, hostel_contact, hostel_image, hostel_location_url) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String SELECT_HOSTEL_BY_ID = "SELECT * FROM hostels WHERE id = ?";
    private static final String SELECT_ALL_HOSTELS = "SELECT * FROM hostels";
    private static final String DELETE_HOSTEL_SQL = "DELETE FROM hostels WHERE id = ?;";
    private static final String UPDATE_HOSTEL_SQL = "UPDATE hostels SET hostel_name = ?, hostel_address = ?, hostel_rent = ?, hostel_contact = ?, hostel_image = ?, hostel_location_url = ? WHERE id = ?;";

    public HostelDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertHostel(Hostel hostel) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_HOSTEL_SQL)) {
            preparedStatement.setString(1, hostel.getHostel_name());
            preparedStatement.setString(2, hostel.getHostel_address());
            preparedStatement.setString(3, hostel.getHostel_rent());
            preparedStatement.setString(4, hostel.getHostel_contact());
            preparedStatement.setString(5, hostel.getHostel_image());
            preparedStatement.setString(6, hostel.getHostel_location_url());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Hostel selectHostel(int id) {
        Hostel hostel = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_HOSTEL_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("hostel_name");
                String address = rs.getString("hostel_address");
                String rent = rs.getString("hostel_rent");
                String contact = rs.getString("hostel_contact");
                String image = rs.getString("hostel_image");
                String locationUrl = rs.getString("hostel_location_url");
                hostel = new Hostel(id, name, address, rent, contact, image, locationUrl);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return hostel;
    }

    public List<Hostel> selectAllHostels() {
        List<Hostel> hostels = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_HOSTELS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("hostel_name");
                String address = rs.getString("hostel_address");
                String rent = rs.getString("hostel_rent");
                String contact = rs.getString("hostel_contact");
                String image = rs.getString("hostel_image");
                String locationUrl = rs.getString("hostel_location_url");
                hostels.add(new Hostel(id, name, address, rent, contact, image, locationUrl));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return hostels;
    }

    public boolean deleteHostel(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_HOSTEL_SQL)) {
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateHostel(Hostel hostel) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_HOSTEL_SQL)) {
            preparedStatement.setString(1, hostel.getHostel_name());
            preparedStatement.setString(2, hostel.getHostel_address());
            preparedStatement.setString(3, hostel.getHostel_rent());
            preparedStatement.setString(4, hostel.getHostel_contact());
            preparedStatement.setString(5, hostel.getHostel_image());
            preparedStatement.setString(6, hostel.getHostel_location_url());
            preparedStatement.setInt(7, hostel.getHostel_id());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
