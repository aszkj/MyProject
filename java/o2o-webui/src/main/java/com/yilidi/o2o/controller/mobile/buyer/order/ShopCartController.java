package com.yilidi.o2o.controller.mobile.buyer.order;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.util.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.order.AdjustmentCartCountParam;
import com.yilidi.o2o.appparam.buyer.order.AsycnChangeCartParam;
import com.yilidi.o2o.appparam.buyer.order.CartInfoParam;
import com.yilidi.o2o.appparam.buyer.order.CartListParam;
import com.yilidi.o2o.appparam.buyer.order.ClearCartParam;
import com.yilidi.o2o.appparam.buyer.order.ConfirmCartParam;
import com.yilidi.o2o.appparam.buyer.order.CreateOrderParam;
import com.yilidi.o2o.appparam.buyer.order.SettlementOrderParam;
import com.yilidi.o2o.appparam.buyer.order.SettlementOrderTicketsParam;
import com.yilidi.o2o.appparam.buyer.order.SynchronousCartParam;
import com.yilidi.o2o.appparam.buyer.order.TicketItemParam;
import com.yilidi.o2o.appparam.buyer.order.ValidationBeforeAddCartParam;
import com.yilidi.o2o.appvo.buyer.order.AsycnChangeCartVO;
import com.yilidi.o2o.appvo.buyer.order.ConfirmCartVO;
import com.yilidi.o2o.appvo.buyer.order.ConsigneeAddressBeanVO;
import com.yilidi.o2o.appvo.buyer.order.CreateOrderVO;
import com.yilidi.o2o.appvo.buyer.order.GiftInfoVO;
import com.yilidi.o2o.appvo.buyer.order.ListCartVO;
import com.yilidi.o2o.appvo.buyer.order.OrderFeeInfoVO;
import com.yilidi.o2o.appvo.buyer.order.SettleOrderItemVO;
import com.yilidi.o2o.appvo.buyer.order.SettlementOrderTicketInfoVO;
import com.yilidi.o2o.appvo.buyer.order.SettlementOrderTicketListVO;
import com.yilidi.o2o.appvo.buyer.order.SettlementOrderTicketsVO;
import com.yilidi.o2o.appvo.buyer.order.SettlementOrderVO;
import com.yilidi.o2o.appvo.buyer.order.ShopCartListVO;
import com.yilidi.o2o.appvo.buyer.order.ShopCartSaleProductListVO;
import com.yilidi.o2o.appvo.buyer.order.SynchronousCartVO;
import com.yilidi.o2o.appvo.buyer.order.ValidationBeforeAddCartVO;
import com.yilidi.o2o.appvo.buyer.product.BuyRewardActivityListVO;
import com.yilidi.o2o.appvo.buyer.product.RewardSaleProductVO;
import com.yilidi.o2o.appvo.buyer.product.RewardTicketVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.service.IActivityOrderCustomerRecService;
import com.yilidi.o2o.order.service.IFirstOrderCustomerRecService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.ISecKillSaleProductInventoryService;
import com.yilidi.o2o.order.service.IShopCartService;
import com.yilidi.o2o.order.service.dto.CreateOrderDto;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.FirstOrderCustomerRecDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaveOrderDto;
import com.yilidi.o2o.order.service.dto.SecKillSaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.SettlementOrderDto;
import com.yilidi.o2o.order.service.dto.ShopCartDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.query.ShopCartQuery;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.ISecKillProductService;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;
import com.yilidi.o2o.product.service.dto.RewardSaleProductDto;
import com.yilidi.o2o.product.service.dto.RewardTicketDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSaleProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.sessionmodel.buyer.order.OrderItemSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.order.OrderSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.order.ShopCartItemSessionModel;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.user.service.IConsigneeAddressService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.ConsigneeAddressDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 购物车
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerShopCartController")
@RequestMapping(value = "/interfaces/buyer")
public class ShopCartController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IShopCartService shopCartService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IConsigneeAddressService consigneeAddressService;
    @Autowired
    private IMessageService messageService;
    @Autowired
    private IUserService userService;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISecKillProductService secKillProductService;
    @Autowired
    private ISecKillSceneService secKillSceneService;
    @Autowired
    private IFirstOrderCustomerRecService firstOrderCustomerRecService;
    @Autowired
    private IActivityOrderCustomerRecService activityOrderCustomerRecService;
    @Autowired
    private ISecKillSaleProductInventoryService secKillSaleProductInventoryService;
    @Autowired
    private IBuyRewardActivityAuditService buyRewardActivityAuditService;

    /** 奖券信息是否是单选:单选 **/
    private static final int TICKET_SELECT_ONE = 1;
    /** 奖券信息是否是单选:多选 **/
    private static final int TICKET_SELECT_MULTIPLE = 0;
    /** 优惠券 **/
    private static final int TICKETTYPE_COUPON = 1;
    /** 优惠券名称 **/
    private static final String TICKETTYPENAME_COUPON = "优惠券";
    /** 抵用券 **/
    private static final int TICKETTYPE_VOUCHER = 2;
    /** 抵用券名称 **/
    private static final String TICKETTYPENAME_VOUCHER = "抵用券";
    /** 无效 **/
    private static final int TICKETSTATUS_INVALID = 0;
    /** 有效 **/
    private static final int TICKETSTATUS_VALID = 1;
    /** 抵用券使用范围描述 **/
    private static final String TICKETDUSERCOPE_VOUCHER = "使用限制";
    /** VIP商品提示信息 **/
    private static final String VIPSALEPRODUCT_MSG = "VIP商品需要单独购买,不能与其它商品同时购买,是否继续购买？";
    /** 成功 **/
    private static final int VALIDATE_STATUS_SUCCESS = 0;
    /** 失败提示 **/
    private static final int VALIDATE_STATUS_FAILURE = 1;
    /** 失败提示并需要确认 **/
    private static final int VALIDATE_STATUS_FAILUREANDCONFIRM = 2;
    /** 提示并提供选择 **/
    private static final int VALIDATE_STATUS_TIPSELECT = 3;
    /** 不限制购买商品 **/
    private static final Integer PRODUCT_NO_LIMIT_COUNT = -1;
    /** 一分钱可购买数量 **/
    private static final Integer PENNY_PRODUCT_LIMIT_COUNT = 1;
    /** 不能购的限制 **/
    private static final Integer PRODUCT_CANTNOT_BUYER_LIMIT_COUNT = 0;

    /**
     * 确认购物车接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/confirmcart")
    @ResponseBody
    public ResultParamModel confirmCart(HttpServletRequest req, HttpServletResponse resp) {
        ConfirmCartParam confirmCartParam = super.getEntityParam(req, ConfirmCartParam.class);
        List<CartInfoParam> cartInfoList = confirmCartParam.getCartInfo();
        Integer communityId = confirmCartParam.getCommunityId();
        Integer storeId = confirmCartParam.getStoreId();
        // 当小区ID和店铺ID都有值时,直接使用店铺ID,不校验店铺ID和小区ID的合法性
        StoreProfileDto storeProfileDto = null;
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
        } else {
            storeProfileDto = storeProfileService.loadByStoreId(storeId, null);
        }
        if (null == storeProfileDto) {
            logger.info("找不到店铺信息");
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "确认购物车接口成功");
        }
        storeId = storeProfileDto.getStoreId();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        List<ShopCartQuery> shopCartQueryList = new ArrayList<ShopCartQuery>();
        if (!ObjectUtils.isNullOrEmpty(cartInfoList)) {
            for (CartInfoParam cartInfoParam : cartInfoList) {
                ShopCartQuery shopCartQuery = new ShopCartQuery();
                shopCartQuery.setSaleProductId(cartInfoParam.getSaleProductId());
                shopCartQuery.setQuantity(cartInfoParam.getCartNum());
                shopCartQuery.setStoreId(storeId);
                shopCartQuery.setDeviceId(super.getDeviceId(req));
                shopCartQuery.setActivityId(cartInfoParam.getActId());
                shopCartQuery.setUserId(userSession.getUserId());
                // shopCartQuery.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
                shopCartQueryList.add(shopCartQuery);
            }
        }
        List<ShopCartDto> shopCartDtoList = shopCartService.updateConfirmCart(shopCartQueryList, storeId,
                userSession.getUserId(), userSession.getCustomerId());
        ConsigneeAddressDto consigneeAddressDto = null;
        if (!ObjectUtils.isNullOrEmpty(communityId)) {
            consigneeAddressDto = consigneeAddressService.loadLatelyUpdateByCommunityId(communityId,
                    userSession.getCustomerId());
        }
        // 赋值前端返回数据
        ConfirmCartVO confirmCartVO = new ConfirmCartVO();
        confirmCartVO.setCurrentTime(DateUtil.formatDate(new Date(), CommonConstants.DATE_FORMAT_CURRENTTIME));
        List<ShopCartListVO> shopCartList = new ArrayList<ShopCartListVO>();
        List<ShopCartSaleProductListVO> shopCartSaleProductList = new ArrayList<ShopCartSaleProductListVO>();
        if (!ObjectUtils.isNullOrEmpty(shopCartDtoList)) {
            ShopCartListVO shopCartListVO = new ShopCartListVO();
            boolean isVip = isVip();
            for (ShopCartDto shopCartDto : shopCartDtoList) {
                ShopCartSaleProductListVO shopCartSaleProductListVO = new ShopCartSaleProductListVO();
                ObjectUtils.fastCopy(shopCartDto, shopCartSaleProductListVO);
                shopCartSaleProductListVO.setActId(shopCartDto.getActivityId());
                shopCartSaleProductListVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(shopCartDto.getSaleProductImageUrl()));
                shopCartSaleProductListVO.setStockNum(shopCartDto.getRemainCount());
                shopCartSaleProductListVO.setCartNum(shopCartDto.getQuantity());
                shopCartSaleProductListVO.setProductStatus(
                        ConverterUtils.toClientProductSaleStatus(shopCartDto.getSaleStatus(), shopCartDto.getEnabledFlag()));
                Long orderPrice = shopCartDto.getRetailPrice();

                if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId()) && shopCartDto.getActivityId().intValue() > 0) {
                    shopCartSaleProductListVO.setPromotionalPrice(shopCartSaleProductListVO.getPromotionalPrice());
                } else if (isVip) {
                    orderPrice = shopCartDto.getPromotionalPrice();
                }
                shopCartSaleProductListVO.setOrderPrice(orderPrice);
                SaleProductDto saleProductDto = saleProductService
                        .loadSaleProductBasicInfoById(shopCartDto.getSaleProductId(), null);
                List<BuyRewardActivityListVO> activityInfoList = new ArrayList<BuyRewardActivityListVO>();
                List<BuyRewardActivityAuditDto> startedBuyRewardActivitys = buyRewardActivityAuditService
                        .getActivityInfoList(saleProductDto.getProductId());
                if (!ObjectUtils.isNullOrEmpty(startedBuyRewardActivitys)) {
                    for (BuyRewardActivityAuditDto buyRewardActivityAuditDto : startedBuyRewardActivitys) {
                        BuyRewardActivityListVO buyRewardActivityListVO = new BuyRewardActivityListVO();
                        buyRewardActivityListVO.setActId(buyRewardActivityAuditDto.getId());
                        buyRewardActivityListVO.setActName(buyRewardActivityAuditDto.getActivityName());
                        buyRewardActivityListVO.setActType(WebConstants.ACTIVITY_TYPE_BUYREWARD);
                        buyRewardActivityListVO.setActTypeName(WebConstants.ACTIVITY_TYPE_BUYREWARD_NAME);
                        activityInfoList.add(buyRewardActivityListVO);
                    }
                }
                shopCartSaleProductListVO.setActivityInfoList(activityInfoList);

                shopCartSaleProductList.add(shopCartSaleProductListVO);
            }
            ObjectUtils.fastCopy(storeProfileDto, shopCartListVO);
            shopCartListVO.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            shopCartListVO.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            String deliveryTimeNote = StringUtils.defaultIfBlank(
                    systemBasicDataInfoUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(),
                            SystemContext.OrderDomain.SALEORDERBESTTIME_FASTESTTIME),
                    CommonConstants.DELIVERY_TIME_NOTE);
            String pickUpTimeNote = StringUtils
                    .defaultIfBlank(
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(),
                                    SystemContext.OrderDomain.SALEORDERBESTTIME_PICKUP),
                            CommonConstants.PICKUP_TIME_NOTE);
            shopCartListVO.setDeliveryTimeNote(deliveryTimeNote);
            shopCartListVO.setPickUpTimeNote(pickUpTimeNote);
            shopCartListVO.setSaleProductList(shopCartSaleProductList);
            ObjectUtils.fastCopy(storeProfileDto, shopCartListVO);
            shopCartListVO.setStoreStatus(ConverterUtils.toClientStoreStatus(shopCartListVO.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getProvinceCode())) {
                shopCartListVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getCityCode())) {
                shopCartListVO.setCityName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getCountyCode())) {
                shopCartListVO.setCountyName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getCountyCode()));
            }
            shopCartList.add(shopCartListVO);
        }
        if (!ObjectUtils.isNullOrEmpty(consigneeAddressDto)) {
            ConsigneeAddressBeanVO consigneeAddressBeanVO = new ConsigneeAddressBeanVO();
            ObjectUtils.fastCopy(consigneeAddressDto, consigneeAddressBeanVO);
            String address = StringUtils.join(consigneeAddressDto.getCommunityName(),
                    consigneeAddressDto.getAddressDetail());
            consigneeAddressBeanVO.setAddress(address);
            confirmCartVO.setConsigneeAddress(consigneeAddressBeanVO);
        }
        confirmCartVO.setShopCartList(shopCartList);
        return super.encapsulateParam(confirmCartVO, AppMsgBean.MsgCode.SUCCESS, "确认购物车接口成功");
    }

    /**
     * 同步购物车接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/synchronouscart")
    @ResponseBody
    public ResultParamModel synchronousCart(HttpServletRequest req, HttpServletResponse resp) {
        SynchronousCartParam synchronousCartParam = super.getEntityParam(req, SynchronousCartParam.class);
        List<CartInfoParam> cartInfoList = synchronousCartParam.getCartInfo();
        Integer communityId = synchronousCartParam.getCommunityId();
        Integer storeId = synchronousCartParam.getStoreId();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        List<ShopCartQuery> shopCartQueryList = null;
        if (!ObjectUtils.isNullOrEmpty(cartInfoList)) {
            shopCartQueryList = new ArrayList<ShopCartQuery>();
            for (CartInfoParam cartInfoParam : cartInfoList) {
                ShopCartQuery shopCartQuery = new ShopCartQuery();
                shopCartQuery.setSaleProductId(cartInfoParam.getSaleProductId());
                shopCartQuery.setQuantity(cartInfoParam.getCartNum());
                shopCartQuery.setDeviceId(super.getDeviceId(req));
                shopCartQuery.setActivityId(cartInfoParam.getActId());
                // shopCartQuery.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
                shopCartQueryList.add(shopCartQuery);
            }
        }
        // 当小区ID和店铺ID都有值时,直接使用店铺ID,不校验店铺ID和小区ID的合法性
        StoreProfileDto storeProfileDto = null;
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
            if (null == storeProfileDto) {
                logger.info("根据小区ID[" + communityId + "]找不到店铺信息");
                return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "确认购物车接口成功");
            }
            storeId = storeProfileDto.getStoreId();
        }
        List<ShopCartDto> shopCartDtoList = shopCartService.updateSynchronousCart(shopCartQueryList, storeId,
                userSession.getUserId());
        List<SynchronousCartVO> cartSynchronusVOList = new ArrayList<SynchronousCartVO>();
        boolean isVip = isVip();
        if (!ObjectUtils.isNullOrEmpty(shopCartDtoList)) {
            for (ShopCartDto shopCartDto : shopCartDtoList) {
                SynchronousCartVO synchronousCartVO = new SynchronousCartVO();
                synchronousCartVO.setActId(shopCartDto.getActivityId());
                synchronousCartVO.setCartNum(shopCartDto.getQuantity());
                synchronousCartVO.setSaleProductId(shopCartDto.getSaleProductId());
                synchronousCartVO.setBrandName(shopCartDto.getBrandName());
                synchronousCartVO.setCartNum(shopCartDto.getQuantity());
                synchronousCartVO.setProductStatus(
                        ConverterUtils.toClientProductSaleStatus(shopCartDto.getSaleStatus(), shopCartDto.getEnabledFlag()));
                synchronousCartVO.setPromotionalPrice(shopCartDto.getPromotionalPrice());
                synchronousCartVO.setRetailPrice(shopCartDto.getRetailPrice());
                Long orderPrice = shopCartDto.getRetailPrice();
                if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId()) && shopCartDto.getActivityId().intValue() > 0) {
                    synchronousCartVO.setPromotionalPrice(synchronousCartVO.getPromotionalPrice());
                } else if (isVip) {
                    orderPrice = shopCartDto.getPromotionalPrice();
                }
                synchronousCartVO.setOrderPrice(orderPrice);
                synchronousCartVO.setSaleProductId(shopCartDto.getSaleProductId());
                synchronousCartVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(shopCartDto.getSaleProductImageUrl()));
                synchronousCartVO.setSaleProductName(shopCartDto.getSaleProductName());
                synchronousCartVO.setStockNum(shopCartDto.getRemainCount());
                cartSynchronusVOList.add(synchronousCartVO);
            }
        }
        return super.encapsulateParam(cartSynchronusVOList, AppMsgBean.MsgCode.SUCCESS, "同步购物车成功");
    }

    /**
     * 调整购物车数量
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/adjustmentcartcount")
    @ResponseBody
    public ResultParamModel adjustmentCartCount(HttpServletRequest req, HttpServletResponse resp) {
        AdjustmentCartCountParam param = super.getEntityParam(req, AdjustmentCartCountParam.class);
        Integer communityId = param.getCommunityId();
        Integer storeId = param.getStoreId();
        Integer saleProductId = param.getSaleProductId();
        Integer type = param.getType();
        Integer actId = param.getActId();
        // 当小区ID和店铺ID都有值时,直接使用店铺ID,不校验店铺ID和小区ID的合法性
        StoreProfileDto storeProfileDto = null;
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
            if (null == storeProfileDto) {
                logger.info("根据小区ID[" + communityId + "]找不到店铺信息");
                return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "确认购物车接口成功");
            }
            storeId = storeProfileDto.getStoreId();
        }
        int quantity = 1;
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        if (WebConstants.ADJUSTMENT_CART_COUNT_REDUCE == type) {
            quantity = -quantity;
        }
        ShopCartDto shopCartDto = new ShopCartDto();
        shopCartDto.setActivityId(actId);
        shopCartDto.setUserId(userSession.getUserId());
        shopCartDto.setStoreId(storeId);
        shopCartDto.setSaleProductId(saleProductId);
        shopCartDto.setQuantity(quantity);
        shopCartService.updateAdjustmentCartCount(shopCartDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "调整购物车数量成功");
    }

    /**
     * 清除购物车信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/cart/clearcart")
    @ResponseBody
    public ResultParamModel clearCart(HttpServletRequest req, HttpServletResponse resp) {
        ClearCartParam clearCartParam = super.getEntityParam(req, ClearCartParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        List<Integer> saleProductIds = null;
        if (!ObjectUtils.isNullOrEmpty(clearCartParam)) {
            saleProductIds = clearCartParam.getProducts();
        }
        if (ObjectUtils.isNullOrEmpty(userSession)) {
            SessionUtils.removeShopCartItemSession(saleProductIds);
        } else {
            shopCartService.deleteByUserIdAndProductIds(userSession.getUserId(), saleProductIds);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "清除购物车信息接口成功");
    }

    /**
     * 3.22订单结算接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/settlementorder")
    @ResponseBody
    public ResultParamModel settlementOrder(HttpServletRequest req, HttpServletResponse resp) {
        SettlementOrderParam settlementOrderParam = super.getEntityParam(req, SettlementOrderParam.class);
        Integer addressId = settlementOrderParam.getAddressId();
        Integer storeId = settlementOrderParam.getStoreId();
        Integer deliveryModeCode = settlementOrderParam.getDeliveryModeCode();
        List<CartInfoParam> cartInfoList = settlementOrderParam.getCartInfo();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        CreateOrderDto createOrderDto = new CreateOrderDto();
        createOrderDto.setAddressId(addressId);
        createOrderDto.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
        createOrderDto.setDeliveryMode(ConverterUtils.toServerDeliveryType(deliveryModeCode));
        createOrderDto.setStoreId(storeId);
        createOrderDto.setUserId(userSession.getUserId());
        createOrderDto.setCustomerId(userSession.getCustomerId());
        createOrderDto.setDeviceId(super.getDeviceId(req));
        List<CreateOrderItemDto> createOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        createOrderDto.setCreateOrderItemDtos(createOrderItemDtoList);

        for (CartInfoParam cartInfoParam : cartInfoList) {
            CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
            createOrderItemDto.setCartNum(cartInfoParam.getCartNum());
            createOrderItemDto.setSaleProductId(cartInfoParam.getSaleProductId());
            createOrderItemDto.setActId(cartInfoParam.getActId());
            createOrderItemDtoList.add(createOrderItemDto);
        }
        Date nowTime = new Date();
        SettlementOrderDto settlementOrderDto = shopCartService.settlementOrder(createOrderDto);
        SettlementOrderVO settlementOrderVO = null;
        if (null != settlementOrderDto) {
            settlementOrderVO = new SettlementOrderVO();
            settlementOrderVO.setStoreName(settlementOrderDto.getStoreName());
            settlementOrderVO.setIsVipOrder(settlementOrderDto.getIsVipOrder());
            // 订单金额信息
            OrderFeeInfoVO orderFeeInfoVo = new OrderFeeInfoVO();
            ObjectUtils.fastCopy(settlementOrderDto, orderFeeInfoVo);
            settlementOrderVO.setOrderFeeInfo(orderFeeInfoVo);

            // 商品列表
            List<SaleOrderItemDto> orderItemDtoList = settlementOrderDto.getSaleOrderItemDtoList();
            List<SettleOrderItemVO> saleOrderItemList = new ArrayList<SettleOrderItemVO>();
            if (!ObjectUtils.isNullOrEmpty(orderItemDtoList)) {
                OrderSessionModel orderSessionModel = new OrderSessionModel();
                List<OrderItemSessionModel> orderItemSessionModelList = new ArrayList<OrderItemSessionModel>();
                for (SaleOrderItemDto saleOrderItemDto : orderItemDtoList) {
                    SettleOrderItemVO settleOrderItemVO = new SettleOrderItemVO();
                    settleOrderItemVO.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    settleOrderItemVO.setBrandName(saleOrderItemDto.getBrandName());
                    settleOrderItemVO.setCartNum(saleOrderItemDto.getQuantity());
                    settleOrderItemVO.setOrderPrice(saleOrderItemDto.getOrderPrice());
                    settleOrderItemVO.setSaleProductName(saleOrderItemDto.getProductName());
                    saleOrderItemList.add(settleOrderItemVO);

                    // 缓存商品列表信息
                    OrderItemSessionModel orderItemSessionModel = new OrderItemSessionModel();
                    orderItemSessionModel.setQuantity(saleOrderItemDto.getQuantity());
                    orderItemSessionModel.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    orderItemSessionModel.setActId(saleOrderItemDto.getActivityId());
                    orderItemSessionModelList.add(orderItemSessionModel);
                }
                orderSessionModel.setAddressId(addressId);
                orderSessionModel.setUserId(userSession.getUserId());
                orderSessionModel.setStoreId(storeId);
                orderSessionModel.setDeliveryModeCode(deliveryModeCode);
                orderSessionModel.setLatitude(settlementOrderParam.getLatitude());
                orderSessionModel.setLongitude(settlementOrderParam.getLongitude());
                orderSessionModel.setOrderItemSessionModelList(orderItemSessionModelList);
                SessionUtils.setSettlementOrderSession(orderSessionModel);
            }
            settlementOrderVO.setSaleOrderItemList(saleOrderItemList);
            List<SettlementOrderTicketListVO> settlementOrderTicketListVOs = new ArrayList<SettlementOrderTicketListVO>();
            SettlementOrderTicketListVO settlementOrderCouponListVO = packageUserCouponInfoDtoList(
                    settlementOrderDto.getUserCouponInfoList(), nowTime);
            // if (!ObjectUtils.isNullOrEmpty(settlementOrderCouponListVO)) {
            settlementOrderTicketListVOs.add(settlementOrderCouponListVO);
            // }
            SettlementOrderTicketListVO settlementOrderVoucherListVO = packageUserVoucherInfoDtoList(
                    settlementOrderDto.getUserVoucherInfoList(), nowTime);
            // if (!ObjectUtils.isNullOrEmpty(settlementOrderVoucherListVO)) {
            settlementOrderTicketListVOs.add(settlementOrderVoucherListVO);
            // }
            settlementOrderVO.setTicketTypes(settlementOrderTicketListVOs);
            settlementOrderVO.setIsTicketSingleSelection(getSystemConfigTicketSelect());

            // 买赠信息
            GiftInfoVO giftInfoVO = new GiftInfoVO();
            List<RewardSaleProductVO> rewardSaleProductVOs = packageRewardSaleProductInfo(orderItemDtoList);
            List<RewardTicketVO> rewardTicketVOs = packageRewardTicketInfo(orderItemDtoList);
            giftInfoVO.setGiftProductList(rewardSaleProductVOs);
            giftInfoVO.setGiftCouponList(rewardTicketVOs);
            settlementOrderVO.setGiftInfo(giftInfoVO);
        }
        return super.encapsulateParam(settlementOrderVO, AppMsgBean.MsgCode.SUCCESS, "订单结算成功");
    }

    private SettlementOrderTicketListVO packageUserCouponInfoDtoList(List<UserCouponInfoDto> userCouponInfoDtos,
            Date nowTime) {
        SettlementOrderTicketListVO settlementOrderTicketListVO = new SettlementOrderTicketListVO();
        settlementOrderTicketListVO.setTicketTypeName(TICKETTYPENAME_COUPON);
        settlementOrderTicketListVO.setTicketType(TICKETTYPE_COUPON);
        if (ObjectUtils.isNullOrEmpty(userCouponInfoDtos)) {
            return settlementOrderTicketListVO;
        }
        if (ObjectUtils.isNullOrEmpty(nowTime)) {
            nowTime = new Date();
        }
        List<SettlementOrderTicketInfoVO> settlementOrderTicketInfoVOs = new ArrayList<SettlementOrderTicketInfoVO>();
        for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtos) {
            SettlementOrderTicketInfoVO settlementOrderTicketInfoVO = new SettlementOrderTicketInfoVO();
            settlementOrderTicketInfoVO.setTicketId(userCouponInfoDto.getUserCouponId());
            settlementOrderTicketInfoVO.setTicketType(TICKETTYPE_COUPON);
            settlementOrderTicketInfoVO.setTicketTypeName(TICKETTYPENAME_COUPON);
            settlementOrderTicketInfoVO.setBeginTime(userCouponInfoDto.getBeginTime());
            settlementOrderTicketInfoVO.setEndTime(userCouponInfoDto.getEndTime());
            settlementOrderTicketInfoVO.setTicketAmount(userCouponInfoDto.getAmount());
            settlementOrderTicketInfoVO.setLimitedAmount(userCouponInfoDto.getUseCondition());
            settlementOrderTicketInfoVO.setUseScope(systemBasicDataInfoUtils.getSystemDictName(
                    SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), userCouponInfoDto.getUseRangeCode()));
            settlementOrderTicketInfoVO.setTicketDescription(userCouponInfoDto.getRule());
            int status = 0;
            String statusCode = null;
            if (userCouponInfoDto.getBeginTime().after(nowTime)) {
                status = TICKETSTATUS_VALID;
                statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED;
            } else if (!userCouponInfoDto.getBeginTime().after(nowTime) && !userCouponInfoDto.getEndTime().before(nowTime)) {
                if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfoDto.getStatus())) {
                    status = TICKETSTATUS_INVALID;
                    statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USED;
                } else {
                    status = TICKETSTATUS_VALID;
                    statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE;
                }
            } else {
                status = TICKETSTATUS_INVALID;
                if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfoDto.getStatus())) {
                    statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USED;
                } else {
                    statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED;
                }
            }
            settlementOrderTicketInfoVO.setTicketStatus(status);
            settlementOrderTicketInfoVO.setTicketStatusName(systemBasicDataInfoUtils
                    .getSystemDictName(SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), statusCode));
            settlementOrderTicketInfoVO.setWouldUse(userCouponInfoDto.getWouldUse());
            settlementOrderTicketInfoVOs.add(settlementOrderTicketInfoVO);
        }
        settlementOrderTicketListVO.setTicketInfoList(settlementOrderTicketInfoVOs);
        return settlementOrderTicketListVO;
    }

    private SettlementOrderTicketListVO packageUserVoucherInfoDtoList(List<UserVoucherInfoDto> userVoucheInfoDtos,
            Date nowTime) {
        SettlementOrderTicketListVO settlementOrderTicketListVO = new SettlementOrderTicketListVO();
        settlementOrderTicketListVO.setTicketTypeName(TICKETTYPENAME_VOUCHER);
        settlementOrderTicketListVO.setTicketType(TICKETTYPE_VOUCHER);
        if (ObjectUtils.isNullOrEmpty(userVoucheInfoDtos)) {
            return settlementOrderTicketListVO;
        }
        if (ObjectUtils.isNullOrEmpty(nowTime)) {
            nowTime = new Date();
        }
        List<SettlementOrderTicketInfoVO> settlementOrderTicketInfoVOs = new ArrayList<SettlementOrderTicketInfoVO>();
        for (UserVoucherInfoDto userVoucherInfoDto : userVoucheInfoDtos) {
            SettlementOrderTicketInfoVO settlementOrderTicketInfoVO = new SettlementOrderTicketInfoVO();
            settlementOrderTicketInfoVO.setTicketId(userVoucherInfoDto.getUserVoucherId());
            settlementOrderTicketInfoVO.setTicketType(TICKETTYPE_VOUCHER);
            settlementOrderTicketInfoVO.setTicketTypeName(TICKETTYPENAME_VOUCHER);
            settlementOrderTicketInfoVO.setBeginTime(userVoucherInfoDto.getValidStartTime());
            settlementOrderTicketInfoVO.setEndTime(userVoucherInfoDto.getValidEndTime());
            settlementOrderTicketInfoVO.setTicketAmount(userVoucherInfoDto.getVouAmount());
            settlementOrderTicketInfoVO.setLimitedAmount(userVoucherInfoDto.getOrderAmountLimit());
            settlementOrderTicketInfoVO.setUseScope(TICKETDUSERCOPE_VOUCHER);
            settlementOrderTicketInfoVO.setTicketDescription(userVoucherInfoDto.getRule());
            int status = 0;
            String statusCode = null;
            if (userVoucherInfoDto.getValidStartTime().after(nowTime)) {
                status = TICKETSTATUS_VALID;
                statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED;
            } else if (!userVoucherInfoDto.getValidStartTime().after(nowTime)
                    && !userVoucherInfoDto.getValidEndTime().before(nowTime)) {
                if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfoDto.getStatus())) {
                    status = TICKETSTATUS_INVALID;
                    statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USED;
                } else {
                    status = TICKETSTATUS_VALID;
                    statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                }
            } else {
                status = TICKETSTATUS_INVALID;
                if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfoDto.getStatus())) {
                    statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USED;
                } else {
                    statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                }
            }
            settlementOrderTicketInfoVO.setTicketStatus(status);
            settlementOrderTicketInfoVO.setTicketStatusName(systemBasicDataInfoUtils
                    .getSystemDictName(SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), statusCode));
            settlementOrderTicketInfoVO.setWouldUse(userVoucherInfoDto.getWouldUse());
            settlementOrderTicketInfoVOs.add(settlementOrderTicketInfoVO);
        }
        settlementOrderTicketListVO.setTicketInfoList(settlementOrderTicketInfoVOs);
        return settlementOrderTicketListVO;
    }

    private List<RewardSaleProductVO> packageRewardSaleProductInfo(List<SaleOrderItemDto> orderItemDtoList) {
        if (ObjectUtils.isNullOrEmpty(orderItemDtoList)) {
            return Collections.emptyList();
        }
        List<RewardSaleProductDto> rewardSaleProductDtos = new ArrayList<RewardSaleProductDto>();
        for (SaleOrderItemDto saleOrderItemDto : orderItemDtoList) {
            List<RewardSaleProductDto> rewardSaleProductItemDtos = buyRewardActivityAuditService
                    .listRewardSaleProductsBySaleProductId(saleOrderItemDto.getSaleProductId(),
                            saleOrderItemDto.getQuantity());
            if (!ObjectUtils.isNullOrEmpty(rewardSaleProductItemDtos)) {
                rewardSaleProductDtos.addAll(rewardSaleProductItemDtos);
            }
        }
        if (ObjectUtils.isNullOrEmpty(rewardSaleProductDtos)) {
            return Collections.emptyList();
        }
        List<RewardSaleProductVO> rewardSaleProductVOs = new ArrayList<RewardSaleProductVO>();
        Map<Integer, RewardSaleProductDto> map = new HashMap<Integer, RewardSaleProductDto>();
        for (RewardSaleProductDto rewardSaleProductDto : rewardSaleProductDtos) {
            RewardSaleProductDto saleProductDto = map.get(rewardSaleProductDto.getId());
            if (map.containsKey(rewardSaleProductDto.getId())) {
                saleProductDto.setNumber(saleProductDto.getNumber().intValue() + rewardSaleProductDto.getNumber());
            } else {
                saleProductDto = new RewardSaleProductDto();
                ObjectUtils.fastCopy(rewardSaleProductDto, saleProductDto);
            }
            map.put(rewardSaleProductDto.getId(), saleProductDto);
        }
        boolean isVip = isVip();
        for (Entry<Integer, RewardSaleProductDto> entry : map.entrySet()) {
            RewardSaleProductDto rewardSaleProductDto = entry.getValue();
            RewardSaleProductVO rewardSaleProductVO = new RewardSaleProductVO();
            rewardSaleProductVO.setBrandName(rewardSaleProductDto.getBrandName());
            rewardSaleProductVO.setCartNum(rewardSaleProductDto.getNumber());
            if (isVip) {
                rewardSaleProductVO.setOrderPrice(rewardSaleProductDto.getPromotionalPrice());
            } else {
                rewardSaleProductVO.setOrderPrice(rewardSaleProductDto.getRetailPrice());
            }
            rewardSaleProductVO.setSaleProductName(rewardSaleProductDto.getSaleProductName());
            rewardSaleProductVOs.add(rewardSaleProductVO);
        }
        return rewardSaleProductVOs;
    }

    private List<RewardTicketVO> packageRewardTicketInfo(List<SaleOrderItemDto> orderItemDtoList) {
        if (ObjectUtils.isNullOrEmpty(orderItemDtoList)) {
            return Collections.emptyList();
        }
        List<RewardTicketDto> rewardTicketDtos = new ArrayList<RewardTicketDto>();
        for (SaleOrderItemDto saleOrderItemDto : orderItemDtoList) {
            List<RewardTicketDto> rewardSaleProductItemDtos = buyRewardActivityAuditService
                    .listRewardTicketsBySaleProductId(saleOrderItemDto.getSaleProductId(), saleOrderItemDto.getQuantity());
            if (!ObjectUtils.isNullOrEmpty(rewardSaleProductItemDtos)) {
                rewardTicketDtos.addAll(rewardSaleProductItemDtos);
            }
        }
        if (ObjectUtils.isNullOrEmpty(rewardTicketDtos)) {
            return Collections.emptyList();
        }
        List<RewardTicketVO> rewardTicketVOs = new ArrayList<RewardTicketVO>();
        Map<Integer, RewardTicketDto> map = new HashMap<Integer, RewardTicketDto>();
        for (RewardTicketDto rewardTicketDto : rewardTicketDtos) {
            RewardTicketDto rewardTicket = map.get(rewardTicketDto.getTicketId());
            if (map.containsKey(rewardTicketDto.getTicketId())) {
                rewardTicket.setRewardNumber(rewardTicket.getRewardNumber().intValue() + rewardTicketDto.getRewardNumber());
            } else {
                rewardTicket = new RewardTicketDto();
                ObjectUtils.fastCopy(rewardTicketDto, rewardTicket);
            }
            map.put(rewardTicketDto.getTicketId(), rewardTicket);
        }
        for (Entry<Integer, RewardTicketDto> entry : map.entrySet()) {
            RewardTicketDto rewardSaleProductDto = entry.getValue();
            RewardTicketVO rewardTicketVO = new RewardTicketVO();
            rewardTicketVO.setCartNum(rewardSaleProductDto.getRewardNumber());
            rewardTicketVO.setTicketAmount(rewardSaleProductDto.getTicketAmount());
            rewardTicketVO.setTicketType(TICKETTYPE_COUPON);
            rewardTicketVO.setTicketDescription(rewardSaleProductDto.getTicketDescription());
            rewardTicketVO.setTicketTypeName(TICKETTYPENAME_COUPON);
            rewardTicketVOs.add(rewardTicketVO);
        }
        return rewardTicketVOs;
    }

    /**
     * 3.23生成订单接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/createorder")
    @ResponseBody
    public ResultParamModel createOrder(HttpServletRequest req, HttpServletResponse resp) {
        CreateOrderParam createOrderParam = super.getEntityParam(req, CreateOrderParam.class);
        String note = null;
        List<TicketItemParam> ticketItemParamList = null;
        if (null != createOrderParam) {
            ticketItemParamList = createOrderParam.getTickets();
            note = createOrderParam.getNote();
        }
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        OrderSessionModel orderSessionModel = SessionUtils.getSettlementOrderSession();
        if (null == orderSessionModel || orderSessionModel.getUserId().intValue() != userSession.getUserId().intValue()) {
            SessionUtils.removeSettlementOrderSession();
            throw new OrderServiceException("商品下单信息不存在,请重新下单");
        }

        CreateOrderDto createOrderDto = new CreateOrderDto();
        ObjectUtils.fastCopy(orderSessionModel, createOrderDto);
        createOrderDto.setNote(note);
        createOrderDto.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
        createOrderDto.setDeliveryMode(ConverterUtils.toServerDeliveryType(orderSessionModel.getDeliveryModeCode()));
        createOrderDto.setUserId(userSession.getUserId());
        createOrderDto.setCustomerId(userSession.getCustomerId());
        createOrderDto.setUserName(userSession.getUserName());
        createOrderDto.setDeviceId(super.getDeviceId(req));
        List<OrderItemSessionModel> orderItemSessionModelList = orderSessionModel.getOrderItemSessionModelList();
        List<CreateOrderItemDto> createOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        for (OrderItemSessionModel orderItemSessionModel : orderItemSessionModelList) {
            CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
            createOrderItemDto.setCartNum(orderItemSessionModel.getQuantity());
            createOrderItemDto.setSaleProductId(orderItemSessionModel.getSaleProductId());
            createOrderItemDto.setActId(orderItemSessionModel.getActId());
            createOrderItemDtoList.add(createOrderItemDto);
        }
        createOrderDto.setCreateOrderItemDtos(createOrderItemDtoList);
        List<Integer> userCouponIdList = new ArrayList<Integer>();
        List<Integer> userVoucherIdList = new ArrayList<Integer>();
        if (!ObjectUtils.isNullOrEmpty(ticketItemParamList)) {
            for (TicketItemParam createOrderTicketItemParam : ticketItemParamList) {
                if (TICKETTYPE_COUPON == createOrderTicketItemParam.getTicketType()) {
                    userCouponIdList.add(createOrderTicketItemParam.getTicketId());
                }
                if (TICKETTYPE_VOUCHER == createOrderTicketItemParam.getTicketType()) {
                    userVoucherIdList.add(createOrderTicketItemParam.getTicketId());
                }
            }
            if (userCouponIdList.size() > 0 && userVoucherIdList.size() > 0) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "不能同时选择优惠券和抵用券");
            }
            if (getSystemConfigTicketSelect() == TICKET_SELECT_ONE) {
                if (userCouponIdList.size() > 1 || userVoucherIdList.size() > 1) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "只能用一张券");
                }
            }
            createOrderDto.setUserCouponIdList(userCouponIdList);
            createOrderDto.setUserVoucherIdList(userVoucherIdList);
        }
        SaveOrderDto saveOrderDto = orderService.saveCreateOrder(createOrderDto);
        CreateOrderVO createOrderVO = new CreateOrderVO();
        ObjectUtils.fastCopy(saveOrderDto, createOrderVO);
        String deliverTimeCode = saveOrderDto.getDeliveryTimeCode();
        String deliverTimeNote = systemBasicDataInfoUtils
                .getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(), deliverTimeCode);
        if (ObjectUtils.isNullOrEmpty(deliverTimeNote)) {
            deliverTimeNote = CommonConstants.DELIVERY_TIME_NOTE;
        }
        createOrderVO.setDeliveryTimeNote(deliverTimeNote);
        String deliveryModeName = systemBasicDataInfoUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.SALEORDERDELIVERYMODE.getValue(), saveOrderDto.getDeliveryMode());
        createOrderVO.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(saveOrderDto.getDeliveryMode()));
        createOrderVO.setDeliveryModeName(deliveryModeName);
        // 清除缓存信息
        SessionUtils.removeSettlementOrderSession();
        if (saveOrderDto.getPaidAmount() == 0) {
            try {
                // 发送接单推送通知给卖家
                SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(saveOrderDto.getSaleOrderNo());
                Integer forAcceptOrderCount = orderService.getForAcceptOrderCount(saleOrderDto.getStoreId());
                // 获取所有可以接单的用户
                List<Integer> userIdList = userService.getAcceptOrderUserId(saleOrderDto.getStoreId());
                if (!ObjectUtils.isNullOrEmpty(userIdList)) {
                    messageService.sendPushOrderMessage(PushTypeModelClassMapping.ORDERACCEPT, userIdList,
                            null == forAcceptOrderCount ? "0" : Integer.toString(forAcceptOrderCount));
                }
            } catch (Exception e) {
                logger.error("发送接单推送通知给卖家出现系统异常！", e);
            }
        }
        return super.encapsulateParam(createOrderVO, AppMsgBean.MsgCode.SUCCESS, "生成订单接口成功");
    }

    /**
     * 3.61购物车奖券结算信息接口
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/cart/settlementordertickets")
    @ResponseBody
    public ResultParamModel settlementordertickets(HttpServletRequest req, HttpServletResponse resp) {
        SettlementOrderTicketsParam settlementOrderParam = super.getEntityParam(req, SettlementOrderTicketsParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        OrderSessionModel orderSessionModel = SessionUtils.getSettlementOrderSession();
        if (null == orderSessionModel || orderSessionModel.getUserId().intValue() != userSession.getUserId().intValue()) {
            SessionUtils.removeSettlementOrderSession();
            throw new OrderServiceException("商品下单信息不存在,请重新下单");
        }
        CreateOrderDto createOrderDto = new CreateOrderDto();
        ObjectUtils.fastCopy(orderSessionModel, createOrderDto);
        createOrderDto.setUserId(userSession.getUserId());
        createOrderDto.setCustomerId(userSession.getCustomerId());
        createOrderDto.setDeviceId(super.getDeviceId(req));
        createOrderDto.setDeliveryMode(ConverterUtils.toServerDeliveryType(orderSessionModel.getDeliveryModeCode()));
        List<OrderItemSessionModel> orderItemSessionModelList = orderSessionModel.getOrderItemSessionModelList();
        List<CreateOrderItemDto> createOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        for (OrderItemSessionModel orderItemSessionModel : orderItemSessionModelList) {
            CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
            createOrderItemDto.setCartNum(orderItemSessionModel.getQuantity());
            createOrderItemDto.setSaleProductId(orderItemSessionModel.getSaleProductId());
            createOrderItemDto.setActId(orderItemSessionModel.getActId());
            createOrderItemDtoList.add(createOrderItemDto);
        }
        createOrderDto.setCreateOrderItemDtos(createOrderItemDtoList);
        List<TicketItemParam> ticketItemParamList = null;
        if (!ObjectUtils.isNullOrEmpty(settlementOrderParam)) {
            ticketItemParamList = settlementOrderParam.getTickets();
        }
        List<Integer> userCouponIdList = new ArrayList<Integer>();
        List<Integer> userVoucherIdList = new ArrayList<Integer>();
        if (!ObjectUtils.isNullOrEmpty(ticketItemParamList)) {
            for (TicketItemParam createOrderTicketItemParam : ticketItemParamList) {
                if (TICKETTYPE_COUPON == createOrderTicketItemParam.getTicketType()) {
                    userCouponIdList.add(createOrderTicketItemParam.getTicketId());
                }
                if (TICKETTYPE_VOUCHER == createOrderTicketItemParam.getTicketType()) {
                    userVoucherIdList.add(createOrderTicketItemParam.getTicketId());
                }
            }
            if (userCouponIdList.size() > 0 && userVoucherIdList.size() > 0) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "不能同时选择优惠券和抵用券");
            }
            if (getSystemConfigTicketSelect() == TICKET_SELECT_ONE) {
                if (userCouponIdList.size() > 1 || userVoucherIdList.size() > 1) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "只能用一张券");
                }
            }
            createOrderDto.setUserCouponIdList(userCouponIdList);
            createOrderDto.setUserVoucherIdList(userVoucherIdList);
        }
        SettlementOrderDto settlementOrderDto = shopCartService.settlementOrderTickets(createOrderDto);
        SettlementOrderTicketsVO settlementOrderTicketsVO = null;
        if (null != settlementOrderDto) {
            settlementOrderTicketsVO = new SettlementOrderTicketsVO();
            // 订单金额信息
            OrderFeeInfoVO orderFeeInfoVo = new OrderFeeInfoVO();
            ObjectUtils.fastCopy(settlementOrderDto, orderFeeInfoVo);
            settlementOrderTicketsVO.setOrderFeeInfo(orderFeeInfoVo);
        }
        return super.encapsulateParam(settlementOrderTicketsVO, AppMsgBean.MsgCode.SUCCESS, "购物车奖券结算信息接口成功");
    }

    /**
     * 3.74商品加入购物车前业务判断接口
     */
    @RequestMapping(value = "/cart/validationbeforeaddcart")
    @ResponseBody
    public ResultParamModel validateBeforeAddCart(HttpServletRequest req, HttpServletResponse resp) {
        ValidationBeforeAddCartParam validationBeforeAddCartParam = super.getEntityParam(req,
                ValidationBeforeAddCartParam.class);
        if (ObjectUtils.isNullOrEmpty(validationBeforeAddCartParam)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "参数不能为空");
        }
        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(validationBeforeAddCartParam.getStoreId(), null);
        if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺不存在");
        }
        if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
            logger.info("店铺[" + storeProfileDto.getStoreId() + "," + storeProfileDto.getStoreName() + "]是微仓,不支持用户购买");
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺不存在");
        }
        ValidationBeforeAddCartVO validationBeforeAddCartVO = new ValidationBeforeAddCartVO();
        if (!SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileDto.getStoreStatus())) {
            logger.info("店铺[" + storeProfileDto.getStoreId() + "," + storeProfileDto.getStoreName() + "]已关闭营业");
            validationBeforeAddCartVO.setStatus(VALIDATE_STATUS_FAILURE);
            validationBeforeAddCartVO.setNotification("店铺已关闭营业");
            return super.encapsulateParam(validationBeforeAddCartVO, AppMsgBean.MsgCode.SUCCESS, "业务判断成功");
        }
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        Integer customerId = null;
        int cartNum = getCartNumFromSession(validationBeforeAddCartParam.getStoreId(),
                validationBeforeAddCartParam.getActId(), validationBeforeAddCartParam.getSaleProductId());
        if (!ObjectUtils.isNullOrEmpty(userSessionModel)) {
            customerId = userSessionModel.getCustomerId();
            cartNum = getCartNumFromDB(validationBeforeAddCartParam.getActId(),
                    validationBeforeAddCartParam.getSaleProductId(), validationBeforeAddCartParam.getStoreId());
        }
        ShopCartDto shopCartDto = new ShopCartDto();
        shopCartDto.setActivityId(validationBeforeAddCartParam.getActId());
        shopCartDto.setDeviceId(super.getDeviceId(req));
        shopCartDto.setCustomerId(customerId);
        shopCartDto.setSaleProductId(validationBeforeAddCartParam.getSaleProductId());
        shopCartDto.setQuantity(cartNum + 1);
        String validateMessage = shopCartService.validateShopCartSaleProduct(shopCartDto);
        if (!ObjectUtils.isNullOrEmpty(validateMessage)) {
            validationBeforeAddCartVO.setStatus(VALIDATE_STATUS_FAILURE);
            validationBeforeAddCartVO.setNotification(validateMessage);
            return super.encapsulateParam(validationBeforeAddCartVO, AppMsgBean.MsgCode.SUCCESS, "业务判断成功");
        }
        SaleProductAppDto saleProductAppDto = saleProductService
                .loadSaleProductById(validationBeforeAddCartParam.getSaleProductId(), null, null, null);
        List<ShopCartDto> notActShopCartDtos = getNotActShopCartDtoList(validationBeforeAddCartParam.getStoreId());
        boolean isContainVipSaleProduct = isContainVipSaleProduct(notActShopCartDtos,
                validationBeforeAddCartParam.getStoreId());
        boolean isVipSaleProduct = isVipSaleProduct(saleProductAppDto.getProductId());
        if (!ObjectUtils.isNullOrEmpty(validationBeforeAddCartParam.getActId())) {
            isVipSaleProduct = false;
        }
        if (isContainVipSaleProduct && !isVipSaleProduct) {
            validationBeforeAddCartVO.setStatus(VALIDATE_STATUS_TIPSELECT);
            validationBeforeAddCartVO.setNotification(VIPSALEPRODUCT_MSG);
            return super.encapsulateParam(validationBeforeAddCartVO, AppMsgBean.MsgCode.SUCCESS, "业务判断成功");
        }
        if (isVipSaleProduct && !isContainVipSaleProduct && !ObjectUtils.isNullOrEmpty(notActShopCartDtos)) {
            validationBeforeAddCartVO.setStatus(VALIDATE_STATUS_TIPSELECT);
            validationBeforeAddCartVO.setNotification(VIPSALEPRODUCT_MSG);
            return super.encapsulateParam(validationBeforeAddCartVO, AppMsgBean.MsgCode.SUCCESS, "业务判断成功");
        }
        validationBeforeAddCartVO.setStatus(VALIDATE_STATUS_SUCCESS);
        return super.encapsulateParam(validationBeforeAddCartVO, AppMsgBean.MsgCode.SUCCESS, "业务判断成功");
    }

    /**
     * 3.75新版同步调整购物车数量接口
     */
    @RequestMapping(value = "/cart/asycnchangecart")
    @ResponseBody
    public ResultParamModel asycnChangeCart(HttpServletRequest req, HttpServletResponse resp) {
        AsycnChangeCartParam asycnChangeCartParam = super.getEntityParam(req, AsycnChangeCartParam.class);
        if (ObjectUtils.isNullOrEmpty(asycnChangeCartParam)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "参数不能为空");
        }
        int quantity = 1;
        if (WebConstants.ADJUSTMENT_CART_COUNT_REDUCE == asycnChangeCartParam.getType()) {
            quantity = -quantity;
        }
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        Integer customerId = null;
        int cartNum = getCartNumFromSession(asycnChangeCartParam.getStoreId(), asycnChangeCartParam.getActId(),
                asycnChangeCartParam.getSaleProductId());
        if (!ObjectUtils.isNullOrEmpty(userSessionModel)) {
            customerId = userSessionModel.getCustomerId();
            cartNum = getCartNumFromDB(asycnChangeCartParam.getActId(), asycnChangeCartParam.getSaleProductId(),
                    asycnChangeCartParam.getStoreId());
        }
        ShopCartDto shopCartDto = new ShopCartDto();
        shopCartDto.setActivityId(asycnChangeCartParam.getActId());
        shopCartDto.setDeviceId(super.getDeviceId(req));
        shopCartDto.setCustomerId(customerId);
        shopCartDto.setSaleProductId(asycnChangeCartParam.getSaleProductId());
        shopCartDto.setQuantity(cartNum + quantity);
        String validateMessage = shopCartService.validateShopCartSaleProduct(shopCartDto);
        if (!ObjectUtils.isNullOrEmpty(validateMessage)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, validateMessage);
        }
        SaleProductAppDto saleProductAppDto = saleProductService.loadSaleProductById(asycnChangeCartParam.getSaleProductId(),
                null, null, null);
        List<ShopCartDto> notActShopCartDtos = getNotActShopCartDtoList(asycnChangeCartParam.getStoreId());
        boolean isContainVipSaleProduct = isContainVipSaleProduct(notActShopCartDtos, asycnChangeCartParam.getStoreId());
        boolean isVipSaleProduct = isVipSaleProduct(saleProductAppDto.getProductId());
        if (!ObjectUtils.isNullOrEmpty(asycnChangeCartParam.getActId())) {
            isVipSaleProduct = false;
        }
        List<ShopCartDto> shopCartDtoList = null;
        if (ObjectUtils.isNullOrEmpty(userSessionModel)) {
            if (isContainVipSaleProduct && !isVipSaleProduct) {
                // 删除购物里面的vip商品
                removeSessionShopCartVipSaleProduct(asycnChangeCartParam.getStoreId());
            }
            if (isVipSaleProduct && !isContainVipSaleProduct && !ObjectUtils.isNullOrEmpty(notActShopCartDtos)) {
                // 删除购物车里面的普通商品
                removeSessionShopCartNotVipSaleProduct(asycnChangeCartParam.getStoreId());
            }
            if (isSessionShopCartContainSaleProductId(asycnChangeCartParam.getStoreId(), asycnChangeCartParam.getActId(),
                    asycnChangeCartParam.getSaleProductId())) {
                updateSessionShopCartNum(asycnChangeCartParam.getStoreId(), asycnChangeCartParam.getActId(),
                        asycnChangeCartParam.getSaleProductId(), quantity);
            } else {
                if (quantity <= 0) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "购物车数量为0,不能进行此操作");
                }
                addSessionShopCartNum(asycnChangeCartParam.getStoreId(), asycnChangeCartParam.getActId(),
                        asycnChangeCartParam.getSaleProductId(), quantity);
            }
            shopCartDtoList = getShopCartDtoListFromSession(asycnChangeCartParam.getStoreId());
        } else {
            // 用户登录
            ShopCartDto shopCartParamDto = new ShopCartDto();
            shopCartParamDto.setActivityId(asycnChangeCartParam.getActId());
            shopCartParamDto.setDeviceId(super.getDeviceId(req));
            shopCartParamDto.setStoreId(asycnChangeCartParam.getStoreId());
            shopCartParamDto.setCustomerId(customerId);
            shopCartParamDto.setSaleProductId(asycnChangeCartParam.getSaleProductId());
            shopCartParamDto.setUserId(userSessionModel.getUserId());
            shopCartParamDto.setQuantity(quantity);
            shopCartDtoList = shopCartService.updateAsycnChangeCart(shopCartParamDto);
        }
        List<AsycnChangeCartVO> asycnChangeCartVOList = packageAsycnChangeCartVO(shopCartDtoList);
        return super.encapsulateParam(asycnChangeCartVOList, AppMsgBean.MsgCode.SUCCESS, "新版同步调整购物车数量接口成功");
    }

    /**
     * 3.76获取购物车信息列表接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/cart/cartinfo")
    @ResponseBody
    public ResultParamModel listCart(HttpServletRequest req, HttpServletResponse resp) {
        CartListParam confirmCartParam = super.getEntityParam(req, CartListParam.class);
        Integer communityId = confirmCartParam.getCommunityId();
        Integer storeId = confirmCartParam.getStoreId();
        // 当小区ID和店铺ID都有值时,直接使用店铺ID,不校验店铺ID和小区ID的合法性
        StoreProfileDto storeProfileDto = null;
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
        } else {
            storeProfileDto = storeProfileService.loadByStoreId(storeId, null);
        }
        if (null == storeProfileDto) {
            logger.info("找不到店铺信息");
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "确认购物车接口成功");
        }
        storeId = storeProfileDto.getStoreId();
        List<ShopCartDto> shopCartDtoList = null;
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        ConsigneeAddressDto consigneeAddressDto = null;
        Integer customerId = null;
        if (ObjectUtils.isNullOrEmpty(userSession)) {
            shopCartDtoList = getShopCartDtoListFromSession(storeId);
        } else {
            ShopCartQuery shopCartQuery = new ShopCartQuery();
            shopCartQuery.setStoreId(storeId);
            shopCartQuery.setUserId(userSession.getUserId());
            shopCartDtoList = shopCartService.listUserShopCart(shopCartQuery);
            if (!ObjectUtils.isNullOrEmpty(communityId)) {
                consigneeAddressDto = consigneeAddressService.loadLatelyUpdateByCommunityId(communityId,
                        userSession.getCustomerId());
            }
            customerId = userSession.getCustomerId();
        }
        Date currentTime = new Date();
        List<SecKillSceneDto> secKillSceneDtos = secKillSceneService.listStartedAndStaring(currentTime);
        List<Integer> avaliableActivityIds = new ArrayList<Integer>();
        if (!ObjectUtils.isNullOrEmpty(avaliableActivityIds)) {
            for (SecKillSceneDto secKillSceneDto : secKillSceneDtos) {
                avaliableActivityIds.add(secKillSceneDto.getActivityId());
            }
        }
        FirstOrderCustomerRecDto firstOrderCustomerRec = null;
        if (!ObjectUtils.isNullOrEmpty(customerId)) {
            firstOrderCustomerRec = firstOrderCustomerRecService.loadByBuyerCustomerIdAndFirstOrderType(customerId,
                    SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
        }
        // 赋值前端返回数据
        ListCartVO listCartVO = new ListCartVO();
        listCartVO.setCurrentTime(DateUtil.formatDate(new Date(), CommonConstants.DATE_FORMAT_CURRENTTIME));
        List<ShopCartListVO> shopCartList = new ArrayList<ShopCartListVO>();
        List<ShopCartSaleProductListVO> shopCartSaleProductList = new ArrayList<ShopCartSaleProductListVO>();
        if (!ObjectUtils.isNullOrEmpty(shopCartDtoList)) {
            ShopCartListVO shopCartListVO = new ShopCartListVO();
            boolean isVip = isVip();
            for (ShopCartDto shopCartDto : shopCartDtoList) {
                SaleProductAppDto saleProductDto = saleProductService.loadSaleProductById(shopCartDto.getSaleProductId(),
                        null, null, null);
                ObjectUtils.fastCopy(saleProductDto, shopCartDto);
                if (ArithUtils.converIntegerToInt(shopCartDto.getActivityId()) > 0) {
                    if (!avaliableActivityIds.contains(shopCartDto.getActivityId())) {
                        shopCartDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                    }
                    SecKillSaleProductDto secKillSaleProductDto = secKillProductService
                            .loadSecKillSaleProductByActivityIdAndSaleProductId(shopCartDto.getSaleProductId(),
                                    shopCartDto.getActivityId());
                    if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto)) {
                        shopCartDto.setLimitCount(0);
                        shopCartDto.setRemainCount(0);
                    } else {
                        if (SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
                                .equals(secKillSaleProductDto.getStatusCode())) {
                            shopCartDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                        }
                        shopCartDto.setPromotionalPrice(secKillSaleProductDto.getSecKillProductPrice());
                        shopCartDto.setRetailPrice(secKillSaleProductDto.getSecKillProductPrice());
                        int limitOrderCount = ArithUtils.converIntegerToInt(secKillSaleProductDto.getLimitOrderCount());
                        int secKillOrderCount = ArithUtils.converIntegerToInt(secKillSaleProductDto.getSecKillCount());
                        if (limitOrderCount > secKillOrderCount || 0 == limitOrderCount) {
                            limitOrderCount = secKillOrderCount;
                        }
                        int orderCount = ArithUtils.converIntegerToInt(
                                activityOrderCustomerRecService.loadSaleProductOrderCountByActivityIdAndSaleProductId(
                                        shopCartDto.getActivityId(), shopCartDto.getSaleProductId()));
                        if (orderCount >= secKillOrderCount) {
                            limitOrderCount = 0;
                        }
                        if (!ObjectUtils.isNullOrEmpty(customerId)) {
                            Integer customerOrderCount = activityOrderCustomerRecService
                                    .loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(customerId,
                                            shopCartDto.getActivityId(), shopCartDto.getSaleProductId(),
                                            super.getDeviceId(req), null);
                            limitOrderCount = limitOrderCount - ArithUtils.converIntegerToInt(customerOrderCount);
                        }
                        if (limitOrderCount > secKillOrderCount - orderCount) {
                            limitOrderCount = secKillOrderCount - orderCount;
                        }
                        if (limitOrderCount <= 0) {
                            limitOrderCount = 0;
                        }
                        shopCartDto.setLimitCount(limitOrderCount);
                        secKillSaleProductInventoryService.loadByActivityIdAndSaleProductId(shopCartDto.getSaleProductId(),
                                shopCartDto.getActivityId());
                        SecKillSaleProductInventoryDto secKillSaleProductInventoryDto = secKillSaleProductInventoryService
                                .loadByActivityIdAndSaleProductId(shopCartDto.getSaleProductId(),
                                        shopCartDto.getActivityId());
                        if (ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryDto)) {
                            shopCartDto.setRemainCount(0);
                        } else if (saleProductDto.getRemainCount().intValue() > secKillSaleProductInventoryDto
                                .getRemainCount().intValue()) {
                            shopCartDto.setRemainCount(secKillSaleProductInventoryDto.getRemainCount());
                        }
                        long secKillTime = ArithUtils.converLongTolong(secKillSaleProductDto.getSecKillTime());
                        if (secKillTime > 0 && currentTime
                                .after(DateUtils.addSeconds(secKillSaleProductDto.getStartTime(), (int) secKillTime))) {
                            shopCartDto.setRemainCount(0);
                        }
                    }
                } else {
                    if (isPennySaleProduct(saleProductDto.getProductId())) {
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
            for (ShopCartDto shopCartDto : shopCartDtoList) {
                ShopCartSaleProductListVO shopCartSaleProductListVO = new ShopCartSaleProductListVO();
                ObjectUtils.fastCopy(shopCartDto, shopCartSaleProductListVO);
                shopCartSaleProductListVO.setActId(shopCartDto.getActivityId());
                shopCartSaleProductListVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(shopCartDto.getSaleProductImageUrl()));
                shopCartSaleProductListVO.setStockNum(shopCartDto.getRemainCount());
                shopCartSaleProductListVO.setCartNum(shopCartDto.getQuantity());
                shopCartSaleProductListVO.setProductStatus(
                        ConverterUtils.toClientProductSaleStatus(shopCartDto.getSaleStatus(), shopCartDto.getEnabledFlag()));
                Long orderPrice = shopCartDto.getRetailPrice();

                if (!ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId()) && shopCartDto.getActivityId().intValue() > 0) {
                    shopCartSaleProductListVO.setPromotionalPrice(shopCartSaleProductListVO.getPromotionalPrice());
                } else if (isVip) {
                    orderPrice = shopCartDto.getPromotionalPrice();
                }
                shopCartSaleProductListVO.setOrderPrice(orderPrice);
                shopCartSaleProductList.add(shopCartSaleProductListVO);
            }
            ObjectUtils.fastCopy(storeProfileDto, shopCartListVO);
            shopCartListVO.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            shopCartListVO.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            String deliveryTimeNote = StringUtils.defaultIfBlank(
                    systemBasicDataInfoUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(),
                            SystemContext.OrderDomain.SALEORDERBESTTIME_FASTESTTIME),
                    CommonConstants.DELIVERY_TIME_NOTE);
            String pickUpTimeNote = StringUtils
                    .defaultIfBlank(
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(),
                                    SystemContext.OrderDomain.SALEORDERBESTTIME_PICKUP),
                            CommonConstants.PICKUP_TIME_NOTE);
            shopCartListVO.setDeliveryTimeNote(deliveryTimeNote);
            shopCartListVO.setPickUpTimeNote(pickUpTimeNote);
            shopCartListVO.setSaleProductList(shopCartSaleProductList);
            ObjectUtils.fastCopy(storeProfileDto, shopCartListVO);
            shopCartListVO.setStoreStatus(ConverterUtils.toClientStoreStatus(shopCartListVO.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getProvinceCode())) {
                shopCartListVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getCityCode())) {
                shopCartListVO.setCityName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(shopCartListVO.getCountyCode())) {
                shopCartListVO.setCountyName(systemBasicDataInfoUtils.getAreaName(shopCartListVO.getCountyCode()));
            }
            shopCartList.add(shopCartListVO);
        }
        if (!ObjectUtils.isNullOrEmpty(consigneeAddressDto)) {
            ConsigneeAddressBeanVO consigneeAddressBeanVO = new ConsigneeAddressBeanVO();
            ObjectUtils.fastCopy(consigneeAddressDto, consigneeAddressBeanVO);
            String address = StringUtils.join(consigneeAddressDto.getCommunityName(),
                    consigneeAddressDto.getAddressDetail());
            consigneeAddressBeanVO.setAddress(address);
            listCartVO.setConsigneeAddress(consigneeAddressBeanVO);
        }
        listCartVO.setShopCartList(shopCartList);
        return super.encapsulateParam(listCartVO, AppMsgBean.MsgCode.SUCCESS, "获取购物车信息列表成功");
    }

    private void removeSessionShopCartVipSaleProduct(Integer storeId) {
        List<ShopCartItemSessionModel> shopCartItemSessionModels = SessionUtils.getShopCartItemSession();
        if (!ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
            for (Iterator<ShopCartItemSessionModel> iterator = shopCartItemSessionModels.iterator(); iterator.hasNext();) {
                ShopCartItemSessionModel shopCartItemSessionModel = iterator.next();
                if (ObjectUtils.isNullOrEmpty(shopCartItemSessionModel.getActId())
                        && shopCartItemSessionModel.getStoreId().intValue() == storeId.intValue()) {
                    SaleProductDto saleProductDto = saleProductService
                            .loadSaleProductBasicInfoById(shopCartItemSessionModel.getSaleProductId(), null);
                    if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
                        continue;
                    }
                    if (isVipSaleProduct(saleProductDto.getProductId())) {
                        iterator.remove();
                    }
                }
            }
            SessionUtils.setShopCartItemSession(shopCartItemSessionModels);
        }
    }

    private void removeSessionShopCartNotVipSaleProduct(Integer storeId) {
        List<ShopCartItemSessionModel> shopCartItemSessionModels = SessionUtils.getShopCartItemSession();
        if (!ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
            for (Iterator<ShopCartItemSessionModel> iterator = shopCartItemSessionModels.iterator(); iterator.hasNext();) {
                ShopCartItemSessionModel shopCartItemSessionModel = iterator.next();
                if (ObjectUtils.isNullOrEmpty(shopCartItemSessionModel.getActId())
                        && shopCartItemSessionModel.getStoreId().intValue() == storeId.intValue()) {
                    SaleProductDto saleProductDto = saleProductService
                            .loadSaleProductBasicInfoById(shopCartItemSessionModel.getSaleProductId(), null);
                    if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
                        continue;
                    }
                    if (!isVipSaleProduct(saleProductDto.getProductId())) {
                        iterator.remove();
                    }
                }
            }
            SessionUtils.setShopCartItemSession(shopCartItemSessionModels);
        }
    }

    private boolean isSessionShopCartContainSaleProductId(Integer storeId, Integer actId, Integer saleProductId) {
        List<ShopCartItemSessionModel> shopCartItemSessionModels = SessionUtils.getShopCartItemSession();
        if (ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
            return false;
        }
        for (ShopCartItemSessionModel shopCartItemSessionModel : shopCartItemSessionModels) {
            if (shopCartItemSessionModel.getStoreId().intValue() == storeId.intValue()) {
                if (ArithUtils.converIntegerToInt(actId) == ArithUtils
                        .converIntegerToInt(shopCartItemSessionModel.getActId())
                        && saleProductId.intValue() == shopCartItemSessionModel.getSaleProductId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }

    private void updateSessionShopCartNum(Integer storeId, Integer actId, Integer saleProductId, Integer quantity) {
        List<ShopCartItemSessionModel> shopCartItemSessionModels = SessionUtils.getShopCartItemSession();
        if (!ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
            for (Iterator<ShopCartItemSessionModel> iterator = shopCartItemSessionModels.iterator(); iterator.hasNext();) {
                ShopCartItemSessionModel shopCartItemSessionModel = iterator.next();
                if (shopCartItemSessionModel.getStoreId().intValue() == storeId) {
                    if (ArithUtils.converIntegerToInt(actId) == ArithUtils
                            .converIntegerToInt(shopCartItemSessionModel.getActId())
                            && saleProductId.intValue() == shopCartItemSessionModel.getSaleProductId().intValue()) {
                        Integer sessionCartNum = shopCartItemSessionModel.getQuantity() + quantity;
                        if (sessionCartNum <= 0) {
                            iterator.remove();
                        } else {
                            shopCartItemSessionModel.setQuantity(sessionCartNum);
                        }
                    }
                }
            }
        }
        SessionUtils.setShopCartItemSession(shopCartItemSessionModels);
    }

    private void addSessionShopCartNum(Integer storeId, Integer actId, Integer saleProductId, Integer quantity) {
        List<ShopCartItemSessionModel> shopCartItemSessionModels = SessionUtils.getShopCartItemSession();
        if (ObjectUtils.isNullOrEmpty(shopCartItemSessionModels)) {
            shopCartItemSessionModels = new ArrayList<ShopCartItemSessionModel>();
        }
        ShopCartItemSessionModel shopCartItemSessionModel = new ShopCartItemSessionModel();
        shopCartItemSessionModel.setActId(actId);
        shopCartItemSessionModel.setSaleProductId(saleProductId);
        shopCartItemSessionModel.setQuantity(quantity);
        shopCartItemSessionModel.setStoreId(storeId);
        shopCartItemSessionModels.add(shopCartItemSessionModel);
        SessionUtils.setShopCartItemSession(shopCartItemSessionModels);
    }

    private int getSystemConfigTicketSelect() {
        String systemConfigTicketSelectStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.P_TICKET_SELECT_CONFIG);
        if (StringUtils.isEmpty(systemConfigTicketSelectStr)) {
            return TICKET_SELECT_ONE;
        }
        int systemConfigTicketSelect = Integer.parseInt(systemConfigTicketSelectStr);
        return systemConfigTicketSelect;
    }

    private List<ShopCartDto> getShopCartDtoListFromSession(Integer storeId) {
        List<ShopCartItemSessionModel> shopCartItemSessions = SessionUtils.getShopCartItemSession();
        List<ShopCartDto> shopCartDtos = new ArrayList<ShopCartDto>();
        if (ObjectUtils.isNullOrEmpty(shopCartItemSessions)) {
            return shopCartDtos;
        }
        if (!ObjectUtils.isNullOrEmpty(shopCartItemSessions)) {
            for (ShopCartItemSessionModel shopCartItemSessionModel : shopCartItemSessions) {
                if (shopCartItemSessionModel.getStoreId().intValue() == storeId.intValue()) {
                    ShopCartDto shopCartDto = new ShopCartDto();
                    shopCartDto.setActivityId(shopCartItemSessionModel.getActId());
                    shopCartDto.setSaleProductId(shopCartItemSessionModel.getSaleProductId());
                    shopCartDto.setQuantity(shopCartItemSessionModel.getQuantity());
                    shopCartDto.setStoreId(shopCartItemSessionModel.getStoreId());
                    shopCartDtos.add(shopCartDto);
                }
            }
        }
        return shopCartDtos;
    }

    private List<ShopCartDto> getShopCartDtoListFromDB(Integer storeId) {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        ShopCartQuery shopCartQuery = new ShopCartQuery();
        shopCartQuery.setUserId(userSessionModel.getUserId());
        shopCartQuery.setStoreId(storeId);
        List<ShopCartDto> shopCartDtos = shopCartService.listUserShopCart(shopCartQuery);
        return shopCartDtos;
    }

    private List<ShopCartDto> getNotActShopCartDtoListFromSession(Integer storeId) {
        List<ShopCartDto> allShopCartDtos = getShopCartDtoListFromSession(storeId);
        if (ObjectUtils.isNullOrEmpty(allShopCartDtos)) {
            return Collections.emptyList();
        }
        List<ShopCartDto> notActShopCartDtos = new ArrayList<ShopCartDto>();
        for (ShopCartDto shopCartDto : allShopCartDtos) {
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                notActShopCartDtos.add(shopCartDto);
            }
        }
        return notActShopCartDtos;
    }

    private List<ShopCartDto> getNotActShopCartDtoListFromDB(Integer storeId) {
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromDB(storeId);
        if (ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            return Collections.emptyList();
        }
        List<ShopCartDto> notActShopCartDtos = new ArrayList<ShopCartDto>();
        for (ShopCartDto shopCartDto : shopCartDtos) {
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                notActShopCartDtos.add(shopCartDto);
            }
        }
        return notActShopCartDtos;
    }

    private Integer getCartNumFromSession(Integer storeId, Integer actId, Integer saleProductId) {
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromSession(storeId);
        if (!ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            for (ShopCartDto shopCartDto : shopCartDtos) {
                if (ArithUtils.converIntegerToInt(shopCartDto.getActivityId()) == ArithUtils.converIntegerToInt(actId)
                        && shopCartDto.getSaleProductId().intValue() == saleProductId) {
                    return shopCartDto.getQuantity();
                }
            }
        }
        return 0;
    }

    private Integer getCartNumFromDB(Integer actId, Integer saleProductId, Integer storeId) {
        List<ShopCartDto> shopCartDtos = getShopCartDtoListFromDB(storeId);
        if (!ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            for (ShopCartDto shopCartDto : shopCartDtos) {
                if (ArithUtils.converIntegerToInt(shopCartDto.getActivityId()) == ArithUtils.converIntegerToInt(actId)
                        && shopCartDto.getSaleProductId().intValue() == saleProductId) {
                    return shopCartDto.getQuantity();
                }
            }
        }
        return 0;
    }

    private List<AsycnChangeCartVO> packageAsycnChangeCartVO(List<ShopCartDto> shopCartDtos) {
        if (ObjectUtils.isNullOrEmpty(shopCartDtos)) {
            return Collections.emptyList();
        }
        List<AsycnChangeCartVO> asycnChangeCartVOList = new ArrayList<AsycnChangeCartVO>();
        boolean isVip = isVip();
        for (ShopCartDto shopCartDto : shopCartDtos) {
            AsycnChangeCartVO asycnChangeCartVO = new AsycnChangeCartVO();
            asycnChangeCartVO.setActId(shopCartDto.getActivityId());
            asycnChangeCartVO.setSaleProductId(shopCartDto.getSaleProductId());
            asycnChangeCartVO.setCartNum(shopCartDto.getQuantity());
            if (ObjectUtils.isNullOrEmpty(shopCartDto.getActivityId())) {
                SaleProductAppDto saleProductDto = saleProductService.loadSaleProductById(shopCartDto.getSaleProductId(),
                        null, null, null);
                if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
                    logger.info("商品ID[" + shopCartDto.getSaleProductId() + "]不存在");
                    continue;
                }
                if (isVip) {
                    asycnChangeCartVO.setOrderPrice(saleProductDto.getPromotionalPrice());
                } else {
                    asycnChangeCartVO.setOrderPrice(saleProductDto.getRetailPrice());
                }
            } else {
                SecKillSaleProductDto secKillSaleProductDto = secKillProductService
                        .loadSecKillSaleProductByActivityIdAndSaleProductId(shopCartDto.getSaleProductId(),
                                shopCartDto.getActivityId());
                if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto)) {
                    continue;
                }
                asycnChangeCartVO.setOrderPrice(secKillSaleProductDto.getSecKillProductPrice());
            }
            asycnChangeCartVOList.add(asycnChangeCartVO);
        }
        return asycnChangeCartVOList;
    }

    private List<ShopCartDto> getNotActShopCartDtoList(Integer storeId) {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        List<ShopCartDto> notActShopCartDtos = null;
        if (!ObjectUtils.isNullOrEmpty(userSessionModel)) {
            notActShopCartDtos = getNotActShopCartDtoListFromDB(storeId);
        } else {
            notActShopCartDtos = getNotActShopCartDtoListFromSession(storeId);
        }
        return notActShopCartDtos;
    }

    private boolean isContainVipSaleProduct(List<ShopCartDto> notActShopCartDtos, Integer storeId) {
        if (ObjectUtils.isNullOrEmpty(notActShopCartDtos)) {
            return false;
        }
        for (ShopCartDto shopCartDto : notActShopCartDtos) {
            SaleProductDto saleProductDto = saleProductService.loadSaleProductBasicInfoById(shopCartDto.getSaleProductId(),
                    null);
            if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
                continue;
            }
            if (isVipSaleProduct(saleProductDto.getProductId())) {
                return true;
            }
        }
        return false;
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
        String productIdSystemParam = SystemBasicDataUtils.getSystemParamValue(productType);
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
}
