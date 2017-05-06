/**
 * 文件名称：CommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.ActivityOrderCustomerRecMapper;
import com.yilidi.o2o.order.dao.FirstOrderCustomerRecMapper;
import com.yilidi.o2o.order.dao.SecKillSaleProductInventoryMapper;
import com.yilidi.o2o.order.dao.ShopCartMapper;
import com.yilidi.o2o.order.dao.UserCouponMapper;
import com.yilidi.o2o.order.dao.UserVoucherMapper;
import com.yilidi.o2o.order.model.FirstOrderCustomerRec;
import com.yilidi.o2o.order.model.SecKillSaleProductInventory;
import com.yilidi.o2o.order.model.ShopCart;
import com.yilidi.o2o.order.model.result.UserCouponInfo;
import com.yilidi.o2o.order.model.result.UserVoucherInfo;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IShopCartService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.CreateOrderDto;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.SettlementOrderDto;
import com.yilidi.o2o.order.service.dto.ShopCartDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.query.ShopCartQuery;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.ISecKillProductProxyService;
import com.yilidi.o2o.product.proxy.ISecKillSceneProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SecKillProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SecKillSceneProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.user.proxy.IConsigneeAddressProxyService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.ConsigneeAddressProxyDto;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 功能描述：购物车服务层实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("shopCartService")
public class ShopCartServiceImpl extends BasicDataService implements IShopCartService {

    @Autowired
    private ShopCartMapper shopCartMapper;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private IConsigneeAddressProxyService consigneeAddressProxyService;
    @Autowired
    private IUserProxyService userProxyService;
    @Autowired
    private FirstOrderCustomerRecMapper firstOrderCustomerRecMapper;
    @Autowired
    private SecKillSaleProductInventoryMapper secKillSaleProductInventoryMapper;
    @Autowired
    private ISecKillProductProxyService secKillProductProxyService;
    @Autowired
    private ActivityOrderCustomerRecMapper activityOrderCustomerRecMapper;
    @Autowired
    private ISecKillSceneProxyService secKillSceneProxyService;
    @Autowired
    private IStoreWarehouseProxyService storeWarehouseProxyService;
    @Autowired
    private ICouponService couponService;
    @Autowired
    private IVoucherService voucherService;
    @Autowired
    private UserCouponMapper userCouponMapper;
    @Autowired
    private UserVoucherMapper userVoucherMapper;
    @Autowired
    private IMessageProxyService messageProxyService;

    /** 不限制购买商品 **/
    private static final Integer PRODUCT_NO_LIMIT_COUNT = -1;
    /** 一分钱可购买数量 **/
    private static final Integer PENNY_PRODUCT_LIMIT_COUNT = 1;
    /** 不能购的限制 **/
    private static final Integer PRODUCT_CANTNOT_BUYER_LIMIT_COUNT = 0;
    /** VIP订单 **/
    private static final Integer VIPORDER_YES = 1;
    /** 不是VIP订单 **/
    private static final Integer VIPORDER_NO = 0;
    /** 券可用 **/
    private static final Integer TICKETWOULDUSE_USEBLE = 1;
    /** 券不可用 **/
    private static final Integer TICKETWOULDUSE_UNUSEBLE = 0;
    /** 奖券信息是否是单选:单选 **/
    private static final int TICKET_SELECT_ONE = 1;

    @Override
    public List<ShopCartDto> updateConfirmCart(List<ShopCartQuery> shopCartQueryList, Integer storeId, Integer userId,
            Integer customerId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartQueryList)) {
                logger.info("购物车信息参数为空");
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.info("店铺ID为空");
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(userId) || ObjectUtils.isNullOrEmpty(customerId)) {
                logger.info("用户信息为空");
                return Collections.emptyList();
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("店铺ID[" + storeId + "]没有找到店铺信息");
                return Collections.emptyList();
            }
            if (!SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileProxyDto.getStoreStatus())) {
                logger.info("店铺[" + storeId + "," + storeProfileProxyDto.getStoreName() + "]已关闭营业");
                return Collections.emptyList();
            }
            storeId = storeProfileProxyDto.getStoreId();
            String channelCode = null;
            Date nowDate = new Date();

            List<Integer> saleProductIds = new ArrayList<Integer>();
            List<Map<Integer, Integer>> activityIdAndSaleProductMaps = new ArrayList<Map<Integer, Integer>>();
            for (ShopCartQuery shopCartQuery : shopCartQueryList) {
                saleProductIds.add(shopCartQuery.getSaleProductId());
                channelCode = shopCartQuery.getChannelCode();
                if (!ObjectUtils.isNullOrEmpty(shopCartQuery.getActivityId())
                        && shopCartQuery.getActivityId().intValue() > 0) {
                    Map<Integer, Integer> map = new HashMap<Integer, Integer>();
                    map.put(shopCartQuery.getActivityId(), shopCartQuery.getSaleProductId());
                    activityIdAndSaleProductMaps.add(map);
                }
            }

            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, channelCode);
            List<SecKillProductProxyDto> secKillProductProxyDtos = null;
            if (!ObjectUtils.isNullOrEmpty(activityIdAndSaleProductMaps)) {
                secKillProductProxyDtos = secKillProductProxyService
                        .listByActivityIdAndSaleProductIdMaps(activityIdAndSaleProductMaps);
            }
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                    saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
                }
            }
            List<SecKillSceneProxyDto> secKillSceneProxyDtos = secKillSceneProxyService.listStartedAndStaring(nowDate);
            List<Integer> avaliableActivityIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneProxyDtos)) {
                for (SecKillSceneProxyDto secKillSceneProxyDto : secKillSceneProxyDtos) {
                    avaliableActivityIds.add(secKillSceneProxyDto.getActivityId());
                }
            }
            FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper.loadByBuyerCustomerIdAndFirstOrderType(
                    customerId, SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
            List<ShopCartDto> shopCartDtoList = new ArrayList<ShopCartDto>();
            List<ShopCart> shopCartList = new ArrayList<ShopCart>();
            for (ShopCartQuery shopCartQuery : shopCartQueryList) {
                ShopCart shopCart = new ShopCart();
                ObjectUtils.fastCopy(shopCartQuery, shopCart);
                shopCart.setStoreId(storeId);
                shopCart.setUserId(userId);
                shopCart.setActivityId(shopCartQuery.getActivityId());
                shopCart.setCreateTime(nowDate);
                shopCartList.add(shopCart);
                ShopCartDto shopCartDto = new ShopCartDto();
                ObjectUtils.fastCopy(shopCart, shopCartDto);
                shopCartDto.setUserId(userId);
                shopCartDto.setStoreName(storeProfileProxyDto.getStoreName());
                Integer saleProductId = shopCart.getSaleProductId();
                if (saleProductProxyDtoMap.containsKey(saleProductId)) {
                    SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleProductId);
                    ObjectUtils.fastCopy(saleProductProxyDto, shopCartDto);
                    if (!ObjectUtils.isNullOrEmpty(shopCart.getActivityId()) && shopCart.getActivityId().intValue() > 0) {
                        if (!avaliableActivityIds.contains(shopCart.getActivityId())) {
                            shopCartDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                        }
                        if (ObjectUtils.isNullOrEmpty(secKillProductProxyDtos)) {
                            shopCartDto.setLimitCount(0);
                            shopCartDto.setRemainCount(0);
                        } else {
                            for (SecKillProductProxyDto secKillProductProxyDto : secKillProductProxyDtos) {
                                if (secKillProductProxyDto.getActivityId().intValue() == shopCart.getActivityId().intValue()
                                        && shopCart.getSaleProductId().intValue() == secKillProductProxyDto
                                                .getSaleProductId().intValue()) {
                                    if (SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
                                            .equals(secKillProductProxyDto.getStatusCode())) {
                                        shopCartDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                                    }
                                    shopCartDto.setPromotionalPrice(secKillProductProxyDto.getSecKillProductPrice());
                                    shopCartDto.setRetailPrice(secKillProductProxyDto.getSecKillProductPrice());
                                    int limitOrderCount = ArithUtils
                                            .converIntegerToInt(secKillProductProxyDto.getLimitOrderCount());
                                    int secKillOrderCount = ArithUtils
                                            .converIntegerToInt(secKillProductProxyDto.getSecKillCount());
                                    if (limitOrderCount > secKillOrderCount || 0 == limitOrderCount) {
                                        limitOrderCount = secKillOrderCount;
                                    }
                                    int orderCount = ArithUtils.converIntegerToInt(activityOrderCustomerRecMapper
                                            .loadSaleProductOrderCountByActivityIdAndSaleProductId(shopCart.getActivityId(),
                                                    saleProductId,
                                                    SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL));
                                    if (orderCount >= secKillOrderCount) {
                                        limitOrderCount = 0;
                                    }
                                    Integer customerOrderCount = activityOrderCustomerRecMapper
                                            .loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(customerId,
                                                    shopCart.getActivityId(), saleProductId, shopCartQuery.getDeviceId(),
                                                    null);
                                    limitOrderCount = limitOrderCount - ArithUtils.converIntegerToInt(customerOrderCount);
                                    if (limitOrderCount > secKillOrderCount - orderCount) {
                                        limitOrderCount = secKillOrderCount - orderCount;
                                    }
                                    if (limitOrderCount <= 0) {
                                        limitOrderCount = 0;
                                    }
                                    shopCartDto.setLimitCount(limitOrderCount);
                                    SecKillSaleProductInventory secKillSaleProductInventory = secKillSaleProductInventoryMapper
                                            .loadByActivityIdAndSaleProductId(shopCart.getSaleProductId(),
                                                    shopCart.getActivityId());
                                    if (ObjectUtils.isNullOrEmpty(secKillSaleProductInventory)) {
                                        shopCartDto.setRemainCount(0);
                                    } else if (saleProductProxyDto.getRemainCount().intValue() > secKillSaleProductInventory
                                            .getRemainCount().intValue()) {
                                        shopCartDto.setRemainCount(secKillSaleProductInventory.getRemainCount());
                                    }
                                    long secKillTime = ArithUtils.converLongTolong(secKillProductProxyDto.getSecKillTime());
                                    if (secKillTime > 0 && nowDate.after(DateUtils
                                            .addSeconds(secKillProductProxyDto.getStartTime(), (int) secKillTime))) {
                                        shopCartDto.setRemainCount(0);
                                    }
                                    break;
                                }
                            }
                        }
                    } else {
                        if (isPennySaleProduct(saleProductProxyDto.getProductId())) {
                            if (!ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                                shopCartDto.setLimitCount(PRODUCT_CANTNOT_BUYER_LIMIT_COUNT);
                            } else {
                                shopCartDto.setLimitCount(PENNY_PRODUCT_LIMIT_COUNT);
                            }
                        } else {
                            shopCartDto.setLimitCount(PRODUCT_NO_LIMIT_COUNT);
                        }
                    }
                }
                shopCartDtoList.add(shopCartDto);
            }
            shopCartMapper.deleteByUserId(userId);
            Integer result = shopCartMapper.saveBatch(shopCartList);
            if (result != shopCartList.size()) {
                throw new OrderServiceException("确认购物车异常");
            }
            return shopCartDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<ShopCartDto> updateSynchronousCart(List<ShopCartQuery> shopCartQueryList, Integer storeId, Integer userId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.info("店铺ID为空");
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                logger.info("用户信息为空");
                return Collections.emptyList();
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("店铺ID[" + storeId + "]没有找到店铺信息");
                return Collections.emptyList();
            }
            if (!SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileProxyDto.getStoreStatus())) {
                logger.info("店铺[" + storeId + "," + storeProfileProxyDto.getStoreName() + "]已关闭营业");
                return Collections.emptyList();
            }
            storeId = storeProfileProxyDto.getStoreId();
            String channelCode = null;
            if (!ObjectUtils.isNullOrEmpty(shopCartQueryList)) {
                List<Integer> vipProductIds = getVipProductIds();
                List<SaleProductProxyDto> vipSaleProductProxyDtoList = null;
                if (!ObjectUtils.isNullOrEmpty(vipProductIds)) {
                    vipSaleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(vipProductIds,
                            null, null, storeId);
                }
                List<ShopCart> shopCartParams = new ArrayList<ShopCart>();
                List<Integer> deleteShopCartProductIds = new ArrayList<Integer>();
                List<Integer> saleProductIds = new ArrayList<Integer>();
                List<ShopCart> saveShopCartList = new ArrayList<ShopCart>();
                List<ShopCart> updateShopCartList = new ArrayList<ShopCart>();
                Date operatorTime = new Date();
                for (ShopCartQuery shopCartQuery : shopCartQueryList) {
                    ShopCart shopCart = new ShopCart();
                    shopCart.setUserId(userId);
                    shopCart.setStoreId(storeId);
                    shopCart.setQuantity(shopCartQuery.getQuantity());
                    shopCart.setSaleProductId(shopCartQuery.getSaleProductId());
                    shopCart.setActivityId(shopCartQuery.getActivityId());
                    shopCart.setModifyTime(operatorTime);
                    shopCart.setCreateTime(operatorTime);
                    shopCartParams.add(shopCart);

                    channelCode = shopCartQuery.getChannelCode();
                    saleProductIds.add(shopCartQuery.getSaleProductId());
                }
                List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                        .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, channelCode);
                List<ShopCart> existsShopCartList = shopCartMapper.listUserShopCartBySaleProductIds(null, userId, storeId);
                setShopCartInfo(shopCartParams, saleProductProxyDtoList, vipSaleProductProxyDtoList, saveShopCartList,
                        updateShopCartList, deleteShopCartProductIds, existsShopCartList);
                if (!ObjectUtils.isNullOrEmpty(deleteShopCartProductIds)) {
                    shopCartMapper.deleteByUserIdAndProductIds(userId, deleteShopCartProductIds);
                }
                if (!ObjectUtils.isNullOrEmpty(updateShopCartList)) {
                    this.updateShopCartNumberBatch(updateShopCartList);
                }
                if (!ObjectUtils.isNullOrEmpty(saveShopCartList)) {
                    Integer result = shopCartMapper.saveBatch(saveShopCartList);
                    if (result != saveShopCartList.size()) {
                        throw new OrderServiceException("保存购物车异常");
                    }
                }
            }
            // 查询购物车记录
            List<ShopCart> shopCarts = shopCartMapper.listUserShopCartBySaleProductIds(null, userId, storeId);
            List<SaleProductProxyDto> saleProductProxyDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(shopCarts)) {
                List<Integer> saleProductIds = new ArrayList<Integer>();
                for (ShopCart shopCart : shopCarts) {
                    saleProductIds.add(shopCart.getSaleProductId());
                }
                saleProductProxyDtoList = productProxyService.listSaleProductByIdsAndChannelCode(saleProductIds, null, null,
                        channelCode);
            }
            List<ShopCartDto> shopCartDtoList = getShopCartDtoList(shopCarts, saleProductProxyDtoList);
            return shopCartDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    // 校验一分钱商品(只能买一件)
    private void validatePennySaleProduct(Integer customerId, List<SaleProductProxyDto> pennySaleProductProxyDtoList,
            List<CreateOrderItemDto> createOrderItemDtos) {
        if (ObjectUtils.isNullOrEmpty(createOrderItemDtos)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(pennySaleProductProxyDtoList)) {
            return;
        }
        Map<Integer, SaleProductProxyDto> pennySaleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : pennySaleProductProxyDtoList) {
            pennySaleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                .loadByBuyerCustomerIdAndFirstOrderType(customerId, SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) {
                if (pennySaleProductMap.containsKey(createOrderItemDto.getSaleProductId())) {
                    SaleProductProxyDto saleProductProxyDto = pennySaleProductMap.get(createOrderItemDto.getSaleProductId());
                    if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON
                            .equals(saleProductProxyDto.getEnabledFlag())) {
                        throw new OrderServiceException("一分钱商品:" + saleProductProxyDto.getSaleProductName() + "已删除");
                    }
                    if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE
                            .equals(saleProductProxyDto.getSaleStatus())) {
                        throw new OrderServiceException("一分钱商品:" + saleProductProxyDto.getSaleProductName() + "已下架");
                    }
                    if (!ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                        String message = "亲,您已经购买过一分钱商品:" + saleProductProxyDto.getSaleProductName() + "了";
                        throw new OrderServiceException(message);
                    }
                    if (createOrderItemDto.getCartNum().intValue() > PENNY_PRODUCT_LIMIT_COUNT) {
                        String message = "亲,您只能购买" + PENNY_PRODUCT_LIMIT_COUNT + "份一分钱商品("
                                + saleProductProxyDto.getSaleProductName() + ")";
                        throw new OrderServiceException(message);
                    }
                }
            }
        }
    }

    // 校验一分钱商品(一个设备只能买一件)
    private void validatePennySaleProductByDeviceId(String deviceId, List<SaleProductProxyDto> pennySaleProductProxyDtoList,
            List<CreateOrderItemDto> createOrderItemDtos) {
        if (ObjectUtils.isNullOrEmpty(createOrderItemDtos)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(pennySaleProductProxyDtoList)) {
            return;
        }
        Map<Integer, SaleProductProxyDto> pennySaleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : pennySaleProductProxyDtoList) {
            pennySaleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        FirstOrderCustomerRec firstOrderDeviceRec = firstOrderCustomerRecMapper.loadByDeviceIdAndFirstOrderType(deviceId,
                SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) {
                if (pennySaleProductMap.containsKey(createOrderItemDto.getSaleProductId())) {
                    SaleProductProxyDto saleProductProxyDto = pennySaleProductMap.get(createOrderItemDto.getSaleProductId());
                    if (!ObjectUtils.isNullOrEmpty(firstOrderDeviceRec)) {
                        String message = "亲,您的该设备已经购买过一分钱商品:" + saleProductProxyDto.getSaleProductName() + "了";
                        throw new OrderServiceException(message);
                    }
                }
            }
        }
    }

    // 校验是否vip商品和普通商品
    private void validateVipSaleProduct(List<SaleProductProxyDto> vipSaleProductProxyDtoList,
            List<Integer> saleProductIdList) {
        if (ObjectUtils.isNullOrEmpty(saleProductIdList)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
            return;
        }
        Map<Integer, SaleProductProxyDto> vipSaleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
            vipSaleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        int vipProductCount = 0;
        for (Integer saleProductId : saleProductIdList) {
            SaleProductProxyDto saleProductProxyDto = vipSaleProductMap.get(saleProductId);
            if (!ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
                    throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已删除");
                }
                if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
                    throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已下架");
                }
                vipProductCount++;
            }
        }
        if (vipProductCount != 0 && vipProductCount != saleProductIdList.size()) {
            // 存在VIP商品和普通商品,删除普通商品保留vip商品
            throw new OrderServiceException("不能购买VIP商品和普通商品");
        }
    }

    // 校验商品是否存在
    private void validateSaleProduct(List<SaleProductProxyDto> allSaleProductProxyDtoList,
            List<CreateOrderItemDto> createOrderItemDtos) {
        Map<Integer, SaleProductProxyDto> saleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : allSaleProductProxyDtoList) {
            saleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            SaleProductProxyDto saleProductProxyDto = saleProductMap.get(createOrderItemDto.getSaleProductId());
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                throw new OrderServiceException("商品[" + createOrderItemDto.getSaleProductId() + "]不存在");
            }
            if (!ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
                    throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已删除");
                }
                if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
                    throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已下架");
                }
            }
        }
    }

    // 设置需要更新、保存和删除的购物车列表
    private void setShopCartInfo(List<ShopCart> shopCartParams, List<SaleProductProxyDto> saleProductProxyDtoList,
            List<SaleProductProxyDto> vipSaleProductProxyDtoList, List<ShopCart> saveShopCartList,
            List<ShopCart> updateShopCartList, List<Integer> deleteShopCartProductIds, List<ShopCart> existsShopCartList) {
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            throw new OrderServiceException("商品已下架或删除");
        }
        List<Integer> saleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
            saleProductIds.add(saleProductProxyDto.getId());
        }
        List<Integer> vipSaleProductIds = new ArrayList<Integer>();
        if (!ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
            for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
                vipSaleProductIds.add(saleProductProxyDto.getId());
            }
        }
        List<Integer> existsProductIds = new ArrayList<Integer>();
        List<Integer> existsVipProductIds = new ArrayList<Integer>();
        Map<Integer, ShopCart> existsSaleProductIds = null;
        if (!ObjectUtils.isNullOrEmpty(existsShopCartList)) {
            existsSaleProductIds = new HashMap<Integer, ShopCart>();
            for (ShopCart shopCart : existsShopCartList) {
                existsSaleProductIds.put(shopCart.getSaleProductId(), shopCart);
                if (vipSaleProductIds.contains(shopCart.getSaleProductId())) {
                    existsVipProductIds.add(shopCart.getSaleProductId());
                    continue;
                }
                existsProductIds.add(shopCart.getSaleProductId());
            }
        }
        int vipCartCount = 0;
        List<ShopCart> saveVipShopCartList = new ArrayList<ShopCart>();
        List<ShopCart> updateVipShopCartList = new ArrayList<ShopCart>();
        if (!ObjectUtils.isNullOrEmpty(shopCartParams)) {
            for (ShopCart shopCart : shopCartParams) {
                Integer saleProductId = shopCart.getSaleProductId();
                if (!saleProductIds.contains(saleProductId)) { // 过滤不存在的商品
                    continue;
                }
                if (vipSaleProductIds.contains(saleProductId)) {
                    vipCartCount++;
                }
                if (ObjectUtils.isNullOrEmpty(existsSaleProductIds)) { // 购物车列表为空,则全部添加
                    saveShopCartList.add(shopCart);
                    if (vipSaleProductIds.contains(saleProductId)) {
                        saveVipShopCartList.add(shopCart);
                    }
                    continue;
                }

                if (existsSaleProductIds.containsKey(saleProductId)) { // 更新
                    ShopCart existsShopCart = existsSaleProductIds.get(saleProductId);
                    if (ArithUtils.converIntegerToInt(shopCart.getActivityId()) != ArithUtils
                            .converIntegerToInt(existsShopCart.getActivityId())) {
                        deleteShopCartProductIds.add(saleProductId);
                        saveShopCartList.add(shopCart);
                        if (vipSaleProductIds.contains(saleProductId)) {
                            saveVipShopCartList.add(shopCart);
                        }
                    } else {
                        shopCart.setQuantity(shopCart.getQuantity() + existsShopCart.getQuantity()); // 累加数量
                        updateShopCartList.add(shopCart);
                        if (vipSaleProductIds.contains(saleProductId)) {
                            updateVipShopCartList.add(shopCart);
                        }
                    }
                } else { // 新增
                    saveShopCartList.add(shopCart);
                    if (vipSaleProductIds.contains(saleProductId)) {
                        saveVipShopCartList.add(shopCart);
                    }
                }
            }
            if (vipCartCount != 0 && vipCartCount != shopCartParams.size()) {
                // 存在VIP商品和普通商品,删除普通商品保留vip商品
                saveShopCartList.clear();
                saveShopCartList.addAll(saveVipShopCartList);
                updateShopCartList.clear();
                updateVipShopCartList.addAll(updateVipShopCartList);
                deleteShopCartProductIds.clear();
                deleteShopCartProductIds.addAll(existsProductIds);
            } else if (vipCartCount == 0) {
                // 没有VIP商品,删掉原来购物车的vip商品
                deleteShopCartProductIds.addAll(existsVipProductIds);
            } else if (vipCartCount == shopCartParams.size()) {
                // 只有VIP商品,删除原来购物车的普通vip商品
                deleteShopCartProductIds.addAll(existsProductIds);
            }
        }
    }

    // 组装返回dto
    private List<ShopCartDto> getShopCartDtoList(List<ShopCart> shopCarts,
            List<SaleProductProxyDto> saleProductProxyDtoList) {
        if (ObjectUtils.isNullOrEmpty(shopCarts)) {
            return null;
        }
        Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = null;
        if (!ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
        }
        List<ShopCartDto> shopCartDtoList = new ArrayList<ShopCartDto>();
        for (ShopCart shopCart : shopCarts) {
            ShopCartDto shopCartDto = new ShopCartDto();
            ObjectUtils.fastCopy(shopCart, shopCartDto);
            if (!ObjectUtils.isNullOrEmpty(saleProductProxyDtoMap)) {
                Integer saleProductId = shopCart.getSaleProductId();
                if (saleProductProxyDtoMap.containsKey(saleProductId)) {
                    SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleProductId);
                    ObjectUtils.fastCopy(saleProductProxyDto, shopCartDto);
                }
            }
            shopCartDtoList.add(shopCartDto);
        }
        return shopCartDtoList;
    }

    @Override
    public Integer updateAdjustmentCartCount(ShopCartDto shopCartDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartDto)) {
                throw new OrderServiceException("参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getUserId())) {
                throw new OrderServiceException("用户不能为空 ");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getStoreId())) {
                throw new OrderServiceException("店铺ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getSaleProductId())) {
                throw new OrderServiceException("商品不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getQuantity())) {
                throw new OrderServiceException("商品数量不能为空");
            }
            if (shopCartDto.getQuantity().intValue() == 0) {
                throw new OrderServiceException("quantity不合法");
            }
            Date nowTime = new Date();
            int quantity = shopCartDto.getQuantity();
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(shopCartDto.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("店铺ID[" + shopCartDto.getStoreId() + "]没有找到店铺信息");
                throw new OrderServiceException("没有找到店铺信息");
            }
            if (!SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileProxyDto.getStoreStatus())) {
                logger.info("店铺[" + shopCartDto.getStoreId() + "," + storeProfileProxyDto.getStoreName() + "]已关闭营业");
                throw new OrderServiceException("店铺已关闭营业");
            }
            // List<Integer> pennyProductIds = getPennyProductIds();
            // List<SaleProductProxyDto> pennySaleProductProxyDtoList =
            // productProxyService
            // .listSaleProductByProductIdsAndStoreId(pennyProductIds, null,
            // null, storeId);
            // validatePennySaleProduct(customerId,
            // pennySaleProductProxyDtoList, Arrays.asList(saleProductId));
            SaleProductProxyDto saleProductProxyDto = productProxyService.loadById(shopCartDto.getSaleProductId());
            if (null == saleProductProxyDto) {
                throw new OrderServiceException("商品不存在");
            }
            ShopCart shopCart = shopCartMapper.loadShopCart(shopCartDto.getUserId(), shopCartDto.getStoreId(),
                    shopCartDto.getSaleProductId());
            if (null != shopCart) {
                quantity += shopCart.getQuantity();
            }
            if (quantity <= 0) { // 删除此记录
                return shopCartMapper.deleteById(shopCart.getId());
            }
            // saleProductInventoryService.validateRemainCount(saleProductId,
            // quantity);
            ShopCart cart = new ShopCart();
            cart.setQuantity(quantity);
            cart.setSaleProductId(shopCartDto.getSaleProductId());
            cart.setStoreId(shopCartDto.getStoreId());
            cart.setUserId(shopCartDto.getUserId());
            cart.setActivityId(shopCartDto.getActivityId());
            if (null == shopCart) { // 新增
                cart.setCreateTime(nowTime);
                return shopCartMapper.save(cart);
            }
            // 更新购物车数量
            cart.setModifyTime(nowTime);
            return shopCartMapper.updateUserShopCartNumber(cart);
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Integer deleteByUserIdAndProductIds(Integer userId, List<Integer> saleProductIds) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIds)) {
                saleProductIds = null;
            }
            return shopCartMapper.deleteByUserIdAndProductIds(userId, saleProductIds);
        } catch (Exception e) {
            logger.error("购物车中删除商品错误", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SettlementOrderDto settlementOrder(CreateOrderDto createOrderDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(createOrderDto)
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCreateOrderItemDtos())) {
                throw new OrderServiceException("下单信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getUserId())
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCustomerId())) {
                throw new OrderServiceException("用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getAddressId())
                    && ObjectUtils.isNullOrEmpty(createOrderDto.getStoreId())) {
                throw new OrderServiceException("地址和店铺不能同时为空");
            }
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getStoreId())
                    || !SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(createOrderDto.getDeliveryMode())) {
                ConsigneeAddressProxyDto consigneeAddressProxyDto = consigneeAddressProxyService
                        .loadById(createOrderDto.getAddressId());
                if (null == consigneeAddressProxyDto
                        || SystemContext.UserDomain.CONSADDRSTATUS_OFF.equals(consigneeAddressProxyDto.getStatus())) {
                    throw new OrderServiceException("收货地址不存在");
                }
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(consigneeAddressProxyDto.getCommunityId(),
                        SystemContext.UserDomain.STORESTATUS_OPEN);

            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(createOrderDto.getStoreId());
            }
            if (null == storeProfileProxyDto) {
                throw new OrderServiceException("该店已关闭,暂不支持下单");
            }
            UserProxyDto userProxyDto = userProxyService.getUserById(createOrderDto.getUserId());
            if (null == userProxyDto) {
                throw new OrderServiceException("用户异常,不能下单");
            }
            Date nowTime = new Date();
            List<Integer> saleProductIds = new ArrayList<Integer>();
            List<CreateOrderItemDto> createOrderItemDtos = createOrderDto.getCreateOrderItemDtos();
            List<Map<Integer, Integer>> activityIdAndSaleProductMaps = new ArrayList<Map<Integer, Integer>>();
            List<Integer> notActivitySaleProductIds = new ArrayList<Integer>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                saleProductIds.add(createOrderItemDto.getSaleProductId());
                if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())
                        && createOrderItemDto.getActId().intValue() > 0) {
                    Map<Integer, Integer> map = new HashMap<Integer, Integer>();
                    map.put(createOrderItemDto.getActId(), createOrderItemDto.getSaleProductId());
                    activityIdAndSaleProductMaps.add(map);
                } else {
                    notActivitySaleProductIds.add(createOrderItemDto.getSaleProductId());
                }
            }
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)
                    || saleProductIds.size() != saleProductProxyDtoList.size()) {
                throw new OrderServiceException("结算失败,存在找不到的商品");
            }
            // 校验下单商品跟店铺是否符合业务要求
            Integer validateStoreId = storeProfileProxyDto.getStoreId();
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                // 店铺共享库存查询微仓商品信息
                validateStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (saleProductProxyDto.getStoreId().intValue() != validateStoreId.intValue()) {
                    throw new OrderServiceException("下单的商品存在与该店不符合的商品,您可以先清除购物车再选择商品");
                }
            }
            // 校验商品合法
            validateSaleProduct(saleProductProxyDtoList, createOrderItemDtos);
            List<Integer> vipProductIds = getVipProductIds();
            List<Integer> pennyProductIds = getPennyProductIds();
            List<SaleProductProxyDto> pennySaleProductProxyDtoList = null;
            List<SaleProductProxyDto> vipSaleProductProxyDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(vipProductIds) && !ObjectUtils.isNullOrEmpty(notActivitySaleProductIds)) {
                vipSaleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(vipProductIds, null,
                        null, storeProfileProxyDto.getStoreId());
                validateVipSaleProduct(vipSaleProductProxyDtoList, notActivitySaleProductIds);
            }
            if (!ObjectUtils.isNullOrEmpty(pennyProductIds) && !ObjectUtils.isNullOrEmpty(notActivitySaleProductIds)) {
                pennySaleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(pennyProductIds,
                        null, null, storeProfileProxyDto.getStoreId());
                validatePennySaleProduct(createOrderDto.getCustomerId(), pennySaleProductProxyDtoList, createOrderItemDtos);
                validatePennySaleProductByDeviceId(createOrderDto.getDeviceId(), pennySaleProductProxyDtoList,
                        createOrderItemDtos);
            }
            List<SecKillProductProxyDto> secKillProductProxyDtos = null;
            if (!ObjectUtils.isNullOrEmpty(activityIdAndSaleProductMaps)) {
                secKillProductProxyDtos = secKillProductProxyService
                        .listByActivityIdAndSaleProductIdMaps(activityIdAndSaleProductMaps);
                validateSecKillSaleProduct(createOrderDto.getDeviceId(), createOrderDto.getCustomerId(),
                        secKillProductProxyDtos, createOrderItemDtos, null, null);
            }
            List<Integer> vipSaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
                    vipSaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            List<Integer> pennySaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(pennySaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : pennySaleProductProxyDtoList) {
                    pennySaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
            // 非vip商品,一分钱商品和活动商品
            List<Integer> commonSaleProductIds = new ArrayList<Integer>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                if (pennySaleProductIds.contains(createOrderItemDto.getSaleProductId())) {
                    continue;
                }
                if (vipSaleProductIds.contains(createOrderItemDto.getSaleProductId())) {
                    continue;
                }
                if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) {
                    continue;
                }
                commonSaleProductIds.add(createOrderItemDto.getSaleProductId());
            }
            Long totalAmount = 0L; // 订单金额
            Long preferentialAmt = 0L; // 优惠金额
            Long transferFee = 0L; // 配送运费
            Long payableAmount = 0L; // 应付金额
            boolean isIncludePennySaleProductId = false;
            boolean isVipOrderProductIds = false;
            List<SaleOrderItemDto> orderItemDtoList = new ArrayList<SaleOrderItemDto>();
            List<SecKillSceneProxyDto> secKillSceneProxyDtos = secKillSceneProxyService.listStartedAndStaring(nowTime);
            List<Integer> avaliableActivityIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneProxyDtos)) {
                for (SecKillSceneProxyDto secKillSceneProxyDto : secKillSceneProxyDtos) {
                    avaliableActivityIds.add(secKillSceneProxyDto.getActivityId());
                }
            }
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                Integer saleProductId = createOrderItemDto.getSaleProductId();
                SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleProductId);
                if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                    throw new OrderServiceException("订单结算异常,存在已下架的商品");
                }
                SaleOrderItemDto saleOrderItemDto = new SaleOrderItemDto();
                Long orderPrice = saleProductProxyDto.getRetailPrice();
                if (SystemContext.UserDomain.BUYERLEVEL_B.equals(userProxyDto.getBuyerLevelCode())) {
                    orderPrice = saleProductProxyDto.getPromotionalPrice();
                }
                saleOrderItemDto.setStoreId(storeProfileProxyDto.getStoreId());
                saleOrderItemDto.setBrandName(saleProductProxyDto.getBrandName());
                saleOrderItemDto.setQuantity(createOrderItemDto.getCartNum());
                saleOrderItemDto.setProductName(saleProductProxyDto.getSaleProductName());
                saleOrderItemDto.setSaleProductId(saleProductProxyDto.getId());
                saleOrderItemDto.setActivityId(createOrderItemDto.getActId());
                if (!ObjectUtils.isNullOrEmpty(secKillProductProxyDtos)
                        && ArithUtils.converIntegerToInt(createOrderItemDto.getActId()) > 0) {
                    for (SecKillProductProxyDto secKillProductProxyDto : secKillProductProxyDtos) {
                        if (secKillProductProxyDto.getActivityId().intValue() == createOrderItemDto.getActId().intValue()
                                && createOrderItemDto.getSaleProductId().intValue() == secKillProductProxyDto
                                        .getSaleProductId().intValue()) {
                            orderPrice = secKillProductProxyDto.getSecKillProductPrice();
                            break;
                        }
                    }
                } else {
                    if (pennySaleProductIds.contains(saleProductId)) {
                        // 含有一分钱商品
                        isIncludePennySaleProductId = true;
                    }
                    if (vipSaleProductIds.contains(saleProductId)) {
                        // vip商品
                        isVipOrderProductIds = true;
                    }
                }
                saleOrderItemDto.setOrderPrice(orderPrice);
                orderItemDtoList.add(saleOrderItemDto);
                // 计算金额信息
                totalAmount += createOrderItemDto.getCartNum() * orderPrice;
            }
            if (totalAmount - preferentialAmt < ArithUtils.converLongTolong(storeProfileProxyDto.getStartSendingPrice())) { // 增加配送运费
                transferFee = ArithUtils.converLongTolong(storeProfileProxyDto.getAddSendingPrice());
            }
            if (isIncludePennySaleProductId) {
                // 含有一分钱商品免运费
                transferFee = 0L;
            }
            String deliverMOde = StringUtils.defaultIfBlank(createOrderDto.getDeliveryMode(),
                    SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION);
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(deliverMOde)) {
                transferFee = 0L;
            }
            Integer isVipOrder = VIPORDER_NO;
            if (isVipOrderProductIds) {
                FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                        .loadByBuyerCustomerIdAndFirstOrderType(userProxyDto.getCustomerId(),
                                SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
                if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                    isVipOrder = VIPORDER_YES;
                }
            }
            SettlementOrderDto settlementOrderDto = new SettlementOrderDto();
            settlementOrderDto.setIsVipOrder(isVipOrder);
            if (totalAmount - preferentialAmt <= 0) {
                payableAmount = transferFee;
            } else {
                payableAmount = totalAmount + transferFee - preferentialAmt;
            }
            settlementOrderDto.setStoreId(storeProfileProxyDto.getStoreId());
            settlementOrderDto.setStoreName(storeProfileProxyDto.getStoreName());
            settlementOrderDto.setPayableAmount(payableAmount);
            settlementOrderDto.setPreferentialAmt(preferentialAmt);
            settlementOrderDto.setTotalAmount(totalAmount);
            settlementOrderDto.setTransferFee(transferFee);
            settlementOrderDto.setSaleOrderItemDtoList(orderItemDtoList);

            List<UserCouponInfoDto> userCouponInfoDtoList = couponService
                    .listValidAndUsebleUserCoupons(createOrderDto.getUserId(), nowTime);
            List<UserVoucherInfoDto> userVoucherInfoDtoList = voucherService
                    .listValidAndUsebleUserVouchers(createOrderDto.getUserId(), nowTime);
            List<UserCouponInfoDto> avaliableUserCouponInfoDtoList = getAvaliableUserCouponInfoDtoList(userCouponInfoDtoList,
                    saleProductProxyDtoList, totalAmount, nowTime, commonSaleProductIds);
            List<UserVoucherInfoDto> avaliableUserVoucherInfoDtoList = getAvaliableUserVoucherInfoDtoList(
                    userVoucherInfoDtoList, saleProductProxyDtoList, totalAmount, nowTime, createOrderItemDtos);
            settlementOrderDto.setUserCouponInfoList(avaliableUserCouponInfoDtoList);
            settlementOrderDto.setUserVoucherInfoList(avaliableUserVoucherInfoDtoList);
            return settlementOrderDto;
        } catch (Exception e) {
            logger.info("订单结算错误", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SettlementOrderDto settlementOrderTickets(CreateOrderDto createOrderDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(createOrderDto)
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCreateOrderItemDtos())) {
                throw new OrderServiceException("下单商品信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getUserId())
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCustomerId())) {
                throw new OrderServiceException("用户不能为空");
            }
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getStoreId())
                    || !SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(createOrderDto.getDeliveryMode())) {
                ConsigneeAddressProxyDto consigneeAddressProxyDto = consigneeAddressProxyService
                        .loadById(createOrderDto.getAddressId());
                if (null == consigneeAddressProxyDto
                        || SystemContext.UserDomain.CONSADDRSTATUS_OFF.equals(consigneeAddressProxyDto.getStatus())) {
                    throw new OrderServiceException("收货地址不存在");
                }
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(consigneeAddressProxyDto.getCommunityId(),
                        SystemContext.UserDomain.STORESTATUS_OPEN);

            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(createOrderDto.getStoreId());
            }
            if (null == storeProfileProxyDto) {
                throw new OrderServiceException("该店已关闭,暂不支持下单");
            }
            UserProxyDto userProxyDto = userProxyService.getUserById(createOrderDto.getUserId());
            if (null == userProxyDto) {
                throw new OrderServiceException("用户异常,不能下单");
            }
            // 校验奖券信息
            if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserCouponIdList())
                    && !ObjectUtils.isNullOrEmpty(createOrderDto.getUserVoucherIdList())) {
                throw new OrderServiceException("不能同时选择优惠券和抵用券");
            }
            if (getSystemConfigTicketSelect() == TICKET_SELECT_ONE) {
                if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserCouponIdList())
                        && createOrderDto.getUserCouponIdList().size() > 1) {
                    throw new OrderServiceException("只能用一张券");
                }
                if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserVoucherIdList())
                        && createOrderDto.getUserVoucherIdList().size() > 1) {
                    throw new OrderServiceException("只能用一张券");
                }
            }
            Date nowTime = new Date();
            List<Integer> saleProductIds = new ArrayList<Integer>();
            List<CreateOrderItemDto> createOrderItemDtos = createOrderDto.getCreateOrderItemDtos();
            List<Map<Integer, Integer>> activityIdAndSaleProductMaps = new ArrayList<Map<Integer, Integer>>();
            List<Integer> notActivitySaleProductIds = new ArrayList<Integer>();
            List<Integer> activitySaleProductIds = new ArrayList<Integer>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                saleProductIds.add(createOrderItemDto.getSaleProductId());
                if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())
                        && createOrderItemDto.getActId().intValue() > 0) {
                    Map<Integer, Integer> map = new HashMap<Integer, Integer>();
                    map.put(createOrderItemDto.getActId(), createOrderItemDto.getSaleProductId());
                    activityIdAndSaleProductMaps.add(map);
                    activitySaleProductIds.add(createOrderItemDto.getSaleProductId());
                } else {
                    notActivitySaleProductIds.add(createOrderItemDto.getSaleProductId());
                }
            }
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)
                    || saleProductIds.size() != saleProductProxyDtoList.size()) {
                throw new OrderServiceException("结算失败,存在找不到的商品");
            }
            // 校验商品合法
            validateSaleProduct(saleProductProxyDtoList, createOrderItemDtos);
            List<Integer> vipProductIds = getVipProductIds();
            List<Integer> pennyProductIds = getPennyProductIds();
            List<SaleProductProxyDto> pennySaleProductProxyDtoList = null;
            List<SaleProductProxyDto> vipSaleProductProxyDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(vipProductIds) && !ObjectUtils.isNullOrEmpty(notActivitySaleProductIds)) {
                vipSaleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(vipProductIds, null,
                        null, storeProfileProxyDto.getStoreId());
                validateVipSaleProduct(vipSaleProductProxyDtoList, notActivitySaleProductIds);
            }
            if (!ObjectUtils.isNullOrEmpty(pennyProductIds) && !ObjectUtils.isNullOrEmpty(notActivitySaleProductIds)) {
                pennySaleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(pennyProductIds,
                        null, null, storeProfileProxyDto.getStoreId());
                validatePennySaleProduct(createOrderDto.getCustomerId(), pennySaleProductProxyDtoList, createOrderItemDtos);
                validatePennySaleProductByDeviceId(createOrderDto.getDeviceId(), pennySaleProductProxyDtoList,
                        createOrderItemDtos);
            }
            List<SecKillProductProxyDto> secKillProductProxyDtos = null;
            if (!ObjectUtils.isNullOrEmpty(activityIdAndSaleProductMaps)) {
                secKillProductProxyDtos = secKillProductProxyService
                        .listByActivityIdAndSaleProductIdMaps(activityIdAndSaleProductMaps);
                validateSecKillSaleProduct(createOrderDto.getDeviceId(), createOrderDto.getCustomerId(),
                        secKillProductProxyDtos, createOrderItemDtos, null, null);
            }
            List<Integer> vipSaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
                    vipSaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            List<Integer> pennySaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(pennySaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : pennySaleProductProxyDtoList) {
                    pennySaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
            // 非vip商品,一分钱商品和活动商品
            List<Integer> commonSaleProductIds = new ArrayList<Integer>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                if (pennySaleProductIds.contains(createOrderItemDto.getSaleProductId())) {
                    continue;
                }
                if (vipSaleProductIds.contains(createOrderItemDto.getSaleProductId())) {
                    continue;
                }
                if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) {
                    continue;
                }
                commonSaleProductIds.add(createOrderItemDto.getSaleProductId());
            }
            // 有非补贴商品列表
            List<Integer> subsidisedSaleProductIds = new ArrayList<Integer>();
            Long totalAmount = 0L; // 订单金额
            Long preferentialAmt = 0L; // 优惠金额
            Long transferFee = 0L; // 配送运费
            Long payableAmount = 0L; // 应付金额
            boolean isIncludePennySaleProductId = false;
            boolean isVipOrderProductIds = false;
            List<SaleOrderItemDto> orderItemDtoList = new ArrayList<SaleOrderItemDto>();
            List<SecKillSceneProxyDto> secKillSceneProxyDtos = secKillSceneProxyService.listStartedAndStaring(new Date());
            List<Integer> avaliableActivityIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneProxyDtos)) {
                for (SecKillSceneProxyDto secKillSceneProxyDto : secKillSceneProxyDtos) {
                    avaliableActivityIds.add(secKillSceneProxyDto.getActivityId());
                }
            }
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
                Integer saleProductId = createOrderItemDto.getSaleProductId();
                SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleProductId);
                if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                    throw new OrderServiceException("订单结算异常,存在已下架的商品");
                }
                if (ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice()) > 0
                        || ArithUtils.converLongTolong(saleProductProxyDto.getCommissionPrice()) > 0) {
                    subsidisedSaleProductIds.add(saleProductProxyDto.getId());
                }
                SaleOrderItemDto saleOrderItemDto = new SaleOrderItemDto();
                Long orderPrice = saleProductProxyDto.getRetailPrice();
                if (SystemContext.UserDomain.BUYERLEVEL_B.equals(userProxyDto.getBuyerLevelCode())) {
                    orderPrice = saleProductProxyDto.getPromotionalPrice();
                }
                saleOrderItemDto.setStoreId(storeProfileProxyDto.getStoreId());
                saleOrderItemDto.setBrandName(saleProductProxyDto.getBrandName());
                saleOrderItemDto.setQuantity(createOrderItemDto.getCartNum());
                saleOrderItemDto.setProductName(saleProductProxyDto.getSaleProductName());
                saleOrderItemDto.setSaleProductId(saleProductProxyDto.getId());
                saleOrderItemDto.setActivityId(createOrderItemDto.getActId());
                if (!ObjectUtils.isNullOrEmpty(secKillProductProxyDtos)
                        && ArithUtils.converIntegerToInt(createOrderItemDto.getActId()) > 0) {
                    for (SecKillProductProxyDto secKillProductProxyDto : secKillProductProxyDtos) {
                        if (secKillProductProxyDto.getActivityId().intValue() == createOrderItemDto.getActId().intValue()
                                && createOrderItemDto.getSaleProductId().intValue() == secKillProductProxyDto
                                        .getSaleProductId().intValue()) {
                            orderPrice = secKillProductProxyDto.getSecKillProductPrice();
                            break;
                        }
                    }
                } else {
                    if (pennySaleProductIds.contains(saleProductId)) {
                        // 含有一分钱商品
                        isIncludePennySaleProductId = true;
                    }
                    if (vipSaleProductIds.contains(saleProductId)) {
                        // vip商品
                        isVipOrderProductIds = true;
                    }
                }
                saleOrderItemDto.setOrderPrice(orderPrice);
                saleOrderItemDto.setTotalPrice(orderPrice * saleOrderItemDto.getQuantity());
                orderItemDtoList.add(saleOrderItemDto);
                // 计算金额信息
                totalAmount += createOrderItemDto.getCartNum() * orderPrice;
            }
            Integer isVipOrder = VIPORDER_NO;
            if (isVipOrderProductIds) {
                FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                        .loadByBuyerCustomerIdAndFirstOrderType(userProxyDto.getCustomerId(),
                                SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
                if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                    isVipOrder = VIPORDER_YES;
                }
            }
            List<UserCouponInfoDto> userCouponInfoDtoList = new ArrayList<UserCouponInfoDto>();
            List<UserVoucherInfoDto> userVoucherInfoDtoList = new ArrayList<UserVoucherInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserCouponIdList())) {
                for (Integer userCouponId : createOrderDto.getUserCouponIdList()) {
                    List<Integer> useableSaleProductIds = new ArrayList<Integer>();
                    UserCouponInfo userCouponInfo = userCouponMapper
                            .loadUserCouponByUserIdAndUserCouponId(createOrderDto.getUserId(), userCouponId);
                    if (ObjectUtils.isNullOrEmpty(userCouponInfo)) {
                        throw new OrderServiceException("优惠券不存在");
                    }
                    if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfo.getStatus())) {
                        throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")已使用");
                    }
                    if (userCouponInfo.getBeginTime().after(nowTime)) {
                        throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")还未到开始使用时间");
                    }
                    if (userCouponInfo.getEndTime().before(nowTime)) {
                        throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")已过期");
                    }
                    if (ArithUtils.converLongTolong(userCouponInfo.getUseCondition()) > totalAmount) {
                        String userCondition = ArithUtils.convertToYuanStr(userCouponInfo.getUseCondition());
                        throw new OrderServiceException(
                                "订单金额未满" + userCondition + ",不能使用优惠券(" + userCouponInfo.getConName() + ")");
                    }
                    if (SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_CLASS.equals(userCouponInfo.getUseRangeCode())) {
                        // 指定产品分类
                        List<Integer> lastUseableSaleProductIds = getCouponSaleProductIdsByClassCodeUserRange(
                                saleProductProxyDtoList, userCouponInfo.getUseRange());
                        if (!ObjectUtils.isNullOrEmpty(commonSaleProductIds)) {
                            for (Integer commonSaleProductId : commonSaleProductIds) {
                                if (lastUseableSaleProductIds.contains(commonSaleProductId)) {
                                    useableSaleProductIds.add(commonSaleProductId);
                                }
                            }
                        }
                        if (useableSaleProductIds.size() <= 0) {
                            throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")只能购买指定商品分类使用");
                        }
                    }
                    if (SystemContext.OrderDomain.COUPONSUSERANGE_SINGLE_PRODUCT.equals(userCouponInfo.getUseRangeCode())) {
                        // 指定产品ID
                        List<Integer> lastUseableSaleProductIds = getCouponSaleProductIdsBySingleProductUserRange(
                                saleProductProxyDtoList, userCouponInfo.getUseRange());
                        if (!ObjectUtils.isNullOrEmpty(commonSaleProductIds)) {
                            for (Integer commonSaleProductId : commonSaleProductIds) {
                                if (lastUseableSaleProductIds.contains(commonSaleProductId)) {
                                    useableSaleProductIds.add(commonSaleProductId);
                                }
                            }
                        }
                        if (useableSaleProductIds.size() <= 0) {
                            throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")只能购买指定商品使用");
                        }
                    }
                    if (SystemContext.OrderDomain.COUPONSUSERANGE_ALL.equals(userCouponInfo.getUseRangeCode())) {
                        // 全场,校验vip商品,活动商品,一分钱商品
                        if (commonSaleProductIds.size() <= 0) {
                            throw new OrderServiceException("购买一分钱、vip和活动商品不能使用优惠券");
                        }
                        useableSaleProductIds = commonSaleProductIds;
                    }
                    UserCouponInfoDto userCouponInfoDto = new UserCouponInfoDto();
                    ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                    userCouponInfoDto.setSaleProductIds(useableSaleProductIds);
                    logger.info("couponunuseable:" + JsonUtils.toJsonString(useableSaleProductIds));
                    userCouponInfoDtoList.add(userCouponInfoDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserVoucherIdList())) {
                logger.info("saleProductList:" + JsonUtils.toJsonString(saleProductProxyDtoList));
                for (Integer voucherId : createOrderDto.getUserVoucherIdList()) {
                    Set<Integer> unUseableSaleProductIdsSet = new LinkedHashSet<Integer>();
                    UserVoucherInfo userVoucherInfo = userVoucherMapper
                            .loadUserVoucherByUserIdAndUserVoucherId(createOrderDto.getUserId(), voucherId);
                    if (ObjectUtils.isNullOrEmpty(userVoucherInfo)) {
                        throw new OrderServiceException("抵用券不存在");
                    }
                    if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfo.getStatus())) {
                        throw new OrderServiceException("抵用券(" + userVoucherInfo.getVouName() + ")已使用");
                    }
                    if (userVoucherInfo.getValidStartTime().after(nowTime)) {
                        throw new OrderServiceException("抵用券(" + userVoucherInfo.getVouName() + ")还未到开始使用时间");
                    }
                    if (userVoucherInfo.getValidEndTime().before(nowTime)) {
                        throw new OrderServiceException("抵用券(" + userVoucherInfo.getVouName() + ")已过期");
                    }
                    if (ArithUtils.converLongTolong(userVoucherInfo.getOrderAmountLimit()) > totalAmount.longValue()) { // 订单金额条件
                        String userCondition = ArithUtils.convertToYuanStr(userVoucherInfo.getOrderAmountLimit());
                        throw new OrderServiceException(
                                "订单金额未满" + userCondition + ",不能使用抵用券(" + userVoucherInfo.getVouName() + ")");
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getProductClassLimit())) {
                        List<Integer> limitSaleProductIdsByClassCode = getVoucherLimitSaleProductIdsByProductClassCode(
                                saleProductProxyDtoList, userVoucherInfo.getProductClassLimit());
                        logger.info("limitByClassCode:" + JsonUtils.toJsonString(userVoucherInfo) + ";limitSaleProductIds:"
                                + JsonUtils.toJsonString(limitSaleProductIdsByClassCode));
                        unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByClassCode);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getProductLimit())) {
                        List<Integer> limitSaleProductIdsByProductId = getVoucherLimitSaleProductIdsByProductId(
                                saleProductProxyDtoList, userVoucherInfo.getProductLimit());
                        logger.info("limitByProductId:" + JsonUtils.toJsonString(userVoucherInfo) + ";limitSaleProductIds:"
                                + JsonUtils.toJsonString(limitSaleProductIdsByProductId));
                        unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByProductId);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getBusinessRuleLimit())
                            && userVoucherInfo.getBusinessRuleLimit().indexOf(
                                    SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE) != -1) {
                        logger.info("limitByActivity:" + JsonUtils.toJsonString(userVoucherInfo) + ";limitSaleProductIds:"
                                + JsonUtils.toJsonString(activitySaleProductIds));
                        unUseableSaleProductIdsSet.addAll(activitySaleProductIds);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getBusinessRuleLimit())
                            && userVoucherInfo.getBusinessRuleLimit().indexOf(
                                    SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE) != -1) {
                        // 补贴商品不可用
                        unUseableSaleProductIdsSet.addAll(subsidisedSaleProductIds);
                        logger.info("limitBySubsidised:" + JsonUtils.toJsonString(userVoucherInfo) + ";limitSaleProductIds:"
                                + JsonUtils.toJsonString(subsidisedSaleProductIds));
                    }
                    if (unUseableSaleProductIdsSet.size() == saleProductProxyDtoList.size()) {
                        throw new OrderServiceException("订单商品限制使用抵用券");
                    }
                    logger.info("voucherunuseable:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
                    List<Integer> useableSaleProductIds = new ArrayList<Integer>();
                    for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                        boolean isExists = false;
                        for (Integer saleProductId : unUseableSaleProductIdsSet) {
                            if (saleProductId.intValue() == saleProductProxyDto.getId()) {
                                isExists = true;
                                break;
                            }
                        }
                        if (!isExists) {
                            useableSaleProductIds.add(saleProductProxyDto.getId());
                        }
                    }
                    UserVoucherInfoDto userVoucherInfoDto = new UserVoucherInfoDto();
                    ObjectUtils.fastCopy(userVoucherInfo, userVoucherInfoDto);
                    userVoucherInfoDto.setSaleProductIds(useableSaleProductIds);
                    userVoucherInfoDtoList.add(userVoucherInfoDto);
                }
            }
            logger.info("coupon:" + JsonUtils.toJsonString(userCouponInfoDtoList));
            logger.info("voucher:" + JsonUtils.toJsonString(userVoucherInfoDtoList));
            Long useCouponSaleProductAmount = 0L;
            Long useVoucherSaleProductAmount = 0L;
            for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtoList) {
                List<Integer> userCouponSaleProductIds = userCouponInfoDto.getSaleProductIds();
                for (Integer saleProductId : userCouponSaleProductIds) {
                    for (SaleOrderItemDto saleOrderItemDto : orderItemDtoList) {
                        if (saleOrderItemDto.getSaleProductId().intValue() == saleProductId.intValue()) {
                            useCouponSaleProductAmount += saleOrderItemDto.getTotalPrice();
                            logger.info("useCouponSaleProductAmount:" + useCouponSaleProductAmount);
                        }
                    }
                }
                if (userCouponInfoDto.getAmount().longValue() - useCouponSaleProductAmount > 0) {
                    preferentialAmt += useCouponSaleProductAmount;
                } else {
                    preferentialAmt += userCouponInfoDto.getAmount().longValue();
                }
                logger.info("preferentialAmt:" + preferentialAmt);
            }
            for (UserVoucherInfoDto userVoucherInfoDto : userVoucherInfoDtoList) {
                List<Integer> userVoucherSaleProductIds = userVoucherInfoDto.getSaleProductIds();
                for (Integer saleProductId : userVoucherSaleProductIds) {
                    for (SaleOrderItemDto saleOrderItemDto : orderItemDtoList) {
                        if (saleOrderItemDto.getSaleProductId().intValue() == saleProductId.intValue()) {
                            useVoucherSaleProductAmount += saleOrderItemDto.getTotalPrice();
                            logger.info("useCouponSaleProductAmount:" + useCouponSaleProductAmount);
                        }
                    }
                }
                if (userVoucherInfoDto.getVouAmount().longValue() - useVoucherSaleProductAmount > 0) {
                    preferentialAmt += useVoucherSaleProductAmount;
                } else {
                    preferentialAmt += userVoucherInfoDto.getVouAmount().longValue();
                }
            }
            if (totalAmount - preferentialAmt < ArithUtils.converLongTolong(storeProfileProxyDto.getStartSendingPrice())) { // 增加配送运费
                transferFee = ArithUtils.converLongTolong(storeProfileProxyDto.getAddSendingPrice());
            }
            if (isIncludePennySaleProductId) {
                // 含有一分钱商品免运费
                transferFee = 0L;
            }
            String deliverMOde = StringUtils.defaultIfBlank(createOrderDto.getDeliveryMode(),
                    SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION);
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(deliverMOde)) {
                transferFee = 0L;
            }
            SettlementOrderDto settlementOrderDto = new SettlementOrderDto();
            settlementOrderDto.setIsVipOrder(isVipOrder);
            if (totalAmount - preferentialAmt <= 0) {
                payableAmount = transferFee;
            } else {
                payableAmount = totalAmount + transferFee - preferentialAmt;
            }
            settlementOrderDto.setStoreId(storeProfileProxyDto.getStoreId());
            settlementOrderDto.setStoreName(storeProfileProxyDto.getStoreName());
            settlementOrderDto.setPayableAmount(payableAmount);
            settlementOrderDto.setPreferentialAmt(preferentialAmt);
            settlementOrderDto.setTotalAmount(totalAmount);
            settlementOrderDto.setTransferFee(transferFee);
            settlementOrderDto.setSaleOrderItemDtoList(orderItemDtoList);
            return settlementOrderDto;
        } catch (Exception e) {
            logger.info("订单结算错误", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    /**
     * 订单商品是否含有指定的产品分类
     */
    private List<Integer> getCouponSaleProductIdsByClassCodeUserRange(List<SaleProductProxyDto> saleProductProxyDtoList,
            String productClassCode) {
        List<Integer> saleProductIds = new ArrayList<Integer>();
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            return saleProductIds;
        }
        if (ObjectUtils.isNullOrEmpty(productClassCode)) {
            return saleProductIds;
        }
        String[] classCodeArr = productClassCode.split(CommonConstants.DELIMITER_COMMA);
        for (String classCode : classCodeArr) {
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (classCode.equals(saleProductProxyDto.getProductClassCode())) {
                    saleProductIds.add(saleProductProxyDto.getId());
                }
            }
        }
        return saleProductIds;
    }

    /**
     * 根据抵用券商品分类从订单商品中获取限制使用的商品ID列表
     */
    private List<Integer> getVoucherLimitSaleProductIdsByProductClassCode(List<SaleProductProxyDto> saleProductProxyDtoList,
            String productClassCode) {
        List<Integer> saleProductIds = new ArrayList<Integer>();
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            return saleProductIds;
        }
        if (ObjectUtils.isNullOrEmpty(productClassCode)) {
            return saleProductIds;
        }
        String[] classCodeArr = productClassCode.split(CommonConstants.DELIMITER_COMMA);
        for (String classCode : classCodeArr) {
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (classCode.equals(saleProductProxyDto.getProductClassCode())) {
                    saleProductIds.add(saleProductProxyDto.getId());
                }
            }
        }
        return saleProductIds;
    }

    private List<Integer> getCouponSaleProductIdsBySingleProductUserRange(List<SaleProductProxyDto> saleProductProxyDtoList,
            String productIds) {
        List<Integer> saleProductIds = new ArrayList<Integer>();
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            return saleProductIds;
        }
        if (ObjectUtils.isNullOrEmpty(productIds)) {
            return saleProductIds;
        }
        String[] productIdArr = productIds.split(CommonConstants.DELIMITER_COMMA);
        for (String productId : productIdArr) {
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (productId.equals(String.valueOf(saleProductProxyDto.getProductId().intValue()))) {
                    saleProductIds.add(saleProductProxyDto.getId());
                }
            }
        }
        return saleProductIds;
    }

    /**
     * 根据抵用券商品ID从订单商品中获取限制使用的商品ID列表
     */
    private List<Integer> getVoucherLimitSaleProductIdsByProductId(List<SaleProductProxyDto> saleProductProxyDtoList,
            String productIds) {
        List<Integer> saleProductIds = new ArrayList<Integer>();
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            return saleProductIds;
        }
        if (ObjectUtils.isNullOrEmpty(productIds)) {
            return saleProductIds;
        }
        String[] productIdArr = productIds.split(CommonConstants.DELIMITER_COMMA);
        for (String productId : productIdArr) {
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (productId.equals(String.valueOf(saleProductProxyDto.getProductId().intValue()))) {
                    saleProductIds.add(saleProductProxyDto.getId());
                }
            }
        }
        return saleProductIds;
    }

    private List<UserCouponInfoDto> getAvaliableUserCouponInfoDtoList(List<UserCouponInfoDto> userCouponInfoDtoList,
            List<SaleProductProxyDto> saleProductProxyDtoList, Long totalAmount, Date nowTime,
            List<Integer> commonSaleProductIds) {
        if (ObjectUtils.isNullOrEmpty(userCouponInfoDtoList)) {
            return Collections.emptyList();
        }
        List<UserCouponInfoDto> avaliableUserCouponInfoDtos = new ArrayList<UserCouponInfoDto>();
        for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtoList) {
            if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfoDto.getStatus())) {
                continue;
            }
            if (userCouponInfoDto.getBeginTime().after(nowTime)) {
                continue;
            }
            if (userCouponInfoDto.getEndTime().before(nowTime)) {
                continue;
            }
            if (ArithUtils.converLongTolong(userCouponInfoDto.getUseCondition().longValue()) > totalAmount.longValue()) {
                continue;
            }
            if (SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_CLASS.equals(userCouponInfoDto.getUseRangeCode())) {
                // 指定产品分类
                List<Integer> useableSaleProductIds = getCouponSaleProductIdsByClassCodeUserRange(saleProductProxyDtoList,
                        userCouponInfoDto.getUseRange());
                List<Integer> lastUseableSaleProductIds = new ArrayList<Integer>();
                if (!ObjectUtils.isNullOrEmpty(commonSaleProductIds)) {
                    for (Integer commonSaleProductId : commonSaleProductIds) {
                        if (useableSaleProductIds.contains(commonSaleProductId)) {
                            lastUseableSaleProductIds.add(commonSaleProductId);
                        }
                    }
                }
                if (lastUseableSaleProductIds.size() > 0) {
                    userCouponInfoDto.setWouldUse(TICKETWOULDUSE_USEBLE);
                    avaliableUserCouponInfoDtos.add(userCouponInfoDto);
                }
            }
            if (SystemContext.OrderDomain.COUPONSUSERANGE_SINGLE_PRODUCT.equals(userCouponInfoDto.getUseRangeCode())) {
                // 指定产品ID
                List<Integer> useableSaleProductIds = getCouponSaleProductIdsBySingleProductUserRange(
                        saleProductProxyDtoList, userCouponInfoDto.getUseRange());
                List<Integer> lastUseableSaleProductIds = new ArrayList<Integer>();
                if (!ObjectUtils.isNullOrEmpty(commonSaleProductIds)) {
                    for (Integer commonSaleProductId : commonSaleProductIds) {
                        if (useableSaleProductIds.contains(commonSaleProductId)) {
                            lastUseableSaleProductIds.add(commonSaleProductId);
                        }
                    }
                }
                if (lastUseableSaleProductIds.size() > 0) {
                    userCouponInfoDto.setWouldUse(TICKETWOULDUSE_USEBLE);
                    avaliableUserCouponInfoDtos.add(userCouponInfoDto);
                }
            }
            if (SystemContext.OrderDomain.COUPONSUSERANGE_ALL.equals(userCouponInfoDto.getUseRangeCode())) {
                // 全场,校验vip商品,活动商品,一分钱商品
                if (commonSaleProductIds.size() > 0) {
                    userCouponInfoDto.setWouldUse(TICKETWOULDUSE_USEBLE);
                    avaliableUserCouponInfoDtos.add(userCouponInfoDto);
                }
            }
        }
        return avaliableUserCouponInfoDtos;
    }

    private List<UserVoucherInfoDto> getAvaliableUserVoucherInfoDtoList(List<UserVoucherInfoDto> userVoucherInfoDtoList,
            List<SaleProductProxyDto> saleProductProxyDtoList, Long totalAmount, Date nowTime,
            List<CreateOrderItemDto> createOrderItemDtos) {
        if (ObjectUtils.isNullOrEmpty(userVoucherInfoDtoList)) {
            return Collections.emptyList();
        }
        List<Integer> activitySaleProductIds = new ArrayList<Integer>();
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) {
                activitySaleProductIds.add(createOrderItemDto.getSaleProductId());
            }
        }
        List<Integer> subsidisedSaleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
            if (ArithUtils.converLongTolong(saleProductProxyDto.getCommissionPrice()) > 0
                    || ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice()) > 0) {
                subsidisedSaleProductIds.add(saleProductProxyDto.getId());
            }
        }
        List<UserVoucherInfoDto> avaliableUserVoucherInfoDtos = new ArrayList<UserVoucherInfoDto>();
        logger.info("userVoucher.size:" + userVoucherInfoDtoList.size());
        for (UserVoucherInfoDto userVoucherInfoDto : userVoucherInfoDtoList) {
            Set<Integer> unUseableSaleProductIdsSet = new LinkedHashSet<Integer>();
            logger.info("userVoucher:" + userVoucherInfoDto);
            if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfoDto.getStatus())) {
                continue;
            }
            if (userVoucherInfoDto.getValidStartTime().after(nowTime)) {
                continue;
            }
            if (userVoucherInfoDto.getValidEndTime().before(nowTime)) {
                continue;
            }
            if (ArithUtils.converLongTolong(userVoucherInfoDto.getOrderAmountLimit()) > totalAmount.longValue()) { // 订单金额条件
                continue;
            }
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfoDto.getProductClassLimit())) {
                List<Integer> limitSaleProductIdsByClassCode = getVoucherLimitSaleProductIdsByProductClassCode(
                        saleProductProxyDtoList, userVoucherInfoDto.getProductClassLimit());
                logger.info("limitSaleProductIdsByProductClassCode:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
                unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByClassCode);
            }
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfoDto.getProductLimit())) {
                List<Integer> limitSaleProductIdsByProductId = getVoucherLimitSaleProductIdsByProductId(
                        saleProductProxyDtoList, userVoucherInfoDto.getProductLimit());
                unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByProductId);
                logger.info("limitSaleProductIdsByProductId:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
            }
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfoDto.getBusinessRuleLimit())
                    && userVoucherInfoDto.getBusinessRuleLimit()
                            .indexOf(SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE) != -1) {
                unUseableSaleProductIdsSet.addAll(activitySaleProductIds);
                logger.info("activitySaleProductIds:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
            }
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfoDto.getBusinessRuleLimit())
                    && userVoucherInfoDto.getBusinessRuleLimit()
                            .indexOf(SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE) != -1) {
                logger.info("subsidisedSaleProductIds:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
                // 补贴商品不可用
                unUseableSaleProductIdsSet.addAll(subsidisedSaleProductIds);
            }
            if (unUseableSaleProductIdsSet.size() == saleProductProxyDtoList.size()) {
                logger.info("unUseableSaleProductIdsSet:" + JsonUtils.toJsonString(unUseableSaleProductIdsSet));
                continue;
            }
            userVoucherInfoDto.setWouldUse(TICKETWOULDUSE_USEBLE);
            avaliableUserVoucherInfoDtos.add(userVoucherInfoDto);
        }
        logger.info("avaliableUserVoucherInfoDtos:" + JsonUtils.toJsonString(avaliableUserVoucherInfoDtos));
        return avaliableUserVoucherInfoDtos;

    }

    // 校验秒杀商品
    private void validateSecKillSaleProduct(String deviceId, Integer customerId,
            List<SecKillProductProxyDto> secKillProductProxyDtos, List<CreateOrderItemDto> createOrderItemDtos,
            Date currentTime, String addressDetail) {
        List<CreateOrderItemDto> activityOrderItems = new ArrayList<CreateOrderItemDto>();
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId()) && createOrderItemDto.getActId().intValue() > 0) {
                activityOrderItems.add(createOrderItemDto);
            }
        }
        if (ObjectUtils.isNullOrEmpty(activityOrderItems)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(secKillProductProxyDtos)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(currentTime)) {
            currentTime = new Date();
        }
        List<SecKillSceneProxyDto> secKillSceneProxyDtos = secKillSceneProxyService.listStartedAndStaring(currentTime);
        if (ObjectUtils.isNullOrEmpty(secKillSceneProxyDtos)) {
            throw new OrderServiceException("亲,该活动已结束");
        }
        List<Integer> avaliableActivityIds = new ArrayList<Integer>();
        for (SecKillSceneProxyDto secKillSceneProxyDto : secKillSceneProxyDtos) {
            avaliableActivityIds.add(secKillSceneProxyDto.getActivityId());
        }
        for (CreateOrderItemDto createOrderItemDto : activityOrderItems) {
            if (!avaliableActivityIds.contains(createOrderItemDto.getActId())) {
                throw new OrderServiceException("活动已结束,不能购买");
            }
            for (SecKillProductProxyDto secKillProductProxyDto : secKillProductProxyDtos) {
                if (createOrderItemDto.getActId().intValue() == secKillProductProxyDto.getActivityId().intValue()
                        && createOrderItemDto.getSaleProductId().intValue() == secKillProductProxyDto.getSaleProductId()
                                .intValue()) {
                    if (SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
                            .equals(secKillProductProxyDto.getStatusCode())) {
                        throw new OrderServiceException("秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]已下架");
                    }
                    long secKillTime = ArithUtils.converLongTolong(secKillProductProxyDto.getSecKillTime());
                    if (secKillTime > 0 && currentTime
                            .after(DateUtils.addSeconds(secKillProductProxyDto.getStartTime(), (int) secKillTime))) {
                        String message = "商品[" + secKillProductProxyDto.getSaleProductName() + "]已抢光";
                        throw new OrderServiceException(message);
                    }
                    if (currentTime.before(secKillProductProxyDto.getStartTime())) {
                        String message = "活动[" + secKillProductProxyDto.getSceneName() + "]还未开始,不能购买";
                        throw new OrderServiceException(message);
                    }
                    if (secKillProductProxyDto.getSecKillCount() == null
                            || secKillProductProxyDto.getSecKillCount().intValue() == 0) {
                        throw new OrderServiceException("秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]已抢完");
                    }
                    // 秒中数量校验
                    Integer customerOrderCount = ArithUtils.converIntegerToInt(
                            activityOrderCustomerRecMapper.loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(
                                    customerId, secKillProductProxyDto.getActivityId(),
                                    secKillProductProxyDto.getSaleProductId(), deviceId, addressDetail));
                    if (customerOrderCount + createOrderItemDto.getCartNum().intValue() > secKillProductProxyDto
                            .getLimitOrderCount().intValue()) {
                        throw new OrderServiceException("秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]购买数量已达上限");
                    }
                }
                // 限购数量校验
                Integer orderCount = activityOrderCustomerRecMapper.loadSaleProductOrderCountByActivityIdAndSaleProductId(
                        secKillProductProxyDto.getActivityId(), secKillProductProxyDto.getSaleProductId(),
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL);
                orderCount = ArithUtils.converIntegerToInt(orderCount);
                if (orderCount + createOrderItemDto.getCartNum() > secKillProductProxyDto.getSecKillCount()) {
                    throw new OrderServiceException("秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]已抢光");
                }
                break;
            }
        }
    }

    private void updateShopCartNumberBatch(List<ShopCart> shopCartList) {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartList)) {
                throw new OrderServiceException("没有更新的购物车信息");
            }
            for (ShopCart shopCart : shopCartList) {
                logger.info(JsonUtils.toJsonString(shopCart));
                Integer result = shopCartMapper.updateUserShopCartNumber(shopCart);
                if (result != 1) {
                    throw new OrderServiceException("修改物车信息发生错误");
                }
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private int getSystemConfigTicketSelect() {
        String systemConfigTicketSelectStr = super.getSystemParamValue(SystemContext.SystemParams.P_TICKET_SELECT_CONFIG);
        if (StringUtils.isEmpty(systemConfigTicketSelectStr)) {
            return TICKET_SELECT_ONE;
        }
        int systemConfigTicketSelect = Integer.parseInt(systemConfigTicketSelectStr);
        return systemConfigTicketSelect;
    }

    @Override
    public List<ShopCartDto> listUserShopCart(ShopCartQuery shopCartQuery) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartQuery)) {
                return Collections.emptyList();
            }
            List<ShopCart> shopCartList = shopCartMapper.listUserShopCart(shopCartQuery);
            List<ShopCartDto> shopCartDtos = new ArrayList<ShopCartDto>();
            if (!ObjectUtils.isNullOrEmpty(shopCartList)) {
                for (ShopCart shopCart : shopCartList) {
                    ShopCartDto shopCartDto = new ShopCartDto();
                    ObjectUtils.fastCopy(shopCart, shopCartDto);
                    shopCartDtos.add(shopCartDto);
                }
            }
            return shopCartDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<ShopCartDto> updateAsycnChangeCart(ShopCartDto shopCartDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartDto)) {
                throw new OrderServiceException("参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getUserId())) {
                throw new OrderServiceException("用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getDeviceId())) {
                throw new OrderServiceException("设备号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getStoreId())) {
                throw new OrderServiceException("店铺ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getSaleProductId())) {
                throw new OrderServiceException("商品不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getQuantity())) {
                throw new OrderServiceException("商品数量不能为空");
            }
            if (shopCartDto.getQuantity().intValue() == 0) {
                throw new OrderServiceException("quantity不合法");
            }
            Date nowTime = new Date();
            int quantity = shopCartDto.getQuantity();
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(shopCartDto.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("店铺ID[" + shopCartDto.getStoreId() + "]没有找到店铺信息");
                throw new OrderServiceException("没有找到店铺信息");
            }
            if (!SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileProxyDto.getStoreStatus())) {
                logger.info("店铺[" + shopCartDto.getStoreId() + "," + storeProfileProxyDto.getStoreName() + "]已关闭营业");
                throw new OrderServiceException("店铺已关闭营业");
            }
            if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileProxyDto.getStoreType())) {
                logger.info("店铺[" + shopCartDto.getStoreId() + "," + storeProfileProxyDto.getStoreName() + "]是微仓,不支持用户购买");
                throw new OrderServiceException("没有找到店铺信息");
            }
            UserProxyDto userProxyDto = userProxyService.getUserById(shopCartDto.getUserId());
            if (ObjectUtils.isNullOrEmpty(userProxyDto)) {
                throw new OrderServiceException("当前用户不存在");
            }
            shopCartDto.setCustomerId(userProxyDto.getCustomerId());
            String validateMessage = validateShopCartSaleProduct(shopCartDto);
            if (!ObjectUtils.isNullOrEmpty(validateMessage)) {
                throw new OrderServiceException(validateMessage);
            }
            SaleProductProxyDto saleProductProxyDto = productProxyService.loadById(shopCartDto.getSaleProductId());
            if (null == saleProductProxyDto) {
                throw new OrderServiceException("商品不存在");
            }
            ShopCartQuery shopCartQuery = new ShopCartQuery();
            shopCartQuery.setUserId(shopCartDto.getUserId());
            shopCartQuery.setStoreId(shopCartDto.getStoreId());
            List<ShopCartDto> shopCartDtos = listUserShopCart(shopCartQuery);
            List<Integer> vipProductIds = getVipProductIds();
            List<SaleProductProxyDto> vipSaleProducts = productProxyService
                    .listSaleProductByProductIdsAndStoreId(vipProductIds, null, null, shopCartDto.getStoreId());
            List<ShopCartDto> vipShopCartDtos = listVipShopCartDtos(shopCartDtos, vipSaleProducts);
            List<ShopCartDto> notVipShopCartDtos = listNotVipShopCartDtos(shopCartDtos, vipSaleProducts);
            boolean isContainVipSaleProduct = false;
            if (!ObjectUtils.isNullOrEmpty(vipShopCartDtos)) {
                isContainVipSaleProduct = true;
            }
            boolean isVipSaleProduct = false;
            if (isVipSaleProduct(saleProductProxyDto.getProductId())
                    && ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                isVipSaleProduct = true;
            }
            List<Integer> delSaleProductIds = null;
            if (isContainVipSaleProduct && !isVipSaleProduct) {
                // 删除购物里面的vip商品
                delSaleProductIds = new ArrayList<Integer>();
                for (ShopCartDto deleteShopCart : vipShopCartDtos) {
                    delSaleProductIds.add(deleteShopCart.getSaleProductId());
                }
            }
            if (isVipSaleProduct && !isContainVipSaleProduct) {
                // 删除购物车里面的普通商品
                if (!ObjectUtils.isNullOrEmpty(notVipShopCartDtos)) {
                    delSaleProductIds = new ArrayList<Integer>();
                    for (ShopCartDto deleteShopCart : notVipShopCartDtos) {
                        delSaleProductIds.add(deleteShopCart.getSaleProductId());
                    }
                }
            }
            if (!ObjectUtils.isNullOrEmpty(delSaleProductIds)) {
                this.deleteByUserIdAndProductIds(shopCartDto.getUserId(), delSaleProductIds);
            }
            ShopCart shopCart = shopCartMapper.loadShopCart(shopCartDto.getUserId(), shopCartDto.getStoreId(),
                    shopCartDto.getSaleProductId());
            if (null != shopCart) {
                quantity += shopCart.getQuantity();
                if (quantity <= 0) { // 删除此记录
                    shopCartMapper.deleteById(shopCart.getId());
                }
            }
            if (quantity > 0) {
                ShopCart cart = new ShopCart();
                cart.setQuantity(quantity);
                cart.setSaleProductId(shopCartDto.getSaleProductId());
                cart.setStoreId(shopCartDto.getStoreId());
                cart.setUserId(shopCartDto.getUserId());
                cart.setActivityId(shopCartDto.getActivityId());
                if (null == shopCart) { // 新增
                    cart.setCreateTime(nowTime);
                    shopCartMapper.save(cart);
                }
                // 更新购物车数量
                cart.setModifyTime(nowTime);
                shopCartMapper.updateUserShopCartNumber(cart);
            }
            ShopCartQuery cartQuery = new ShopCartQuery();
            cartQuery.setUserId(shopCartDto.getUserId());
            cartQuery.setStoreId(shopCartDto.getStoreId());
            return listUserShopCart(cartQuery);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public String validateShopCartSaleProduct(ShopCartDto shopCartDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shopCartDto) || ObjectUtils.isNullOrEmpty(shopCartDto.getDeviceId())
                    || ObjectUtils.isNullOrEmpty(shopCartDto.getSaleProductId())) {
                return "必填参数不能为空";
            }
            SaleProductProxyDto saleProductProxyDto = productProxyService.loadDetailById(shopCartDto.getSaleProductId());
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                return "商品不存在";
            }
            String message = validateSaleProduct(saleProductProxyDto);
            if (!ObjectUtils.isNullOrEmpty(message)) {
                return message;
            }
            if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                // 活动商品
                message = validateActSaleProduct(shopCartDto.getActivityId(), shopCartDto.getSaleProductId(),
                        shopCartDto.getCustomerId(), shopCartDto.getDeviceId(), shopCartDto.getQuantity());
            } else {
                boolean isPenny = isPennySaleProduct(saleProductProxyDto.getProductId());
                if (isPenny) {
                    message = validatePennySaleProduct(shopCartDto.getCustomerId(), saleProductProxyDto,
                            shopCartDto.getQuantity(), shopCartDto.getDeviceId());
                }
            }
            return message;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private String validateSaleProduct(SaleProductProxyDto saleProductProxyDto) {
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
            return "商品不存在";
        }
        if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
            return "商品已删除";
        }
        if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
            return "商品已下架";
        }
        if (ArithUtils.converIntegerToInt(saleProductProxyDto.getRemainCount()) <= 0) {
            return "亲，该产品没有足够的库存了，店家正在积极备货当中，请耐心等待";
        }
        return null;
    }

    private String validateActSaleProduct(Integer actId, Integer saleProductId, Integer customerId, String deviceId,
            Integer cartNum) {
        SecKillProductProxyDto secKillSaleProductDto = secKillProductProxyService.loadByActivityIdAndSaleProductId(actId,
                saleProductId);
        if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto)) {
            return "活动商品不存在";
        }
        Date currentTime = new Date();
        if (SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
                .equals(secKillSaleProductDto.getStatusCode())) {
            return "秒杀商品已下架";
        }
        long secKillTime = ArithUtils.converLongTolong(secKillSaleProductDto.getSecKillTime());
        if (secKillTime > 0
                && currentTime.after(DateUtils.addSeconds(secKillSaleProductDto.getStartTime(), (int) secKillTime))) {
            return "秒杀商品已抢光";
        }
        if (currentTime.before(secKillSaleProductDto.getStartTime())) {
            return "秒杀活动还未开始";
        }
        if (secKillSaleProductDto.getSecKillCount() == null || secKillSaleProductDto.getSecKillCount().intValue() == 0) {
            return "秒杀商品已抢光";
        }
        // 限购数量校验
        Integer orderCount = activityOrderCustomerRecMapper.loadSaleProductOrderCountByActivityIdAndSaleProductId(actId,
                saleProductId, SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL);
        orderCount = ArithUtils.converIntegerToInt(orderCount);
        if (orderCount + ArithUtils.converIntegerToInt(cartNum) > secKillSaleProductDto.getSecKillCount()) {
            return "秒杀商品已抢光";
        }
        if (!ObjectUtils.isNullOrEmpty(customerId) && ObjectUtils.isNullOrEmpty(deviceId)) {
            // 秒中数量校验
            Integer customerOrderCount = ArithUtils.converIntegerToInt(
                    activityOrderCustomerRecMapper.loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(customerId, actId,
                            saleProductId, deviceId, null));
            if (customerOrderCount + ArithUtils.converIntegerToInt(cartNum) > ArithUtils
                    .converIntegerToInt(secKillSaleProductDto.getLimitOrderCount())) {
                return "秒杀商品[" + secKillSaleProductDto.getSaleProductName() + "]购买数量已达上限";
            }
        }
        return null;
    }

    // 校验一分钱商品(只能买一件)
    private String validatePennySaleProduct(Integer customerId, SaleProductProxyDto saleProductProxyDto, Integer cartNum,
            String deviceId) {
        if (ArithUtils.converIntegerToInt(cartNum) > 1) {
            return "亲，该产品已经限制了购买1件，请查看您的购物车";
        }
        if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
            return "一分钱商品:" + saleProductProxyDto.getSaleProductName() + "已删除";
        }
        if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
            return "一分钱商品:" + saleProductProxyDto.getSaleProductName() + "已下架";
        }
        if (!ObjectUtils.isNullOrEmpty(customerId)) {
            FirstOrderCustomerRec firstOrderDeviceRec = firstOrderCustomerRecMapper.loadByBuyerCustomerIdAndFirstOrderType(
                    customerId, SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
            if (!ObjectUtils.isNullOrEmpty(firstOrderDeviceRec)) {
                String message = "亲,您已经购买过一分钱商品:" + saleProductProxyDto.getSaleProductName() + "了";
                return message;
            }
        }
        if (!ObjectUtils.isNullOrEmpty(deviceId)) {
            FirstOrderCustomerRec firstOrderDeviceRec = firstOrderCustomerRecMapper.loadByDeviceIdAndFirstOrderType(deviceId,
                    SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
            if (!ObjectUtils.isNullOrEmpty(firstOrderDeviceRec)) {
                String message = "亲,您的该设备已经购买过一分钱商品:" + saleProductProxyDto.getSaleProductName() + "了";
                return message;
            }
        }
        return null;
    }

    @Override
    public void sendAsycnShopCartMessage(Integer userId, List<ShopCartDto> shopCartDtoList) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(shopCartDtoList)) {
                return;
            }
            List<ShopCartProxyDto> shopCartProxyDtos = new ArrayList<ShopCartProxyDto>();
            for (ShopCartDto shopCartDto : shopCartDtoList) {
                ShopCartProxyDto shopCartProxyDto = new ShopCartProxyDto();
                ObjectUtils.fastCopy(shopCartDto, shopCartProxyDto);
                shopCartProxyDtos.add(shopCartProxyDto);
            }
            messageProxyService.sendAsycnShopCartMessage(userId, shopCartProxyDtos);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    /**
     * 是否是一分钱商品
     */
    private boolean isPennySaleProduct(Integer productId) {
        if (ObjectUtils.isNullOrEmpty(productId)) {
            return false;
        }
        List<Integer> pennyProductIds = getPennyProductIds();
        if (ObjectUtils.isNullOrEmpty(pennyProductIds)) {
            return false;
        }
        if (pennyProductIds.contains(productId)) {
            return true;
        }
        return false;
    }

    private List<Integer> getVipProductIds() {
        return getProductIdsByType(SystemContext.SystemParams.P_VIP_PRODUCT_ID);
    }

    private List<Integer> getPennyProductIds() {
        return getProductIdsByType(SystemContext.SystemParams.P_PENNY_PRODUCT_ID);
    }

    private List<Integer> getProductIdsByType(String productType) {
        if (StringUtils.isEmpty(productType)) {
            return Collections.emptyList();
        }
        List<Integer> productIds = new ArrayList<Integer>();
        String productIdSystemParam = super.getSystemParamValue(productType);
        if (ObjectUtils.isNullOrEmpty(productIdSystemParam)) {
            return Collections.emptyList();
        }
        String[] productIdArr = productIdSystemParam.split(CommonConstants.DELIMITER_COMMA);
        for (String pennyProductId : productIdArr) {
            Integer productId = ArithUtils.converStringToInt(pennyProductId.trim());
            if (productId <= 0) {
                continue;
            }
            productIds.add(productId);
        }
        return productIds;
    }

    private List<ShopCartDto> listNotVipShopCartDtos(List<ShopCartDto> shopCartDtos,
            List<SaleProductProxyDto> vipSaleProducts) {
        if (ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            return Collections.emptyList();
        }
        if (ObjectUtils.isNullOrEmpty(vipSaleProducts)) {
            return shopCartDtos;
        }
        List<Integer> vipSaleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : vipSaleProducts) {
            vipSaleProductIds.add(saleProductProxyDto.getId());
        }
        List<ShopCartDto> notVipShopCartDtos = new ArrayList<ShopCartDto>();
        for (ShopCartDto shopCartDto : shopCartDtos) {
            if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())
                    || !vipSaleProductIds.contains(shopCartDto.getSaleProductId())) {
                notVipShopCartDtos.add(shopCartDto);
            }
        }
        return notVipShopCartDtos;
    }

    private List<ShopCartDto> listVipShopCartDtos(List<ShopCartDto> shopCartDtos,
            List<SaleProductProxyDto> vipSaleProducts) {
        if (ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            return Collections.emptyList();
        }
        if (ObjectUtils.isNullOrEmpty(vipSaleProducts)) {
            return Collections.emptyList();
        }
        List<Integer> vipSaleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : vipSaleProducts) {
            vipSaleProductIds.add(saleProductProxyDto.getId());
        }
        List<ShopCartDto> vipShopCartDtos = new ArrayList<ShopCartDto>();
        for (ShopCartDto shopCartDto : shopCartDtos) {
            if (vipSaleProductIds.contains(shopCartDto.getSaleProductId())
                    && ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                vipShopCartDtos.add(shopCartDto);
            }
        }
        return vipShopCartDtos;
    }

    private boolean isContainVipSaleProduct(Integer storeId, Integer userId) {
        ShopCartQuery shopCartQuery = new ShopCartQuery();
        shopCartQuery.setUserId(userId);
        shopCartQuery.setStoreId(storeId);
        List<ShopCartDto> shopCartDtos = listUserShopCart(shopCartQuery);
        if (ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            return false;
        }
        List<Integer> vipProductIds = getVipProductIds();
        List<SaleProductProxyDto> vipSaleProducts = productProxyService.listSaleProductByProductIdsAndStoreId(vipProductIds,
                null, null, storeId);
        if (ObjectUtils.isNullOrEmpty(vipSaleProducts)) {
            return false;
        }
        List<Integer> vipSaleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : vipSaleProducts) {
            vipSaleProductIds.add(saleProductProxyDto.getId());
        }
        for (ShopCartDto shopCartDto : shopCartDtos) {
            if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                continue;
            }
            if (vipSaleProductIds.contains(shopCartDto.getSaleProductId())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 是否是vip商品
     */
    private boolean isVipSaleProduct(Integer productId) {
        if (ObjectUtils.isNullOrEmpty(productId)) {
            return false;
        }
        List<Integer> vipProductIds = getVipProductIds();
        if (ObjectUtils.isNullOrEmpty(vipProductIds)) {
            return false;
        }
        if (vipProductIds.contains(productId)) {
            return true;
        }
        return false;
    }
}
