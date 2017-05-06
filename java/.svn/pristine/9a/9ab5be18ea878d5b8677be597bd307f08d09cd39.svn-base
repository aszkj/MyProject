package com.yilidi.o2o.order.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.ActivityOrderCustomerRec;

/**
 * 
 * 活动订单记录信息数据层操作接口类
 * 
 * @author: chenb
 * @date: 2015年11月6日 下午2:49:52
 * 
 */
public interface ActivityOrderCustomerRecMapper {
    /**
     * 新增保存
     * 
     * @param activityOrderCustomerRec
     *            活动订单记录信息实体
     * @return 影响行数
     */
    Integer save(ActivityOrderCustomerRec activityOrderCustomerRec);

    /**
     * 根据客户ID,活动ID,设备ID,商品ID和收货地址获取活动订单记录信息
     * 
     * @param buyerCustomerId
     *            买家客户ID
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @param deviceId
     *            设备ID
     * @param addressDetail
     *            收货地址
     * @return ActivityOrderCustomerRec
     */
    Integer loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(@Param("buyerCustomerId") Integer buyerCustomerId,
            @Param("activityId") Integer activityId, @Param("saleProductId") Integer saleProductId,
            @Param("deviceId") String deviceId, @Param("addressDetail") String addressDetail);

    /**
     * 获取活动商品的总购买数量
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @param status
     *            秒杀订单记录状态
     * @return 总购买数量
     */
    Integer loadSaleProductOrderCountByActivityIdAndSaleProductId(@Param("activityId") Integer activityId,
            @Param("saleProductId") Integer saleProductId, @Param("status") String status);

    /**
     * 更新用户购买数量
     * 
     * @param saleOrderNo
     *            订单编号
     * @param status
     *            活动订单记录状态
     * @return 影响行数
     */
    Integer updateStatusBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("status") String status);
}
