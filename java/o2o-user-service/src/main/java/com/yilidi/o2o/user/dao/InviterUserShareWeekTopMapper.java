package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.InviterUserShareWeekTop;

/**
 * 功能描述：周邀请排行榜对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InviterUserShareWeekTopMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新邀请排行榜缓存
     * </pre>
     * 
     * @param inviterUserShareWeekTop
     *            用户分享记录对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP })
    Integer save(InviterUserShareWeekTop inviterUserShareWeekTop);

    /**
     * 删除用户排行榜信息
     * 
     * <pre>
     *  注：将更新邀请排行榜缓存
     * </pre>
     * 
     * @param userId
     *            用户手机号码
     * @param year
     *            年份
     * @param month
     *            月份
     * @param weekNumber
     *            周次
     * @param weekNumber
     *            当前页数
     * @param pageSize
     *            每页大小
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP })
    Integer deleteUserRecord(@Param("userName") String userName, @Param("year") Integer year, @Param("month") Integer month,
            @Param("weekNumber") Integer weekNumber);

    /**
     * 分页查询用户邀请排行榜
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param year
     *            年份
     * @param month
     *            月份
     * @param weekNumber
     *            周数
     * @return 被邀请用户分享记录数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP })
    Page<InviterUserShareWeekTop> findInviterUserShareWeekTops(@Param("year") Integer year, @Param("month") Integer month,
            @Param("weekNumber") Integer weekNumber, Integer start, Integer pageSize);

    /**
     * 指定年月周查询某人记录
     * 
     * @param userName
     *            用户名(手机号码)
     * @param year
     *            年
     * @param month
     *            月
     * @param weekNumber
     *            周次
     * @return 排行榜记录
     */
    InviterUserShareWeekTop loadByUserNameAndYearAndMonthAndWeekNumber(@Param("userName") String userName,
            @Param("year") Integer year, @Param("month") Integer month, @Param("weekNumber") Integer weekNumber);

    /**
     * 用户邀请排行榜总数
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param year
     *            年份
     * @param month
     *            月份
     * @param weekNumber
     *            周数
     * @return 被邀请用户分享记录总数
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP })
    Integer getInviterUserShareWeekTopsCount(@Param("year") Integer year, @Param("month") Integer month,
            @Param("weekNumber") Integer weekNumber);

    /**
     * 根据ID修改邀请人数和邀请数量
     * 
     * @param id
     *            表ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP })
    Integer updateUserNameAndInviterCountById(@Param("id") Integer id);
}