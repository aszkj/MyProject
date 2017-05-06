package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SiteMessageHistory;

/**
 * 功能描述：站内消息历史记录数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SiteMessageHistoryMapper {

	/**
	 * 保存历史信息
	 * 
	 * @param record
	 *            历史记录实体
	 * @return 影响行数
	 */
	Integer save(SiteMessageHistory record);

	/**
	 * 查询所有的历史记录
	 * 
	 * @return 历史记录列表
	 */
	List<SiteMessageHistory> list();

	/**
	 * 根据站内消息ID查询所有的历史消息
	 * 
	 * @param siteMessageId
	 *            站内消息Id
	 * @return 历史记录列表
	 */
	List<SiteMessageHistory> listBySiteMessageId(Integer siteMessageId);

}