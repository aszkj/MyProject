package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SecKillSaleProductInventoryMapper;
import com.yilidi.o2o.order.model.SecKillSaleProductInventory;
import com.yilidi.o2o.order.service.ISecKillSaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.SecKillSaleProductInventoryDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 
 * 秒杀库存服务实现类
 * 
 * @author: chenb
 * @date: 2015年11月5日 下午2:31:39
 * 
 */
@Service("secKillSaleProductInventoryService")
public class SecKillSaleProductInventoryServiceImpl extends BasicDataService implements ISecKillSaleProductInventoryService {

    @Autowired
    private SecKillSaleProductInventoryMapper secKillSaleProductInventoryMapper;
    @Autowired
    private IProductProxyService productProxyService;

    private String makeSaleProductTips(Integer saleProductId) {
        SaleProductProxyDto saleProductProxyDto = productProxyService.loadById(saleProductId);
        StringBuilder tipsBuilder = new StringBuilder();
        if (!ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
            tipsBuilder.append("商品 ").append(CommonConstants.DELIMITER_SPACE)
                    .append(saleProductProxyDto.getSaleProductName());
        }
        return tipsBuilder.toString();
    }

    @Override
    public void updateIncreaseRemainCountBatch(List<CreateOrderItemDto> createOrderItemDtoList, Date currentTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(createOrderItemDtoList)) {
                throw new OrderServiceException("秒杀商品不能为空");
            }
            Map<Integer, CreateOrderItemDto> sortedMap = new TreeMap<Integer, CreateOrderItemDto>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtoList) {
                if (ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())
                        || createOrderItemDto.getActId().intValue() <= 0) {
                    continue;
                }
                sortedMap.put(createOrderItemDto.getSaleProductId(), createOrderItemDto);
            }
            if (ObjectUtils.isNullOrEmpty(sortedMap)) {
                return;
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存订购数量
                CreateOrderItemDto createOrderItemDto = sortedMap.get(saleProductId);
                updateRemainCount(createOrderItemDto.getActId(), saleProductId, createOrderItemDto.getCartNum(),
                        currentTime);

            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void validateRemainCount(Integer activityId, Integer saleProductId, Integer orderCount)
            throws OrderServiceException {
        try {
            SecKillSaleProductInventory secKillSaleProductInventory = secKillSaleProductInventoryMapper
                    .loadByActivityIdAndSaleProductIdForUpdate(saleProductId, activityId);
            if (ObjectUtils.isNullOrEmpty(secKillSaleProductInventory) || secKillSaleProductInventory
                    .getRemainCount() < secKillSaleProductInventory.getRemainCount() + orderCount) {
                throw new OrderServiceException("秒杀商品[" + makeSaleProductTips(saleProductId) + "]库存不足");
            }
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    private void updateRemainCount(Integer activityId, Integer saleProductId, Integer delta, Date currentTime) {
        try {
            Integer effectCount = secKillSaleProductInventoryMapper
                    .updateRemainCountBySaleProductIdAndActivityId(saleProductId, activityId, delta);
            if (1 != effectCount) {
                throw new OrderServiceException("更新秒杀商品[" + makeSaleProductTips(saleProductId) + "]库存失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateDecreaseRemainCountBatch(List<CreateOrderItemDto> createOrderItemDtoList, Date currentTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(createOrderItemDtoList)) {
                throw new OrderServiceException("秒杀商品不能为空");
            }
            Map<Integer, CreateOrderItemDto> sortedMap = new TreeMap<Integer, CreateOrderItemDto>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtoList) {
                if (ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())
                        || createOrderItemDto.getActId().intValue() <= 0) {
                    continue;
                }
                sortedMap.put(createOrderItemDto.getSaleProductId(), createOrderItemDto);
            }
            if (ObjectUtils.isNullOrEmpty(sortedMap)) {
                return;
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存订购数量
                CreateOrderItemDto createOrderItemDto = sortedMap.get(saleProductId);
                updateRemainCount(createOrderItemDto.getActId(), saleProductId, -createOrderItemDto.getCartNum(),
                        currentTime);

            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSaleProductInventoryDto> listByActivityIdAndStoreIdAndSaleProductIds(Integer activityId,
            Integer storeId, List<Integer> saleProductIds) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIds) || ObjectUtils.isNullOrEmpty(activityId)) {
                return Collections.emptyList();
            }
            List<SecKillSaleProductInventory> secKillSaleProductInventoryList = secKillSaleProductInventoryMapper
                    .listByActivityIdAndStoreIdAndSaleProductIds(activityId, storeId, saleProductIds);
            List<SecKillSaleProductInventoryDto> secKillSaleProductInventoryDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryList)) {
                secKillSaleProductInventoryDtoList = new ArrayList<SecKillSaleProductInventoryDto>();
                for (SecKillSaleProductInventory secKillSaleProductInventory : secKillSaleProductInventoryList) {
                    SecKillSaleProductInventoryDto saleProductInventoryDto = new SecKillSaleProductInventoryDto();
                    ObjectUtils.fastCopy(secKillSaleProductInventory, saleProductInventoryDto);
                    secKillSaleProductInventoryDtoList.add(saleProductInventoryDto);
                }
            }
            return secKillSaleProductInventoryDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSaleProductInventoryDto> listByActivityIdsAndSaleProductIds(
            List<Map<Integer, Integer>> activityIdAndSaleProductIdMaps) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(activityIdAndSaleProductIdMaps)) {
                return Collections.emptyList();
            }
            List<SecKillSaleProductInventoryDto> secKillSaleProductInventoryDtos = new ArrayList<SecKillSaleProductInventoryDto>();
            for (Map<Integer, Integer> activityIdAndSaleProductMap : activityIdAndSaleProductIdMaps) {
                for (Integer activityId : activityIdAndSaleProductMap.keySet()) {
                    SecKillSaleProductInventory secKillSaleProductInventory = secKillSaleProductInventoryMapper
                            .loadByActivityIdAndSaleProductId(activityId, activityIdAndSaleProductMap.get(activityId));
                    if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventory)) {
                        SecKillSaleProductInventoryDto secKillSaleProductInventoryDto = new SecKillSaleProductInventoryDto();
                        ObjectUtils.fastCopy(secKillSaleProductInventory, secKillSaleProductInventoryDto);
                        secKillSaleProductInventoryDtos.add(secKillSaleProductInventoryDto);
                    }
                }
            }
            return secKillSaleProductInventoryDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SecKillSaleProductInventoryDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductId) || ObjectUtils.isNullOrEmpty(activityId)) {
                return null;
            }
            SecKillSaleProductInventory secKillSaleProductInventory = secKillSaleProductInventoryMapper
                    .loadByActivityIdAndSaleProductId(activityId, saleProductId);
            SecKillSaleProductInventoryDto secKillSaleProductInventoryDto = null;
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventory)) {
                secKillSaleProductInventoryDto = new SecKillSaleProductInventoryDto();
                ObjectUtils.fastCopy(secKillSaleProductInventory, secKillSaleProductInventoryDto);
            }
            return secKillSaleProductInventoryDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }
}
