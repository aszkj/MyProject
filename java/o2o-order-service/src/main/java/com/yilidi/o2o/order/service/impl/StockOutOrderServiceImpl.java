package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.StockOutOrderHistoryMapper;
import com.yilidi.o2o.order.dao.StockOutOrderItemMapper;
import com.yilidi.o2o.order.dao.StockOutOrderMapper;
import com.yilidi.o2o.order.model.StockOutOrder;
import com.yilidi.o2o.order.model.StockOutOrderHistory;
import com.yilidi.o2o.order.model.StockOutOrderItem;
import com.yilidi.o2o.order.model.query.StockOutOrderQuery;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.IStockOutOrderService;
import com.yilidi.o2o.order.service.IStockOutService;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderItemDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderSaveDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.query.StockOutOrderQueryDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 出库单处理实现类
 * 
 * @author chenb
 * 
 */
@Service("stockOutOrderService")
public class StockOutOrderServiceImpl extends BasicDataService implements IStockOutOrderService {

    @Autowired
    private StockOutOrderMapper stockOutOrderMapper;
    @Autowired
    private StockOutOrderHistoryMapper stockOutOrderHistoryMapper;
    @Autowired
    private StockOutOrderItemMapper stockOutOrderItemMapper;

    @Autowired
    private IStockOutService stockOutService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private IUserProxyService userProxyService;

    private static final String DISTRIBUTED_LOCK_PREFIX = "SAVE_STOCKOUTORDER_STORE_";

