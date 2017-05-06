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
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.dao.FlittingOrderAddressMapper;
import com.yilidi.o2o.order.dao.FlittingOrderHistoryMapper;
import com.yilidi.o2o.order.dao.FlittingOrderItemHistoryMapper;
import com.yilidi.o2o.order.dao.FlittingOrderItemMapper;
import com.yilidi.o2o.order.dao.FlittingOrderMapper;
import com.yilidi.o2o.order.dao.FlittingOrderRejectMapper;
import com.yilidi.o2o.order.dao.FlittingStockInRelationMapper;
import com.yilidi.o2o.order.dao.FlittingStockOutRelationMapper;
import com.yilidi.o2o.order.model.FlittingOrder;
import com.yilidi.o2o.order.model.FlittingOrderAddress;
import com.yilidi.o2o.order.model.FlittingOrderHistory;
import com.yilidi.o2o.order.model.FlittingOrderItem;
import com.yilidi.o2o.order.model.FlittingOrderItemHistory;
import com.yilidi.o2o.order.model.FlittingOrderReject;
import com.yilidi.o2o.order.model.query.FlittingOrderQuery;
import com.yilidi.o2o.order.service.IFlittingOrderService;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.IStockInService;
import com.yilidi.o2o.order.service.IStockOutService;
import com.yilidi.o2o.order.service.dto.FlittingOrderAddressDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderAuditDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderAuditItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDetailDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemHistoryDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderRejectDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderSaveDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.StoreTotalPrice;
import com.yilidi.o2o.order.service.dto.query.FlittingOrderQueryDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 调拨单处理实现类
 * 
 * @author simpson
 * 
 */
@Service("flittingOrderService")
public class FlittingOrderServiceImpl extends BasicDataService implements IFlittingOrderService {

    @Autowired
    private FlittingOrderMapper flittingOrderMapper;
    @Autowired
    private FlittingOrderHistoryMapper flittingOrderHistoryMapper;
    @Autowired
    private FlittingOrderRejectMapper flittingOrderRejectMapper;
    @Autowired
    private FlittingOrderAddressMapper flittingOrderAddressMapper;
    @Autowired
    private FlittingOrderItemMapper flittingOrderItemMapper;
    @Autowired
    private FlittingOrderItemHistoryMapper flittingOrderItemHistoryMapper;
    @Autowired
    private FlittingStockInRelationMapper flittingStockInRelationMapper;
    @Autowired
    private FlittingStockOutRelationMapper flittingStockOutRelationMapper;

    @Autowired
    private IStockInService stockInService;
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

    private static final String OPERATEUSERID_EMPTY = "调拨单编号不能为空";
    private static final String FLITTINGORDERNO_EMPTY = "操作用户ID不能为空";
    private static final String FLTTINGORDER_NONE = "根据调拨单编码查询不到调拨单信息";
    private static final String UPDATE_FLITTINGORDER_ERROR = "更新调拨单状态失败";
    private static final String FLITTINGORDERITEMS_EMPTY = "调拨单明细调整信息不能为空";
    private static final String SAVE_FLITTINGORDER_ERROR = "保存调货单信息失败";
    private static final String SAVE_FLITTINGORDERADDRESS_ERROR = "保存调货单收货信息失败";
    private static final String SAVE_FLITTINGORDERITEM_ERROR = "保存调货单明细信息失败";
    private static final String SAVE_FLITTINGORDERHISTORY_ERROR = "保存调货单状态信息失败";
    private static final String SAVE_FLITTINGORDERREJECT_ERROR = "保存调货单变化信息失败";
    private static final String SAVE_FLITTINGORDERITEMHISTORY_ERROR = "保存调货单明细变化信息失败";

    private static final String DISTRIBUTED_LOCK_PREFIX = "SAVE_FLITTING_STORE_";

