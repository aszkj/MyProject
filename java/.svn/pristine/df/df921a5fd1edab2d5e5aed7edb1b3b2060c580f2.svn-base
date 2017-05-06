package com.yilidi.o2o.product.proxy;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.proxy.dto.SecKillProductProxyDto;

/**
 * 功能描述：秒杀商品代理服务接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillProductProxyService {

    /**
     * 根据活动ID和商品ID获取秒杀商品信息
     * 
     * @param activityId
     *            活动ID
     * @param saleProductId
     *            商品ID
     * @return 秒杀商品信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillProductProxyDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws ProductServiceException;

    /**
     * 根据店铺ID和活动ID查找该店铺秒杀商品列表
     * 
     * @param actIdAndSaleProductIdMapList
     *            活动ID和商品ID map的列表
     * @return 店铺秒杀商品列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillProductProxyDto> listByActivityIdAndSaleProductIdMaps(
            List<Map<Integer, Integer>> actIdAndSaleProductIdMapList) throws ProductServiceException;
}