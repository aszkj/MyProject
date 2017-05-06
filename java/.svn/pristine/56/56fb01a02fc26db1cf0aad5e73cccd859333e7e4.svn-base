/**
 * 文件名称：OrderService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;

/**
 * 功能描述：订单历史状态服务<br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleOrderHistoryService {

    /**
     * 创建订单时修改库存记录和插入库存变更记录
     * 
     * @param saleProductId
     *            商品ID
     * @param orderCount
     *            订购数量
     * @param orderNo
     *            订单号
     * @param userId
     *            用户ID
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void updateOrderedCount(Integer saleProductId, Integer orderCount, String orderNo, Integer userId)
            throws OrderServiceException;

    /**
     * 校验商品库存
     * 
     * @param createOrderItemDtos
     *            商品数量列表
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void validateSaleProductInventory(List<CreateOrderItemDto> createOrderItemDtos) throws OrderServiceException;
}
