package Model;

public class TheLoai {
    private int maTheLoai;
    private String tenTheLoai;
    private boolean visibleTheLoai;
    private boolean visibleTheLoai1;
    private int sapXep;
    private String url;
    private String target;
    private boolean linkNgoai;

    public TheLoai() {
    }

    public int getMaTheLoai() {
        return maTheLoai;
    }

    public void setMaTheLoai(int maTheLoai) {
        this.maTheLoai = maTheLoai;
    }

    public String getTenTheLoai() {
        return tenTheLoai;
    }

    public void setTenTheLoai(String tenTheLoai) {
        this.tenTheLoai = tenTheLoai;
    }

    public boolean isVisibleTheLoai() {
        return visibleTheLoai;
    }

    public void setVisibleTheLoai(boolean visibleTheLoai) {
        this.visibleTheLoai = visibleTheLoai;
    }

    public boolean isVisibleTheLoai1() {
        return visibleTheLoai1;
    }

    public void setVisibleTheLoai1(boolean visibleTheLoai1) {
        this.visibleTheLoai1 = visibleTheLoai1;
    }

    public int getSapXep() {
        return sapXep;
    }

    public void setSapXep(int sapXep) {
        this.sapXep = sapXep;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public boolean isLinkNgoai() {
        return linkNgoai;
    }

    public void setLinkNgoai(boolean linkNgoai) {
        this.linkNgoai = linkNgoai;
    }
}