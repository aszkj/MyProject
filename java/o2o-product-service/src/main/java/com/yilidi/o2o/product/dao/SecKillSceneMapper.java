package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SecKillScene;
import com.yilidi.o2o.product.model.query.SecKillSceneQuery;

/**
 * 功能描述：场次基础信息数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SecKillSceneMapper {

    /**
     * 保存场次基础信息
     * 
     * @param record
     *            场次基础信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Integer save(SecKillScene record);

    /**
     * 根据ID删除场次基础信息
     * 
     * @param id
     *            场次ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Integer deleteById(@Param("id") Integer id);

    /**
     * 修改场次信息
     * 
     * @param secKillScene
     *            场次信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Integer updateSelective(SecKillScene secKillScene);

    /**
     * 修改场次状态
     * 
     * @param id
     *            场次ID
     * @param statusCode
     *            场次状态
     * @param updateUserId
     *            修改用户ID
     * @param updateTime
     *            修改时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Integer updateStatusCodeById(@Param("id") Integer id, @Param("statusCode") String statusCode,
            @Param("updateUserId") Integer updateUserId, @Param("updateTime") Date updateTime);

    /**
     * 修改开始时间小于指定时间为已结束状态
     * 
     * @param startTime
     *            开始时间
     * @param statusCode
     *            场次状态
     * @param updateUserId
     *            修改用户ID
     * @param updateTime
     *            修改时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Integer updateStatusCodeForExpiredByStartTime(@Param("startTime") Date startTime, @Param("statusCode") String statusCode,
            @Param("updateUserId") Integer updateUserId, @Param("updateTime") Date updateTime);

    /**
     * 根据场次ID获取场次信息
     * 
     * @param id
     *            场次ID
     * @return 场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    SecKillScene loadById(@Param("id") Integer id);

    /**
     * 根据活动ID获取场次信息
     * 
     * @param activityId
     *            活动ID
     * @return 场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    SecKillScene loadByActivityId(@Param("activityId") Integer activityId);

    /**
     * 根据当前时间获取正在进行的秒杀活动信息
     * 
     * @param currentTime
     *            当前时间
     * @return 场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    SecKillScene loadStartingSecKillSceneByCurrentTime(@Param("currentTime") Date currentTime);

    /**
     * 根据当前时间获取下一场次即将进行的秒杀活动信息
     * 
     * @param currentTime
     *            当前时间
     * @return 场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    SecKillScene loadNextSecKillSceneByCurrentTime(@Param("currentTime") Date currentTime);

    /**
     * 获取开始时间小于当前时间的场次信息列表
     * 
     * @param currentTime
     *            当前时间
     * @param limit
     *            限制条数
     * @return 场次信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    List<SecKillScene> listBeforeOrEqualsByCurrentTime(@Param("currentTime") Date currentTime,
            @Param("limit") Integer limit);

    /**
     * 获取重复的场次信息列表
     * 
     * @param beginStartTime
     *            开始时间
     * @param endStartTime
     *            结束时间
     * @param repeatType
     *            场次重复类型编码
     * @return 场次列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    List<SecKillScene> listSecKillSceneForRepeatByStartTime(@Param("beginStartTime") Date beginStartTime,
            @Param("endStartTime") Date endStartTime, @Param("repeatType") String repeatType);

    /**
     * 获取开始时间即将开始的当前时间的场次信息列表
     * 
     * @param currentTime
     *            当前时间
     * @param limit
     *            限制条数
     * @return 场次信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    List<SecKillScene> listAfterByCurrentTime(@Param("currentTime") Date currentTime, @Param("limit") Integer limit);

    /**
     * 根据场次开始时间获取场次信息
     * 
     * @param beginStartTime
     *            开始-开始时间
     * @param endStartTime
     *            结束-开始时间
     * @return 场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    List<SecKillScene> listByStartTime(@Param("beginStartTime") Date beginStartTime,
            @Param("endStartTime") Date endStartTime);

    /**
     * 查询场次分页信息列表
     * 
     * @param secKillSceneQuery
     *            场次查询条件
     * @return 场次分页信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE })
    Page<SecKillScene> findSecKillScenes(SecKillSceneQuery secKillSceneQuery);

    /**
     * 查询秒杀商品关联的场次列表
     * 
     * @param secKillSceneQuery
     *            场次查询条件
     * @return 场次分页信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE,
            DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Page<SecKillScene> findSecKillProductRelationScenes(SecKillSceneQuery secKillSceneQuery);
}