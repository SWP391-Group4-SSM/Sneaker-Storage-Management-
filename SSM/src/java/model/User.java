package model;

import java.sql.Timestamp;

public class User {
    private int userID;
    private String username;
    private String passwordHash;
    private String role;
    private Timestamp createdAt;
    private boolean isDeleted;

    // Constructor đầy đủ
    public User(int userID, String username, String passwordHash, String role, Timestamp createdAt, boolean isDeleted) {
        this.userID = userID;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
    }

    // Constructor khi thêm mới user (mặc định isDeleted = false)
    public User(String username, String passwordHash, String role) {
        this(username, passwordHash, role, new Timestamp(System.currentTimeMillis()), false);
    }

    // Constructor bổ sung nếu cần timestamp cụ thể
    public User(String username, String passwordHash, String role, Timestamp createdAt, boolean isDeleted) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
    }

    // Getter & Setter
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
}
