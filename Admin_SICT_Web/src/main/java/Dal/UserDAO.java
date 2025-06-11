package Dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.User;

public class UserDAO {
    private Connection conn;

    public UserDAO() {
        DBConnect db = new DBConnect();
        conn = db.getConnection();
    }

    // Retrieve all users from the Users table
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPasswordHash(rs.getString("PasswordHash"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setNgayDangKy(rs.getTimestamp("NgayDangKy"));
                users.add(user);
            }
        }
        return users;
    }

    // Retrieve a user by ID
    public User getUserById(int userId) throws SQLException {
        User user = null;
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setNgayDangKy(rs.getTimestamp("NgayDangKy"));
                }
            }
        }
        return user;
    }

    // Update user information
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE Users SET Username = ?, PasswordHash = ?, FullName = ?, Email = ?, NgayDangKy = ? WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setTimestamp(5, user.getNgayDangKy());
            ps.setInt(6, user.getUserID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Close connection
    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}