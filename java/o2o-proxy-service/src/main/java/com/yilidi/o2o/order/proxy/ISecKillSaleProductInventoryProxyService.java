/**
 * 文件名称：IProductProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.proxy.dto.SecKillSaleProductInventoryProxyDto;

/**
 * 功能描述：秒杀商品库存服务接口 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillSaleProductInventoryProxyService {
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
    List<SecKillSaleProductInventoryProxyDto> listByActivityIdAndStoreIdAndSaleProductIds(Integer activityId,
            Integer storeId, List<Integer> saleProductIds) throws OrderServiceException;

    /**
     * 根据店铺ID和商品ID查找库存信息
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @throws OrderServiceException
     *             交易域服务异常
     * @return 库存信息
     */
    SecKillSaleProductInventoryProxyDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws OrderServiceException;

    /**
     * 秒杀商品库存初始化数据
     * 
     * @param activityId
     *            活动ID
     * @param secKillSaleProductInventoryProxyDtos
     *            库存属性
     * @param userId
     *            用户ID
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void saveSecKillSaleProductInventory(Integer activityId,
            List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtos, Integer userId)
            throws OrderServiceException;
}
