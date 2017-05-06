/**
 * 文件名称：OrderService.java
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
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.SecKillSaleProductInventoryDto;

/**
 * 功能描述：秒杀商品库存<br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillSaleProductInventoryService {

    /**
     * 校验商品库存
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @param orderCount
     *            订购数量
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void validateRemainCount(Integer activityId, Integer saleProductId, Integer orderCount) throws OrderServiceException;

    /**
     * 批量增加秒杀商品库存记录
     * 
     * @param createOrderItemDtoList
     *            商品数量
     * @param currentTime
     *            操作时间
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void updateIncreaseRemainCountBatch(List<CreateOrderItemDto> createOrderItemDtoList, Date currentTime)
            throws OrderServiceException;

    /**
     * 批量减少秒杀商品库存记录
     * 
     * @param createOrderItemDtoList
     *            商品数量
     * @param currentTime
     *            操作时间
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void updateDecreaseRemainCountBatch(List<CreateOrderItemDto> createOrderItemDtoList, Date currentTime)
            throws OrderServiceException;

    /**
     * 批量查找商品库存信息
     * 
     * @param activityId
     *            活动ID
     * @param storeId
     *            店铺ID
     * @param saleProductIds
     *            商品ID列表
     * @throws OrderServiceException
     *             交易域服务异常
     * @return 库存列表
     */
    List<SecKillSaleProductInventoryDto> listByActivityIdAndStoreIdAndSaleProductIds(Integer activityId, Integer storeId,
            List<Integer> saleProductIds) throws OrderServiceException;

    /**
     * 批量查找商品库存信息
     * 
     * @param activityIdAndSaleProductIdMaps
     *            活动商品列表
     * @throws OrderServiceException
     *             交易域服务异常
     * @return 库存列表
     */
    List<SecKillSaleProductInventoryDto> listByActivityIdsAndSaleProductIds(
            List<Map<Integer, Integer>> activityIdAndSaleProductIdMaps) throws OrderServiceException;

    /**
     * 查找指定活动商品秒杀库存
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @return 秒杀商品库存信息
     * @throws OrderServiceException
     *             交易域服务异常
     */
    SecKillSaleProductInventoryDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws OrderServiceException;

}
