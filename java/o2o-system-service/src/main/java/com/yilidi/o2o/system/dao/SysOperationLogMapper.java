package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SysOperationLog;

/**
 * 功能描述：系统日志DAO层接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SysOperationLogMapper {

	/**
	 * 保存日志
	 * 
	 * @param sysLog
	 *            日志对象
	 * @return 返回日志的ID
	 */
	int save(SysOperationLog sysLog);

	/**
	 * 查找所有的日志信息
	 * 
	 * @return 日志对象列表
	 */
	List<SysOperationLog> list();
	
	/**
	 * 根据系统日志ID删除日志信息
	 * 
	 * @param id
	 * @return Integer
	 */
	Integer deleteById(Integer id);

}