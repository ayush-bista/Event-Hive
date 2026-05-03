package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/eventhive_db";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "A@yush123";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "MySQL JDBC Driver not found! " +
                            "Make sure mysql-connector-j-8.x.x.jar " +
                            "is inside WEB-INF/lib and added as library.", e);
        }
    }
public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
private DBConnection() {}
}
