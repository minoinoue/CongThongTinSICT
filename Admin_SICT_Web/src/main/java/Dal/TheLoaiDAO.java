package Dal;

import Model.PhanLoaiTin;
import Model.TheLoai;
import Model.TheLoaiTin;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lenovo
 */
public class TheLoaiDAO extends DBConnect {

	public List<TheLoai> getAllTheLoai() {
		List<TheLoai> list = new ArrayList<>();
		String sql = "SELECT * FROM TheLoai";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TheLoai(rs.getInt("maTheLoai"), rs.getString("tenTheLoai"),
						rs.getBoolean("visibleTheLoai"), rs.getBoolean("visibleTheLoai1"), rs.getInt("sapXep"),
						rs.getString("url"), rs.getString("target"), rs.getBoolean("linkNgoai")));
			}
			System.out.println("Fetched " + list.size() + " categories");
		} catch (SQLException e) {
			System.err.println(e);
		}
		return list;
	}

	public List<TheLoaiTin> getAllTheLoaiTin() {
		List<TheLoaiTin> list = new ArrayList<>();
		String sql = "SELECT * FROM TheLoaiTin";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new TheLoaiTin(rs.getInt("maTheLoaiTin"), rs.getString("tenTheLoaiTin"),
						rs.getBoolean("visibleTheLoaiTin"), rs.getBoolean("visibleTheLoaiTin1"), rs.getInt("sapXep"),
						rs.getString("url"), rs.getString("target"), rs.getBoolean("linkNgoai"),
						rs.getInt("maTheLoai")));
			}
			System.out.println("Fetched " + list.size() + " subcategories");
		} catch (SQLException e) {
			System.err.println(e);
		}
		return list;
	}

	public List<PhanLoaiTin> getAllPhanLoaiTin() {
		List<PhanLoaiTin> list = new ArrayList<>();
		String sql = "SELECT * FROM PhanLoaiTin";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new PhanLoaiTin(rs.getInt("maPhanLoaiTin"), rs.getString("tenPhanLoaiTin"),
						rs.getInt("sapXep")));
			}
			System.out.println("Fetched " + list.size() + " classifications");
		} catch (SQLException e) {
			System.err.println(e);
		}
		return list;
	}

	public int getTheLoaiByNewsID(int nID) {
		String sql = "SELECT maTheLoai FROM TinTuc WHERE maTinTuc = ?";
		try (PreparedStatement st = c.prepareStatement(sql)) {
			st.setInt(1, nID);
			ResultSet rs = st.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println(e);
		}
		return -1;
	}

	public static void main(String[] args) {
		TheLoaiDAO cDB = new TheLoaiDAO();
		List<TheLoai> list = cDB.getAllTheLoai();
		for (TheLoai theLoai : list) {
			System.out.println(theLoai.toString());
		}
		System.out.println(cDB.getTheLoaiByNewsID(1));
	}
}