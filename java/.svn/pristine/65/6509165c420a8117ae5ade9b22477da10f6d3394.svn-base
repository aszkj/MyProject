package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SystemAnnouncementHistory;

/**
 * 功能描述：系统公告历史信息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SystemAnnouncementHistoryMapper {

	/**
	 * 保存公告的历史记录
	 * 
	 * @param record
	 *            历史记录对象
	 * @return 影响行数
	 */
	Integer save(SystemAnnouncementHistory record);

	/**
	 * 查询所有的历史记录
	 * 
	 * @return 历史记录列表
	 */
	List<SystemAnnouncementHistory> list();

	/**
	 * 根据公告ID查询历史记录
	 * 
	 * @param announceId
	 *            公告Id
	 * @return 历史记录列表
	 */
	List<SystemAnnouncementHistory> listByAnnounceId(Integer announceId);

}