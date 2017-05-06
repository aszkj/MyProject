/**
 * 文件名称：OrderProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.IShopCartProxyService;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;
import com.yilidi.o2o.order.service.IShopCartService;
import com.yilidi.o2o.order.service.dto.query.ShopCartQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("shopCartProxyService")
public class ShopCartProxyService extends BaseService implements IShopCartProxyService {

    @Autowired
    private IShopCartService shopCartService;

    @Override
    public void synchronousCart(Integer userId, List<ShopCartProxyDto> shopCartProxyDtoList) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartProxyDtoList)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return;
            }
            Integer storeId = null;
            List<ShopCartQuery> shopCartQueryList = new ArrayList<ShopCartQuery>();
            for (ShopCartProxyDto shopCartProxyDto : shopCartProxyDtoList) {
                if (ObjectUtils.isNullOrEmpty(shopCartProxyDto.getQuantity())) {
                    throw new OrderServiceException("购物车商品数量不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shopCartProxyDto.getSaleProductId())) {
                    throw new OrderServiceException("购物车商品ID不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shopCartProxyDto.getStoreId())) {
                    throw new OrderServiceException("购物车店铺ID不能为空");
                }
                storeId = shopCartProxyDto.getStoreId();
                if (shopCartProxyDto.getStoreId().intValue() != storeId) {
                    throw new OrderServiceException("存在不一样的店铺");
                }
                ShopCartQuery shopCartQuery = new ShopCartQuery();
                shopCartQuery.setStoreId(storeId);
                shopCartQuery.setUserId(userId);
                shopCartQuery.setQuantity(shopCartProxyDto.getQuantity());
                shopCartQuery.setActivityId(shopCartProxyDto.getActivityId());
                shopCartQuery.setSaleProductId(shopCartProxyDto.getSaleProductId());
                shopCartQueryList.add(shopCartQuery);
            }
            shopCartService.updateSynchronousCart(shopCartQueryList, storeId, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
