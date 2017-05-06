package com.yilidi.o2o.core.sequence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.log4j.Logger;

/**
 * 全局ID生成器，用纯JDBC实现提高效率
 * 
 * 在各Service层的成员变量中加入 private IDGenerator generator = new IDGenerator();
 * 由于Service是单例的，因此，ReentrantLock针对该Service是可以锁住的，而对别的Service是毫无影响的。
 * 
 * @author chenl
 * 
 */
public class IDGenerator {

	private final Logger logger = Logger.getLogger(IDGenerator.class);

	// 对象实例级别的锁，而不是static的类级别的锁，防止在同时生成多个毫不相关表的ID时，出现的不必要等待的情况。
	private final Lock lock = new ReentrantLock();

	public Long generate(String tableName) {
		lock.lock();
		Connection connection = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet resultSet = null;
		try {
			DBConnection dbConnection = new DBConnection();
			connection = dbConnection.getConn();
			String replaceSql = "REPLACE INTO " + tableName + "(stub) VALUES ('a')";
			pstmt1 = connection.prepareStatement(replaceSql);
			int result = pstmt1.executeUpdate();
			if (result <= 0) {
				return null;
			}
			String selectSql = "SELECT LAST_INSERT_ID() AS LASTID";
			pstmt2 = connection.prepareStatement(selectSql);
			resultSet = pstmt2.executeQuery(selectSql);
			Long lastId = null;
			if (resultSet.next()) {
				lastId = (Long) resultSet.getObject("LASTID");
				logger.info("================>lastId : " + lastId);
			}
			connection.commit();
			return lastId;
		} catch (SQLException e) {
			String msg = "生成全局ID发生系统异常";
			if (null != connection) {
				try {
					connection.rollback();
				} catch (SQLException e1) {
					logger.error(msg, e);
					throw new IllegalStateException(msg, e);
				}
			}
			logger.error(msg, e);
			throw new IllegalStateException(msg, e);
		} finally {
			try {
				if (null != resultSet) {
					resultSet.close();
				}
				if (null != pstmt2) {
					pstmt2.close();
				}
				if (null != pstmt1) {
					pstmt1.close();
				}
				if (null != connection) {
					connection.setAutoCommit(true);
					connection.close();
				}
				lock.unlock();
			} catch (SQLException ex) {
				String msg = "生成全局ID发生系统异常";
				lock.unlock();
				logger.error(msg, ex);
				throw new IllegalStateException(msg, ex);
			}
		}
	}

}
