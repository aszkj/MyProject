package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.CouponPackage;
import com.yilidi.o2o.order.model.query.CouponPackageQuery;

/**
 * 优惠券包Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月19日 上午10:43:48
 */
public interface CouponPackageMapper {

    /**
     * 新增保存
     * 
     * @param couponPackage
     *            优惠劵包实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_COUPON_PACKAGE })
    Integer save(CouponPackage couponPackage);

    /**
     * 更新
     * 
     * @param couponPackage
     *            优惠劵包实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_COUPON_PACKAGE })
    Integer update(CouponPackage couponPackage);

    /**
     * 根据ID查询优惠劵包信息
     * 
     * @param id
     *            优惠劵包ID
     * @return CouponPackage
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON_PACKAGE })
    CouponPackage loadById(Integer id);

    /**
     * 
     * 根据ID修改优惠劵包的状态，
     * 
     * @param id
     *            优惠劵包ID
     * @param state
     *            状态
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_COUPON_PACKAGE })
    Integer updateStateById(@Param("id") Integer id, @Param("state") String state,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 
     * 查询列表
     * 
     * @param couponPackageQuery
     *            查询条件
     * @return 分頁列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_COUPON_PACKAGE })
    Page<CouponPackage> findCouponPackages(CouponPackageQuery couponPackageQuery);

	List<CouponPackage> listAvailableCouponPackage(@Param("grantWay") String grantWay);
}
