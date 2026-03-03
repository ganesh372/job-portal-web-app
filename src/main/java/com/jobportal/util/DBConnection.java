package com.jobportal.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Provides JDBC connections to the PostgreSQL database (Supabase).
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
        } catch (IOException ignored) {
            // Non-fatal: env vars may still supply the values
        }

        // Environment variables take precedence over the properties file
        DB_URL = envOrProp("DB_URL", props, "db.url",
                "jdbc:postgresql://localhost:5432/postgres?sslmode=disable");
        DB_USER = envOrProp("DB_USERNAME", props, "db.username", "postgres");
        DB_PASSWORD = envOrProp("DB_PASSWORD", props, "db.password", "");
    }

    /** Returns a new database connection. Callers must close it when done. */
    public static Connection getConnection() throws SQLException {
        // Optional debug logs (you can remove later)
        System.out.println("ENV DB_URL = " + DB_URL);
        System.out.println("ENV DB_USERNAME = " + DB_USER);
        System.out.println("ENV DB_PASSWORD is null? " + (DB_PASSWORD == null));

        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private DBConnection() {
        // utility class
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
