package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.UserProfile;

/**
 * 功能描述：用户属性数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface UserProfileMapper {
    /**
     * 保存用户属性数据
     * 
     * @param record
     *            待保存的用户属性对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_PROFILE })
    Integer save(UserProfile record);

    /**
     * 根据用户Id更新用户属性数据（如果字段值为null，将不会更新该字段）
     * 
     * @param record
     *            用户属性数据
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER_PROFILE })
    Integer updateByUserIdSelective(UserProfile record);

    /**
     * 根据用户Id查询用户属性
     * 
     * @param userId
     *            用户Id
     * @return 用户属性对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_PROFILE })
    UserProfile loadByUserId(Integer userId);

    /**
     * 根据用户ID修改用户头像
     * 
     * @param userId
     *            用户ID
     * @param avatarUrl
     *            用户头像url
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER_PROFILE })
    Integer updateUserAvatarByUserId(@Param("userId") Integer userId, @Param("avatarUrl") String avatarUrl);

}