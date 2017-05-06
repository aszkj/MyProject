package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.query.StatisticsParamQuery;
import com.yilidi.o2o.order.model.result.ActivitySaleOrderItemCountInfo;
import com.yilidi.o2o.order.model.result.SaleDailyStatisticsInfo;

/**
 * 功能描述：订单明细数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleOrderItemMapper {

    /**
     * 保存订单明细
     * 
     * @param record
     *            订单明细
     * @return 影响行数
     */
    Integer save(SaleOrderItem record);

    /**
     * 更新订单明细中商品的采购价
     * 
     * @param id
     *            订单明细id
     * @param orderPrice
     *            采购价，单位厘
     * @param totalPrice
     *            总价，单位厘
     * @return 影响行数
     */
    Integer updateOrderPrice(@Param("id") Integer id, @Param("orderPrice") Long orderPrice,
            @Param("totalPrice") Long totalPrice);

    /**
     * 根据id查询订单明细
     * 
     * @param id
     *            订单明细id
     * @return 订单明细记录
     */
    SaleOrderItem loadById(Integer id);

    /**
     * 根据订单编号查询该订单的明细记录
     * 
     * @param saleOrderNo
     *            订单编号
     * @return 订单明细列表
     */
    List<SaleOrderItem> listBySaleOrderNo(String saleOrderNo);

    /**
     * 根据订单编号列表查询该订单的明细记录
     * 
     * @param saleOrderNos
     *            订单编号列表
     * @return 订单明细列表
     */
    List<SaleOrderItem> listBySaleOrderNos(@Param("saleOrderNos") List<String> saleOrderNos);

    /**
     * 根据订单编号列表查询该订单的图片
     * 
     * @param saleOrderNos
     *            订单编号列表
     * @return 订单明细列表
     */
    List<SaleOrderItem> listSaleOrderItemsBySaleOrderNos(@Param("saleOrderNos") List<String> saleOrderNos);

    /**
     * 根据下单日期获取商品的销量信息列表
     * 
     * @param startTakeTime
     *            开始收货时间
     * @param endTakeTime
     *            结束收货时间
     * @return 销量信息列表
     */
    List<SaleDailyStatisticsInfo> listSaleDailyStatistictsByTakeTime(@Param("startTakeTime") Date startTakeTime,
            @Param("endTakeTime") Date endTakeTime);

    /**
     * 获取活动下的商品购买数量
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @return 商品购买数量
     */
    ActivitySaleOrderItemCountInfo loadByActivityIdAndSaleProductId(@Param("activityId") Integer activityId,
            @Param("saleProductId") Integer saleProductId);

    /**
     * 根据用户ID,设备号,收货地址查找购买活动商品数量
     * 
     * @param deviceId
     *            设备编号
     * @param buyerCustomerId
     *            购买用户ID
     * @param addressDetail
     *            收货地址
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @return 购买商品总数量
     */
    Integer loadOrderCountByDeviceIdAndCustomerIdAndAddress(@Param("deviceId") String deviceId,
            @Param("buyerCustomerId") Integer buyerCustomerId, @Param("addressDetail") String addressDetail,
            @Param("activityId") Integer activityId, @Param("saleProductId") Integer saleProductId);

    /**
     * 订单销量
     * 
     * @param query
     * @return
     */
    Map<String, Object> getOrderStatistics(StatisticsParamQuery query);

    /**
     * 商品销量，分类销量，店铺销量
     * 
     * @param query
     * @return
     */
    List<SaleDailyStatisticsInfo> getProductStatistics(StatisticsParamQuery query);

    /**
     * 商品销量，分类销量，店铺销量汇总
     * 
     * @param query
     * @return
     */
    SaleDailyStatisticsInfo getProductStatisticsCount(StatisticsParamQuery query);

}