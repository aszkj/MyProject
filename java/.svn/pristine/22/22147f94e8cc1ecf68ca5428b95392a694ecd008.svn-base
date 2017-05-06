package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.UserShareCode;

/**
 * 功能描述：用户分享码对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface UserShareCodeMapper {

    /**
     * 保存对象
     * 
     * <pre>
     * 	注：将更新用户分享码缓存
     * </pre>
     * 
     * @param userShareCode
     *            用户分享结果对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_SHARECODE })
    Integer save(UserShareCode userShareCode);

    /**
     * 根据id 加载用户分享码
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            ID
     * @return 用户分享结果对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_SHARECODE })
    UserShareCode loadById(Integer id);

    /**
     * 根据分享用户ID加载对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param shareUserId
     *            分享用户
     * @return 用户分享码信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_SHARECODE })
    UserShareCode loadByShareUserId(@Param("shareUserId") Integer shareUserId);

    /**
     * 根据分享码加载对象
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param shareCode
     *            用户分享码
     * @return 用户分享码信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_SHARECODE })
    UserShareCode loadByShareCode(@Param("shareCode") String shareCode);

    /**
     * 根据分享码和分享用户ID加载对象
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param shareCode
     *            用户分享码
     * @param shareUserId
     *            分享用户ID
     * @return 用户分享码信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_SHARECODE })
    UserShareCode loadByShareCodeAndUserId(@Param("shareCode") String shareCode, @Param("shareUserId") Integer shareUserId);

    /**
     * 查询所有分享码列表
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @return 用户分享码信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_SHARECODE })
    List<UserShareCode> listAll();
}