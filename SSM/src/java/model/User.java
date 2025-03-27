package model;

import java.sql.Timestamp;

public class User {
    private int userID;
    private String username;
    private String passwordHash;
    private String role;
    private Timestamp createdAt;
    private boolean isDeleted;
    private String name;
    private String email;
    private String numberPhone;
    private String address;

    // Constructor đầy đủ
    public User(int userID, String username, String passwordHash, String role, Timestamp createdAt, boolean isDeleted, String name, String email, String numberPhone, String address) {
        this.userID = userID;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
        this.name = name;
        this.email = email;
        this.numberPhone = numberPhone;
        this.address = address;
    }

    // Constructor khi thêm mới user (mặc định isDeleted = false)
    public User(String username, String passwordHash, String role, String name, String email, String numberPhone, String address) {
        this(username, passwordHash, role, new Timestamp(System.currentTimeMillis()), false, name, email, numberPhone, address);
    }

    // Constructor bổ sung nếu cần timestamp cụ thể
    public User(String username, String passwordHash, String role, Timestamp createdAt, boolean isDeleted, String name, String email, String numberPhone, String address) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
        this.name = name;
        this.email = email;
        this.numberPhone = numberPhone;
        this.address = address;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNumberPhone() {
        return numberPhone;
    }

    public void setNumberPhone(String numberPhone) {
        this.numberPhone = numberPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}