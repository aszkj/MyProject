package com.yilidi.o2o.user.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.InvitedUserShareAward;
import com.yilidi.o2o.user.model.combination.InviterUserStatisticInfo;
import com.yilidi.o2o.user.model.query.InvitedUserShareAwardQuery;

/**
 * 功能描述： 分享用户奖励对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InvitedUserShareAwardMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新分享记录缓存
     * </pre>
     * 
     * @param invitedUserShareAward
     *            用户分享记录对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Integer save(InvitedUserShareAward invitedUserShareAward);

    /**
     * 根据分享记录ID 加载分享记录对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            用户分享记录ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    InvitedUserShareAward loadById(Integer id);

    /**
     * 根据参加用户ID和分享规则加载奖励记录
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param invitedUserId
     *            被邀请用户ID
     * @param shareRuleId
     *            分享规则ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    InvitedUserShareAward loadByInvitedUserIdAndShareRuleId(@Param("invitedUserId") Integer invitedUserId,
            @Param("shareRuleId") Integer shareRuleId);

    /**
     * 分页查询被邀请用户分享记录数据
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param invitedUserShareAwardQuery
     *            查询条件对象
     * @return 被邀请用户分享记录数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Page<InvitedUserShareAward> findInvitedUserShareAwardsByShareUserId(
            InvitedUserShareAwardQuery invitedUserShareAwardQuery);

    /**
     * 分页查询邀请用户统计数据信息
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param invitedUserShareAwardQuery
     *            查询条件
     * @return 邀请用户统计信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Page<InviterUserStatisticInfo> findInviterStatisticsCounts(InvitedUserShareAwardQuery invitedUserShareAwardQuery);

    /**
     * 查询邀请用户统计数据信息总数量
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param invitedUserShareAwardQuery
     *            查询条件
     * @return 邀请用户统计信息列表总数
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Integer getInviterStatisticsCount(InvitedUserShareAwardQuery invitedUserShareAwardQuery);

    /**
     * 查找分享人一定时间范围内的统计信息
     * 
     * @param shareUserId
     *            分享用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 统计信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    InviterUserStatisticInfo loadStatisticsCountByShareUserIdAndTime(@Param("shareUserId") Integer shareUserId,
            @Param("startTime") Date startTime, @Param("endTime") Date endTime);

    /**
     * 查询指定时间区间内的冠军用户ID
     * 
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 冠军用户ID
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Integer loadChampionByTime(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    /**
     * 获取指定时间内分享用户邀请的人数
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
    Integer getInviterCountByShareUserIdAndTime(@Param("shareUserId") Integer shareUserId,
            @Param("startTime") Date startTime, @Param("endTime") Date endTime);

    /**
     * 分页查询用户分享记录数据
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param userShareRecordQuery
     *            查询条件对象
     * @return 用户分享记录数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    Page<InvitedUserShareAward> findInvitedUserShareAwards(InvitedUserShareAwardQuery userShareRecordQuery);

    /**
     * 根据指定时间查询邀请人数汇总列表
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 邀请用户统计信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_AWARD })
    List<InviterUserStatisticInfo> listInviterStatisticsCountsByTime(@Param("startTime") Date startTime,
            @Param("endTime") Date endTime);

}