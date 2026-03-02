package com.jobportal.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Password utility using salted SHA-256.
 * Stored format: base64(salt):hex(sha256(salt+password))
 */
public class PasswordUtil {

    private static final int SALT_BYTES = 16;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordUtil() {
    }

    /** Hash a plain-text password with a fresh random salt. */
    public static String hashPassword(String password) {
        byte[] salt = new byte[SALT_BYTES];
        RANDOM.nextBytes(salt);
        String saltB64 = Base64.getEncoder().encodeToString(salt);
        return saltB64 + ":" + sha256Hex(saltB64 + password);
    }

    /** Verify a plain-text password against a stored salted hash. */
    public static boolean verifyPassword(String password, String stored) {
        if (stored == null || !stored.contains(":")) {
            return false;
        }
        int sep = stored.indexOf(':');
        String saltB64 = stored.substring(0, sep);
        String expectedHash = stored.substring(sep + 1);
        return expectedHash.equals(sha256Hex(saltB64 + password));
    }

    private static String sha256Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }
}
