package Dal;

import Model.TheLoaiTin;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TheLoaiTinDAO extends DBConnect {

    public List<TheLoaiTin> getAll() throws SQLException {
        List<TheLoaiTin> list = new ArrayList<>();
        String sql = "SELECT * FROM TheLoaiTin";
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TheLoaiTin tlt = new TheLoaiTin();
                tlt.setMaTheLoaiTin(rs.getInt("MaTheLoaiTin"));
                tlt.setTenTheLoaiTin(rs.getString("TenTheLoaiTin"));
                tlt.setVisibleTheLoaiTin(rs.getBoolean("VisibleTheLoaiTin"));
                tlt.setVisibleTheLoaiTin1(rs.getBoolean("VisibleTheLoaiTin1"));
                tlt.setSapXep(rs.getInt("SapXep"));
                tlt.setUrl(rs.getString("Url"));
                tlt.setTarget(rs.getString("Target"));
                tlt.setLinkNgoai(rs.getBoolean("LinkNgoai"));
                tlt.setMaTheLoai(rs.getInt("MaTheLoai"));
                list.add(tlt);
            }
        }
        return list;
    }

    public void insert(TheLoaiTin tlt) throws SQLException {
        String sql = "INSERT INTO TheLoaiTin (TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, tlt.getTenTheLoaiTin());
            ps.setBoolean(2, tlt.isVisibleTheLoaiTin());
            ps.setBoolean(3, tlt.isVisibleTheLoaiTin1());
            ps.setInt(4, tlt.getSapXep());
            ps.setString(5, tlt.getUrl());
            ps.setString(6, tlt.getTarget());
            ps.setBoolean(7, tlt.isLinkNgoai());
            ps.setInt(8, tlt.getMaTheLoai());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM TheLoaiTin WHERE MaTheLoaiTin = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void update(TheLoaiTin tlt) throws SQLException {
        String sql = "UPDATE TheLoaiTin SET TenTheLoaiTin=?, VisibleTheLoaiTin=?, VisibleTheLoaiTin1=?, SapXep=?, Url=?, Target=?, LinkNgoai=?, MaTheLoai=? WHERE MaTheLoaiTin=?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, tlt.getTenTheLoaiTin());
            ps.setBoolean(2, tlt.isVisibleTheLoaiTin());
            ps.setBoolean(3, tlt.isVisibleTheLoaiTin1());
            ps.setInt(4, tlt.getSapXep());
            ps.setString(5, tlt.getUrl());
            ps.setString(6, tlt.getTarget());
            ps.setBoolean(7, tlt.isLinkNgoai());
            ps.setInt(8, tlt.getMaTheLoai());
            ps.setInt(9, tlt.getMaTheLoaiTin());
            ps.executeUpdate();
        }
    }

    public TheLoaiTin getById(int id) throws SQLException {
        String sql = "SELECT * FROM TheLoaiTin WHERE MaTheLoaiTin = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TheLoaiTin tlt = new TheLoaiTin();
                    tlt.setMaTheLoaiTin(rs.getInt("MaTheLoaiTin"));
                    tlt.setTenTheLoaiTin(rs.getString("TenTheLoaiTin"));
                    tlt.setVisibleTheLoaiTin(rs.getBoolean("VisibleTheLoaiTin"));
                    tlt.setVisibleTheLoaiTin1(rs.getBoolean("VisibleTheLoaiTin1"));
                    tlt.setSapXep(rs.getInt("SapXep"));
                    tlt.setUrl(rs.getString("Url"));
                    tlt.setTarget(rs.getString("Target"));
                    tlt.setLinkNgoai(rs.getBoolean("LinkNgoai"));
                    tlt.setMaTheLoai(rs.getInt("MaTheLoai"));
                    return tlt;
                }
            }
        }
        return null;
    }
}