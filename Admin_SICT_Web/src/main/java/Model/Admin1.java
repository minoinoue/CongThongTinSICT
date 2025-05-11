package Model;

import java.time.LocalDateTime;

public class Admin1 {
	private int adminID;
	private String username;
	private String passwordHash;
	private String fullName;

	public Admin1() {
	}

	public Admin1(int adminID, String username, String passwordHash, String fullName) {
		this.adminID = adminID;
		this.username = username;
		this.passwordHash = passwordHash;
		this.fullName = fullName;
	}

	public int getAdminID() {
		return adminID;
	}

	public void setAdminID(int adminID) {
		this.adminID = adminID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public int getIsAdmin() {
		return 1;
	}

	@Override
	public String toString() {
		return "Admin{" + "adminID=" + adminID + ", username='" + username + '\'' + ", passwordHash='" + passwordHash
				+ '\'' + ", fullName='" + fullName + '}';
	}
}