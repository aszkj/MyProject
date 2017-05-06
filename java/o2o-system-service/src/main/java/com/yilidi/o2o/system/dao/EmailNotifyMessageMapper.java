package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.EmailNotifyMessage;

/**
 * 
 * @Description:TODO(邮件通知消息Mapper接口)
 * @author: chenlian
 * @date: 2015-9-21 上午10:14:27
 * 
 */
public interface EmailNotifyMessageMapper {

	/**
	 * 保存消息
	 * 
	 * @param record
	 *            消息对象实体
	 * @return 影响行数
	 */
	Integer save(EmailNotifyMessage record);

	/**
	 * 根据ID删除通知消息
	 * 
	 * @param id
	 *            消息ID
	 * @return 影响行数
	 */
	Integer deleteById(Integer id);

	/**
	 * 根据ID加载通知消息
	 * 
	 * @param id
	 *            消息ID
	 * @return 消息对象
	 */
	EmailNotifyMessage loadById(Integer id);

	/**
	 * 根据接收者的名称加载消息列表
	 * 
	 * @param toUser
	 *            消息接收者
	 * @return 消息列表
	 */
	List<EmailNotifyMessage> listByReciever(String toUser);

}