    @Override
    public String saveCreateStockOutOrder(StockOutOrderSaveDto stockOutOrderSaveDto, Integer userId)
            throws OrderServiceException {
        try {
            if (null == stockOutOrderSaveDto) {
                throw new OrderServiceException("参数不能为空");
            }
            if (null == stockOutOrderSaveDto.getStoreId()) {
                throw new OrderServiceException("店铺不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(stockOutOrderSaveDto.getStockOutOrderType())) {
                throw new OrderServiceException("出库单类型不能为空");
            }
            List<StockOutOrderSaveItemDto> stockOutOrderSaveItemDtoList = stockOutOrderSaveDto
                    .getStockOutOrderSaveItemDtos();
            if (ObjectUtils.isNullOrEmpty(stockOutOrderSaveItemDtoList)) {
                throw new OrderServiceException("商品不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService
                    .loadByStoreId(stockOutOrderSaveDto.getStoreId());
            if (null == storeProfileProxyDto) {
                throw new OrderServiceException("店铺不存在");
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                throw new OrderServiceException("该店铺库存为共享库存,不能创建出库单");
            }
            List<Integer> saleProductIdList = new ArrayList<Integer>();
            for (StockOutOrderSaveItemDto stockOutOrderSaveItemDto : stockOutOrderSaveItemDtoList) {
                saleProductIdList.add(stockOutOrderSaveItemDto.getSaleProductId());
            }
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIdList, null, null, null);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
                throw new OrderServiceException("出库单的商品不存在");
            }
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            List<Integer> saleProductIds = new ArrayList<Integer>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
                saleProductIds.add(saleProductProxyDto.getId());
            }
            DistributedLockUtils.lock(DISTRIBUTED_LOCK_PREFIX + stockOutOrderSaveDto.getStoreId());
            List<SaleProductInventoryDto> saleProductInventoryDtos = saleProductInventoryService
                    .listByStoreIdAndSaleProductIds(stockOutOrderSaveDto.getStoreId(), saleProductIds);
            Map<Integer, SaleProductInventoryDto> saleProductInventoryDtoMap = new HashMap<Integer, SaleProductInventoryDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryDtos)) {
                for (SaleProductInventoryDto saleProductInventoryDto : saleProductInventoryDtos) {
                    saleProductInventoryDtoMap.put(saleProductInventoryDto.getSaleProductId(), saleProductInventoryDto);
                }
            }
            Long totalAmount = 0L; // 出库金额
            Integer stockOutCount = 0; // 出库商品数量
            String stockOutOrderNo = StringUtils.generateStockOutOrderNo();
            List<StockOutOrderItem> stockOutOrderItemList = new ArrayList<StockOutOrderItem>();
            for (StockOutOrderSaveItemDto stockOutOrderSaveItemDto : stockOutOrderSaveItemDtoList) {
                SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap
                        .get(stockOutOrderSaveItemDto.getSaleProductId());
                SaleProductInventoryDto saleProductInventoryDto = saleProductInventoryDtoMap
                        .get(stockOutOrderSaveItemDto.getSaleProductId());
                if (null == saleProductProxyDto) {
                    throw new OrderServiceException("出库单的商品不存在");
                }
                int remainCount = saleProductInventoryDto.getRemainCount().intValue()
                        - saleProductInventoryDto.getOrderedCount().intValue();
                if (ObjectUtils.isNullOrEmpty(saleProductInventoryDto)
                        || stockOutOrderSaveItemDto.getStockOutCount().intValue() > remainCount) {
                    throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 库存不够出库");
                }
                stockOutCount += stockOutOrderSaveItemDto.getStockOutCount();
                totalAmount += stockOutOrderSaveItemDto.getStockOutCount()
                        * ArithUtils.converLongTolong(saleProductProxyDto.getPromotionalPrice());
                StockOutOrderItem stockOutOrderItem = getStockOutOrderItem(stockOutOrderNo, saleProductProxyDto,
                        stockOutOrderSaveItemDto.getStockOutCount());
                stockOutOrderItemList.add(stockOutOrderItem);
            }
            DistributedLockUtils.unlock();
            Integer effectCount = 0;
            Date operationTime = new Date();
            // 保存出库单信息
            StockOutOrder stockOutOrder = new StockOutOrder();
            stockOutOrder.setStockOutOrderNo(stockOutOrderNo);
            stockOutOrder.setStoreId(storeProfileProxyDto.getStoreId());
            stockOutOrder.setStoreType(storeProfileProxyDto.getStoreType());
            stockOutOrder.setStoreName(storeProfileProxyDto.getStoreName());
            stockOutOrder.setStoreCode(storeProfileProxyDto.getStoreCode());
            stockOutOrder.setOrderStatus(SystemContext.OrderDomain.STOCKOUTORDERSTATUS_UNAUDIT);
            stockOutOrder.setStockOutAmount(totalAmount);
            stockOutOrder.setStockOutCount(stockOutCount);
            stockOutOrder.setStockOutOrderType(stockOutOrderSaveDto.getStockOutOrderType());
            stockOutOrder.setCreateUserId(userId);
            stockOutOrder.setCreateTime(operationTime);
            stockOutOrder.setUpdateTime(operationTime);
            stockOutOrder.setUpdateUserId(userId);
            effectCount = stockOutOrderMapper.save(stockOutOrder);
            if (1 != effectCount) {
                throw new OrderServiceException("保存出库单失败");
            }
            // 保存出库单状态变化历史信息
            StockOutOrderHistory stockOutOrderHistory = new StockOutOrderHistory();
            stockOutOrderHistory.setOperateTime(operationTime);
            stockOutOrderHistory.setStockOutOrderNo(stockOutOrderNo);
            stockOutOrderHistory.setOperateUserId(userId);
            stockOutOrderHistory.setOrderStatus(SystemContext.OrderDomain.STOCKOUTORDERSTATUS_UNAUDIT);
            stockOutOrderHistory.setOperationDesc("生成出库单");
            effectCount = stockOutOrderHistoryMapper.save(stockOutOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存出库单状态变化历史失败");
            }
            // 保存出库单明细信息
            for (StockOutOrderItem stockOutOrderItem : stockOutOrderItemList) {
                effectCount = stockOutOrderItemMapper.save(stockOutOrderItem);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存出库单明细失败");
                }
            }
            return stockOutOrderNo;
        } catch (Exception e) {
            DistributedLockUtils.unlock();
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private StockOutOrderItem getStockOutOrderItem(String stockOutOrderNo, SaleProductProxyDto saleProductProxyDto,
            Integer saleProductCount) {
        StockOutOrderItem stockOutOrderItem = new StockOutOrderItem();
        stockOutOrderItem.setStockOutOrderNo(stockOutOrderNo);
        stockOutOrderItem.setProductId(saleProductProxyDto.getProductId());
        stockOutOrderItem.setSaleProductId(saleProductProxyDto.getId());
        stockOutOrderItem.setQuantity(saleProductCount);

        stockOutOrderItem.setProductClassName(saleProductProxyDto.getProductClassName());
        stockOutOrderItem.setProductName(saleProductProxyDto.getSaleProductName());
        stockOutOrderItem.setSpecifications(saleProductProxyDto.getSaleProductSpec());
        stockOutOrderItem.setBarCode(saleProductProxyDto.getBarCode());
        stockOutOrderItem.setProductImageUrl3(saleProductProxyDto.getSaleProductImageUrl());
        stockOutOrderItem.setOrderPrice(ArithUtils.converLongTolong(saleProductProxyDto.getPromotionalPrice()));
        stockOutOrderItem
                .setTotalPrice(ArithUtils.converLongTolong(saleProductProxyDto.getPromotionalPrice()) * saleProductCount);
        return stockOutOrderItem;
    }

    @Override
    public StockOutOrderDto loadByStockOutOrderNo(String stockOutOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderNo)) {
                throw new OrderServiceException("出库单号不能为空");
            }
            StockOutOrder stockOutOrder = stockOutOrderMapper.loadByStockOutOrderNo(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrder)) {
                return null;
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(stockOutOrder.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                return null;
            }
            StockOutOrderDto stockOutOrderDto = new StockOutOrderDto();
            ObjectUtils.fastCopy(stockOutOrder, stockOutOrderDto);
            stockOutOrderDto.setOrderStatusName(super.getSystemDictName(
                    SystemContext.OrderDomain.DictType.STOCKOUTORDERSTATUS.getValue(), stockOutOrderDto.getOrderStatus()));
            stockOutOrderDto.setStoreTypeName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                    stockOutOrderDto.getStoreType()));
            stockOutOrderDto.setAddressDetail(storeProfileProxyDto.getAddressDetail());
            List<Integer> userIds = new ArrayList<Integer>();
            if (null != stockOutOrderDto.getCreateUserId()) {
                userIds.add(stockOutOrderDto.getCreateUserId());
            }
            if (null != stockOutOrderDto.getAuditUserId()) {
                userIds.add(stockOutOrderDto.getAuditUserId());
            }
            if (null != stockOutOrderDto.getUpdateUserId()) {
                userIds.add(stockOutOrderDto.getUpdateUserId());
            }
            List<UserProxyDto> userProxyDtos = userProxyService.listUserByIds(userIds);
            if (!ObjectUtils.isNullOrEmpty(userProxyDtos)) {
                for (UserProxyDto userProxyDto : userProxyDtos) {
                    if (userProxyDto.getUserId().intValue() == ArithUtils
                            .converIntegerToInt(stockOutOrderDto.getCreateUserId())) {
                        stockOutOrderDto.setCreateUserName(userProxyDto.getUserName());
                    }
                    if (userProxyDto.getUserId().intValue() == ArithUtils
                            .converIntegerToInt(stockOutOrderDto.getAuditUserId())) {
                        stockOutOrderDto.setAuditUserName(userProxyDto.getUserName());
                    }
                    if (userProxyDto.getUserId().intValue() == ArithUtils
                            .converIntegerToInt(stockOutOrderDto.getUpdateUserId())) {
                        stockOutOrderDto.setUpdateUserName(userProxyDto.getUserName());
                    }
                }
            }
            List<StockOutOrderItem> stockOutOrderItemList = stockOutOrderItemMapper.listStockOutOrderItems(stockOutOrderNo);
            if (!ObjectUtils.isNullOrEmpty(stockOutOrderItemList)) {
                List<StockOutOrderItemDto> stockOutOrderItemDtoList = new ArrayList<StockOutOrderItemDto>();
                for (StockOutOrderItem stockOutOrderItem : stockOutOrderItemList) {
                    StockOutOrderItemDto stockOutOrderItemDto = new StockOutOrderItemDto();
                    ObjectUtils.fastCopy(stockOutOrderItem, stockOutOrderItemDto);
                    stockOutOrderItemDtoList.add(stockOutOrderItemDto);
                }
                stockOutOrderDto.setStockOutOrderItemDtos(stockOutOrderItemDtoList);
            }
            return stockOutOrderDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<StockOutOrderDto> findStockOutOrders(StockOutOrderQueryDto stockOutOrderQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            StockOutOrderQuery stockOutOrderQuery = new StockOutOrderQuery();
            ObjectUtils.fastCopy(stockOutOrderQueryDto, stockOutOrderQuery);
            if (!ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto.getStrBeginCreateTime())) {
                Date startCreateDate = DateUtils
                        .parseDate(stockOutOrderQueryDto.getStrBeginCreateTime() + StringUtils.STARTTIMESTRING);
                stockOutOrderQuery.setBeginCreateTime(startCreateDate);
            }
            if (!ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto.getStrEndCreateTime())) {
                Date endCreateDate = DateUtils
                        .parseDate(stockOutOrderQueryDto.getStrEndCreateTime() + StringUtils.ENDTIMESTRING);
                stockOutOrderQuery.setEndCreateTime(endCreateDate);
            }
            if (!ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto.getStrBeginAuditTime())) {
                Date startAuditDate = DateUtils
                        .parseDate(stockOutOrderQueryDto.getStrBeginAuditTime() + StringUtils.STARTTIMESTRING);
                stockOutOrderQuery.setBeginAuditTime(startAuditDate);
            }
            if (!ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto.getStrEndAuditTime())) {
                Date endCreateDate = DateUtils
                        .parseDate(stockOutOrderQueryDto.getStrEndAuditTime() + StringUtils.ENDTIMESTRING);
                stockOutOrderQuery.setEndAuditTime(endCreateDate);
            }
            PageHelper.startPage(stockOutOrderQuery.getStart(), stockOutOrderQuery.getPageSize());

            Page<StockOutOrder> stockOutOrderPages = stockOutOrderMapper.findStockOutOrderInfos(stockOutOrderQuery);
            Page<StockOutOrderDto> pageDto = new Page<StockOutOrderDto>(stockOutOrderQueryDto.getStart(),
                    stockOutOrderQueryDto.getPageSize());
            ObjectUtils.fastCopy(stockOutOrderPages, pageDto);
            List<StockOutOrder> stockOutOrders = stockOutOrderPages.getResult();
            if (!ObjectUtils.isNullOrEmpty(stockOutOrders)) {
                for (StockOutOrder stockOutOrder : stockOutOrders) {
                    StockOutOrderDto stockOutOrderDto = new StockOutOrderDto();
                    ObjectUtils.fastCopy(stockOutOrder, stockOutOrderDto);
                    stockOutOrderDto.setOrderStatusName(
                            super.getSystemDictName(SystemContext.OrderDomain.DictType.STOCKOUTORDERSTATUS.getValue(),
                                    stockOutOrderDto.getOrderStatus()));
                    stockOutOrderDto.setStoreTypeName(super.getSystemDictName(
                            SystemContext.UserDomain.DictType.STORETYPE.getValue(), stockOutOrderDto.getStoreType()));
                    if (!ObjectUtils.isNullOrEmpty(stockOutOrderDto.getStockOutOrderType())) {
                        stockOutOrderDto.setStockOutOrderTypeName(
                                super.getSystemDictName(SystemContext.OrderDomain.DictType.STOCKOUTORDERTYPE.getValue(),
                                        stockOutOrderDto.getStockOutOrderType()));
                    }
                    pageDto.add(stockOutOrderDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditPassed(String stockOutOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderNo)) {
                throw new OrderServiceException("出库单不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException("操作用户不能为空");
            }
            StockOutOrder stockOutOrder = stockOutOrderMapper.loadForUpdateByStockOutOrderNo(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrder)) {
                throw new OrderServiceException("没有找到出库单信息");
            }
            List<StockOutOrderItem> stockOutOrderItemList = stockOutOrderItemMapper.listStockOutOrderItems(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrderItemList)) {
                throw new OrderServiceException("没有找到出库单明细信息");
            }
            List<Integer> saleProductIds = new ArrayList<Integer>();
            for (StockOutOrderItem stockOutOrderItem : stockOutOrderItemList) {
                saleProductIds.add(stockOutOrderItem.getSaleProductId());
            }
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
                throw new OrderServiceException("查询不到需要出库的产品");
            }
            if (saleProductIds.size() != saleProductProxyDtoList.size()) {
                throw new OrderServiceException("存在无效的产品");
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(stockOutOrder.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                throw new OrderServiceException("查找不到出库商户信息");
            }
            Date nowDate = new Date();
            // 更新出库单状态为审核通过
            Integer effectCount = stockOutOrderMapper.updateOrderStautsForAuditPassedByStockOutOrderNo(stockOutOrderNo,
                    SystemContext.OrderDomain.STOCKOUTORDERSTATUS_UNAUDIT,
                    SystemContext.OrderDomain.STOCKOUTORDERSTATUS_AUDIT_PASSED, nowDate, operateUserId);
            if (effectCount != 1) {
                throw new OrderServiceException("更新出库单状态失败");
            }

            // 保存出库单状态变化历史信息
            StockOutOrderHistory stockOutOrderHistory = new StockOutOrderHistory();
            stockOutOrderHistory.setOperateTime(nowDate);
            stockOutOrderHistory.setStockOutOrderNo(stockOutOrderNo);
            stockOutOrderHistory.setOperateUserId(operateUserId);
            stockOutOrderHistory.setOrderStatus(SystemContext.OrderDomain.STOCKOUTORDERSTATUS_AUDIT_PASSED);
            stockOutOrderHistory.setOperationDesc("审核出库单通过");
            effectCount = stockOutOrderHistoryMapper.save(stockOutOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存出库单状态变化历史失败");
            }

            Map<Integer, Integer> saleProductMap = new HashMap<Integer, Integer>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductMap.put(saleProductProxyDto.getProductId(), saleProductProxyDto.getId());
            }
            stockOutService.saveStockOutByStockOutOrderNo(stockOutOrderNo);

            List<StockOutOrderItemDto> stockOutOrderItemDtos = new ArrayList<StockOutOrderItemDto>();
            List<StockOutOrderItem> stockOutOrderItems = stockOutOrderItemMapper.listStockOutOrderItems(stockOutOrderNo);
            for (StockOutOrderItem stockOutOrderItem : stockOutOrderItems) {
                StockOutOrderItemDto stockOutOrderItemDto = new StockOutOrderItemDto();
                ObjectUtils.fastCopy(stockOutOrderItem, stockOutOrderItemDto);
                stockOutOrderItemDtos.add(stockOutOrderItemDto);
            }
            // 更新库存
            saleProductInventoryService.updateInventoryForStockOutFinish(stockOutOrderItemDtos, operateUserId, nowDate);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditRejected(String stockOutOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderNo)) {
                throw new OrderServiceException("出库单号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException("操作用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(rejectReason)) {
                throw new OrderServiceException("审核不能过理由不能为空");
            }
            StockOutOrder stockOutOrder = stockOutOrderMapper.loadForUpdateByStockOutOrderNo(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrder)) {
                throw new OrderServiceException("找不到出库单信息");
            }

            Date nowDate = new Date();

            stockOutOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED);
            stockOutOrder.setUpdateTime(nowDate);
            stockOutOrder.setUpdateUserId(operateUserId);
            stockOutOrder.setAuditTime(nowDate);
            stockOutOrder.setAuditUserId(operateUserId);
            stockOutOrder.setAuditRejectReason(rejectReason);
            Integer effectCount = stockOutOrderMapper.updateOrderStautsForAuditNotPassedByStockOutOrderNo(stockOutOrderNo,
                    SystemContext.OrderDomain.STOCKOUTORDERSTATUS_UNAUDIT,
                    SystemContext.OrderDomain.STOCKOUTORDERSTATUS_AUDIT_NOTPASSED, rejectReason, nowDate, operateUserId);
            if (effectCount != 1) {
                throw new OrderServiceException("更新出库单状态失败");
            }

            // 保存出库单状态变化历史信息
            StockOutOrderHistory stockOutOrderHistory = new StockOutOrderHistory(stockOutOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.STOCKOUTORDERSTATUS_AUDIT_NOTPASSED, "出库单审核不通过");
            effectCount = stockOutOrderHistoryMapper.save(stockOutOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException("保存出库单状态异常");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<StockOutOrderHistoryDto> listStockOutOrderHistorys(String stockOutOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(stockOutOrderNo)) {
                throw new OrderServiceException("出库订单不能为空");
            }
            List<StockOutOrderHistory> items = stockOutOrderHistoryMapper.listStockOutOrderHistorys(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<StockOutOrderHistoryDto> itemDtos = new ArrayList<StockOutOrderHistoryDto>();
            for (StockOutOrderHistory item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                StockOutOrderHistoryDto itemDto = new StockOutOrderHistoryDto();
                ObjectUtils.fastCopy(item, itemDto);
                itemDtos.add(itemDto);
            }
            return itemDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStockOutOrder(StockOutOrderQueryDto stockOutOrderQueryDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            StockOutOrderQuery stockOutOrderQuery = new StockOutOrderQuery();
            Long count = stockOutOrderMapper.getCountsForExportStockOutOrder(stockOutOrderQuery);
            return null == count ? 0L : count.longValue();
        } catch (Exception e) {
            logger.error("findStockOutOrders异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<StockOutOrderDto> listDataForExportStockOutOrder(StockOutOrderQueryDto stockOutOrderQueryDto,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            if (null == startLineNum || startLineNum <= 0) {
                stockOutOrderQueryDto.setStart(1);
            } else {
                stockOutOrderQueryDto.setStart(startLineNum.intValue());
            }
            if (null == pageSize || pageSize <= 0) {
                stockOutOrderQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            } else {
                stockOutOrderQueryDto.setPageSize(pageSize);
            }
            YiLiDiPage<StockOutOrderDto> page = findStockOutOrders(stockOutOrderQueryDto);
            if (null == page) {
                return null;
            }
            return page.getResultList();
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
