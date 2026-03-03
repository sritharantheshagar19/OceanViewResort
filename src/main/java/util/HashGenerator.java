package util;

public class HashGenerator {
    public static void main(String[] args) {
        String plainPassword = "admin123"; // your current plain password
        String hashed = PasswordUtil.hashPassword(plainPassword);
        System.out.println("Hashed password: " + hashed);
    }
}