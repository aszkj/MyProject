/**
 * 文件名称：OrderProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SaleProductInventoryMapper;
import com.yilidi.o2o.order.model.SaleProductInventory;
import com.yilidi.o2o.order.proxy.ISaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SaleProductInventoryProxyDto;

/**
 * 功能描述：库存代理服务实现类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductInventoryProxyService")
public class SaleProductInventoryProxyServiceImpl extends BaseService implements ISaleProductInventoryProxyService {

    @Autowired
    private SaleProductInventoryMapper saleProductInventoryMapper;

    @Override
    public List<SaleProductInventoryProxyDto> listByStoreIdAndSaleProductIds(Integer storeId, List<Integer> saleProductIds)
            throws OrderServiceException {
        try {
            List<SaleProductInventory> saleProductInventoryList = saleProductInventoryMapper
                    .listByStoreIdAndSaleProductIds(storeId, saleProductIds);
            List<SaleProductInventoryProxyDto> saleProductInventoryProxyDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryList)) {
                saleProductInventoryProxyDtoList = new ArrayList<SaleProductInventoryProxyDto>();
                for (SaleProductInventory saleProductInventory : saleProductInventoryList) {
                    SaleProductInventoryProxyDto saleProductInventoryProxyDto = new SaleProductInventoryProxyDto();
                    ObjectUtils.fastCopy(saleProductInventory, saleProductInventoryProxyDto);
                    saleProductInventoryProxyDtoList.add(saleProductInventoryProxyDto);
                }
            }
            return saleProductInventoryProxyDtoList;
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SaleProductInventoryProxyDto loadByStoreIdAndSaleProductId(Integer storeId, Integer saleProductId)
            throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = saleProductInventoryMapper.loadByStoreIdAndSaleProductId(storeId,
                    saleProductId);
            SaleProductInventoryProxyDto saleProductInventoryProxyDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductInventory)) {
                saleProductInventoryProxyDto = new SaleProductInventoryProxyDto();
                ObjectUtils.fastCopy(saleProductInventory, saleProductInventoryProxyDto);
            }
            return saleProductInventoryProxyDto;
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveSaleProductInventory(Integer storeId, List<Integer> saleProductIds, Integer userId)
            throws OrderServiceException {
        try {
            if (null == storeId) {
                throw new OrderServiceException("店铺不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleProductIds)) {
                throw new OrderServiceException("商品不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            Date nowTime = new Date();
            for (Integer saleProductId : saleProductIds) {
                SaleProductInventory saleProductInventory = new SaleProductInventory();
                saleProductInventory.setStoreId(storeId);
                saleProductInventory.setSaleProductId(saleProductId);
                saleProductInventory.setOrderedCount(0);
                saleProductInventory.setRemainCount(0);
                saleProductInventory.setStandbyCount(0);
                saleProductInventory.setStoreStatus(SystemContext.OrderDomain.INVENTORYSTORESTATUS_TIGHT);
                saleProductInventory.setWarningFlag(SystemContext.OrderDomain.INVENTORYWARNINGFLAG_NO);
                saleProductInventory.setCreateUserId(userId);
                saleProductInventory.setCreateTime(nowTime);
                saleProductInventory.setModifyUserId(userId);
                saleProductInventory.setModifyTime(nowTime);
                Integer effectCount = saleProductInventoryMapper.save(saleProductInventory);
                if (1 != effectCount) {
                    throw new OrderServiceException("初化库存失败");
                }
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }

}
