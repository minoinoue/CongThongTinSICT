package Model;

public class PhanLoaiTin {
	private int maPhanLoaiTin;
	private String tenPhanLoaiTin;
	private int sapXep;

	public PhanLoaiTin() {
	}

	public PhanLoaiTin(int maPhanLoaiTin, String tenPhanLoaiTin, Integer sapXep) {
		this.maPhanLoaiTin = maPhanLoaiTin;
		this.tenPhanLoaiTin = tenPhanLoaiTin;
		this.sapXep = sapXep;
	}

	public int getMaPhanLoaiTin() {
		return maPhanLoaiTin;
	}

	public void setMaPhanLoaiTin(int maPhanLoaiTin) {
		this.maPhanLoaiTin = maPhanLoaiTin;
	}

	public String getTenPhanLoaiTin() {
		return tenPhanLoaiTin;
	}

	public void setTenPhanLoaiTin(String tenPhanLoaiTin) {
		this.tenPhanLoaiTin = tenPhanLoaiTin;
	}

	public Integer getSapXep() {
		return sapXep;
	}

	public void setSapXep(int sapXep) {
		this.sapXep = sapXep;
	}

	@Override
	public String toString() {
		return "PhanLoaiTin{" + "maPhanLoaiTin=" + maPhanLoaiTin + ", tenPhanLoaiTin='" + tenPhanLoaiTin + '\''
				+ ", sapXep=" + sapXep + '}';
	}
}