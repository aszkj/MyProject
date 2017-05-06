/**
 * 文件名称：CacheType.java
 * 
 * 描述： 数据库缓存类型定义
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.cache;

/**
 * 功能描述：定义缓存操作的类型 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public enum CacheType {

	/**
	 * 查询时使用缓存
	 */
	QUERY,
	/**
	 * 在进行 增、删、改的时候通知缓存
	 */
	NOTIFY
}
