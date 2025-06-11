package model;

import java.sql.Timestamp;

public class Comments {
    private int commentID;
    private int maTinTuc;
    private int userID;
    private String noiDung;
    private Timestamp ngayBinhLuan;
    private String fullName; // For display purposes

    public Comments() {
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}