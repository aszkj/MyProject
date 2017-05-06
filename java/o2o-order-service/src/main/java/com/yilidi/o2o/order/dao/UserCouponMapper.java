package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.UserCoupon;
import com.yilidi.o2o.order.model.query.UserCouponQuery;
import com.yilidi.o2o.order.model.result.UserCouponInfo;

/**
 * 用户优惠劵Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月19日 上午11:03:33
 */
public interface UserCouponMapper {

    /**
     * 新增保存
     * 
     * @param userCoupon
     *            实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_COUPON })
    Integer save(UserCoupon userCoupon);

    /**
     * 查询单个UserCoupon
     * 
     * @param id
     *            用户优惠劵ID
     * @return UserCoupon
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    UserCoupon loadUserCouponById(Integer id);

    /**
     * 查询单个UserCoupon
     * 
     * @param userId
     *            用户ID
     * @param conId
     *            优惠券ID
     * @return UserCoupon
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    UserCoupon loadUserCouponByUserIdAndConId(@Param("userId") Integer userId, @Param("conId") Integer conId);

    /**
     * 分页获取用户优惠劵使用记录列表
     * 
     * @param userCouponQuery
     *            查询条件
     * @return 分頁列表
     */
    Page<UserCouponInfo> findUserCoupons(UserCouponQuery userCouponQuery);

    /**
     * 根据活动ID、优惠券ID获取用户优惠券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param conId
     *            优惠券ID
     * @return UserCoupon
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    List<UserCoupon> listByActivityIdAndConId(@Param("activityId") Integer activityId, @Param("conId") Integer conId);

    /**
     * 根据活动ID、优惠券ID、用户ID、用户优惠劵状态获取用户优惠券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param conId
     *            优惠券ID
     * @param userId
     *            用户ID
     * @param statusList
     *            用户优惠劵状态列表
     * @return UserCoupon
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    List<UserCoupon> listByActivityIdAndConIdAndUserIdAndStatus(@Param("activityId") Integer activityId,
            @Param("conId") Integer conId, @Param("userId") Integer userId, @Param("statusList") List<String> statusList);

    /**
     * 获取需定时更新状态的优惠券列表
     * 
     * @param statusList
     *            用户优惠劵状态列表
     * @return List<UserCoupon>
     */
    List<UserCoupon> listCouponsForNeedAutoUpdateStatus(@Param("statusList") List<String> statusList);

    /**
     * 
     * 根据ID修改用户优惠劵的状态
     * 
     * @param id
     *            用户优惠劵ID
     * @param status
     *            状态
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_COUPON })
    Integer updateStatusById(@Param("id") Integer id, @Param("status") String status);

    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_COUPON })
    Integer updateUseCouponById(@Param("id") Integer id, @Param("status") String status, @Param("useTime") Date useTime);

    /**
     * 根据状态分页获取用户优惠劵列表(状态有效无效根据时间计算)
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param usedStatus
     *            优惠券使用状态编码
     * @param isValid
     *            是否有效
     * @return 分頁列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON, DBTablesName.Trade.T_COUPON,
            DBTablesName.Trade.T_COUPON_PACKAGE })
    Page<UserCouponInfo> findUserCouponsByRealTimeStatus(@Param("userId") Integer userId,
            @Param("currentTime") Date currentTime, @Param("usedStatus") String usedStatus,
            @Param("isValid") Boolean isValid);

    /**
     * 获取用户有效优惠券的总数量
     * 
     * @param userId
     *            用户ID
     * @param usedStatus
     *            优惠券使用状态编码
     * @param currentTime
     *            当前时间
     * @return 用户优惠券总数量
     */
    Integer getValidUserCouponCountByUserId(@Param("userId") Integer userId, @Param("usedStatus") String usedStatus,
            @Param("currentTime") Date currentTime);

    /**
     * 获取用户有效可用的优惠劵列表
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param usedStatus
     *            优惠券使用状态编码
     * @return 有效可用的优惠劵列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON, DBTablesName.Trade.T_COUPON,
            DBTablesName.Trade.T_COUPON_PACKAGE })
    List<UserCouponInfo> listValidAndUsebleUserCoupons(@Param("userId") Integer userId,
            @Param("currentTime") Date currentTime, @Param("usedStatus") String usedStatus);

    /**
     * 根据用户ID和用户优惠券ID获取优惠券信息
     * 
     * @param userId
     *            用户ID
     * @param userCouponId
     *            优惠券ID
     * @return 优惠劵信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON, DBTablesName.Trade.T_COUPON,
            DBTablesName.Trade.T_COUPON_PACKAGE })
    UserCouponInfo loadUserCouponByUserIdAndUserCouponId(@Param("userId") Integer userId,
            @Param("userCouponId") Integer userCouponId);

    /**
     * 根据优惠券id获取用户优惠券信息
     * 
     * @param id
     *            优惠券id
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    UserCoupon getUserCouponByCouponId(@Param("id") Integer id);

    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_COUPON })
    List<UserCoupon> getUserCouponByConPackIdAndBatchNo(@Param("conPackId") Integer conPackId,
            @Param("batchNo") String batchNo);

}