    private Long getMinCreateFlittingOrderAmount() {
        String paramValue = getSystemParamValue(SystemContext.SystemParams.T_FLITTING_ORDER_CREATE_MIN_AMOUNT);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return 0L;
        }
        try {
            return Long.parseLong(paramValue);
        } catch (Exception e) {
            logger.error("转换T_FLITTING_ORDER_CREATE_MIN_AMOUNT参数值异常", e);
            return 0L;
        }
    }

    private Long getMaxFlittingOrderPromotionAmount() {
        String paramValue = getSystemParamValue(SystemContext.SystemParams.T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return 0L;
        }
        try {
            return Long.parseLong(paramValue);
        } catch (Exception e) {
            logger.error("转换T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT参数值异常", e);
            return 0L;
        }
    }

    @Override
    public String saveOrder(FlittingOrderSaveDto flittingOrderSaveDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderSaveDto)) {
                throw new OrderServiceException("调货保存对象不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderSaveDto.getSrcStoreId())) {
                throw new OrderServiceException("调出店铺ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderSaveDto.getDestStoreId())) {
                throw new OrderServiceException("调入店铺ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderSaveDto.getOperateUserId())) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderSaveDto.getFlittingProductList())) {
                throw new OrderServiceException("调货商品列表不能为空");
            }

            StoreProfileProxyDto srcStoreProfileProxyDto = storeProfileProxyService
                    .loadByStoreId(flittingOrderSaveDto.getSrcStoreId());
            if (ObjectUtils.isNullOrEmpty(srcStoreProfileProxyDto)) {
                throw new OrderServiceException("查找不到调出店铺信息");
            }

            StoreProfileProxyDto destStoreProfileProxyDto = storeProfileProxyService
                    .loadByStoreId(flittingOrderSaveDto.getDestStoreId());
            if (ObjectUtils.isNullOrEmpty(destStoreProfileProxyDto)) {
                throw new OrderServiceException("查找不到调入店铺信息");
            }

            List<Integer> srcSaleProductIds = new ArrayList<Integer>();
            List<FlittingOrderSaveItemDto> flittingOrderSaveItemDtos = flittingOrderSaveDto.getFlittingProductList();
            for (FlittingOrderSaveItemDto flittingOrderSaveItemDto : flittingOrderSaveItemDtos) {
                if (ObjectUtils.isNullOrEmpty(flittingOrderSaveItemDto)
                        || ObjectUtils.isNullOrEmpty(flittingOrderSaveItemDto.getSrcSaleProductId())
                        || ObjectUtils.isNullOrEmpty(flittingOrderSaveItemDto.getFlittingCount())
                        || flittingOrderSaveItemDto.getFlittingCount() <= 0) {
                    throw new OrderServiceException("存在无效的调货商品信息");
                }

                srcSaleProductIds.add(flittingOrderSaveItemDto.getSrcSaleProductId());
            }
            if (srcSaleProductIds.size() == 0) {
                throw new OrderServiceException("没有传入需要调货的商品");
            }

            List<SaleProductProxyDto> srcSaleProductProxyDtos = productProxyService.listSaleProductByIdsAndChannelCode(
                    srcSaleProductIds, SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, null);
            if (ObjectUtils.isNullOrEmpty(srcSaleProductProxyDtos)) {
                throw new OrderServiceException("查询不到需要调出的商品");
            }
            if (srcSaleProductIds.size() != srcSaleProductProxyDtos.size()) {
                throw new OrderServiceException("存在无效的商品");
            }

            List<Integer> productIds = new ArrayList<Integer>();
            Map<Integer, SaleProductProxyDto> srcSaleProductProxyMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto srcSaleProductProxyDto : srcSaleProductProxyDtos) {
                productIds.add(srcSaleProductProxyDto.getProductId());
                srcSaleProductProxyMap.put(srcSaleProductProxyDto.getId(), srcSaleProductProxyDto);
            }

            Integer operateUserId = flittingOrderSaveDto.getOperateUserId();
            Date nowDate = new Date();

            // 分布式锁，以防多个进程同时处理
            DistributedLockUtils.lock(DISTRIBUTED_LOCK_PREFIX + flittingOrderSaveDto.getDestStoreId());
            List<Integer> needCreateProductIds = new ArrayList<Integer>();
            List<SaleProductProxyDto> destSaleProductProxyDtos = productProxyService.listSaleProductByProductIdsAndStoreId(
                    productIds, SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, destStoreProfileProxyDto.getStoreId());
            if (ObjectUtils.isNullOrEmpty(destSaleProductProxyDtos)) {
                // 查询不到需要调入的商品，需要全部创建调入店铺的商品信息
                for (SaleProductProxyDto srcSaleProductProxyDto : srcSaleProductProxyDtos) {
                    needCreateProductIds.add(srcSaleProductProxyDto.getProductId());
                }
                destSaleProductProxyDtos = new ArrayList<SaleProductProxyDto>();
            }
            if (srcSaleProductProxyDtos.size() != destSaleProductProxyDtos.size()) {
                // 调出商品与调入商品存在不匹配，需要创建调入店铺不存在的商品信息
                for (SaleProductProxyDto srcSaleProductProxyDto : srcSaleProductProxyDtos) {
                    boolean isFound = false;
                    for (SaleProductProxyDto saleProductProxyDto : destSaleProductProxyDtos) {
                        if (srcSaleProductProxyDto.getProductId().intValue() == saleProductProxyDto.getProductId()
                                .intValue()) {
                            isFound = true;
                            break;
                        }
                    }
                    if (!isFound) {
                        needCreateProductIds.add(srcSaleProductProxyDto.getProductId());
                    }
                }
            }
            if (needCreateProductIds.size() > 0) {
                productProxyService.saveSaleProductByProductIdsAndStoreId(destStoreProfileProxyDto.getStoreId(),
                        destStoreProfileProxyDto.getStoreType(), needCreateProductIds, operateUserId, nowDate);
                List<SaleProductProxyDto> destNewSaleProductProxyDtos = productProxyService
                        .listSaleProductByProductIdsAndStoreId(needCreateProductIds,
                                SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                                SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE,
                                destStoreProfileProxyDto.getStoreId());
                destSaleProductProxyDtos.addAll(destNewSaleProductProxyDtos);
            }
            // 解锁
            DistributedLockUtils.unlock();

            Integer effectCount = 0;
            Integer flittingCount = 0;
            Long flittingAmount = 0L;
            String flittingOrderNo = StringUtils.generateFlittingOrderNo();

            // 组装调拨明细信息列表
            List<FlittingOrderItem> flittingOrderItems = new ArrayList<FlittingOrderItem>();
            List<FlittingOrderItemDto> flittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            for (FlittingOrderSaveItemDto flittingOrderSaveItemDto : flittingOrderSaveItemDtos) {
                FlittingOrderItem flittingOrderItem = new FlittingOrderItem();
                SaleProductProxyDto srcSaleProductProxyDto = srcSaleProductProxyMap
                        .get(flittingOrderSaveItemDto.getSrcSaleProductId());
                if (flittingOrderSaveItemDto.getFlittingCount() > srcSaleProductProxyDto.getRemainCount()) {
                    StringBuilder tipsBuilder = new StringBuilder("商品");
                    tipsBuilder.append(srcSaleProductProxyDto.getProductClassName()).append(CommonConstants.DELIMITER_SPACE)
                            .append(srcSaleProductProxyDto.getSaleProductName()).append("库存不足");
                    throw new OrderServiceException(tipsBuilder.toString());
                }
                flittingOrderItem.setBarCode(srcSaleProductProxyDto.getBarCode());
                flittingOrderItem.setBrandName(srcSaleProductProxyDto.getBrandName());
                flittingOrderItem.setCreateTime(nowDate);
                flittingOrderItem.setCreateUserId(operateUserId);
                flittingOrderItem.setFlittingOrderNo(flittingOrderNo);
                flittingOrderItem.setProductClassName(srcSaleProductProxyDto.getProductClassName());
                flittingOrderItem.setProductId(srcSaleProductProxyDto.getProductId());
                flittingOrderItem.setProductImageUrl3(srcSaleProductProxyDto.getSaleProductImageUrl());
                flittingOrderItem.setSpecifications(srcSaleProductProxyDto.getSaleProductSpec());
                flittingOrderItem.setProductName(srcSaleProductProxyDto.getSaleProductName());
                flittingOrderItem.setQuantity(flittingOrderSaveItemDto.getFlittingCount());
                flittingOrderItem.setSrcSaleProductId(srcSaleProductProxyDto.getId());
                for (SaleProductProxyDto destSaleProductProxyDto : destSaleProductProxyDtos) {
                    if (destSaleProductProxyDto.getProductId().intValue() == flittingOrderItem.getProductId().intValue()) {
                        flittingOrderItem.setDestSaleProductId(destSaleProductProxyDto.getId());
                        break;
                    }
                }
                flittingOrderItem.setCostPrice(srcSaleProductProxyDto.getCostPrice());
                flittingCount += flittingOrderItem.getQuantity();
                flittingAmount += flittingOrderItem.getQuantity() * srcSaleProductProxyDto.getPromotionalPrice();

                flittingOrderItems.add(flittingOrderItem);

                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);

                flittingOrderItemDtos.add(flittingOrderItemDto);
            }

            // 判断调入店铺是否能生成调货单
            if (flittingAmount < getMinCreateFlittingOrderAmount()) {
                // 调货金额小于最小调货金额
                throw new OrderServiceException("调货商品的金额小于最小调货金额，不能生成调货单");
            }
            StoreTotalPrice storeTotalPrice = saleProductInventoryService
                    .sumTotalPriceByStoreId(flittingOrderSaveDto.getDestStoreId());
            if (storeTotalPrice.getTotalPromotionPrice() + flittingAmount > getMaxFlittingOrderPromotionAmount()) {
                // 调货金额加上现有库存商品金额大于最大允许储存商品金额
                throw new OrderServiceException("调货金额加上现有库存商品金额大于最大允许储存商品金额，不能生成调货单");
            }

            // 保存调拨单信息
            FlittingOrder flittingOrder = new FlittingOrder();
            flittingOrder.setCreateTime(nowDate);
            flittingOrder.setCreateUserId(operateUserId);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setDestCityCode(destStoreProfileProxyDto.getCityCode());
            flittingOrder.setDestCountyCode(destStoreProfileProxyDto.getCountyCode());
            flittingOrder.setDestProvinceCode(destStoreProfileProxyDto.getProvinceCode());
            flittingOrder.setDestStoreId(destStoreProfileProxyDto.getStoreId());
            flittingOrder.setDestStoreName(destStoreProfileProxyDto.getStoreName());
            flittingOrder.setFlittingAmount(flittingAmount);
            flittingOrder.setFlittingCount(flittingCount);
            flittingOrder.setFlittingOrderNo(flittingOrderNo);
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_APPLY);
            flittingOrder.setSrcCityCode(srcStoreProfileProxyDto.getCityCode());
            flittingOrder.setSrcCountyCode(srcStoreProfileProxyDto.getCountyCode());
            flittingOrder.setSrcProvinceCode(srcStoreProfileProxyDto.getProvinceCode());
            flittingOrder.setSrcStoreId(srcStoreProfileProxyDto.getStoreId());
            flittingOrder.setSrcStoreName(srcStoreProfileProxyDto.getStoreName());

            effectCount = flittingOrderMapper.save(flittingOrder);
            if (1 != effectCount) {
                throw new OrderServiceException(SAVE_FLITTINGORDER_ERROR);
            }

            // 更新调出商品库存订购数量
            saleProductInventoryService.updateInventoryForFlittingCreate(flittingOrderItemDtos, flittingOrderNo,
                    flittingOrderSaveDto.getOperateUserId(), nowDate);

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_APPLY, "");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }

            // 保存调拨单地址信息
            FlittingOrderAddress flittingOrderAddress = new FlittingOrderAddress();
            flittingOrderAddress.setFlittingOrderNo(flittingOrderNo);
            flittingOrderAddress.setUserName(destStoreProfileProxyDto.getStoreName());
            flittingOrderAddress.setPhoneNo(destStoreProfileProxyDto.getMobile());
            flittingOrderAddress.setAddressDetail(destStoreProfileProxyDto.getAddressDetail());
            effectCount = flittingOrderAddressMapper.save(flittingOrderAddress);
            if (1 != effectCount) {
                throw new OrderServiceException(SAVE_FLITTINGORDERADDRESS_ERROR);
            }

            // 保存调拨单明细信息
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                effectCount = flittingOrderItemMapper.save(flittingOrderItem);
                if (1 != effectCount) {
                    throw new OrderServiceException(SAVE_FLITTINGORDERITEM_ERROR);
                }
            }

            return flittingOrderNo;
        } catch (Exception e) {
            logger.error("saveOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public FlittingOrderDto loadByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                return null;
            }
            FlittingOrderDto flittingOrderDto = new FlittingOrderDto();
            ObjectUtils.fastCopy(flittingOrder, flittingOrderDto);
            String orderStatusName = super.getSystemDictName(
                    SystemContext.OrderDomain.DictType.FLITTINGORDERSTATUS.getValue(), flittingOrderDto.getOrderStatus());
            flittingOrderDto.setOrderStatusName(orderStatusName);

            List<Integer> userIds = new ArrayList<Integer>();
            userIds.add(flittingOrder.getCreateUserId());
            userIds.add(flittingOrder.getAuditUserId());
            userIds.add(flittingOrder.getCheckUserId());
            userIds.add(flittingOrder.getUpdateUserId());
            List<UserProxyDto> userProxyDtoList = userProxyService.listUserByIds(userIds);
            if (!ObjectUtils.isNullOrEmpty(userProxyDtoList)) {
                for (UserProxyDto userProxyDto : userProxyDtoList) {
                    int userId = ArithUtils.converIntegerToInt(userProxyDto.getUserId());
                    if (userId == ArithUtils.converIntegerToInt(flittingOrderDto.getCreateUserId())) {
                        flittingOrderDto.setCreateUserName(userProxyDto.getUserName());
                    }
                    if (userId == ArithUtils.converIntegerToInt(flittingOrderDto.getAuditUserId())) {
                        flittingOrderDto.setAuditUserName(userProxyDto.getUserName());
                    }
                    if (userId == ArithUtils.converIntegerToInt(flittingOrderDto.getCheckUserId())) {
                        flittingOrderDto.setCheckUserName(userProxyDto.getUserName());
                    }
                    if (userId == ArithUtils.converIntegerToInt(flittingOrderDto.getUpdateUserId())) {
                        flittingOrderDto.setUpdateUserName(userProxyDto.getUserName());
                    }
                }
            }

            List<FlittingOrderItem> flittingOrderItemList = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            if (!ObjectUtils.isNullOrEmpty(flittingOrderItemList)) {
                List<FlittingOrderItemDto> flittingOrderItemDtoList = new ArrayList<FlittingOrderItemDto>();
                for (FlittingOrderItem flittingOrderItem : flittingOrderItemList) {
                    FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                    ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                    flittingOrderItemDtoList.add(flittingOrderItemDto);
                }
                flittingOrderDto.setFlittingOrderItemDtoList(flittingOrderItemDtoList);
            }
            FlittingOrderAddress flittingOrderAddress = flittingOrderAddressMapper.loadByFlittingOrderNo(flittingOrderNo);
            FlittingOrderAddressDto flittingOrderAddressDto = new FlittingOrderAddressDto();
            ObjectUtils.fastCopy(flittingOrderAddress, flittingOrderAddressDto);
            flittingOrderDto.setFlittingOrderAddressDto(flittingOrderAddressDto);
            return flittingOrderDto;
        } catch (Exception e) {
            logger.error("loadByFlittingOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public FlittingOrderDetailDto loadDetailByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException {
        try {
            FlittingOrderDto flittingOrderDto = this.loadByFlittingOrderNo(flittingOrderNo);
            if (null == flittingOrderDto) {
                return null;
            }
            FlittingOrderDetailDto flittingOrderDetailDto = new FlittingOrderDetailDto();
            flittingOrderDetailDto.setFlittingOrderDto(flittingOrderDto);
            List<FlittingOrderHistory> flittingOrderHistoryList = flittingOrderHistoryMapper
                    .listFlittingOrderHistorys(flittingOrderNo);
            List<FlittingOrderHistoryDto> flittingOrderHistoryDtoList = new ArrayList<FlittingOrderHistoryDto>();
            if (!ObjectUtils.isNullOrEmpty(flittingOrderHistoryList)) {
                for (FlittingOrderHistory flittingOrderHistory : flittingOrderHistoryList) {
                    FlittingOrderHistoryDto flittingOrderHistoryDto = new FlittingOrderHistoryDto();
                    ObjectUtils.fastCopy(flittingOrderHistory, flittingOrderHistoryDto);
                    flittingOrderHistoryDtoList.add(flittingOrderHistoryDto);
                }

            }
            flittingOrderDetailDto.setFlittingOrderHistoryDtoList(flittingOrderHistoryDtoList);
            List<FlittingOrderReject> flittingOrderRejectList = flittingOrderRejectMapper
                    .listFlittingOrderRejects(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrderRejectList)) {
                return flittingOrderDetailDto;
            }
            List<FlittingOrderRejectDto> flittingOrderRejectDtoList = new ArrayList<FlittingOrderRejectDto>();
            for (FlittingOrderReject flittingOrderReject : flittingOrderRejectList) {
                FlittingOrderRejectDto flittingOrderRejectDto = new FlittingOrderRejectDto();
                ObjectUtils.fastCopy(flittingOrderReject, flittingOrderRejectDto);
                List<FlittingOrderItemHistory> flittingOrderItemHistoryList = flittingOrderItemHistoryMapper
                        .listFlittingOrderItemHistorys(flittingOrderReject.getId());
                List<FlittingOrderItemHistoryDto> flittingOrderItemHistoryDtoList = new ArrayList<FlittingOrderItemHistoryDto>();
                if (!ObjectUtils.isNullOrEmpty(flittingOrderItemHistoryList)) {
                    for (FlittingOrderItemHistory flittingOrderItemHistory : flittingOrderItemHistoryList) {
                        if (SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_CHECKED
                                .equals(flittingOrderItemHistory.getOperateType())
                                && ArithUtils.converIntegerToInt(flittingOrderItemHistory.getRejectQuantity()) == 0) {
                            continue;
                        }
                        FlittingOrderItemHistoryDto flittingOrderItemHistoryDto = new FlittingOrderItemHistoryDto();
                        ObjectUtils.fastCopy(flittingOrderItemHistory, flittingOrderItemHistoryDto);
                        FlittingOrderItem flittingOrderItem = flittingOrderItemMapper
                                .loadById(flittingOrderItemHistory.getFlittingOrderItemId());
                        if (null != flittingOrderItem) {
                            FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                            ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                            flittingOrderItemHistoryDto.setFlittingOrderItemDto(flittingOrderItemDto);
                        }
                        flittingOrderItemHistoryDtoList.add(flittingOrderItemHistoryDto);
                    }
                }
                flittingOrderRejectDto.setFlittingOrderItemHistoryDtoList(flittingOrderItemHistoryDtoList);
                flittingOrderRejectDtoList.add(flittingOrderRejectDto);
            }
            flittingOrderDetailDto.setFlittingOrderRejectDtoList(flittingOrderRejectDtoList);
            return flittingOrderDetailDto;
        } catch (Exception e) {
            logger.error("loadByFlittingOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<FlittingOrderDto> findFlittingOrders(FlittingOrderQueryDto flittingOrderQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            FlittingOrderQuery flittingOrderQuery = new FlittingOrderQuery();
            ObjectUtils.fastCopy(flittingOrderQueryDto, flittingOrderQuery);
            PageHelper.startPage(flittingOrderQuery.getStart(), flittingOrderQuery.getPageSize());
            Page<FlittingOrder> flittingOrderPages = flittingOrderMapper.findFlittingOrderInfos(flittingOrderQuery);
            Page<FlittingOrderDto> pageDto = new Page<FlittingOrderDto>(flittingOrderQueryDto.getStart(),
                    flittingOrderQueryDto.getPageSize());
            ObjectUtils.fastCopy(flittingOrderPages, pageDto);
            List<FlittingOrder> flittingOrders = flittingOrderPages.getResult();
            if (!ObjectUtils.isNullOrEmpty(flittingOrders)) {
                for (FlittingOrder flittingOrder : flittingOrders) {
                    FlittingOrderDto flittingOrderDto = new FlittingOrderDto();
                    ObjectUtils.fastCopy(flittingOrder, flittingOrderDto);
                    String orderStatusName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.FLITTINGORDERSTATUS.getValue(),
                            flittingOrderDto.getOrderStatus());
                    flittingOrderDto.setOrderStatusName(orderStatusName);
                    FlittingOrderAddress flittingOrderAddress = flittingOrderAddressMapper
                            .loadByFlittingOrderNo(flittingOrderDto.getFlittingOrderNo());
                    if (!ObjectUtils.isNullOrEmpty(flittingOrderAddress)) {
                        FlittingOrderAddressDto flittingOrderAddressDto = new FlittingOrderAddressDto();
                        ObjectUtils.fastCopy(flittingOrderAddress, flittingOrderAddressDto);
                        flittingOrderDto.setFlittingOrderAddressDto(flittingOrderAddressDto);
                    }
                    pageDto.add(flittingOrderDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findFlittingOrders异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private FlittingOrder updateFlittingOrderItems(FlittingOrder flittingOrder,
            List<FlittingOrderItemDto> flittingOrderItemDtos, String operateType, String operationDesc) {
        List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper
                .listFlittingOrderItems(flittingOrder.getFlittingOrderNo());
        if (SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_CHECKED.equals(operateType)) {
            // 需要验证调拨单明细和传入的调整明细必须一样大小
            if (flittingOrderItemDtos.size() != flittingOrderItems.size()) {
                throw new OrderServiceException("传入的调拨单明细大小不一致");
            }
        } else {
            if (!SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_ADJUSTBYOPER.equals(operateType)) {
                throw new OrderServiceException("更新调拨单明细的操作类型非法");
            }
        }

        List<Integer> saleProductIds = new ArrayList<Integer>();
        for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
            saleProductIds.add(flittingOrderItem.getSrcSaleProductId());
        }
        // 获取调货商品的成本价列表信息
        List<SaleProductPriceProxyDto> saleProductPriceProxyDtos = productProxyService
                .listSaleProductPriceByIdsAndChannelCode(saleProductIds, null);

        Integer realFlittingCount = 0;
        Long realFlittingAmount = 0L;
        List<FlittingOrderItem> adjustItems = new ArrayList<FlittingOrderItem>();
        List<FlittingOrderItemHistory> adjustItemHistories = new ArrayList<FlittingOrderItemHistory>();
        for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
            boolean isFound = false;
            for (FlittingOrderItemDto adjustItemDto : flittingOrderItemDtos) {
                if (ObjectUtils.isNullOrEmpty(adjustItemDto) || ObjectUtils.isNullOrEmpty(adjustItemDto.getId())
                        || ObjectUtils.isNullOrEmpty(adjustItemDto.getReceiveQuantity())
                        || ObjectUtils.isNullOrEmpty(adjustItemDto.getRejectQuantity())) {
                    // 传入的明细信息存在空内容
                    throw new OrderServiceException("传入的明细信息存在空内容");
                }
                if (flittingOrderItem.getId().intValue() == adjustItemDto.getId().intValue()) {
                    isFound = true;
                    realFlittingCount += adjustItemDto.getReceiveQuantity();
                    if (ObjectUtils.isNullOrEmpty(flittingOrderItem.getReceiveQuantity()) || flittingOrderItem
                            .getReceiveQuantity().intValue() != adjustItemDto.getReceiveQuantity().intValue()) {
                        FlittingOrderItemHistory flittingOrderItemHistory = new FlittingOrderItemHistory();
                        flittingOrderItemHistory.setFlittingOrderItemId(flittingOrderItem.getId());
                        flittingOrderItemHistory.setOriReceiveQuantity(flittingOrderItem.getReceiveQuantity());
                        flittingOrderItemHistory.setOriRejectQuantity(flittingOrderItem.getRejectQuantity());
                        flittingOrderItemHistory.setReceiveQuantity(adjustItemDto.getReceiveQuantity());
                        flittingOrderItemHistory.setRejectQuantity(adjustItemDto.getRejectQuantity());
                        flittingOrderItemHistory.setOperateType(operateType);
                        flittingOrderItemHistory.setOperateTime(flittingOrder.getUpdateTime());
                        flittingOrderItemHistory.setOperateUserId(flittingOrder.getUpdateUserId());
                        flittingOrderItemHistory.setOperateDesc(operationDesc);
                        adjustItemHistories.add(flittingOrderItemHistory);

                        flittingOrderItem.setReceiveQuantity(adjustItemDto.getReceiveQuantity());
                        flittingOrderItem.setRejectQuantity(adjustItemDto.getRejectQuantity());
                        flittingOrderItem.setUpdateTime(flittingOrder.getUpdateTime());
                        flittingOrderItem.setUpdateUserId(flittingOrder.getUpdateUserId());
                        adjustItems.add(flittingOrderItem);
                    }
                }
            }
            if (!isFound) {
                if (SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_CHECKED.equals(operateType)) {
                    // 验货时必须传入所有调拨商品
                    StringBuilder tipsBuilder = new StringBuilder("未传入");
                    tipsBuilder.append(flittingOrderItem.getProductClassName()).append(" ")
                            .append(flittingOrderItem.getProductName()).append("的商品调整信息");
                    throw new OrderServiceException(tipsBuilder.toString());
                } else {
                    // 仲裁时如果没有找到需要调整的，则视为无争议
                    realFlittingCount += flittingOrderItem.getReceiveQuantity();
                }
            }
            for (SaleProductPriceProxyDto saleProductPriceProxyDto : saleProductPriceProxyDtos) {
                if (flittingOrderItem.getSrcSaleProductId().intValue() == saleProductPriceProxyDto.getSaleProductId()
                        .intValue()) {
                    realFlittingAmount += saleProductPriceProxyDto.getPromotionalPrice()
                            * flittingOrderItem.getReceiveQuantity();
                    break;
                }
            }
        }
        if (adjustItems.size() == 0) {
            throw new OrderServiceException("没有传入正确的需要调整的明细信息");
        }

        // 创建调拨单调整历史记录
        FlittingOrderReject flittingOrderReject = new FlittingOrderReject();
        flittingOrderReject.setFlittingOrderNo(flittingOrder.getFlittingOrderNo());
        if (SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_CHECKED.equals(operateType)) {
            flittingOrderReject.setOriRealFlittingAmount(flittingOrder.getFlittingAmount());
            flittingOrderReject.setOriRealFlittingCount(flittingOrder.getFlittingCount());
            flittingOrderReject.setOperateType(SystemContext.OrderDomain.FLITTINGORDERHISOPERTYPE_CHECKED);
        } else {
            flittingOrderReject.setOriRealFlittingAmount(flittingOrder.getRealFlittingAmount());
            flittingOrderReject.setOriRealFlittingCount(flittingOrder.getRealFlittingCount());
            flittingOrderReject.setOperateType(SystemContext.OrderDomain.FLITTINGORDERHISOPERTYPE_ADJUSTBYOPER);
        }
        flittingOrderReject.setOperateTime(flittingOrder.getUpdateTime());
        flittingOrderReject.setOperateUserId(flittingOrder.getUpdateUserId());
        flittingOrderReject.setOperateDesc(operationDesc);
        flittingOrderReject.setRealFlittingAmount(realFlittingAmount);
        flittingOrderReject.setRealFlittingCount(realFlittingCount);
        Integer effectCount = flittingOrderRejectMapper.save(flittingOrderReject);
        if (1 != effectCount) {
            throw new OrderServiceException(SAVE_FLITTINGORDERREJECT_ERROR);
        }

        // 更新调拨单明细信息
        for (FlittingOrderItem adjustItem : adjustItems) {
            flittingOrderItemMapper.updateReceiveQuantityByFlittingOrderItemId(adjustItem);
        }
        // 创建调拨单调整历史明细记录
        for (FlittingOrderItemHistory flittingOrderItemHistory : adjustItemHistories) {
            flittingOrderItemHistory.setFlittingOrderRejectId(flittingOrderReject.getId());
            effectCount = flittingOrderItemHistoryMapper.save(flittingOrderItemHistory);
            if (1 != effectCount) {
                throw new OrderServiceException(SAVE_FLITTINGORDERITEMHISTORY_ERROR);
            }
        }

        flittingOrder.setRealFlittingAmount(realFlittingAmount);
        flittingOrder.setRealFlittingCount(realFlittingCount);

        return flittingOrder;
    }

    @Override
    public void updateForAcceptPassed(String flittingOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为接收
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_PASSED);
            flittingOrder.setAcceptStatus(SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_PASSED);
            flittingOrder.setAcceptTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);
            Integer effectCount = flittingOrderMapper.updateAcceptStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_APPLY, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTED, "正在积极备货中");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (1 != effectCount) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }
            // 更新待发货数量
            List<FlittingOrderItemDto> flittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtos.add(flittingOrderItemDto);
            }
            saleProductInventoryService.updateInventoryForFlittingAccept(flittingOrderItemDtos, flittingOrderNo,
                    operateUserId, nowDate);
        } catch (Exception e) {
            logger.error("updateForAcceptPassed异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAcceptRejected(String flittingOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为拒绝
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTREJECTED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_REJECTED);
            flittingOrder.setAcceptTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);
            flittingOrder.setAcceptRejectReason(rejectReason);
            Integer effectCount = flittingOrderMapper.updateAcceptStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_APPLY, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTREJECTED, "调拨单、调拨商品出错了");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }

            // 更新调出店铺库存，清除响应的订购数量
            List<FlittingOrderItemDto> flittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtos.add(flittingOrderItemDto);
            }
            saleProductInventoryService.updateInventoryForFlittingAcceptReject(flittingOrderItemDtos, flittingOrderNo,
                    operateUserId, nowDate);
        } catch (Exception e) {
            logger.error("updateForAcceptRejected异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForSend(String flittingOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为发货
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_SEND);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setSendStatus(SystemContext.OrderDomain.FLITTINGORDERSENDSTATUS_SENT);
            flittingOrder.setSendTime(nowDate);
            flittingOrder.setSendUserId(operateUserId);
            Integer effectCount = flittingOrderMapper.updateSendStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERSENDSTATUS_NOTYET,
                    SystemContext.OrderDomain.FLITTINGORDERACCEPTSTATUS_PASSED, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_SEND, "已安排仓储人员配送");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }
            // 生成调货出库单及明细
            stockOutService.saveStockOutByFlittingOrderNo(flittingOrderNo);

            // 更新调出店铺库存，扣除调出店铺的库存
            List<FlittingOrderItemDto> flittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtos.add(flittingOrderItemDto);
            }
            saleProductInventoryService.updateInventoryForFlittingSend(flittingOrderItemDtos, flittingOrderNo, operateUserId,
                    nowDate);
        } catch (Exception e) {
            logger.error("updateForSend异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForChecking(String flittingOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为验货中
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKING);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setCheckStatus(SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKING);
            flittingOrder.setCheckTime(nowDate);
            flittingOrder.setCheckUserId(operateUserId);
            Integer effectCount = flittingOrderMapper.updateCheckStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_NOTYET,
                    SystemContext.OrderDomain.FLITTINGORDERSENDSTATUS_SENT, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKING, "商品验货确认中");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }
        } catch (Exception e) {
            logger.error("updateForChecking异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForChecked(String flittingOrderNo, List<FlittingOrderItemDto> flittingOrderItemDtos,
            Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderItemDtos)) {
                throw new OrderServiceException(FLITTINGORDERITEMS_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为验货完毕
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setCheckStatus(SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKED);
            flittingOrder.setCheckTime(nowDate);
            flittingOrder.setCheckUserId(operateUserId);

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKED, "等待微仓确认调拨商品数量");
            Integer effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }

            // 更新调拨单明细信息
            flittingOrder = updateFlittingOrderItems(flittingOrder, flittingOrderItemDtos,
                    SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_CHECKED, "合伙人验货调整");

            // 更新调拨单状态
            effectCount = flittingOrderMapper.updateCheckedByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKING,
                    SystemContext.OrderDomain.FLITTINGORDERSENDSTATUS_SENT, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }
        } catch (Exception e) {
            logger.error("updateForChecked异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditPassed(String flittingOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为调货完成
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_PASSED);
            flittingOrder.setAuditTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);
            Integer effectCount = flittingOrderMapper.updateAuditStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_NOTYET,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKED, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED, "微仓确认调拨数量，审核通过");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }

            // 生成调出店铺入库单和调入店铺入库单及相关明细信息
            stockInService.saveStockInByFlittingOrderNo(flittingOrderNo);

            // 更新调出店铺商品库存信息和调入店铺商品库存信息
            List<FlittingOrderItemDto> flittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtos.add(flittingOrderItemDto);
            }
            saleProductInventoryService.updateInventoryForFlittingFinish(flittingOrderItemDtos, flittingOrderNo,
                    operateUserId, nowDate);
        } catch (Exception e) {
            logger.error("updateForAuditPassed异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAuditRejected(String flittingOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为发货
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_REJECTED);
            flittingOrder.setAuditTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);
            flittingOrder.setAuditRejectReason(rejectReason);
            Integer effectCount = flittingOrderMapper.updateAuditStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_NOTYET,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKED, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED, "微仓对实际调拨数量有争议，申请平台客服介入");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }
        } catch (Exception e) {
            logger.error("updateForAuditRejected异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForArbitrateByOper(String flittingOrderNo, Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为发货
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_ARBITRATE);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_ARBITRATE);
            flittingOrder.setAuditTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);
            Integer effectCount = flittingOrderMapper.updateAuditStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_REJECTED,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKED, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_ARBITRATE, "解决调拨争议、确认实际调拨数量中");
            effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }
        } catch (Exception e) {
            logger.error("updateForArbitrateByOper异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForAdjustAndFinishByOper(String flittingOrderNo, List<FlittingOrderItemDto> flittingOrderItemDtos,
            Integer operateUserId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(operateUserId)) {
                throw new OrderServiceException(OPERATEUSERID_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(flittingOrderItemDtos)) {
                throw new OrderServiceException(FLITTINGORDERITEMS_EMPTY);
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadForUpdateByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException(FLTTINGORDER_NONE);
            }

            Date nowDate = new Date();
            // 修改调拨单状态为完成
            flittingOrder.setOrderStatus(SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED);
            flittingOrder.setUpdateTime(nowDate);
            flittingOrder.setUpdateUserId(operateUserId);
            flittingOrder.setAuditStatus(SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_PASSED);
            flittingOrder.setAuditTime(nowDate);
            flittingOrder.setAuditUserId(operateUserId);

            // 保存调拨单状态变化历史信息
            FlittingOrderHistory flittingOrderHistory = new FlittingOrderHistory(flittingOrderNo, operateUserId, nowDate,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED, "调拨争议已调解完成，三方最终确认实际调拨数量");
            Integer effectCount = flittingOrderHistoryMapper.save(flittingOrderHistory);
            if (effectCount != 1) {
                throw new OrderServiceException(SAVE_FLITTINGORDERHISTORY_ERROR);
            }

            // 更新调拨单明细信息
            flittingOrder = updateFlittingOrderItems(flittingOrder, flittingOrderItemDtos,
                    SystemContext.OrderDomain.FLITTINGORDERITEMHISOPERTYPE_ADJUSTBYOPER, "后台操作员调整");

            // 更新调拨单状态
            effectCount = flittingOrderMapper.updateAuditStautsByFlittingOrderNo(flittingOrderNo,
                    SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_ARBITRATE,
                    SystemContext.OrderDomain.FLITTINGORDERCHECKSTATUS_CHECKED, flittingOrder);
            if (effectCount != 1) {
                throw new OrderServiceException(UPDATE_FLITTINGORDER_ERROR);
            }

            // 更新调出店铺商品库存信息和调入店铺商品库存信息
            List<FlittingOrderItemDto> updatedFlittingOrderItemDtos = new ArrayList<FlittingOrderItemDto>();
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtos.add(flittingOrderItemDto);
            }
            saleProductInventoryService.updateInventoryForFlittingFinish(updatedFlittingOrderItemDtos, flittingOrderNo,
                    operateUserId, nowDate);
        } catch (Exception e) {
            logger.error("updateForAdjustAndFinishByOper异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<FlittingOrderHistoryDto> listFlittingOrderHistorys(String flittingOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            List<FlittingOrderHistory> items = flittingOrderHistoryMapper.listFlittingOrderHistorys(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<FlittingOrderHistoryDto> itemDtos = new ArrayList<FlittingOrderHistoryDto>();
            for (FlittingOrderHistory item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                FlittingOrderHistoryDto itemDto = new FlittingOrderHistoryDto();
                ObjectUtils.fastCopy(item, itemDto);
                itemDtos.add(itemDto);
            }
            return itemDtos;
        } catch (Exception e) {
            logger.error("listFlittingOrderHistorys异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<FlittingOrderRejectDto> listFlittingOrderRejects(String flittingOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(flittingOrderNo)) {
                throw new OrderServiceException(FLITTINGORDERNO_EMPTY);
            }
            List<FlittingOrderReject> items = flittingOrderRejectMapper.listFlittingOrderRejects(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<FlittingOrderRejectDto> itemDtos = new ArrayList<FlittingOrderRejectDto>();
            for (FlittingOrderReject item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                FlittingOrderRejectDto itemDto = new FlittingOrderRejectDto();
                ObjectUtils.fastCopy(item, itemDto);
                itemDtos.add(itemDto);
            }
            return itemDtos;
        } catch (Exception e) {
            logger.error("listFlittingOrderRejects异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForUlitmateModify(FlittingOrderAuditDto flittingOrderAuditDto, Integer operateUserId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderAuditDto)
                    || ObjectUtils.isNullOrEmpty(flittingOrderAuditDto.getFlittingOrderNo())
                    || ObjectUtils.isNullOrEmpty(flittingOrderAuditDto.getFlittingOrderAuditItemDtoList())) {
                throw new OrderServiceException("参数不能为空");
            }
            if (null == operateUserId) {
                throw new OrderServiceException("操作用户不能为空");
            }
            List<FlittingOrderAuditItemDto> flittingOrderAuditItemDtoList = flittingOrderAuditDto
                    .getFlittingOrderAuditItemDtoList();
            List<FlittingOrderItemDto> flittingOrderItemDtoList = new ArrayList<FlittingOrderItemDto>();
            for (FlittingOrderAuditItemDto flittingOrderAuditItemDto : flittingOrderAuditItemDtoList) {
                FlittingOrderItem flittingOrderItem = flittingOrderItemMapper
                        .loadById(flittingOrderAuditItemDto.getFlittingOrderItemId());
                if (ObjectUtils.isNullOrEmpty(flittingOrderItem)) {
                    logger.error("采购明细ID[" + flittingOrderAuditItemDto.getFlittingOrderItemId() + "]不存在");
                    throw new OrderServiceException("存在无效的采购明细信息");
                }
                flittingOrderItem.setReceiveQuantity(flittingOrderAuditItemDto.getRealReceiveQuantity());
                flittingOrderItem.setRejectQuantity(ArithUtils.converIntegerToInt(flittingOrderItem.getQuantity())
                        - ArithUtils.converIntegerToInt(flittingOrderItem.getReceiveQuantity()));
                FlittingOrderItemDto flittingOrderItemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(flittingOrderItem, flittingOrderItemDto);
                flittingOrderItemDtoList.add(flittingOrderItemDto);
            }
            this.updateForAdjustAndFinishByOper(flittingOrderAuditDto.getFlittingOrderNo(), flittingOrderItemDtoList,
                    operateUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }

}
