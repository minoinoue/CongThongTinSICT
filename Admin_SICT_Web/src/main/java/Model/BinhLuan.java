package Model;

import java.sql.Timestamp;

public class BinhLuan {
    private int maBinhLuan; 
    private int maTinTuc;  
    private int userID;    
    private String fullName; 
    private String noiDung;  
    private Timestamp ngayBinhLuan; 
    private String tieuDeTinTuc; 

    // Constructor
    public BinhLuan(int maBinhLuan, int maTinTuc, int userID, String fullName, String noiDung, Timestamp ngayBinhLuan, String tieuDeTinTuc) {
        this.maBinhLuan = maBinhLuan;
        this.maTinTuc = maTinTuc;
        this.userID = userID;
        this.fullName = fullName;
        this.noiDung = noiDung;
        this.ngayBinhLuan = ngayBinhLuan;
        this.tieuDeTinTuc = tieuDeTinTuc;
    }

    // Getters and Setters
    public int getMaBinhLuan() {
        return maBinhLuan;
    }

    public void setMaBinhLuan(int maBinhLuan) {
        this.maBinhLuan = maBinhLuan;
    }

    public int getMaTinTuc() {
        return maTinTuc;
    }

    public void setMaTinTuc(int maTinTuc) {
        this.maTinTuc = maTinTuc;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public Timestamp getNgayBinhLuan() {
        return ngayBinhLuan;
    }

    public void setNgayBinhLuan(Timestamp ngayBinhLuan) {
        this.ngayBinhLuan = ngayBinhLuan;
    }

    public String getTieuDeTinTuc() {
        return tieuDeTinTuc;
    }

    public void setTieuDeTinTuc(String tieuDeTinTuc) {
        this.tieuDeTinTuc = tieuDeTinTuc;
    }

    @Override
    public String toString() {
        return "BinhLuan{" +
                "maBinhLuan=" + maBinhLuan +
                ", maTinTuc=" + maTinTuc +
                ", userID=" + userID +
                ", fullName='" + fullName + '\'' +
                ", noiDung='" + noiDung + '\'' +
                ", ngayBinhLuan=" + ngayBinhLuan +
                ", tieuDeTinTuc='" + tieuDeTinTuc + '\'' +
                '}';
    }
}