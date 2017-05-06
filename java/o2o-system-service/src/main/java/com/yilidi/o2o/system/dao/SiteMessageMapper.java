package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.SiteMessage;

/**
 * 功能描述：站内消息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SiteMessageMapper {
	/**
	 * 保存站内消息
	 * 
	 * @param record
	 *            消息对象
	 * @return 影响行数
	 */
	Integer save(SiteMessage record);

	/**
	 * 根据消息ID删除站内消息
	 * 
	 * @param id
	 *            站内消息Id
	 * @return 影响行数
	 */
	Integer deleteById(Integer id);

	/**
	 * 根据站内消息ID更新消息内容（如果字段值为null，则不更新该字段，推荐使用该方法更新）
	 * 
	 * @param record
	 *            站内消息对象
	 * @return 影响行数
	 */
	Integer updateByIdSelective(SiteMessage record);

	/**
	 * 根据站内消息ID更新消息内容
	 * 
	 * @param record
	 *            站内消息对象
	 * @return 影响行数
	 */
	Integer updateById(SiteMessage record);

	/**
	 * 根据站内消息ID加载消息对象
	 * 
	 * @param id
	 *            站内消息Id
	 * @return 站内消息对象
	 */
	SiteMessage loadById(Integer id);

	/**
	 * 查询所有的站内消息
	 * 
	 * @return 消息对象列表
	 */
	List<SiteMessage> list();

}