/**
 * 文件名称：OrderProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SecKillSaleProductInventoryMapper;
import com.yilidi.o2o.order.model.SecKillSaleProductInventory;
import com.yilidi.o2o.order.proxy.ISecKillSaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SecKillSaleProductInventoryProxyDto;
import com.yilidi.o2o.order.service.ISecKillSaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.SecKillSaleProductInventoryDto;

/**
 * 功能描述：秒杀商品库存代理服务实现类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("secKillSaleProductInventoryProxyService")
public class SecKillSaleProductInventoryProxyServiceImpl extends BaseService
        implements ISecKillSaleProductInventoryProxyService {

    @Autowired
    private SecKillSaleProductInventoryMapper secKillSaleProductInventoryMapper;
    @Autowired
    private ISecKillSaleProductInventoryService secKillSaleProductInventoryService;

    @Override
    public List<SecKillSaleProductInventoryProxyDto> listByActivityIdAndStoreIdAndSaleProductIds(Integer activityId,
            Integer storeId, List<Integer> saleProductIds) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIds) || ObjectUtils.isNullOrEmpty(activityId)) {
                return Collections.emptyList();
            }
            List<SecKillSaleProductInventoryDto> secKillSaleProductInventoryDtoList = secKillSaleProductInventoryService
                    .listByActivityIdAndStoreIdAndSaleProductIds(activityId, storeId, saleProductIds);
            List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryDtoList)) {
                secKillSaleProductInventoryProxyDtoList = new ArrayList<SecKillSaleProductInventoryProxyDto>();
                for (SecKillSaleProductInventoryDto secKillSaleProductInventory : secKillSaleProductInventoryDtoList) {
                    SecKillSaleProductInventoryProxyDto saleProductInventoryProxyDto = new SecKillSaleProductInventoryProxyDto();
                    ObjectUtils.fastCopy(secKillSaleProductInventory, saleProductInventoryProxyDto);
                    secKillSaleProductInventoryProxyDtoList.add(saleProductInventoryProxyDto);
                }
            }
            return secKillSaleProductInventoryProxyDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SecKillSaleProductInventoryProxyDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws OrderServiceException {
        try {
            SecKillSaleProductInventory secKillSaleProductInventory = secKillSaleProductInventoryMapper
                    .loadByActivityIdAndSaleProductIdForUpdate(activityId, saleProductId);
            SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto = null;
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventory)) {
                secKillSaleProductInventoryProxyDto = new SecKillSaleProductInventoryProxyDto();
                ObjectUtils.fastCopy(secKillSaleProductInventory, secKillSaleProductInventoryProxyDto);
            }
            return secKillSaleProductInventoryProxyDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveSecKillSaleProductInventory(Integer activityId,
            List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtos, Integer userId)
            throws OrderServiceException {
        try {
            if (null == activityId) {
                throw new OrderServiceException("活动不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryProxyDtos)) {
                throw new OrderServiceException("库存参数不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            Date nowTime = new Date();
            for (SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto : secKillSaleProductInventoryProxyDtos) {
                SecKillSaleProductInventory secKillSaleProductInventory = new SecKillSaleProductInventory();
                secKillSaleProductInventory.setActivityId(activityId);
                secKillSaleProductInventory.setStoreId(secKillSaleProductInventoryProxyDto.getStoreId());
                secKillSaleProductInventory.setSaleProductId(secKillSaleProductInventoryProxyDto.getSaleProductId());
                secKillSaleProductInventory.setRemainCount(secKillSaleProductInventoryProxyDto.getRemainCount());
                secKillSaleProductInventory.setCreateUserId(userId);
                secKillSaleProductInventory.setCreateTime(nowTime);
                SecKillSaleProductInventory secKillSaleProductInventoryTemp = secKillSaleProductInventoryMapper
                        .loadByActivityIdAndSaleProductId(secKillSaleProductInventoryProxyDto.getSaleProductId(),
                                activityId);
                if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryTemp)) {
                    secKillSaleProductInventoryMapper.deleteByActivityIdAndSaleProductId(
                            secKillSaleProductInventoryProxyDto.getSaleProductId(), activityId);
                }
                Integer effectCount = secKillSaleProductInventoryMapper.save(secKillSaleProductInventory);
                if (1 != effectCount) {
                    throw new OrderServiceException("初化秒杀商品库存失败");
                }
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }
}
