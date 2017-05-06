package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.InviterUserShareWeekTopHistory;

/**
 * 功能描述：周邀请排行榜修改历史记录对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InviterUserShareWeekTopHistoryMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新缓存
     * </pre>
     * 
     * @param inviterUserShareWeekTopHistory
     *            用户分享记录对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP_HISTORY })
    Integer save(InviterUserShareWeekTopHistory inviterUserShareWeekTopHistory);

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
     * @param start
     *            周数
     * @param weekNumber
     *            当前页数
     * @param pageSize
     *            每页大小
     * @return 排行榜修改历史记录列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITERUSER_SHARE_WEEKTOP_HISTORY })
    Page<InviterUserShareWeekTopHistory> findInviterUserShareWeekTopHistorys(@Param("year") Integer year,
            @Param("month") Integer month, @Param("weekNumber") Integer weekNumber,
            @Param("revisionBatchCode") String revisionBatchCode, Integer start, Integer pageSize);

    /**
     * 获取修改次数
     * 
     * @param year
     *            年份
     * @param month
     *            月份
     * @param weekNumber
     *            周次
     * @param userName
     *            用户手机号码
     * @return 用户域服务异常
     */
    Integer getRevisionCount(@Param("year") Integer year, @Param("month") Integer month,
            @Param("weekNumber") Integer weekNumber, @Param("userName") String userName);

}