package Dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

public class LoginStatsDAO extends DBConnect {

	public Map<String, Integer> getDailyLoginCounts(String startDate, String endDate) {
	    Map<String, Integer> dailyLoginCounts = new HashMap<>();
	    String sql = "SELECT CONVERT(VARCHAR(10), LoginTime, 120) AS LoginDate, COUNT(*) AS LoginCount " +
	                 "FROM LoginHistory " +
	                 "WHERE LoginTime >= ? AND LoginTime <= ? " +
	                 "GROUP BY CONVERT(VARCHAR(10), LoginTime, 120) " +
	                 "ORDER BY LoginDate";
	    System.out.println("Executing query with startDate: " + startDate + " 00:00:00 and endDate: " + endDate + " 23:59:59");
	    try (PreparedStatement st = getConnection().prepareStatement(sql)) {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        Timestamp startTs = new Timestamp(sdf.parse(startDate + " 00:00:00").getTime());
	        Timestamp endTs = new Timestamp(sdf.parse(endDate + " 23:59:59").getTime());
	        st.setTimestamp(1, startTs);
	        st.setTimestamp(2, endTs);
	        System.out.println("Set parameters: startTs=" + startTs + ", endTs=" + endTs);
	        ResultSet rs = st.executeQuery();
	        while (rs.next()) {
	            String loginDate = rs.getString("LoginDate");
	            int loginCount = rs.getInt("LoginCount");
	            dailyLoginCounts.put(loginDate, loginCount);
	            System.out.println("Found record: LoginDate=" + loginDate + ", LoginCount=" + loginCount);
	        }
	        System.out.println("Fetched " + dailyLoginCounts.size() + " daily login counts: " + dailyLoginCounts);
	    } catch (SQLException e) {
	        System.err.println("Database error in getDailyLoginCounts: " + e.getMessage());
	    } catch (Exception e) {
	        System.err.println("Date parsing or other error in getDailyLoginCounts: " + e.getMessage());
	    }
	    return dailyLoginCounts;
	}

    public int getTotalLoginCount(String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM LoginHistory WHERE LoginTime >= ? AND LoginTime <= ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            st.setTimestamp(1, new Timestamp(sdf.parse(startDate + " 00:00:00").getTime()));
            st.setTimestamp(2, new Timestamp(sdf.parse(endDate + " 23:59:59").getTime()));
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getTotalLoginCount: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Date parsing error in getTotalLoginCount: " + e.getMessage());
        }
        return 0;
    }
}
