package com.yilidi.o2o.core.sequence;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * JDBC连接类
 * 
 * @author chenl
 * 
 */
public class DBConnection {

	private Connection conn = null;

	private static Properties props = null;

	static {
		props = new Properties();
		try {
			props.load(DBConnection.class.getResourceAsStream("/dbconf.properties"));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		try {
			Class.forName(props.getProperty("jdbc_driver_class"));
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		try {
			conn = DriverManager.getConnection(props.getProperty("jdbc_url"), props.getProperty("jdbc_username"),
					props.getProperty("jdbc_password"));
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

}
