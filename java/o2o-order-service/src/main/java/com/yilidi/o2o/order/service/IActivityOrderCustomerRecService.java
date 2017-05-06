package com.yilidi.o2o.order.service;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.service.dto.ActivityOrderCustomerRecDto;

/**
 * 
 * 首单信息业务接口
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午2:13:58
 * 
 */
public interface IActivityOrderCustomerRecService {

    /**
     * 根据客户ID,活动ID,设备ID,商品ID和收货地址获取活动订单记录总数量
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
     * @return 总购买数量
     */
    Integer loadSaleProductOrderCountByActivityIdAndSaleProductId(@Param("activityId") Integer activityId,
            @Param("saleProductId") Integer saleProductId);

}
