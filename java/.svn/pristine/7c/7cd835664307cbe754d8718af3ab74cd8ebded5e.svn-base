package com.yilidi.o2o.system.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.SystemMessage;
import com.yilidi.o2o.system.model.query.SystemMessageQuery;

public interface SystemMessageMapper {
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public SystemMessage loadById(@Param("id")Integer id);
	
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Integer save(SystemMessage systemMessage);

	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Integer saveSelective(SystemMessage systemMessage);
	
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Integer updateById(SystemMessage systemMessage);

	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Integer updateByIdSelective(SystemMessage systemMessage);
	
	/**
	 * 根据条件获取所有系统消息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Page<SystemMessage> findList(SystemMessageQuery systemMessageQuery);

	/**
	 * 获取app用户系统消息
	 * @param systemMessageQuery
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_MESSAGE })
	public Page<SystemMessage> findAppSystemMessageList(SystemMessageQuery systemMessageQuery);

	/**
	 * 获取最新一条消息
	 * @param dictCode
	 * @param createTime 
	 * @return
	 */
	public SystemMessage findNewMessageByMessageType(@Param("messageType")String messageType, @Param("createTime")Date createTime);
}
