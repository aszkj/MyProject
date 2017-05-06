package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.UserClientToken;

/**
 * 用户与APP客户端Token关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月5日 下午7:09:43
 */
public interface UserClientTokenMapper {

    /**
     * 新增用户与APP客户端Token关联关系
     * 
     * @param userClientToken
     * @return Integer
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    Integer save(UserClientToken userClientToken);

    /**
     * 更新用户与APP客户端Token关联关系
     * 
     * @param id
     * @param clientToken
     * @param deviceToken
     * @param platform
     * @return Integer
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    Integer update(@Param("id") Integer id, @Param("clientToken") String clientToken,
            @Param("deviceToken") String deviceToken, @Param("platform") String platform);

    /**
     * 根据用户ID获取用户与APP客户端Token关联关系
     * 
     * @param userId
     * @return UserClientToken
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    UserClientToken loadByUserId(@Param("userId") Integer userId);


    /**
     * 根据APP客户端clientToken查询当前存在的关联关系数据信息
     * 
     * @param clientToken
     * @return UserClientToken
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    UserClientToken loadByClientToken(@Param("clientToken") String clientToken);
    
    /**
     * 根据APP客户端deviceToken查询当前存在的关联关系数据信息
     * 
     * @param deviceToken
     * @return UserClientToken
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    UserClientToken loadByDeviceToken(@Param("deviceToken") String deviceToken);
    
    /**
     * 清除APP客户端与用户的关联关系数据信息
     * 
     * @param id
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_CLIENT_TOKEN })
    Integer delete(@Param("id") Integer id);
}
