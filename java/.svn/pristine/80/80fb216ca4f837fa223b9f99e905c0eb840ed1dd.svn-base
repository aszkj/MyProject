package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.InvitedUserShareRecord;

/**
 * 功能描述：被邀请用户分享记录对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InvitedUserShareRecordMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新被邀请用户分享记录缓存
     * </pre>
     * 
     * @param userShareResult
     *            被邀请用户分享记录对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_RECORD })
    Integer save(InvitedUserShareRecord userShareResult);

    /**
     * 根据被邀请用户分享记录ID 加载被邀请用户分享记录对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            被邀请用户分享记录ID
     * @return 被邀请用户分享记录对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_RECORD })
    InvitedUserShareRecord loadById(Integer id);

    /**
     * 根据用户分享码和分享规则加载分享记录
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
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_RECORD })
    InvitedUserShareRecord loadByShareCodeAndShareRuleId(@Param("shareCode") String shareCode,
            @Param("shareRuleId") Integer shareRuleId);

    /**
     * 根据参加用户ID和分享规则加载分享记录
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
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_INVITEDUSER_SHARE_RECORD })
    InvitedUserShareRecord loadByInvitedUserIdAndShareRuleId(@Param("invitedUserId") Integer invitedUserId,
            @Param("shareRuleId") Integer shareRuleId);

}