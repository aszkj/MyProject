/**
 * 文件名称：ISaleOrderItemService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.SaleDailyStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.query.StatisticsParamQueryDto;

/**
 * 功能描述：订单明细服务类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleOrderItemService {

    /**
     * 保存订单明细
     * 
     * @param item
     *            订单明细对象
     * @return 影响行数
     * @throws OrderServiceException
     *             订单服务异常
     */
    Integer save(SaleOrderItemDto item) throws OrderServiceException;

    /**
     * 批量保存
     * 
     * @param items
     *            订单明细列表
     * @throws OrderServiceException
     *             订单服务异常
     */
    void saveBatch(List<SaleOrderItemDto> items) throws OrderServiceException;

    /**
     * 根据订单编号查询该订单的明细记录
     * 
     * @param saleOrderNo
     *            订单编号
     * @return 订单明细列表
     * @throws OrderServiceException
     *             订单服务异常
     */
    List<SaleOrderItemDto> listBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * 根据下单时间范围获取商品的销量信息列表
     * 
     * @param startTakeTime
     *            开始收货时间
     * @param endTakeTime
     *            结束收货时间
     * @return 商品销量信息列表
     * @throws OrderServiceException
     *             订单服务异常
     */
    List<SaleDailyStatisticsInfoDto> listSaleDailyStatistictsByTakeTime(Date startTakeTime, Date endTakeTime)
            throws OrderServiceException;

    /**
     * 订单销量
     * 
     * @param
     * @return
     */
    Map<String, Map<String, Object>> getOrderStatistics() throws OrderServiceException;

    /**
     * 商品销量，分类销量，店铺销量
     * 
     * @param query
     * @return
     */
    Map<String, List<SaleDailyStatisticsInfoDto>> getProductStatistics(StatisticsParamQueryDto query)
            throws OrderServiceException;
}
