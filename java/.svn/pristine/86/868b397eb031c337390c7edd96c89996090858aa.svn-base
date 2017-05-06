package com.yilidi.o2o.user.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.InviterUserShareAward;
import com.yilidi.o2o.user.model.combination.InviterUserAwardStatisticInfo;

/**
 * 功能描述：邀请人分享奖励对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InviterUserShareAwardMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新被邀请用户分享奖励缓存
     * </pre>
     * 
     * @param inviterUserShareAward
     *            保存用户分享奖励信息
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_AWARD })
    Integer save(InviterUserShareAward inviterUserShareAward);

    /**
     * 根据 分享奖励记录ID 加载邀请人用户奖励记录对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            被邀请用户分享记录ID
     * @return 被邀请用户分享记录对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_AWARD })
    InviterUserShareAward loadById(Integer id);

    /**
     * 根据用户分享码和分享规则加载分享奖励
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param shareCode
     *            用户分享码
     * @param shareRuleId
     *            分享规则ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_AWARD })
    InviterUserShareAward loadByShareCodeAndShareRuleId(@Param("shareCode") String shareCode,
            @Param("shareRuleId") Integer shareRuleId);

    /**
     * 根据用户Id和分享规则加载分享奖励
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param userId
     *            分享用户ID
     * @param shareRuleId
     *            分享规则ID
     * @param invitedUserId
     *            被邀请用户ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_AWARD })
    InviterUserShareAward loadByUserIdAndShareRuleIdAndInvitedUserId(@Param("userId") Integer userId,
            @Param("shareRuleId") Integer shareRuleId, @Param("invitedUserId") Integer invitedUserId);

    /**
     * 统计分享奖励信息
     * 
     * @param userId
     *            用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 累计奖励信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_AWARD })
    InviterUserAwardStatisticInfo getAwardStatisticsInfo(@Param("userId") Integer userId, @Param("startTime") Date startTime,
            @Param("endTime") Date endTime);

    /**
     * 获取指定时间内分享用户累计奖励优惠券金额
     * 
     * @param shareUserId
     *            分享用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 冠军用户ID
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Long getInviterAmountCountByShareUserIdAndTime(@Param("shareUserId") Integer shareUserId,
            @Param("startTime") Date startTime, @Param("endTime") Date endTime);

}