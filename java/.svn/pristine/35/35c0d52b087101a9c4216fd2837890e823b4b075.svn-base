package com.yilidi.o2o.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.SiteMessagePublished;
import com.yilidi.o2o.system.model.combination.SiteMessagePublishedRelationInfo;
import com.yilidi.o2o.system.service.dto.query.SiteMessagePublishedQuery;

/**
 * 功能描述：已发布的站内消息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SiteMessagePublishedMapper {

    /**
     * 保存发布的消息
     * 
     * @param record
     *            已发布的消息对象
     * @return 影响的行数
     */
    Integer save(SiteMessagePublished record);

    /**
     * 根据消息ID，更新消息状态
     * 
     * @param id
     *            消息Id
     * @param status
     *            已发布的消息状态 "0" 未读 "1" 已读
     * @return 影响的行数
     */
    Integer updateStatusById(@Param("id") Integer id, @Param("status") String status);

    /**
     * 根据ID加载已发布的消息
     * 
     * @param id
     *            已发布的消息id
     * @return 已发布的消息实体
     */
    SiteMessagePublished loadById(Integer id);

    /**
     * 根据接收者的ID查询发布的消息
     * 
     * @param receiveId
     *            接收者ID
     * @return 发布的消息列表
     */
    List<SiteMessagePublished> listByReceiveId(Integer receiveId);

    /**
     * 根据接收者的ID和已发布的消息状态（已读，未读）获取已发布的消息
     * 
     * @param receiveId
     *            接收者Id
     * @param status
     *            消息状态 消 "0" 未读 "1" 已读
     * @return 发布的消息列表
     */
    List<SiteMessagePublished> listByReceiveIdAndStatus(@Param("receiveId") Integer receiveId,
            @Param("status") String status);

    /**
     * 查询消息列表
     * 
     * @param siteMessagePublishedQuery
     *            消息查询实体类
     * @return Page<SiteMessagePublishedRelationInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SITE_MESSAGE_PUBLISHED,
            DBTablesName.System.S_SITE_MESSAGE })
    Page<SiteMessagePublishedRelationInfo> listSiteMessagePublishedRelationInfo(
            SiteMessagePublishedQuery siteMessagePublishedQuery);

}