/**
 * 文件名称：ExceptionMessageManualHandlingQuery.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.system.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：需人工处理的异常消息查询条件封装类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ExceptionMessageManualHandlingQuery extends BaseQuery {

	private static final long serialVersionUID = 3063107551753400367L;

	/**
	 * 消息名称
	 */
	private String messageName;

	public String getMessageName() {
		return messageName;
	}

	public void setMessageName(String messageName) {
		this.messageName = messageName;
	}

}
