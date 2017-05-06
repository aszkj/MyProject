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
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.dao.PurchaseOrderAddressMapper;
import com.yilidi.o2o.order.dao.PurchaseOrderHistoryMapper;
import com.yilidi.o2o.order.dao.PurchaseOrderItemMapper;
import com.yilidi.o2o.order.dao.PurchaseOrderMapper;
import com.yilidi.o2o.order.model.PurchaseOrder;
import com.yilidi.o2o.order.model.PurchaseOrderAddress;
import com.yilidi.o2o.order.model.PurchaseOrderHistory;
import com.yilidi.o2o.order.model.PurchaseOrderItem;
import com.yilidi.o2o.order.model.query.PurchaseOrderAddressQuery;
import com.yilidi.o2o.order.model.query.PurchaseOrderQuery;
import com.yilidi.o2o.order.service.IPurchaseOrderService;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.IStockInService;
import com.yilidi.o2o.order.service.dto.PurchaseOrderAddressDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderItemDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderSaveDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.query.PurchaseOrderQueryDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 采购单处理实现类
 * 
 * @author chenb
 * 
 */
@Service("purchaseOrderService")
public class PurchaseOrderServiceImpl extends BasicDataService implements IPurchaseOrderService {

    @Autowired
    private PurchaseOrderMapper purchaseOrderMapper;
    @Autowired
    private PurchaseOrderHistoryMapper purchaseOrderHistoryMapper;
    @Autowired
    private PurchaseOrderAddressMapper purchaseOrderAddressMapper;
    @Autowired
    private PurchaseOrderItemMapper purchaseOrderItemMapper;

    @Autowired
    private IStockInService stockInService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private IUserProxyService userProxyService;

    private static final String DISTRIBUTED_LOCK_PREFIX = "SAVE_PURCHASE_STORE_";

