package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SaleProductInventoryHistoryMapper;
import com.yilidi.o2o.order.dao.SaleProductInventoryMapper;
import com.yilidi.o2o.order.model.SaleProductInventory;
import com.yilidi.o2o.order.model.SaleProductInventoryHistory;
import com.yilidi.o2o.order.model.query.SaleProductInventoryQuery;
import com.yilidi.o2o.order.model.result.SimpleSaleProductInventory;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.AcceptOrderItemDto;
import com.yilidi.o2o.order.service.dto.CancelOrderItemDto;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.SendOrderItemDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderItemDto;
import com.yilidi.o2o.order.service.dto.StoreTotalPrice;
import com.yilidi.o2o.order.service.dto.query.SaleProductInventoryQueryDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;

/**
 * 
 * 库存服务实现类
 * 
 * @author: chenb
 * @date: 2015年11月5日 下午2:31:39
 * 
 */
@Service("saleProductInventoryService")
public class SaleProductInventoryServiceImpl extends BasicDataService implements ISaleProductInventoryService {

    @Autowired
    private SaleProductInventoryMapper productInventoryMapper;
    @Autowired
    private SaleProductInventoryHistoryMapper productInventoryHistoryMapper;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IMessageProxyService messageProxyService;

    private String makeSaleProductTips(Integer saleProductId) {
        SaleProductProxyDto saleProductProxyDto = productProxyService.loadById(saleProductId);
        StringBuilder tipsBuilder = new StringBuilder();
        if (!ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
            tipsBuilder.append("商品 ").append(CommonConstants.DELIMITER_SPACE)
                    .append(saleProductProxyDto.getSaleProductName());
        }
        return tipsBuilder.toString();
    }

