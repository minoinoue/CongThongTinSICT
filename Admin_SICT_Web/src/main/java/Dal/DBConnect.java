package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	protected Connection c;

	public DBConnect() {
		try {
			// Đăng ký driver của SQL Server
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

			// Thông tin kết nối SQL Server
			String url = "jdbc:sqlserver://localhost:1433;databaseName=SICT_HAUI;encrypt=true;trustServerCertificate=true";
			String username = "sa"; // Username của SQL Server
			String pass = "123456789"; // Password của SQL Server

			// Khởi tạo kết nối
			c = DriverManager.getConnection(url, username, pass);
			System.out.println("Connection successful.");
		} catch (ClassNotFoundException e) {
			System.out.println("SQL Server JDBC Driver not found: " + e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Connection failed: " + e.getMessage());
			e.printStackTrace();
		}
	}

	// Getter để cung cấp kết nối cho các lớp khác
	public Connection getConnection() {
		return c;
	}

	// Đóng kết nối
	public void closeConnection() {
		try {
			if (c != null && !c.isClosed()) {
				c.close();
			}
		} catch (SQLException e) {
			System.err.println("Error closing connection: " + e.getMessage());
		}
	}

	// Phương thức kiểm tra kết nối
	public static void main(String[] args) {
		DBConnect db = new DBConnect();
		if (db.getConnection() != null) {
			System.out.println("Connection is established.");
		} else {
			System.out.println("Connection is null. Check the error messages above.");
		}
		db.closeConnection();
	}
}