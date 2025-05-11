package Model;

public class TheLoaiTin {
	private int maTheLoaiTin;
	private String tenTheLoaiTin;
	private boolean visibleTheLoaiTin;
	private boolean visibleTheLoaiTin1;
	private Integer sapXep;
	private String url;
	private String target;
	private boolean linkNgoai;
	private int maTheLoai;
	private TheLoai theLoai; // Reference to the parent category

	public TheLoaiTin() {
	}

	public TheLoaiTin(int maTheLoaiTin, String tenTheLoaiTin, boolean visibleTheLoaiTin, boolean visibleTheLoaiTin1,
			Integer sapXep, String url, String target, boolean linkNgoai, int maTheLoai) {
		this.maTheLoaiTin = maTheLoaiTin;
		this.tenTheLoaiTin = tenTheLoaiTin;
		this.visibleTheLoaiTin = visibleTheLoaiTin;
		this.visibleTheLoaiTin1 = visibleTheLoaiTin1;
		this.sapXep = sapXep;
		this.url = url;
		this.target = target;
		this.linkNgoai = linkNgoai;
		this.maTheLoai = maTheLoai;
	}

	public int getMaTheLoaiTin() {
		return maTheLoaiTin;
	}

	public void setMaTheLoaiTin(int maTheLoaiTin) {
		this.maTheLoaiTin = maTheLoaiTin;
	}

	public String getTenTheLoaiTin() {
		return tenTheLoaiTin;
	}

	public void setTenTheLoaiTin(String tenTheLoaiTin) {
		this.tenTheLoaiTin = tenTheLoaiTin;
	}

	public boolean isVisibleTheLoaiTin() {
		return visibleTheLoaiTin;
	}

	public void setVisibleTheLoaiTin(boolean visibleTheLoaiTin) {
		this.visibleTheLoaiTin = visibleTheLoaiTin;
	}

	public boolean isVisibleTheLoaiTin1() {
		return visibleTheLoaiTin1;
	}

	public void setVisibleTheLoaiTin1(boolean visibleTheLoaiTin1) {
		this.visibleTheLoaiTin1 = visibleTheLoaiTin1;
	}

	public Integer getSapXep() {
		return sapXep;
	}

	public void setSapXep(Integer sapXep) {
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

	public int getMaTheLoai() {
		return maTheLoai;
	}

	public void setMaTheLoai(int maTheLoai) {
		this.maTheLoai = maTheLoai;
	}

	public TheLoai getTheLoai() {
		return theLoai;
	}

	public void setTheLoai(TheLoai theLoai) {
		this.theLoai = theLoai;
	}

	@Override
	public String toString() {
		return "TheLoaiTin{" + "maTheLoaiTin=" + maTheLoaiTin + ", tenTheLoaiTin='" + tenTheLoaiTin + '\''
				+ ", visibleTheLoaiTin=" + visibleTheLoaiTin + ", visibleTheLoaiTin1=" + visibleTheLoaiTin1
				+ ", sapXep=" + sapXep + ", url='" + url + '\'' + ", target='" + target + '\'' + ", linkNgoai="
				+ linkNgoai + ", maTheLoai=" + maTheLoai + '}';
	}
}