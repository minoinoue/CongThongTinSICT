package connection;

import model.TinTuc;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TinTucDAO {
    private Connection conn;

    public TinTucDAO() {
        try {
			this.conn = DatabaseConnection.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    // Lấy danh sách tin tức theo MaTheLoai và MaTheLoaiTin (nếu có)
    public List<TinTuc> getTinTucList(int maTheLoai, Integer maTheLoaiTin) {
        List<TinTuc> list = new ArrayList<>();
        String query = maTheLoaiTin != null
                ? "SELECT MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh, SoLanDoc, Tag FROM TinTuc WHERE MaTheLoai = ? AND MaTheLoaiTin = ? ORDER BY NgayCapNhat DESC"
                : "SELECT MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh, SoLanDoc, Tag FROM TinTuc WHERE MaTheLoai = ? ORDER BY NgayCapNhat DESC";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTheLoai);
            if (maTheLoaiTin != null) {
                stmt.setInt(2, maTheLoaiTin);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TinTuc item = new TinTuc();
                    item.setMaTinTuc(rs.getInt("MaTinTuc"));
                    item.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                    String trichDanTin = rs.getString("TrichDanTin");
                    if (trichDanTin != null) {
                        trichDanTin = trichDanTin.replace("\\n", "\n").replaceAll("\r\n|\n|\r", "<br>");
                    }
                    item.setTrichDanTin(trichDanTin);
                    Timestamp timestamp = rs.getTimestamp("NgayCapNhat");
                    if (timestamp != null) {
                        item.setNgayCapNhat(timestamp.toLocalDateTime());
                    }
                    item.setUrlAnh(rs.getString("UrlAnh"));
                    item.setSoLanDoc(rs.getInt("SoLanDoc"));
                    item.setTag(rs.getString("Tag"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết tin tức theo MaTinTuc với điều kiện
    public TinTuc getTinTucById(int maTinTuc, int maTheLoai, Integer maTheLoaiTin) {
        TinTuc item = null;
        String condition = maTheLoaiTin != null ? " AND MaTheLoaiTin = ?" : "";
        String query = "SELECT MaTinTuc, TieuDeTinTuc, TrichDanTin, NoiDungTin, NgayCapNhat, UrlAnh, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien " +
                "FROM TinTuc WHERE MaTinTuc = ? AND MaTheLoai = ?" + condition;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTinTuc);
            stmt.setInt(2, maTheLoai);
            if (maTheLoaiTin != null) {
                stmt.setInt(3, maTheLoaiTin);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    item = new TinTuc();
                    item.setMaTinTuc(rs.getInt("MaTinTuc"));
                    item.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                    String trichDanTin = rs.getString("TrichDanTin");
                    if (trichDanTin != null) {
                        trichDanTin = trichDanTin.replace("\\n", "\n").replaceAll("\r\n|\n|\r", "<br>");
                    }
                    item.setTrichDanTin(trichDanTin);
                    String noiDungTin = rs.getString("NoiDungTin");
                    if (noiDungTin != null) {
                        noiDungTin = noiDungTin.replace("\\n", "\n").replaceAll("\r\n|\n|\r", "<br>");
                    }
                    item.setNoiDungTin(noiDungTin);
                    Timestamp timestamp = rs.getTimestamp("NgayCapNhat");
                    if (timestamp != null) {
                        item.setNgayCapNhat(timestamp.toLocalDateTime());
                    }
                    item.setUrlAnh(rs.getString("UrlAnh"));
                    item.setSoLanDoc(rs.getInt("SoLanDoc"));
                    item.setTag(rs.getString("Tag"));
                    item.setMaTheLoai(rs.getInt("MaTheLoai"));
                    item.setMaTheLoaiTin(rs.getInt("MaTheLoaiTin"));
                    item.setMaPhanLoaiTin(rs.getInt("MaPhanLoaiTin"));
                    item.setMaThanhVien(rs.getInt("MaThanhVien"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    // Cập nhật số lượt xem
    public void updateViewCount(int maTinTuc, int maTheLoai, Integer maTheLoaiTin) {
        String condition = maTheLoaiTin != null ? " AND MaTheLoaiTin = ?" : "";
        String query = "UPDATE TinTuc SET SoLanDoc = SoLanDoc + 1 WHERE MaTinTuc = ? AND MaTheLoai = ?" + condition;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTinTuc);
            stmt.setInt(2, maTheLoai);
            if (maTheLoaiTin != null) {
                stmt.setInt(3, maTheLoaiTin);
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Tìm kiếm tin tức theo từ khóa và MaTheLoai
    public List<TinTuc> searchTinTuc(String query, int maTheLoai) {
        List<TinTuc> list = new ArrayList<>();
        if (query == null || query.trim().isEmpty()) {
            return list; // Trả về danh sách rỗng nếu không có từ khóa
        }
        String searchPattern = "%" + query + "%";
        String querySql = "SELECT MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh, SoLanDoc, Tag " +
                "FROM TinTuc WHERE MaTheLoai = ? AND (TieuDeTinTuc LIKE ? OR TrichDanTin LIKE ?) ORDER BY NgayCapNhat DESC";

        try (PreparedStatement stmt = conn.prepareStatement(querySql)) {
            stmt.setInt(1, maTheLoai);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TinTuc news = new TinTuc();
                    news.setMaTinTuc(rs.getInt("MaTinTuc"));
                    news.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                    news.setTrichDanTin(rs.getString("TrichDanTin"));
                    Timestamp timestamp = rs.getTimestamp("NgayCapNhat");
                    if (timestamp != null) {
                        news.setNgayCapNhat(timestamp.toLocalDateTime());
                    }
                    news.setUrlAnh(rs.getString("UrlAnh"));
                    news.setSoLanDoc(rs.getInt("SoLanDoc"));
                    news.setTag(rs.getString("Tag"));
                    list.add(news);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách tin tức giới hạn theo MaTheLoai
    public List<TinTuc> getTopTinTuc(int maTheLoai, int limit) {
        List<TinTuc> list = new ArrayList<>();
        String query = "SELECT TOP " + limit + " MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh FROM TinTuc WHERE MaTheLoai = ? ORDER BY NgayCapNhat DESC";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTheLoai);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TinTuc item = new TinTuc();
                    item.setMaTinTuc(rs.getInt("MaTinTuc"));
                    item.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                    item.setTrichDanTin(rs.getString("TrichDanTin"));
                    Timestamp timestamp = rs.getTimestamp("NgayCapNhat");
                    if (timestamp != null) {
                        item.setNgayCapNhat(timestamp.toLocalDateTime());
                    }
                    item.setUrlAnh(rs.getString("UrlAnh"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đóng kết nối
    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}