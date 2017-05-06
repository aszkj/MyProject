/**
 * 文件名称：BaseModel.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.model;

import java.io.Serializable;

import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * 功能描述：实体基础类，实现序列化和toStirng方法 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class BaseModel implements Serializable {

	private static final long serialVersionUID = -9191310105031822857L;

	@Override
	public String toString() {
		return JsonUtils.toJsonStringWithDateFormat(this);
	}
}
