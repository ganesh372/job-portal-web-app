package com.jobportal.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Provides JDBC connections to the MySQL database.
 *
 * <p>Credentials are resolved in this priority order:
 * <ol>
 *   <li>Environment variables: {@code DB_URL}, {@code DB_USERNAME}, {@code DB_PASSWORD}</li>
 *   <li>Properties file: {@code db.properties} on the classpath</li>
 * </ol>
 */
public class DBConnection {

    private static final String DB_URL;
    private static final String DB_USER;
    private static final String DB_PASSWORD;

    static {
        // Load fallback values from the bundled properties file
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (IOException e) {
            // Non-fatal: env vars may still supply the values
        }

        // Environment variables take precedence over the properties file
        DB_URL = envOrProp("DB_URL", props, "db.url",
                "jdbc:mysql://localhost:3306/jobportal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
        DB_USER     = envOrProp("DB_USERNAME", props, "db.username", "root");
        DB_PASSWORD = envOrProp("DB_PASSWORD", props, "db.password", "root");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    /** Returns a new database connection. Callers must close it when done. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private DBConnection() {
    }

    private static String envOrProp(String envKey, Properties props,
                                    String propKey, String defaultValue) {
        String env = System.getenv(envKey);
        if (env != null && !env.isEmpty()) {
            return env;
        }
        return props.getProperty(propKey, defaultValue);
    }
}