    @Override
    public String saveCreatePurchaseOrder(PurchaseOrderSaveDto purchaseOrderSaveDto, Integer userId)
            throws OrderServiceException {
        try {
            if (null == purchaseOrderSaveDto) {
                throw new OrderServiceException("参数不能为空");
            }
            if (null == purchaseOrderSaveDto.getStoreId()) {
                throw new OrderServiceException("店铺不能为空");
            }
            List<PurchaseOrderSaveItemDto> purchaseOrderSaveItemDtoList = purchaseOrderSaveDto
                    .getPurchaseOrderSaveItemDtoList();
            if (ObjectUtils.isNullOrEmpty(purchaseOrderSaveItemDtoList)) {
                throw new OrderServiceException("产品不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService
                    .loadByStoreId(purchaseOrderSaveDto.getStoreId());
            if (null == storeProfileProxyDto) {
                throw new OrderServiceException("店铺不存在");
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                throw new OrderServiceException("该店铺库存为共享库存,不能进行采购");
            }
            List<Integer> productIdList = new ArrayList<Integer>();
            for (PurchaseOrderSaveItemDto purchaseOrderSaveItemDto : purchaseOrderSaveItemDtoList) {
                productIdList.add(purchaseOrderSaveItemDto.getProductId());
            }
            List<ProductProxyDto> productProxyDtoList = productProxyService.listProductByProductIds(productIdList);
            if (ObjectUtils.isNullOrEmpty(productProxyDtoList)) {
                throw new OrderServiceException("下单的商品已被删除");
            }
            Map<Integer, ProductProxyDto> productProxyDtoMap = new HashMap<Integer, ProductProxyDto>();
            for (ProductProxyDto productProxyDto : productProxyDtoList) {
                productProxyDtoMap.put(productProxyDto.getId(), productProxyDto);
            }
            Long totalAmount = 0L; // 采购金额
            Integer purchaseCount = 0; // 采购商品数量
            String purchaseOrderNo = StringUtils.generatePurchaseOrderNo();
            List<PurchaseOrderItem> purchaseOrderItemList = new ArrayList<PurchaseOrderItem>();
            for (PurchaseOrderSaveItemDto purchaseOrderSaveItemDto : purchaseOrderSaveItemDtoList) {
                ProductProxyDto productProxyDto = productProxyDtoMap.get(purchaseOrderSaveItemDto.getProductId());
                if (null == productProxyDto) {
                    throw new OrderServiceException("下单的商品不存在");
                }
                purchaseCount += purchaseOrderSaveItemDto.getPurchaseCount();
                totalAmount += purchaseOrderSaveItemDto.getPurchaseCount()
                        * ArithUtils.converLongTolong(productProxyDto.getCostPrice());
                PurchaseOrderItem purchaseOrderItem = getPurchaseOrderItem(purchaseOrderNo, productProxyDto,
                        purchaseOrderSaveItemDto.getPurchaseCount());
                purchaseOrderItemList.add(purchaseOrderItem);
            }

            Integer effectCount = 0;
            Date operationTime = new Date();
            // 保存采购单信息
            PurchaseOrder purchaseOrder = new PurchaseOrder();
            purchaseOrder.setPurchaseOrderNo(purchaseOrderNo);
            purchaseOrder.setStoreId(storeProfileProxyDto.getStoreId());
            purchaseOrder.setStoreName(storeProfileProxyDto.getStoreName());
            purchaseOrder.setStoreCode(storeProfileProxyDto.getStoreCode());
            purchaseOrder.setProvinceCode(storeProfileProxyDto.getProvinceCode());
            purchaseOrder.setCityCode(storeProfileProxyDto.getCityCode());
            purchaseOrder.setCountyCode(storeProfileProxyDto.getCountyCode());
            purchaseOrder.setOrderStatus(SystemContext.OrderDomain.PURCHASEORDERSTATUS_UNAUDIT);
            purchaseOrder.setPurchaseAmount(totalAmount);
            purchaseOrder.setPurchaseCount(purchaseCount);
            purchaseOrder.setCreateUserId(userId);
            purchaseOrder.setCreateTime(operationTime);
            purchaseOrder.setUpdateTime(operationTime);
            purchaseOrder.setUpdateUserId(userId);
            effectCount = purchaseOrderMapper.save(purchaseOrder);
            if (1 != effectCount) {
                throw new OrderServiceException("保存采购单失败");
            }
            // 保存采购单状态变化历史信息
            PurchaseOrderHistory purchaseOrderHistory = new PurchaseOrderHistory();
            purchaseOrderHistory.setOperateTime(operationTime);
            purchaseOrderHistory.setPurchaseOrderNo(purchaseOrderNo);
            purchaseOrderHistory.setOperateUserId(userId);
            purchaseOrderHistory.setPurchaseStatus(SystemContext.OrderDomain.PURCHASEORDERSTATUS_UNAUDIT);
            purchaseOrderHistory.setOperationDesc("生成采购单");
            effectCount = purchaseOrderHistoryMapper.save(purchaseOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存采购单状态变化历史失败");
            }
            // 保存采购单明细信息
            for (PurchaseOrderItem purchaseOrderItem : purchaseOrderItemList) {
                effectCount = purchaseOrderItemMapper.save(purchaseOrderItem);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存采购单明细失败");
                }
            }
            // 保存收货地址信息
            PurchaseOrderAddress purchaseOrderAddress = new PurchaseOrderAddress();
            purchaseOrderAddress.setPurchaseOrderNo(purchaseOrderNo);
            purchaseOrderAddress.setUserName(storeProfileProxyDto.getStoreName());
            purchaseOrderAddress.setPhoneNo(storeProfileProxyDto.getMobile());
            purchaseOrderAddress.setAddressDetail(storeProfileProxyDto.getAddressDetail());
            effectCount = purchaseOrderAddressMapper.save(purchaseOrderAddress);
            if (1 != effectCount) {
                throw new OrderServiceException("保存采购收货地址失败");
            }
            return purchaseOrderNo;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private PurchaseOrderItem getPurchaseOrderItem(String purchaseOrderNo, ProductProxyDto productProxyDto,
            Integer productCount) {
        PurchaseOrderItem purchaseOrderItem = new PurchaseOrderItem();
        purchaseOrderItem.setPurchaseOrderNo(purchaseOrderNo);
        purchaseOrderItem.setProductId(productProxyDto.getId());
        purchaseOrderItem.setQuantity(productCount);

        purchaseOrderItem.setProductClassName(productProxyDto.getProductClassName());
        purchaseOrderItem.setProductName(productProxyDto.getProductName());
        purchaseOrderItem.setSpecifications(productProxyDto.getProductSpec());
        purchaseOrderItem.setBarCode(productProxyDto.getBarCode());
        purchaseOrderItem.setProductImageUrl3(productProxyDto.getProductImageUrl());
        purchaseOrderItem.setOrderPrice(ArithUtils.converLongTolong(productProxyDto.getCostPrice()));
        purchaseOrderItem.setTotalPrice(ArithUtils.converLongTolong(productProxyDto.getCostPrice()) * productCount);
        return purchaseOrderItem;
    }

    @Override
    public PurchaseOrderDto loadByPurchaseOrderNo(String purchaseOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderNo)) {
                throw new OrderServiceException("采购单号不能为空");
            }
            PurchaseOrder purchaseOrder = purchaseOrderMapper.loadByPurchaseOrderNo(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrder)) {
                return null;
            }
            PurchaseOrderDto purchaseOrderDto = new PurchaseOrderDto();
            ObjectUtils.fastCopy(purchaseOrder, purchaseOrderDto);
            purchaseOrderDto.setOrderStatusName(SystemBasicDataUtils.getSystemDictName(
                    SystemContext.OrderDomain.DictType.PURCHASEORDERSTATUS.getValue(), purchaseOrderDto.getOrderStatus()));
            if (null != purchaseOrderDto.getAuditUserId()) {
                UserProxyDto userProxyDto = userProxyService.getUserById(purchaseOrderDto.getAuditUserId());
                if (!ObjectUtils.isNullOrEmpty(userProxyDto)) {
                    purchaseOrderDto.setAuditUserName(userProxyDto.getUserName());
                }
            }
            PurchaseOrderAddress purchaseOrderAddress = purchaseOrderAddressMapper.loadByPurchaseOrderNo(purchaseOrderNo);
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderAddress)) {
                PurchaseOrderAddressDto purchaseOrderAddressDto = new PurchaseOrderAddressDto();
                ObjectUtils.fastCopy(purchaseOrderAddress, purchaseOrderAddressDto);
                purchaseOrderDto.setPurchaseOrderAddressDto(purchaseOrderAddressDto);
            }
            List<PurchaseOrderItem> purchaseOrderItemList = purchaseOrderItemMapper.listPurchaseOrderItems(purchaseOrderNo);
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderItemList)) {
                List<PurchaseOrderItemDto> purchaseOrderItemDtoList = new ArrayList<PurchaseOrderItemDto>();
                for (PurchaseOrderItem purchaseOrderItem : purchaseOrderItemList) {
                    PurchaseOrderItemDto purchaseOrderItemDto = new PurchaseOrderItemDto();
                    ObjectUtils.fastCopy(purchaseOrderItem, purchaseOrderItemDto);
                    purchaseOrderItemDtoList.add(purchaseOrderItemDto);
                }
                purchaseOrderDto.setPurchaseOrderItemDtoList(purchaseOrderItemDtoList);
            }
            return purchaseOrderDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<PurchaseOrderDto> findPurchaseOrders(PurchaseOrderQueryDto purchaseOrderQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            PurchaseOrderQuery purchaseOrderQuery = new PurchaseOrderQuery();
            ObjectUtils.fastCopy(purchaseOrderQueryDto, purchaseOrderQuery);
            PageHelper.startPage(purchaseOrderQuery.getStart(), purchaseOrderQuery.getPageSize());

            List<PurchaseOrderAddress> purchaseOrderAddressList = null;
            List<String> purchaseOrderNos = null;
            if (!StringUtils.isEmpty(purchaseOrderQuery.getPhoneNo())) {
                PurchaseOrderAddressQuery purchaseOrderAddressQuery = new PurchaseOrderAddressQuery();
                purchaseOrderAddressQuery.setPhoneNo(purchaseOrderQuery.getPhoneNo());
                purchaseOrderAddressList = purchaseOrderAddressMapper.listPurchaseOrderAddress(purchaseOrderAddressQuery);
            }
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderAddressList)) {
                purchaseOrderNos = new ArrayList<String>();
                for (PurchaseOrderAddress purchaseOrderAddress : purchaseOrderAddressList) {
                    purchaseOrderNos.add(purchaseOrderAddress.getPurchaseOrderNo());
                }
            }
            purchaseOrderQuery.setPurchaseOrderNoList(purchaseOrderNos);
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto.getStrBeginCreateTime())) {
                Date startCreateDate = DateUtils
                        .parseDate(purchaseOrderQueryDto.getStrBeginCreateTime() + StringUtils.STARTTIMESTRING);
                purchaseOrderQuery.setBeginCreateTime(startCreateDate);
            }
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto.getStrEndCreateTime())) {
                Date endCreateDate = DateUtils
                        .parseDate(purchaseOrderQueryDto.getStrEndCreateTime() + StringUtils.ENDTIMESTRING);
                purchaseOrderQuery.setEndCreateTime(endCreateDate);
            }
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto.getStrBeginAuditTime())) {
                Date startAuditDate = DateUtils
                        .parseDate(purchaseOrderQueryDto.getStrBeginAuditTime() + StringUtils.STARTTIMESTRING);
                purchaseOrderQuery.setBeginAuditTime(startAuditDate);
            }
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto.getStrEndAuditTime())) {
                Date endCreateDate = DateUtils
                        .parseDate(purchaseOrderQueryDto.getStrEndAuditTime() + StringUtils.ENDTIMESTRING);
                purchaseOrderQuery.setEndAuditTime(endCreateDate);
            }
            Page<PurchaseOrder> purchaseOrderPages = purchaseOrderMapper.findPurchaseOrderInfos(purchaseOrderQuery);
            Page<PurchaseOrderDto> pageDto = new Page<PurchaseOrderDto>(purchaseOrderQueryDto.getStart(),
                    purchaseOrderQueryDto.getPageSize());
            ObjectUtils.fastCopy(purchaseOrderPages, pageDto);
            List<PurchaseOrder> purchaseOrders = purchaseOrderPages.getResult();
            if (!ObjectUtils.isNullOrEmpty(purchaseOrders)) {
                for (PurchaseOrder purchaseOrder : purchaseOrders) {
                    PurchaseOrderDto purchaseOrderDto = new PurchaseOrderDto();
                    ObjectUtils.fastCopy(purchaseOrder, purchaseOrderDto);
                    purchaseOrderDto.setOrderStatusName(SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PURCHASEORDERSTATUS.getValue(),
                            purchaseOrderDto.getOrderStatus()));
                    PurchaseOrderAddress purchaseOrderAddress = purchaseOrderAddressMapper
                            .loadByPurchaseOrderNo(purchaseOrderDto.getPurchaseOrderNo());
                    if (!ObjectUtils.isNullOrEmpty(purchaseOrderAddress)) {
                        PurchaseOrderAddressDto purchaseOrderAddressDto = new PurchaseOrderAddressDto();
                        ObjectUtils.fastCopy(purchaseOrderAddress, purchaseOrderAddressDto);
                        purchaseOrderDto.setPurchaseOrderAddressDto(purchaseOrderAddressDto);
                    }
                    pageDto.add(purchaseOrderDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditPassed(String purchaseOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderNo)) {
                throw new OrderServiceException("采购单不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException("操作用户不能为空");
            }
            PurchaseOrder purchaseOrder = purchaseOrderMapper.loadForUpdateByPurchaseOrderNo(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrder)) {
                throw new OrderServiceException("没有找到采购单信息");
            }
            List<PurchaseOrderItem> purchaseOrderItemList = purchaseOrderItemMapper.listPurchaseOrderItems(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrderItemList)) {
                throw new OrderServiceException("没有找到采购单明细信息");
            }
            List<Integer> productIds = new ArrayList<Integer>();
            for (PurchaseOrderItem purchaseOrderItem : purchaseOrderItemList) {
                productIds.add(purchaseOrderItem.getProductId());
            }
            List<ProductProxyDto> productProxyDtoList = productProxyService.listProductByProductIds(productIds);
            if (ObjectUtils.isNullOrEmpty(productProxyDtoList)) {
                throw new OrderServiceException("查询不到需要采购的产品");
            }
            if (productIds.size() != productProxyDtoList.size()) {
                throw new OrderServiceException("存在无效的产品");
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(purchaseOrder.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                throw new OrderServiceException("查找不到采购微仓信息");
            }
            Date nowDate = new Date();
            // 分布式锁，以防多个进程同时处理
            DistributedLockUtils.lock(DISTRIBUTED_LOCK_PREFIX + purchaseOrder.getStoreId());
            List<Integer> needCreateProductIds = new ArrayList<Integer>();
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(
                    productIds, SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, purchaseOrder.getStoreId());
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
                // 查询不到需要采购的商品，需要全部创建采购店铺的商品信息
                for (ProductProxyDto productProxyDto : productProxyDtoList) {
                    needCreateProductIds.add(productProxyDto.getId());
                }
                saleProductProxyDtoList = new ArrayList<SaleProductProxyDto>();
            } else {
                if (productProxyDtoList.size() != saleProductProxyDtoList.size()) {
                    // 采购产品在微仓中存在不存在的产品，需要创建不存在的商品信息
                    Map<Integer, SaleProductProxyDto> saleProductMap = new HashMap<Integer, SaleProductProxyDto>();
                    for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                        saleProductMap.put(saleProductProxyDto.getProductId(), saleProductProxyDto);
                    }
                    for (ProductProxyDto productProxyDto : productProxyDtoList) {
                        if (!saleProductMap.containsKey(productProxyDto.getId())) { // 不存在,需要创建
                            needCreateProductIds.add(productProxyDto.getId());
                        }
                    }
                }
            }
            if (needCreateProductIds.size() > 0) {
                productProxyService.saveSaleProductByProductIdsAndStoreId(storeProfileProxyDto.getStoreId(),
                        storeProfileProxyDto.getStoreType(), needCreateProductIds, operateUserId, nowDate);
                List<SaleProductProxyDto> newSaleProductProxyDtos = productProxyService
                        .listSaleProductByProductIdsAndStoreId(needCreateProductIds,
                                SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                                SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, storeProfileProxyDto.getStoreId());
                saleProductProxyDtoList.addAll(newSaleProductProxyDtos);
            }
            // 解锁
            DistributedLockUtils.unlock();

            // 更新采购单状态为审核通过
            Integer effectCount = purchaseOrderMapper.updateOrderStautsForAuditPassedByPurchaseOrderNo(purchaseOrderNo,
                    SystemContext.OrderDomain.PURCHASEORDERSTATUS_UNAUDIT,
                    SystemContext.OrderDomain.PURCHASEORDERSTATUS_AUDIT_PASSED, nowDate, operateUserId);
            if (effectCount != 1) {
                throw new OrderServiceException("更新采购单状态失败");
            }

            // 保存采购单状态变化历史信息
            PurchaseOrderHistory purchaseOrderHistory = new PurchaseOrderHistory();
            purchaseOrderHistory.setOperateTime(nowDate);
            purchaseOrderHistory.setPurchaseOrderNo(purchaseOrderNo);
            purchaseOrderHistory.setOperateUserId(operateUserId);
            purchaseOrderHistory.setPurchaseStatus(SystemContext.OrderDomain.PURCHASEORDERSTATUS_AUDIT_PASSED);
            purchaseOrderHistory.setOperationDesc("审核采购单通过");
            effectCount = purchaseOrderHistoryMapper.save(purchaseOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存采购单状态变化历史失败");
            }

            Map<Integer, Integer> saleProductMap = new HashMap<Integer, Integer>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductMap.put(saleProductProxyDto.getProductId(), saleProductProxyDto.getId());
            }
            stockInService.saveStockInByPurchaseOrderNo(purchaseOrderNo, saleProductMap);

            // 更新调出店铺商品库存信息和调入店铺商品库存信息
            List<PurchaseOrderItemDto> purchaseOrderItemDtos = new ArrayList<PurchaseOrderItemDto>();
            List<PurchaseOrderItem> purchaseOrderItems = purchaseOrderItemMapper.listPurchaseOrderItems(purchaseOrderNo);
            for (PurchaseOrderItem purchaseOrderItem : purchaseOrderItems) {
                PurchaseOrderItemDto purchaseOrderItemDto = new PurchaseOrderItemDto();
                ObjectUtils.fastCopy(purchaseOrderItem, purchaseOrderItemDto);
                purchaseOrderItemDtos.add(purchaseOrderItemDto);
            }
            // 更新库存
            saleProductInventoryService.updateInventoryForPurchaseFinish(purchaseOrderItemDtos, saleProductMap,
                    operateUserId, nowDate);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditRejected(String purchaseOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderNo)) {
                throw new OrderServiceException("采购单号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException("操作用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(rejectReason)) {
                throw new OrderServiceException("审核不能过理由不能为空");
            }
            PurchaseOrder purchaseOrder = purchaseOrderMapper.loadForUpdateByPurchaseOrderNo(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrder)) {
                throw new OrderServiceException("找不到采购单信息");
            }

            Date nowDate = new Date();

            purchaseOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED);
            purchaseOrder.setUpdateTime(nowDate);
            purchaseOrder.setUpdateUserId(operateUserId);
            purchaseOrder.setAuditTime(nowDate);
            purchaseOrder.setAuditUserId(operateUserId);
            purchaseOrder.setAuditRejectReason(rejectReason);
            Integer effectCount = purchaseOrderMapper.updateOrderStautsForAuditNotPassedByPurchaseOrderNo(purchaseOrderNo,
                    SystemContext.OrderDomain.PURCHASEORDERSTATUS_UNAUDIT,
                    SystemContext.OrderDomain.PURCHASEORDERSTATUS_AUDIT_NOTPASSED, rejectReason, nowDate, operateUserId);
            if (effectCount != 1) {
                throw new OrderServiceException("更新采购单状态失败");
            }

            // 保存采购单状态变化历史信息
            PurchaseOrderHistory purchaseOrderHistory = new PurchaseOrderHistory(purchaseOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.PURCHASEORDERSTATUS_AUDIT_NOTPASSED, "采购单审核不通过");
            effectCount = purchaseOrderHistoryMapper.save(purchaseOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException("保存采购单状态异常");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<PurchaseOrderHistoryDto> listPurchaseOrderHistorys(String purchaseOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(purchaseOrderNo)) {
                throw new OrderServiceException("采购订单不能为空");
            }
            List<PurchaseOrderHistory> items = purchaseOrderHistoryMapper.listPurchaseOrderHistorys(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<PurchaseOrderHistoryDto> itemDtos = new ArrayList<PurchaseOrderHistoryDto>();
            for (PurchaseOrderHistory item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                PurchaseOrderHistoryDto itemDto = new PurchaseOrderHistoryDto();
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
    public Long getCountsForExportPurchaseOrder(PurchaseOrderQueryDto purchaseOrderQueryDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            PurchaseOrderQuery purchaseOrderQuery = new PurchaseOrderQuery();
            List<PurchaseOrderAddress> purchaseOrderAddressList = null;
            List<String> purchaseOrderNos = null;
            if (!StringUtils.isEmpty(purchaseOrderQuery.getPhoneNo())) {
                PurchaseOrderAddressQuery purchaseOrderAddressQuery = new PurchaseOrderAddressQuery();
                purchaseOrderAddressQuery.setPhoneNo(purchaseOrderQuery.getPhoneNo());
                purchaseOrderAddressList = purchaseOrderAddressMapper.listPurchaseOrderAddress(purchaseOrderAddressQuery);
            }
            if (!ObjectUtils.isNullOrEmpty(purchaseOrderAddressList)) {
                purchaseOrderNos = new ArrayList<String>();
                for (PurchaseOrderAddress purchaseOrderAddress : purchaseOrderAddressList) {
                    purchaseOrderNos.add(purchaseOrderAddress.getPurchaseOrderNo());
                }
            }
            purchaseOrderQuery.setPurchaseOrderNoList(purchaseOrderNos);
            Long count = purchaseOrderMapper.getCountsForExportPurchaseOrder(purchaseOrderQuery);
            return null == count ? 0L : count.longValue();
        } catch (Exception e) {
            logger.error("findPurchaseOrders异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<PurchaseOrderDto> listDataForExportPurchaseOrder(PurchaseOrderQueryDto purchaseOrderQueryDto,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(purchaseOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            if (null == startLineNum || startLineNum <= 0) {
                purchaseOrderQueryDto.setStart(1);
            } else {
                purchaseOrderQueryDto.setStart(startLineNum.intValue());
            }
            if (null == pageSize || pageSize <= 0) {
                purchaseOrderQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            } else {
                purchaseOrderQueryDto.setPageSize(pageSize);
            }
            YiLiDiPage<PurchaseOrderDto> page = findPurchaseOrders(purchaseOrderQueryDto);
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
