package Dal;

import Model.Admin1;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Admin1DAO extends DBConnect {
	public Admin1 login(String username, String password) {
		String sql = "SELECT * FROM [Admin] WHERE Username = ? AND PasswordHash = ?";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setString(1, username);
			st.setString(2, password); // Lưu ý: Cần mã hóa password trong thực tế
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return new Admin1(rs.getInt("adminID"), rs.getString("username"), rs.getString("passwordHash"),
						rs.getString("fullName"));
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return null;
	}
}