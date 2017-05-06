package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.Coupon;
import com.yilidi.o2o.order.model.query.CouponQuery;
import com.yilidi.o2o.order.model.result.CouponInfo;

/**
 * 优惠劵Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月19日 上午11:00:26
 */
public interface CouponMapper {

    /**
     * 新增保存
     * 
     * @param coupon
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_COUPON })
    Integer save(Coupon coupon);

    /**
     * 查询单张优惠券
     * 
     * @param id
     *            优惠券ID
     * @return Coupon
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON })
    Coupon loadCouponById(Integer id);

    /**
     * 获取抢红包活动所需的优惠券列表
     * 
     * @param grantWay
     *            发放方式
     * @param activityStartDate
     *            抢红包活动开始有效时间
     * @param customerType
     *            客户类型编码
     * @param buyerUserType
     *            买家用户类型标示编码
     * @return List<Coupon>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON })
    List<Coupon> listCouponsForRedEnvelopeActivity(@Param("grantWay") String grantWay,
            @Param("conPackId") Integer conPackId, @Param("customerType") String customerType,
            @Param("buyerUserType") String buyerUserType);

    /**
     * 根据分享规则的活动时间获取有效可用的优惠券分组信息列表
     * 
     * @param startTime
     *            分享规则活动开始时间
     * @param endTime
     *            分享规则结束时间
     * @param buyerUserType
     *            买家用户类型标识码:新用户注册
     * @param grantWay
     *            发放方式:分享有礼 编码
     * @return 优惠券金额分组信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON })
    List<Coupon> listCouponsForShareRule(@Param("conPackId") Integer conPackId);
    /**
     * 通过发放方式查优惠券
     * @param grantway 发放方式
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON })
    List<Coupon> getCouponByGrantWay(@Param("grantWay") String grantWay);

    /**
     * 加载优惠券发放记录
     * @param couponQuery
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON })
	Page<CouponInfo> findGrantRecord(CouponQuery couponQuery);

	CouponInfo getCouponGrantRecord(@Param("conPackId")Integer conPackId, @Param("batchNo")String batchNo);

	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON})
	List<Coupon> getCouponByPackIdBatchNoGrantWay(@Param("conPackId")Integer conPackId, @Param("batchNo")String batchNo, @Param("grantWay")String grantWay);
	
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON})
	List<Coupon> getValidRegistUseCouponActive(@Param("nowTime")Date nowTime);

	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON})
	Page<CouponInfo> findCouponByGrantWay(CouponQuery couponQuery);
	
}
