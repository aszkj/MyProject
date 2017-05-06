package com.yilidi.o2o.system.dao;

import com.yilidi.o2o.system.model.ExceptionMessageManualHandling;
import com.yilidi.o2o.system.service.dto.query.ExceptionMessageManualHandlingQuery;
import com.github.pagehelper.Page;

/**
 * 功能描述：异常消息人工处理数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ExceptionMessageManualHandlingMapper {

	/**
	 * 保存异常消息信息
	 * 
	 * @param exceptionMessageManualHandling
	 * @return Integer
	 */
	Integer save(ExceptionMessageManualHandling exceptionMessageManualHandling);

	/**
	 * 根据ID获取该异常消息人工处理信息
	 * 
	 * @param id
	 * @return ExceptionMessageInfo
	 */
	ExceptionMessageManualHandling loadById(Integer id);

	/**
	 * 根据ID删除该异常消息人工处理信息
	 * 
	 * @param id
	 * @return Integer
	 */
	Integer deleteById(Integer id);

	/**
	 * 分页显示需要人工处理的异常消息
	 * 
	 * @param query
	 * @return Page<ExceptionMessageManualHandling>
	 */
	Page<ExceptionMessageManualHandling> findExceptionMessageManualHandlings(ExceptionMessageManualHandlingQuery query);

}