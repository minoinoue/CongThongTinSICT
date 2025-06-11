package Model;

import java.time.LocalDateTime;

public class TinTuc {
    private int maTinTuc;
    private String tieuDeTinTuc;
    private String urlAnh;
    private String trichDanTin;
    private String noiDungTin;
    private LocalDateTime ngayCapNhat;
    private int soLanDoc;
    private String tag;
    private int maTheLoai;
    private int maTheLoaiTin;
    private int maThanhVien;

    public TinTuc() {
    }

    public TinTuc(int maTinTuc, String tieuDeTinTuc, String urlAnh, String trichDanTin, String noiDungTin,
                  LocalDateTime ngayCapNhat, int soLanDoc, String tag, int maTheLoai, int maTheLoaiTin, int maThanhVien) {
        this.maTinTuc = maTinTuc;
        this.tieuDeTinTuc = tieuDeTinTuc;
        this.urlAnh = urlAnh;
        this.trichDanTin = trichDanTin;
        this.noiDungTin = noiDungTin;
        this.ngayCapNhat = ngayCapNhat;
        this.soLanDoc = soLanDoc;
        this.tag = tag;
        this.maTheLoai = maTheLoai;
        this.maTheLoaiTin = maTheLoaiTin;
        this.maThanhVien = maThanhVien;
    }

    // Getters and Setters
    public int getMaTinTuc() {
        return maTinTuc;
    }

    public void setMaTinTuc(int maTinTuc) {
        this.maTinTuc = maTinTuc;
    }

    public String getTieuDeTinTuc() {
        return tieuDeTinTuc;
    }

    public void setTieuDeTinTuc(String tieuDeTinTuc) {
        this.tieuDeTinTuc = tieuDeTinTuc;
    }

    public String getUrlAnh() {
        return urlAnh;
    }

    public void setUrlAnh(String urlAnh) {
        this.urlAnh = urlAnh;
    }

    public String getTrichDanTin() {
        return trichDanTin;
    }

    public void setTrichDanTin(String trichDanTin) {
        this.trichDanTin = trichDanTin;
    }

    public String getNoiDungTin() {
        return noiDungTin;
    }

    public void setNoiDungTin(String noiDungTin) {
        this.noiDungTin = noiDungTin;
    }

    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }

    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    public int getSoLanDoc() {
        return soLanDoc;
    }

    public void setSoLanDoc(int soLanDoc) {
        this.soLanDoc = soLanDoc;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public int getMaTheLoai() {
        return maTheLoai;
    }

    public void setMaTheLoai(int maTheLoai) {
        this.maTheLoai = maTheLoai;
    }

    public int getMaTheLoaiTin() {
        return maTheLoaiTin;
    }

    public void setMaTheLoaiTin(int maTheLoaiTin) {
        this.maTheLoaiTin = maTheLoaiTin;
    }

    public int getMaThanhVien() {
        return maThanhVien;
    }

    public void setMaThanhVien(int maThanhVien) {
        this.maThanhVien = maThanhVien;
    }

    @Override
    public String toString() {
        return "TinTuc{" +
                "maTinTuc=" + maTinTuc +
                ", tieuDeTinTuc='" + tieuDeTinTuc + '\'' +
                ", urlAnh='" + urlAnh + '\'' +
                ", trichDanTin='" + trichDanTin + '\'' +
                ", noiDungTin='" + noiDungTin + '\'' +
                ", ngayCapNhat=" + ngayCapNhat +
                ", soLanDoc=" + soLanDoc +
                ", tag='" + tag + '\'' +
                ", maTheLoai=" + maTheLoai +
                ", maTheLoaiTin=" + maTheLoaiTin +
                ", maThanhVien=" + maThanhVien +
                '}';
    }
}