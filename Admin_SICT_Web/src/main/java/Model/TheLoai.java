package Model;

public class TheLoai {
	private int maTheLoai;
	private String tenTheLoai;
	private boolean visibleTheLoai;
	private boolean visibleTheLoai1;
	private Integer sapXep;
	private String url;
	private String target;
	private boolean linkNgoai;

	public TheLoai() {
	}

	public TheLoai(int maTheLoai, String tenTheLoai, boolean visibleTheLoai, boolean visibleTheLoai1, Integer sapXep,
			String url, String target, boolean linkNgoai) {
		this.maTheLoai = maTheLoai;
		this.tenTheLoai = tenTheLoai;
		this.visibleTheLoai = visibleTheLoai;
		this.visibleTheLoai1 = visibleTheLoai1;
		this.sapXep = sapXep;
		this.url = url;
		this.target = target;
		this.linkNgoai = linkNgoai;
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

	@Override
	public String toString() {
		return "TheLoai{" + "maTheLoai=" + maTheLoai + ", tenTheLoai='" + tenTheLoai + '\'' + ", visibleTheLoai="
				+ visibleTheLoai + ", visibleTheLoai1=" + visibleTheLoai1 + ", sapXep=" + sapXep + ", url='" + url
				+ '\'' + ", target='" + target + '\'' + ", linkNgoai=" + linkNgoai + '}';
	}
}