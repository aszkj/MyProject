package com.yilidi.o2o.system.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.system.service.dto.query.SystemMessageQueryDto;

/**
 * 系统消息服务接口
 * @author Administrator
 *
 */
public interface ISystemMessageService {
	/**
	 * 添加消息
	 */
	public int addSystemMessage(SystemMessageDto systemMessageDto);
	/**
	 * 修改消息
	 */
	public int updateSystemMessage(SystemMessageDto systemMessageDto);
	/**
	 * 根据id获取消息(用于回显)
	 */
	public SystemMessageDto getSystemMessageById(Integer id);
	/**
	 * 消息列表
	 */
	public YiLiDiPage<SystemMessageDto> getSystemMessageList(SystemMessageQueryDto systemMessageQueryDto);
	/**
	 * 消息审核
	 */
	public int updateCheckStatus(SystemMessageDto systemMessageDto);
	/**
	 * 根据id获取消息
	 */
	public SystemMessageDto loadById(Integer id);
	
	/**
	 * 获取消息模块
	 * @param date 
	 */
	public List<SystemDictDto> getMessageModule(Date createTime);
	/**
	 * app消息列表
	 * @param systemMessageQueryDto
	 * @param userId
	 * @return
	 */
	public YiLiDiPage<SystemMessageDto> getAppSystemMessageList(SystemMessageQueryDto systemMessageQueryDto,
			Integer userId);
}
