package Dal;

import Model.TinTuc;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lenovo
 */
public class TinTucDAO extends DBConnect {

	public List<TinTuc> getAllTinTuc() {
		List<TinTuc> list = new ArrayList<>();
		String sql = "SELECT * FROM TinTuc";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TinTuc(rs.getInt("maTinTuc"), rs.getString("tieuDeTinTuc"),
						rs.getString("urlAnh") != null ? rs.getString("urlAnh") : "",
						rs.getString("trichDanTin") != null ? rs.getString("trichDanTin") : "",
						rs.getString("noiDungTin") != null ? rs.getString("noiDungTin") : "",
						rs.getTimestamp("ngayCapNhat") != null ? rs.getTimestamp("ngayCapNhat").toLocalDateTime()
								: null,
						rs.getObject("soLanDoc") != null ? rs.getInt("soLanDoc") : 0,
						rs.getString("tag") != null ? rs.getString("tag") : "", rs.getInt("maTheLoai"),
						rs.getInt("maTheLoaiTin"), rs.getInt("maPhanLoaiTin"), rs.getInt("maThanhVien")));
			}
			System.out.println("Fetched " + list.size() + " news items");
		} catch (SQLException e) {
			System.err.println("Database error: " + e.getMessage());
		}
		return list;
	}

	public TinTuc getTinTucByID(String id) {
		String sql = "SELECT * FROM TinTuc WHERE maTinTuc = ?";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setString(1, id);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return new TinTuc(rs.getInt("maTinTuc"), rs.getString("tieuDeTinTuc"), rs.getString("urlAnh"),
						rs.getString("trichDanTin"), rs.getString("noiDungTin"),
						rs.getTimestamp("ngayCapNhat").toLocalDateTime(), rs.getInt("soLanDoc"), rs.getString("tag"),
						rs.getInt("maTheLoai"), rs.getInt("maTheLoaiTin"), rs.getInt("maPhanLoaiTin"),
						rs.getInt("maThanhVien"));
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return null;
	}

	public TinTuc getMostViewedNews() {
		String sql = "SELECT * FROM TinTuc WHERE soLanDoc >= ALL(SELECT soLanDoc FROM TinTuc)";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return new TinTuc(rs.getInt("maTinTuc"), rs.getString("tieuDeTinTuc"), rs.getString("urlAnh"),
						rs.getString("trichDanTin"), rs.getString("noiDungTin"),
						rs.getTimestamp("ngayCapNhat").toLocalDateTime(), rs.getInt("soLanDoc"), rs.getString("tag"),
						rs.getInt("maTheLoai"), rs.getInt("maTheLoaiTin"), rs.getInt("maPhanLoaiTin"),
						rs.getInt("maThanhVien"));
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return null;
	}

	public List<TinTuc> getNewsByCategory(String cid) {
		List<TinTuc> list = new ArrayList<>();
		String sql = "SELECT * FROM TinTuc WHERE maTheLoai = ?";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setString(1, cid);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TinTuc(rs.getInt("maTinTuc"), rs.getString("tieuDeTinTuc"), rs.getString("urlAnh"),
						rs.getString("trichDanTin"), rs.getString("noiDungTin"),
						rs.getTimestamp("ngayCapNhat").toLocalDateTime(), rs.getInt("soLanDoc"), rs.getString("tag"),
						rs.getInt("maTheLoai"), rs.getInt("maTheLoaiTin"), rs.getInt("maPhanLoaiTin"),
						rs.getInt("maThanhVien")));
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return list;
	}

	public List<TinTuc> getNewsByTitle(String title) {
		List<TinTuc> list = new ArrayList<>();
		String sql = "SELECT * FROM TinTuc WHERE tieuDeTinTuc LIKE ?";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setString(1, "%" + title + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TinTuc(rs.getInt("maTinTuc"), rs.getString("tieuDeTinTuc"), rs.getString("urlAnh"),
						rs.getString("trichDanTin"), rs.getString("noiDungTin"),
						rs.getTimestamp("ngayCapNhat").toLocalDateTime(), rs.getInt("soLanDoc"), rs.getString("tag"),
						rs.getInt("maTheLoai"), rs.getInt("maTheLoaiTin"), rs.getInt("maPhanLoaiTin"),
						rs.getInt("maThanhVien")));
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return list;
	}

	public List<TinTuc> getTinTucByPage(int page, int pageSize) {
		List<TinTuc> list = new ArrayList<>();
		int offset = (page - 1) * pageSize;
		String sql = "SELECT * FROM TinTuc ORDER BY MaTinTuc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		try (PreparedStatement st = getConnection().prepareStatement(sql)) {
			st.setInt(1, offset);
			st.setInt(2, pageSize);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TinTuc(rs.getInt("MaTinTuc"), rs.getString("TieuDeTinTuc"),
						rs.getString("UrlAnh") != null ? rs.getString("UrlAnh") : "",
						rs.getString("TrichDanTin") != null ? rs.getString("TrichDanTin") : "",
						rs.getString("NoiDungTin") != null ? rs.getString("NoiDungTin") : "",
						rs.getTimestamp("NgayCapNhat") != null ? rs.getTimestamp("NgayCapNhat").toLocalDateTime()
								: null,
						rs.getObject("SoLanDoc") != null ? rs.getInt("SoLanDoc") : 0,
						rs.getString("Tag") != null ? rs.getString("Tag") : "", rs.getInt("MaTheLoai"),
						rs.getInt("MaTheLoaiTin"), rs.getInt("MaPhanLoaiTin"), rs.getInt("MaThanhVien")));
			}
			System.out.println("Fetched " + list.size() + " news items for page " + page);
		} catch (SQLException e) {
			System.err.println("Database error in getTinTucByPage: " + e.getMessage());
		}
		return list;
	}

	public int getTotalNewsCount() {
		String sql = "SELECT COUNT(*) FROM TinTuc";
		try (PreparedStatement st = getConnection().prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.err.println("Database error in getTotalNewsCount: " + e.getMessage());
		}
		return 0;
	}

	public int getNextMaTinTuc() {
		String sql = "SELECT MAX(MaTinTuc) FROM TinTuc";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (SQLException e) {
			System.err.println("Error getting next MaTinTuc: " + e.getMessage());
		}
		return 1; // Nếu bảng rỗng, bắt đầu từ 1
	}

	public void addTinTuc(TinTuc n, String category) {
		// Kiểm tra khóa ngoại trước khi thêm
		if (!checkForeignKey("TheLoai", "MaTheLoai", n.getMaTheLoai())
				|| !checkForeignKey("TheLoaiTin", "MaTheLoaiTin", n.getMaTheLoaiTin())
				|| !checkForeignKey("PhanLoaiTin", "MaPhanLoaiTin", n.getMaPhanLoaiTin())
				|| !checkForeignKey("Admin", "AdminID", n.getMaThanhVien())) {
			throw new IllegalArgumentException("Invalid foreign key value");
		}

		// Lấy MaTinTuc mới
		int newMaTinTuc = getNextMaTinTuc();
		n.setMaTinTuc(newMaTinTuc); // Cập nhật MaTinTuc cho đối tượng

		String sql = "INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien) "
				+ "VALUES (?, ?, ?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setInt(1, newMaTinTuc);
			st.setString(2, n.getTieuDeTinTuc());
			st.setString(3, n.getUrlAnh());
			st.setString(4, n.getTrichDanTin());
			st.setString(5, n.getNoiDungTin());
			st.setInt(6, n.getSoLanDoc());
			st.setString(7, n.getTag());
			st.setInt(8, n.getMaTheLoai());
			st.setInt(9, n.getMaTheLoaiTin());
			st.setInt(10, n.getMaPhanLoaiTin());
			st.setInt(11, n.getMaThanhVien());
			int rowsAffected = st.executeUpdate();
			System.out.println("Inserted news: " + n.getTieuDeTinTuc() + ", Rows affected: " + rowsAffected);
		} catch (SQLException e) {
			System.err.println("Error inserting news: " + e.getMessage());
			throw new RuntimeException("Failed to insert news: " + e.getMessage());
		}
	}

	public void editTinTuc(TinTuc n, int category) {
		if (!checkForeignKey("TheLoai", "MaTheLoai", n.getMaTheLoai())
				|| !checkForeignKey("TheLoaiTin", "MaTheLoaiTin", n.getMaTheLoaiTin())
				|| !checkForeignKey("PhanLoaiTin", "MaPhanLoaiTin", n.getMaPhanLoaiTin())
				|| !checkForeignKey("Admin", "AdminID", n.getMaThanhVien())) {
			throw new IllegalArgumentException("Invalid foreign key value");
		}

		String sql = "UPDATE TinTuc SET TieuDeTinTuc = ?, UrlAnh = ?, TrichDanTin = ?, NoiDungTin = ?, NgayCapNhat = GETDATE(), SoLanDoc = ?, Tag = ?, MaTheLoai = ?, MaTheLoaiTin = ?, MaPhanLoaiTin = ?, MaThanhVien = ? WHERE MaTinTuc = ?";
		try (PreparedStatement st = getConnection().prepareStatement(sql)) {
			st.setString(1, n.getTieuDeTinTuc());
			st.setString(2, n.getUrlAnh());
			st.setString(3, n.getTrichDanTin());
			st.setString(4, n.getNoiDungTin());
			st.setInt(5, n.getSoLanDoc());
			st.setString(6, n.getTag());
			st.setInt(7, n.getMaTheLoai());
			st.setInt(8, n.getMaTheLoaiTin());
			st.setInt(9, n.getMaPhanLoaiTin());
			st.setInt(10, n.getMaThanhVien());
			st.setInt(11, n.getMaTinTuc());
			int rowsAffected = st.executeUpdate();
			System.out.println("Updated news ID: " + n.getMaTinTuc() + ", Rows affected: " + rowsAffected);
			if (rowsAffected == 0) {
				throw new RuntimeException("No news found with ID: " + n.getMaTinTuc());
			}
		} catch (SQLException e) {
			System.err.println("Error updating news: " + e.getMessage());
			throw new RuntimeException("Failed to update news: " + e.getMessage());
		}
	}

	public void deleteTinTuc(String nID) {
		String sql = "DELETE FROM TinTuc WHERE MaTinTuc = ?";
		try (PreparedStatement st = getConnection().prepareStatement(sql)) {
			st.setInt(1, Integer.parseInt(nID));
			int rowsAffected = st.executeUpdate();
			System.out.println("Deleted news ID: " + nID + ", Rows affected: " + rowsAffected);
		} catch (SQLException e) {
			System.err.println("Error deleting news: " + e.getMessage());
			throw new RuntimeException("Failed to delete news: " + e.getMessage());
		}
	}

	private boolean checkForeignKey(String table, String column, int value) {
		String sql = "SELECT COUNT(*) FROM " + table + " WHERE " + column + " = ?";
		try (PreparedStatement st = getConnection().prepareStatement(sql)) {
			st.setInt(1, value);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.err.println("Error checking foreign key: " + e.getMessage());
		}
		return false;
	}

	public int getMaxValueNewsID() {
		String sql = "SELECT maTinTuc FROM TinTuc WHERE maTinTuc >= ALL(SELECT maTinTuc FROM TinTuc)";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		return -1;
	}

	public static void main(String[] args) {
		TinTucDAO nDB = new TinTucDAO();
		List<TinTuc> list = nDB.getNewsByTitle("test");
		for (TinTuc news : list) {
			System.out.println(news.toString());
		}
		System.out.println(nDB.getMaxValueNewsID());
	}
}