    private void updateOrderedCount(Integer saleProductId, Integer orderCount, String orderNo, Integer userId,
            Date currentTime) {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory)
                    || saleProductInventory.getRemainCount() < saleProductInventory.getOrderedCount() + orderCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "库存不足");
            }
            Integer effectCount = productInventoryMapper.updateOrderedCountBySaleProductId(saleProductId, orderCount, userId,
                    currentTime);
            if (1 != effectCount) {
                throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(orderCount);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_CREATEORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(currentTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount() + orderCount);
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateOrderedCountBatch(List<KeyValuePair<Integer, Integer>> pairs, String orderNo, Integer userId,
            Date currentTime) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(pairs)) {
                throw new OrderServiceException("没有更改的商品");
            }
            if (ObjectUtils.isNullOrEmpty(orderNo)) {
                throw new OrderServiceException("订单号不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存订购数量
                updateOrderedCount(saleProductId, sortedMap.get(saleProductId), orderNo, userId, currentTime);

            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void validateRemainCount(Integer saleProductId, Integer orderCount) throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory)
                    || saleProductInventory.getRemainCount() < saleProductInventory.getOrderedCount() + orderCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "库存不足");
            }
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    private void updateStandbyCountForSellerAccept(Integer saleProductId, Integer standbyCount, String orderNo,
            Integer userId, Date operateTime) throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory)
                    || saleProductInventory.getOrderedCount() < saleProductInventory.getStandbyCount() + standbyCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法进行接单操作");
            }
            int result = productInventoryMapper.updateStandbyCountForAccept(saleProductId, standbyCount, userId,
                    operateTime);
            if (result != 1) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法进行接单操作");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(standbyCount);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_ACCEPTORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(operateTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount() + standbyCount);
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            Integer effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private void updateStandbyCountForSendCancel(Integer saleProductId, Integer standbyCount, String orderNo, Integer userId,
            Date operateTime) throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory)
                    || saleProductInventory.getOrderedCount() < saleProductInventory.getStandbyCount() - standbyCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法取消订单操作");
            }
            int result = productInventoryMapper.updateOrderCountAndStandbyCountForAcceptCancel(saleProductId, standbyCount,
                    userId, operateTime);
            if (result != 1) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法取消单操作");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(standbyCount);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_ACCEPTORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(operateTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount() - standbyCount);
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount() - standbyCount);
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            Integer effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForSellerAccept(List<KeyValuePair<Integer, Integer>> pairs, String orderNo, Integer userId,
            Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存待发货数量
                updateStandbyCountForSellerAccept(saleProductId, sortedMap.get(saleProductId), orderNo, userId, operateTime);
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新库存待发货数量出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    private void updateOrderedCountForSellerCancel(Integer saleProductId, Integer returnCount, String orderNo,
            Integer userId, Date operateTime) throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory) || saleProductInventory.getOrderedCount() < returnCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法进行取消操作");
            }
            int result = productInventoryMapper.updateOrderedCountForCancel(saleProductId, returnCount, userId, operateTime);
            if (result <= 0) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "订购数量不足，无法进行取消操作");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(returnCount);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_CANCELORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(operateTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount() - returnCount);
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            Integer effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForSellerCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer cancelUserId, Date cancelTime) throws OrderServiceException {
        try {
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存订购数量
                updateOrderedCountForSellerCancel(saleProductId, sortedMap.get(saleProductId), saleOrderNo, cancelUserId,
                        cancelTime);
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新库存订购数量出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    private void updateAllCountForSellerSend(Integer saleProductId, Integer sendCount, String orderNo, Integer userId,
            Date operateTime) throws OrderServiceException {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductInventory)) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "无库存，无法进行发货操作");
            }
            if (saleProductInventory.getRemainCount() < sendCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "库存不足，无法进行发货操作");
            }
            if (saleProductInventory.getStandbyCount() < sendCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "待发货数量不足，无法进行发货操作");
            }
            if (saleProductInventory.getOrderedCount() < sendCount) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "已订购数量不足，无法进行发货操作");
            }
            int result = productInventoryMapper.updateAllCountForSend(saleProductId, sendCount, userId, operateTime);
            if (result <= 0) {
                throw new OrderServiceException(makeSaleProductTips(saleProductId) + "库存不足，无法进行发货操作");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(sendCount);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_SENDORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(operateTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount() - sendCount);
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount() - sendCount);
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount() - sendCount);
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            Integer effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
            // 发送修改商品冗余库存消息
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
            keyValuePair.setKey(saleProductId);
            keyValuePair.setValue(-sendCount);
            saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForSellerSend(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer sendUserId, Date sendTime) throws OrderServiceException {
        try {
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存数量、待发货数量、已订购数量
                updateAllCountForSellerSend(saleProductId, sortedMap.get(saleProductId), saleOrderNo, sendUserId, sendTime);
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新库存数量、待发货数量、已订购数量出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void updateInventoryForSendCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer sendUserId, Date sendTime) throws OrderServiceException {
        try {
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                updateStandbyCountForSendCancel(saleProductId, sortedMap.get(saleProductId), saleOrderNo, sendUserId,
                        sendTime);
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新库待发货数量出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    private void updateRemainCount(Integer saleProductId, Integer delta, String orderNo, Integer userId, Date currentTime) {
        try {
            SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                    saleProductId);
            Integer effectCount = productInventoryMapper.updateRemainCountById(saleProductInventory.getId(), delta, userId,
                    currentTime);
            if (1 != effectCount) {
                throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
            }
            SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
            saleProductInventoryHistory.setDelta(delta);
            saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_CANCELORDER);
            saleProductInventoryHistory.setRelativeNo(orderNo);
            saleProductInventoryHistory.setOperateTime(currentTime);
            saleProductInventoryHistory.setOperateUserId(userId);
            saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
            saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
            saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
            saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount() + delta);
            saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
            saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
            effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
            }
            // 发送修改商品冗余库存消息
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
            keyValuePair.setKey(saleProductId);
            keyValuePair.setValue(delta);
            saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForReceiveCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer cancelUserId, Date cancelTime) throws OrderServiceException {
        try {
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> pair : pairs) {
                sortedMap.put(pair.getKey(), pair.getValue());
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新库存数量
                updateRemainCount(saleProductId, sortedMap.get(saleProductId), saleOrderNo, cancelUserId, cancelTime);
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新库存数量出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void updateInventoryForFlittingCreate(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, FlittingOrderItemDto> sortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtoList) {
                sortedMap.put(flittingOrderItemDto.getSrcSaleProductId(), flittingOrderItemDto);
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = sortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateOrderedCountBySaleProductId(saleProductId,
                        flittingOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_CREATEFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory
                        .setPreOrderedCount(saleProductInventory.getOrderedCount() - flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
            }
        } catch (Exception e) {
            logger.error("updateInventoryForFlittingCreate异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForFlittingAccept(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, FlittingOrderItemDto> sortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtoList) {
                sortedMap.put(flittingOrderItemDto.getSrcSaleProductId(), flittingOrderItemDto);
            }
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = sortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateStandbyCountForAccept(saleProductId,
                        flittingOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_ACCEPTFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory
                        .setPreStandbyCount(saleProductInventory.getStandbyCount() - flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
            }
        } catch (Exception e) {
            logger.error("updateInventoryForFlittingAccept异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForFlittingAcceptReject(List<FlittingOrderItemDto> flittingOrderItemDtoList,
            String flittingOrderNo, Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, FlittingOrderItemDto> sortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtoList) {
                sortedMap.put(flittingOrderItemDto.getSrcSaleProductId(), flittingOrderItemDto);
            }
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = sortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateOrderedCountForCancel(saleProductId,
                        flittingOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_CANCELFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory
                        .setPreOrderedCount(saleProductInventory.getOrderedCount() + flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(flittingOrderItemDto.getQuantity());
                saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            // 发送修改商品冗余库存消息
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, operateUserId);
        } catch (Exception e) {
            logger.error("updateInventoryForFlittingAcceptReject异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForFlittingSend(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, FlittingOrderItemDto> sortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtoList) {
                sortedMap.put(flittingOrderItemDto.getSrcSaleProductId(), flittingOrderItemDto);
            }
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (Integer saleProductId : sortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = sortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateAllCountForSend(saleProductId,
                        flittingOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_SENDFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory
                        .setPreOrderedCount(saleProductInventory.getOrderedCount() + flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory
                        .setPreRemainCount(saleProductInventory.getRemainCount() + flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory
                        .setPreStandbyCount(saleProductInventory.getStandbyCount() + flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(-flittingOrderItemDto.getQuantity());
                saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            // 发送修改商品冗余库存消息
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, operateUserId);
        } catch (Exception e) {
            logger.error("updateInventoryForFlittingSend异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForFlittingFinish(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, FlittingOrderItemDto> srcSortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            Map<Integer, FlittingOrderItemDto> destSortedMap = new TreeMap<Integer, FlittingOrderItemDto>();
            for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtoList) {
                srcSortedMap.put(flittingOrderItemDto.getSrcSaleProductId(), flittingOrderItemDto);
                destSortedMap.put(flittingOrderItemDto.getDestSaleProductId(), flittingOrderItemDto);
            }
            List<KeyValuePair<Integer, Integer>> srcSaleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (Integer saleProductId : srcSortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = srcSortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateRemainCountBySaleProductId(saleProductId,
                        flittingOrderItemDto.getRejectQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getRejectQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_FINISHFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory
                        .setPreRemainCount(saleProductInventory.getRemainCount() - flittingOrderItemDto.getRejectQuantity());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(flittingOrderItemDto.getRejectQuantity());
                srcSaleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            for (Integer saleProductId : destSortedMap.keySet()) {
                // 更新已订购数量
                FlittingOrderItemDto flittingOrderItemDto = destSortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateRemainCountBySaleProductId(saleProductId,
                        flittingOrderItemDto.getReceiveQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getReceiveQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_FINISHFLITTING);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getFlittingOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setPreRemainCount(
                        saleProductInventory.getRemainCount() - flittingOrderItemDto.getReceiveQuantity());
                saleProductInventoryHistory.setRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(flittingOrderItemDto.getReceiveQuantity());
                srcSaleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            // 发送修改商品冗余库存消息
            sendSaleProductRemainChangeMessage(srcSaleProductIdAndRemainCountDeltaKeys, operateUserId);
        } catch (Exception e) {
            logger.error("updateInventoryForFlittingFinish异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateInventoryForPurchaseFinish(List<PurchaseOrderItemDto> purchaseOrderItemDtoList,
            Map<Integer, Integer> saleProductMap, Integer operateUserId, Date operateTime) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderItemDtoList) || ObjectUtils.isNullOrEmpty(saleProductMap)) {
                throw new OrderServiceException("没有更新库存的商品");
            }
            Map<Integer, PurchaseOrderItemDto> sortedMap = new TreeMap<Integer, PurchaseOrderItemDto>();
            for (PurchaseOrderItemDto purchaseOrderItemDto : purchaseOrderItemDtoList) {
                sortedMap.put(purchaseOrderItemDto.getProductId(), purchaseOrderItemDto);
            }
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (Integer productId : sortedMap.keySet()) {
                // 更新库存数量
                PurchaseOrderItemDto purchaseOrderItemDto = sortedMap.get(productId);
                Integer saleProductId = saleProductMap.get(productId);
                if (null == saleProductId) {
                    logger.error("产品ID[" + productId + "]没有找到商品信息");
                    throw new OrderServiceException("没有找到商品信息");
                }
                Integer effectCount = productInventoryMapper.updateRemainCountBySaleProductId(saleProductId,
                        purchaseOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(purchaseOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_FINISHPURCHASE);
                saleProductInventoryHistory.setRelativeNo(purchaseOrderItemDto.getPurchaseOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory
                        .setRemainCount(saleProductInventory.getRemainCount() + purchaseOrderItemDto.getQuantity());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(purchaseOrderItemDto.getQuantity());
                saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            // 发送修改商品冗余库存消息
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, operateUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }

    @Override
    public StoreTotalPrice sumTotalPriceByStoreId(Integer storeId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                throw new OrderServiceException("店铺ID不能为空");
            }
            StoreTotalPrice storeTotalPrice = new StoreTotalPrice(storeId);
            List<SimpleSaleProductInventory> simpleSaleProductInventories = productInventoryMapper
                    .listSimpleSaleProductInventoryByStoreId(storeId);
            if (ObjectUtils.isNullOrEmpty(simpleSaleProductInventories)) {
                return storeTotalPrice;
            }
            Long totalRetailPrice = 0L;
            Long totalPromotionPrice = 0L;
            Long totalCostPrice = 0L;
            List<Integer> saleProductIds = new ArrayList<Integer>();
            Map<Integer, Integer> simpleMap = new HashMap<Integer, Integer>();
            int itemCount = 0;
            for (SimpleSaleProductInventory simpleSaleProductInventory : simpleSaleProductInventories) {
                itemCount++;
                simpleMap.put(simpleSaleProductInventory.getSaleProductId(), simpleSaleProductInventory.getRemainCount());
                saleProductIds.add(simpleSaleProductInventory.getSaleProductId());
                if (saleProductIds.size() == 100 || simpleSaleProductInventories.size() == itemCount) {
                    List<SaleProductPriceProxyDto> saleProductPriceProxyDtos = productProxyService
                            .listSaleProductPriceByIdsAndChannelCode(saleProductIds, null);
                    saleProductIds.clear();
                    if (!ObjectUtils.isNullOrEmpty(saleProductPriceProxyDtos)) {
                        for (SaleProductPriceProxyDto saleProductPriceProxyDto : saleProductPriceProxyDtos) {
                            Integer remainCount = simpleMap.get(saleProductPriceProxyDto.getSaleProductId());
                            totalRetailPrice += saleProductPriceProxyDto.getRetailPrice() * remainCount;
                            totalPromotionPrice += saleProductPriceProxyDto.getPromotionalPrice() * remainCount;
                            totalCostPrice += saleProductPriceProxyDto.getCostPrice() * remainCount;
                        }
                    }
                }
            }

            storeTotalPrice.setTotalRetailPrice(totalRetailPrice);
            storeTotalPrice.setTotalPromotionPrice(totalPromotionPrice);
            storeTotalPrice.setTotalCostPrice(totalCostPrice);
            return storeTotalPrice;
        } catch (Exception e) {
            logger.error("sumTotalPriceByStoreId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductInventoryDto> listByStoreIdAndSaleProductIds(Integer storeId, List<Integer> saleProductIds)
            throws OrderServiceException {
        try {
            List<SaleProductInventory> saleProductInventoryList = productInventoryMapper
                    .listByStoreIdAndSaleProductIds(storeId, saleProductIds);
            List<SaleProductInventoryDto> saleProductInventoryDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryList)) {
                saleProductInventoryDtoList = new ArrayList<SaleProductInventoryDto>();
                for (SaleProductInventory saleProductInventory : saleProductInventoryList) {
                    SaleProductInventoryDto saleProductInventoryDto = new SaleProductInventoryDto();
                    ObjectUtils.fastCopy(saleProductInventory, saleProductInventoryDto);
                    saleProductInventoryDtoList.add(saleProductInventoryDto);
                }
            }
            return saleProductInventoryDtoList;
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleProductInventoryDto> findInventoriesBySaleProductIds(
            SaleProductInventoryQueryDto saleProductInventoryQueryDto) throws OrderServiceException {
        try {
            if (null == saleProductInventoryQueryDto.getStart() || saleProductInventoryQueryDto.getStart() <= 0) {
                saleProductInventoryQueryDto.setStart(1);
            }
            if (null == saleProductInventoryQueryDto.getPageSize() || saleProductInventoryQueryDto.getPageSize() <= 0) {
                saleProductInventoryQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<SaleProductInventoryDto> pageDto = new Page<SaleProductInventoryDto>(
                    saleProductInventoryQueryDto.getStart(), saleProductInventoryQueryDto.getPageSize());
            if (ObjectUtils.isNullOrEmpty(saleProductInventoryQueryDto.getSaleProductIds())) {
                pageDto.setPageNum(saleProductInventoryQueryDto.getStart());
                pageDto.setPageSize(saleProductInventoryQueryDto.getPageSize());
                pageDto.setTotal(0);
                return YiLiDiPageUtils.encapsulatePageResult(pageDto);
            }
            SaleProductInventoryQuery saleProductInventoryQuery = new SaleProductInventoryQuery();
            ObjectUtils.fastCopy(saleProductInventoryQueryDto, saleProductInventoryQuery);
            PageHelper.startPage(saleProductInventoryQuery.getStart(), saleProductInventoryQuery.getPageSize());
            Page<SimpleSaleProductInventory> page = productInventoryMapper
                    .findInventoriesBySaleProductIds(saleProductInventoryQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<SimpleSaleProductInventory> simpleSaleProductInventoryInfos = page.getResult();
            if (ObjectUtils.isNullOrEmpty(simpleSaleProductInventoryInfos)) {
                return YiLiDiPageUtils.encapsulatePageResult(pageDto);
            }
            for (SimpleSaleProductInventory simpleSaleProductInventory : simpleSaleProductInventoryInfos) {
                SaleProductInventoryDto saleProductInventoryDto = new SaleProductInventoryDto();
                saleProductInventoryDto.setSaleProductId(simpleSaleProductInventory.getSaleProductId());
                saleProductInventoryDto.setRemainCount(simpleSaleProductInventory.getRemainCount());
                pageDto.add(saleProductInventoryDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "根据商品ID列表分页获取商品库存信息出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void updateInventoryForStockOutFinish(List<StockOutOrderItemDto> stockOutOrderItemDtoList, Integer operateUserId,
            Date operateTime) throws OrderServiceException {
        try {
            Map<Integer, StockOutOrderItemDto> sortedMap = new TreeMap<Integer, StockOutOrderItemDto>();
            for (StockOutOrderItemDto stockOutOrderItemDto : stockOutOrderItemDtoList) {
                sortedMap.put(stockOutOrderItemDto.getSaleProductId(), stockOutOrderItemDto);
            }
            List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (Integer saleProductId : sortedMap.keySet()) {
                SaleProductInventory saleProductInventory = productInventoryMapper.loadByStoreIdAndSaleProductId(null,
                        saleProductId);
                StockOutOrderItemDto flittingOrderItemDto = sortedMap.get(saleProductId);
                Integer effectCount = productInventoryMapper.updateRemainCountBySaleProductId(saleProductId,
                        -flittingOrderItemDto.getQuantity(), operateUserId, operateTime);
                if (1 != effectCount) {
                    throw new OrderServiceException("更新" + makeSaleProductTips(saleProductId) + "库存失败");
                }
                SaleProductInventoryHistory saleProductInventoryHistory = new SaleProductInventoryHistory();
                saleProductInventoryHistory.setDelta(flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setOperateType(SystemContext.OrderDomain.INVENTORYOPERTYPE_FINISHSTOCKOUT);
                saleProductInventoryHistory.setRelativeNo(flittingOrderItemDto.getStockOutOrderNo());
                saleProductInventoryHistory.setOperateTime(operateTime);
                saleProductInventoryHistory.setOperateUserId(operateUserId);
                saleProductInventoryHistory.setOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setSaleProductId(saleProductInventory.getSaleProductId());
                saleProductInventoryHistory.setPreOrderedCount(saleProductInventory.getOrderedCount());
                saleProductInventoryHistory.setPreRemainCount(saleProductInventory.getRemainCount());
                saleProductInventoryHistory
                        .setRemainCount(saleProductInventory.getRemainCount() - flittingOrderItemDto.getQuantity());
                saleProductInventoryHistory.setStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setPreStandbyCount(saleProductInventory.getStandbyCount());
                saleProductInventoryHistory.setStoreId(saleProductInventory.getStoreId());
                effectCount = productInventoryHistoryMapper.save(saleProductInventoryHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存" + makeSaleProductTips(saleProductId) + "库存日志信息失败");
                }
                KeyValuePair<Integer, Integer> keyValuePair = new KeyValuePair<Integer, Integer>();
                keyValuePair.setKey(saleProductId);
                keyValuePair.setValue(-flittingOrderItemDto.getQuantity());
                saleProductIdAndRemainCountDeltaKeys.add(keyValuePair);
            }
            // 发送修改商品冗余库存消息
            sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, operateUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void sendSaleProductRemainChangeMessage(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIdAndRemainCountDeltaKeys)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new OrderServiceException("操作用户不能为空");
            }
            messageProxyService.sendSaleProductRemainChangeMessage(saleProductIdAndRemainCountDeltaKeys, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }
}
