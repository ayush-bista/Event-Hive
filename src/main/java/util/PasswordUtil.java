package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * PasswordUtil - SHA-256 password hashing utility.
 * Matches the SHA2(..., 256) function used in MySQL seed data.
 */
public class PasswordUtil {

    /**
     * Returns the SHA-256 hex string of the given plain-text password.
     * Example: hash("Admin@123") → same 64-char hex stored in DB
     */
    public static String hash(String plainText) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(plainText.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    /**
     * Compares a plain-text password against a stored hash.
     */
    public static boolean verify(String plainText, String storedHash) {
        return hash(plainText).equals(storedHash);
    }

    private PasswordUtil() {}
}
