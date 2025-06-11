package connection;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DatabaseConnection {
    private static DataSource dataSource = null;

    static {
        try {
            // Tra cứu DataSource từ JNDI
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/SICT_HAUI");
            System.out.println("DataSource initialized successfully with JNDI name 'jdbc/SICT_HAUI' at " + new java.util.Date());
        } catch (NamingException e) {
            System.err.println("JNDI lookup failed: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Failed to initialize DataSource: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Lấy kết nối từ Connection Pool
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource không được khởi tạo. Kiểm tra cấu hình JNDI trong context.xml.");
        }
        Connection conn = dataSource.getConnection();
        if (conn == null) {
            throw new SQLException("Không thể lấy kết nối từ Connection Pool.");
        }
        System.out.println("Đã lấy kết nối từ Connection Pool: " + conn);
        return conn;
    }
}