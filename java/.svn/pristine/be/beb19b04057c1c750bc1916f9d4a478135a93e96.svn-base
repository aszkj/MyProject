package com.yilidi.o2o.user.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.user.model.ShareRule;
import com.yilidi.o2o.user.model.query.ShareRuleQuery;

/**
 * 分享规则Mapper
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:00:26
 */
public interface ShareRuleMapper {

    /**
     * 新增保存
     * 
     * @param shareRule
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SHARE_RULE })
    Integer save(ShareRule shareRule);

    /**
     * 修改分享规则信息
     * 
     * @param shareRule
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SHARE_RULE })
    Integer update(ShareRule shareRule);

    /**
     * 选择性修改分享规则信息
     * 
     * @param shareRule
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SHARE_RULE })
    Integer updateSelective(ShareRule shareRule);

    /**
     * 查询分享规则列表,不分页
     * 
     * @param shareRuleQuery
     *            分享规则查询实体
     * @return 分享规则列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    List<ShareRule> listShareRules(ShareRuleQuery shareRuleQuery);

    /**
     * 分享规则分页列表
     * 
     * @param shareRuleQuery
     *            分享规则查询实体
     * @return 分享规则分页列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    Page<ShareRule> findShareRules(ShareRuleQuery shareRuleQuery);

    /**
     * 根据分享规则ID查找分享规则对象
     * 
     * @param ruleId
     *            分享规则ID
     * @return 分享规则对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    ShareRule loadById(@Param("ruleId") Integer ruleId);

    /**
     * 获取当前正在进行的分享规则活动
     * 
     * @param nowTime
     *            当前时间
     * @param status
     *            失效的状态
     * @return 分享规则对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    ShareRule loadProgressing(@Param("nowTime") Date nowTime, @Param("status") String status);

    /**
     * 查询活动时间在指定开始时间和指定结束时间区间的分享规则
     * 
     * @param startValidTime
     *            活动开始时间
     * @param endValidTime
     *            活动结束时间
     * @param status
     *            失效状态 活动结束时间
     * @return 分享规则对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    List<ShareRule> listByValidTime(@Param("startValidTime") Date startValidTime, @Param("endValidTime") Date endValidTime,
            @Param("status") String status);

    /**
     * 根据状态查找分享规则列表
     * 
     * @param status
     *            分享状态
     * @return 分享规则列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SHARE_RULE })
    List<ShareRule> listShareRulesByStatus(@Param("status") String status);

    /**
     * 修改分享规则状态
     * 
     * @param shareRuleId
     *            分享规则ID
     * @param updateStatus
     *            修改后规则状态
     * @param updateUserId
     *            用户操作ID
     * @param updateTime
     *            操作时间
     * @throws OrderServiceException
     *             销售服务异常
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SHARE_RULE })
    void updateStatusById(@Param("shareRuleId") Integer shareRuleId, @Param("updateStatus") String updateStatus,
            @Param("updateUserId") Integer updateUserId, @Param("updateTime") Date updateTime);
}
