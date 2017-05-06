package com.yilidi.o2o.user.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.ConnectUser;

/**
 * 功能描述：第三方接入用户对象操作DAO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ConnectUserMapper {

    /**
     * 保存第三方用户对象
     * 
     * <pre>
     * 	注：将更新UserSSL缓存
     * </pre>
     * 
     * @param connectUser
     *            第三方用户对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONNECT_USER })
    Integer save(ConnectUser connectUser);

    /**
     * 根据openId绑定用户ID
     * 
     * @param openId
     *            第三方接入平台返回的用户唯一标识
     * @param userId
     *            用户ID
     * @param modifyTime
     *            用户操作时间
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONNECT_USER })
    Integer updateBindUserIdByOpenId(@Param("openId") String openId, @Param("userId") Integer userId,
            @Param("modifyTime") Date modifyTime);

    /**
     * 根据unionId更新绑定用户ID(微信接入使用)
     * 
     * @param unionId
     *            第三方接入平台返回的标识
     * @param userId
     *            用户ID
     * @param modifyTime
     *            用户操作时间
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONNECT_USER })
    Integer updateBindUserIdByUnionId(@Param("unionId") String unionId, @Param("userId") Integer userId,
            @Param("modifyTime") Date modifyTime);

    /**
     * 根据openID 加载第三方用户对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param openId
     *            用户ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONNECT_USER })
    ConnectUser loadByOpenId(@Param("openId") String openId);

    /**
     * 根据openID 加载第三方用户对象
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param userId
     *            用户ID
     * @param connectType
     *            第三方接入类型
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONNECT_USER })
    ConnectUser loadByUserIdAndConnectType(@Param("userId") Integer userId, @Param("connectType") String connectType);

    /**
     * 根据用户ID 加载用户对象
     * 
     * <pre>
     *  注：将使用缓存查询
     * </pre>
     * 
     * @param userId
     *            用户ID
     * @param connectTypes
     *            连接类型
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONNECT_USER })
    List<ConnectUser> listByUserId(@Param("userId") Integer userId, @Param("connectTypes") List<String> connectTypes);

    /**
     * 根据unionid获取接入用户列表
     * 
     * @param unionId
     *            unionId
     * @return 接入用户信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONNECT_USER })
    List<ConnectUser> listByUnionId(@Param("unionId") String unionId);

    /**
     * 根据unionid和connectType获取接入用户信息
     * 
     * @param unionId
     * @param connectType
     * @return 接入用户信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONNECT_USER })
    ConnectUser loadByUnionIdAndConnectType(@Param("unionId") String unionId, @Param("connectType") String connectType);

}