package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.LoginLog;
import com.yilidi.o2o.user.service.dto.query.LoginLogQuery;

/**
 * 功能描述：用户登录日志数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface LoginLogMapper {

	/**
	 * 保存用户登录日志
	 * 
	 * @param record
	 *            登录日志对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGIN_LOG })
	Integer save(LoginLog record);

	/**
	 * 根据sessionid更新登出时间
	 * 
	 * @param sessionId
	 *            sessionId
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGIN_LOG })
	Integer updateLogoutTimeBySessionId(String sessionId);

	/**
	 * 
	 * 根据SessionID获取登录日志
	 * 
	 * @param sessionId
	 *            SessionID
	 * @return LoginLog
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGIN_LOG })
	LoginLog getLoginLogBySessionId(@Param("sessionId") String sessionId);

	/**
	 * 根据查询条件分页查询用户登录日志信息
	 * <p>
	 * 如果查询条件对象中字段值为null，则该字段不作为查询条件
	 * </p>
	 * 
	 * @param query
	 *            查询对象
	 * @return 日志列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGIN_LOG })
	Page<LoginLog> findLoginLogs(LoginLogQuery query);

}