package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.BuyRewardActivityAudit;
import com.yilidi.o2o.product.model.BuyRewardActivityMapping;
import com.yilidi.o2o.product.model.query.BuyRewardActivityQuery;

/**
 * 
 * 功能描述：买赠活动mapper 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年2月27日
 */
public interface BuyRewardActivityAuditMapper {

    /**
     * 新增买赠活动
     * 
     * @param buyRewardActivity
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    void save(BuyRewardActivityAudit buyRewardActivity);

    /**
     * 新增买赠活动详情
     * 
     * @param list
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_MAPPING_AUDIT })
    void saveActivityMapping(List<BuyRewardActivityMapping> list);

    /**
     * 更新买赠活动
     * 
     * @param buyRewardActivity
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    Integer update(BuyRewardActivityAudit buyRewardActivity);

    /**
     * 根据活动id更新买赠活动状态
     * 
     * @param id
     * @param statusCode
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    void updateStatusCode(@Param("id") Integer id, @Param("statusCode") String statusCode);

    /**
     * 根据条件分页查询买赠活动信息
     * 
     * @param query
     *            查询条件对象
     * @return 买赠活动信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    Page<BuyRewardActivityAudit> findBuyRewardActivityMappers(BuyRewardActivityQuery query);

    /**
     * 根据活动Id 查询买赠活动信息
     * 
     * @param id
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    BuyRewardActivityAudit loadById(@Param("id") Integer id);

    /**
     * 根据产品Id查询该产品已参加的活动
     * 
     * @param productId
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    List<BuyRewardActivityAudit> getBuyRewardActivityByProductId(Integer productId);

    /**
     * 根据活动Id查询活动详情
     * 
     * @param activityId
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_MAPPING_AUDIT })
    List<BuyRewardActivityMapping> listBuyRewardActivityDetailsByActivityId(Integer ActivityId);

    /**
     * 根据活动名称查询活动
     * 
     * @param activityName
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    List<BuyRewardActivityAudit> listBuyRewardActivityByActivityName(String activityName);

    /**
     * 根据活动id和活动审核状态删除买赠活动
     * 
     * @param id
     * @param auditStatusList
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    int deleteBuyRewardActivitysByIdsAndAuditStatusList(@Param("id") Integer id,
            @Param("auditStatusList") List<String> auditStatusList);

    /**
     * 根据买赠活动id删除买赠活动详情
     * 
     * @param id
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_MAPPING_AUDIT })
    void deleteBuyRewardActivityMappingsByActivityId(Integer activityId);

    /**
     * 提交待审核
     * 
     * @param id
     * @param preAuditStatusList
     * @param submitTime
     * @param auditStatus
     * @param modifyUserId
     * @param modifyTime
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    Integer updateAuditStatusById(@Param("id") Integer id, @Param("preAuditStatusList") List<String> preAuditStatusList,
            @Param("submitTime") Date submitTime, @Param("auditStatus") String auditStatus,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 审批后更新审核状态
     * 
     * @param id
     * @param preAuditStatus
     * @param auditStatus
     * @param finalAuditUserId
     * @param finalAuditTime
     * @param finalAuditRejectReason
     * @param modifyUserId
     * @param modifyTime
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    Integer updateAuditStatusByFinalAudit(@Param("id") Integer id, @Param("preAuditStatus") String preAuditStatus,
            @Param("auditStatus") String auditStatus, @Param("finalAuditUserId") Integer finalAuditUserId,
            @Param("finalAuditTime") Date finalAuditTime, @Param("finalAuditRejectReason") String finalAuditRejectReason,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 获取已审批、未失效的买赠活动
     * 
     * @param statusCode
     * @param auditStatus
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    List<BuyRewardActivityAudit> listBuyRewardActivityByActivityStatusCode(@Param("statusCode") String statusCode,
            @Param("auditStatus") String auditStatus);

    /**
     * 更新活动时间段
     * 
     * @param act
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_AUDIT })
    Integer updateActivityTime(BuyRewardActivityAudit act);

    /**
     * 根据活动id及产品id查询产品买赠详情
     * 
     * @param productId
     * @param id
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_BUYREWARD_ACTIVITY_MAPPING_AUDIT })
    BuyRewardActivityMapping getBuyRewardActivityDetailByProductIdAndActivityId(@Param("productId") Integer productId,
            @Param("id") Integer id);
}