package com.yilidi.o2o.controller.mobile.buyer.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.order.OrderCancelParam;
import com.yilidi.o2o.appparam.buyer.order.OrderConfirmParam;
import com.yilidi.o2o.appparam.buyer.order.OrderDetailParam;
import com.yilidi.o2o.appparam.buyer.order.OrderListParam;
import com.yilidi.o2o.appparam.buyer.order.PaySuccessInfoParam;
import com.yilidi.o2o.appparam.buyer.order.RefundInfoParam;
import com.yilidi.o2o.appvo.buyer.order.ConsigneeAddressBeanVO;
import com.yilidi.o2o.appvo.buyer.order.GiftInfoVO;
import com.yilidi.o2o.appvo.buyer.order.OrderBaseInfoVO;
import com.yilidi.o2o.appvo.buyer.order.OrderDetailItemVO;
import com.yilidi.o2o.appvo.buyer.order.OrderDetailStatusVO;
import com.yilidi.o2o.appvo.buyer.order.OrderDetailVO;
import com.yilidi.o2o.appvo.buyer.order.OrderFeeInfoVO;
import com.yilidi.o2o.appvo.buyer.order.OrderImageVO;
import com.yilidi.o2o.appvo.buyer.order.OrderListVO;
import com.yilidi.o2o.appvo.buyer.order.OrderRefundInfoVO;
import com.yilidi.o2o.appvo.buyer.order.OrderRefundStatusVO;
import com.yilidi.o2o.appvo.buyer.order.PaySuccessInfoVO;
import com.yilidi.o2o.appvo.buyer.product.RewardSaleProductVO;
import com.yilidi.o2o.appvo.buyer.product.RewardTicketVO;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SaleOrderStatusMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IOrderRefundService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.OrderConsigneeAddressDto;
import com.yilidi.o2o.order.service.dto.OrderGiftInfoDto;
import com.yilidi.o2o.order.service.dto.OrderRefundDto;
import com.yilidi.o2o.order.service.dto.OrderRefundStatusHistoryDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 订单
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerSaleOrderController")
@RequestMapping(value = "/interfaces/buyer")
public class SaleOrderController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    @Autowired
    private IOrderService orderService;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IUserShareService userShareService;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ICouponService couponService;
    @Autowired
    private IOrderRefundService orderRefundService;

    private static final String SALEORDERSTATUS_FORRECEIVE_PICKUP_DESC = "待提货";
    /** 优惠券 **/
    private static final int TICKETTYPE_COUPON = 1;
    /** 优惠券名称 **/
    private static final String TICKETTYPENAME_COUPON = "优惠券";

    /**
     * 订单列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/orderlist")
    @ResponseBody
    public ResultParamModel orderList(HttpServletRequest req, HttpServletResponse resp) {
        OrderListParam orderListParam = super.getEntityParam(req, OrderListParam.class);
        /**
         * 查询订单列表类型： 0-全部订单 1-待付款 2-待确认 3-已完成 4-退款订单
         **/
        String statusCode = orderListParam.getStatusCode();
        Integer pageNum = orderListParam.getPageNum();
        Integer pageSize = orderListParam.getPageSize();

        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();

        SaleOrderQueryDto saleOrderQuery = new SaleOrderQueryDto();
        // saleOrderQuery.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
        saleOrderQuery.setPageSize(pageSize);
        saleOrderQuery.setStart(pageNum);
        saleOrderQuery.setUserId(userSessionModel.getUserId());
        saleOrderQuery.setBuyerCustomerId(userSessionModel.getCustomerId());
        saleOrderQuery.setStatusCodes(ConverterUtils.toServerOrderStatusCode(statusCode));
        if (WebConstants.ORDERLIST_FINISHED == Integer.parseInt(statusCode)) {
            saleOrderQuery.setAppraiseFlag(SystemContext.OrderDomain.APPRAISEFLAG_NO);
        }
        saleOrderQuery.setOrder(DBTablesColumnsName.SaleOrder.CREATETIME);
        saleOrderQuery.setSort(CommonConstants.SORT_ORDER_DESC);
        // saleOrderQuery.setStatusCode(statusCode);

        YiLiDiPage<SaleOrderDto> page = orderService.findSaleOrders(saleOrderQuery);
        List<SaleOrderDto> saleOrderDtoList = page.getResultList();
        List<OrderListVO> orderListVos = new ArrayList<OrderListVO>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderDtoList)) {
            for (SaleOrderDto saleOrderDto : saleOrderDtoList) {
                OrderListVO saleOrderListVO = new OrderListVO();
                String orderStatusCode = saleOrderDto.getStatusCode();
                String orderStatusCodeName = systemBasicDataInfoUtils
                        .getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERSTATUS.getValue(), orderStatusCode);
                if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(orderStatusCode)
                        && SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                    orderStatusCodeName = SALEORDERSTATUS_FORRECEIVE_PICKUP_DESC;
                }
                saleOrderListVO.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
                saleOrderListVO.setCreateTime(
                        DateUtils.formatDate(saleOrderDto.getCreateTime(), CommonConstants.DATE_FORMAT_CURRENTTIME));
                saleOrderListVO.setQuantity(saleOrderDto.getOrderCount());
                saleOrderListVO.setStatusCode(SaleOrderStatusMapping.getType(orderStatusCode));
                saleOrderListVO.setStatusCodeName(orderStatusCodeName);
                saleOrderListVO.setIsEvaluated(ConverterUtils.toClientAppraiseFlag(saleOrderDto.getAppraiseFlag()));
                saleOrderListVO.setStoreId(saleOrderDto.getStoreId());
                saleOrderListVO.setStoreName(saleOrderDto.getStoreName());
                saleOrderListVO.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(saleOrderDto.getDeliveryMode()));
                long payAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                        + ArithUtils.converLongTolong(saleOrderDto.getTransferFee())
                        - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
                if (payAmount <= 0) {
                    payAmount = 0;
                }
                saleOrderListVO.setTotalAmount(payAmount);
                List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderDto.getSaleOrderItemDtoList();
                List<OrderImageVO> imageList = new ArrayList<OrderImageVO>();
                if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
                    for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                        OrderImageVO saleOrderImageVO = new OrderImageVO();
                        saleOrderImageVO.setOrderImage(StringUtils.toFullImageUrl(saleOrderItemDto.getProductImageUrl3()));
                        imageList.add(saleOrderImageVO);
                    }
                }
                saleOrderListVO.setOrderImageList(imageList);
                orderListVos.add(saleOrderListVO);
            }
        }
        return super.encapsulatePageParam(page, orderListVos, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 订单详情
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/orderdetail")
    @ResponseBody
    public ResultParamModel orderDetail(HttpServletRequest req, HttpServletResponse resp) {
        OrderDetailParam orderDetailParam = super.getEntityParam(req, OrderDetailParam.class);
        String orderNo = orderDetailParam.getSaleOrderNo();
        SaleOrderDetailDto saleOrderDetailDto = orderService.findOrderDetailByOrderNo(orderNo);
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        SaleOrderDto saleOrderDto = saleOrderDetailDto.getSaleOrderDto();
        if (saleOrderDto.getBuyerCustomerId().intValue() != userSessionModel.getCustomerId().intValue()) {
            logger.error("用户[" + userSessionModel.getUserId() + "]请求不合法");
            throw new OrderServiceException("不合法的请求");
        }
        OrderConsigneeAddressDto orderConsigneeAddressDto = saleOrderDto.getOrderConsigneeAddressDto();
        List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderDetailDto.getItems();
        List<SaleOrderHistoryDto> saleOrderHistoryDtoList = saleOrderDetailDto.gethList();
        OrderDetailVO orderDetailVO = new OrderDetailVO();
        orderDetailVO.setReceiveNo(saleOrderDto.getReceiveCode());

        // 订单信息
        OrderBaseInfoVO orderBaseInfo = new OrderBaseInfoVO();
        String orderStatusCode = saleOrderDto.getStatusCode();
        String statusCodeName = systemBasicDataInfoUtils
                .getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERSTATUS.getValue(), orderStatusCode);
        if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(saleOrderDto.getStatusCode())
                && SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
            statusCodeName = SALEORDERSTATUS_FORRECEIVE_PICKUP_DESC;
        }
        orderBaseInfo.setStatusCode(SaleOrderStatusMapping.getType(orderStatusCode));
        orderBaseInfo.setStatusCodeName(statusCodeName);
        orderBaseInfo.setStoreId(saleOrderDto.getStoreId());
        orderBaseInfo.setStoreName(saleOrderDto.getStoreName());
        orderBaseInfo.setCreateTime(DateUtils.formatDate(saleOrderDetailDto.getSaleOrderDto().getCreateTime(),
                CommonConstants.DATE_FORMAT_CURRENTTIME));
        orderBaseInfo.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(saleOrderDto.getDeliveryMode()));
        orderBaseInfo.setDeliveryModeName(saleOrderDto.getDeliveryModeName());
        orderBaseInfo.setSaleOrderId(saleOrderDto.getId());
        orderBaseInfo.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
        orderBaseInfo.setPayTypeCode(saleOrderDto.getPayTypeCode());
        orderBaseInfo.setPayTypeName(saleOrderDto.getPayTypeName());
        orderBaseInfo.setNote(saleOrderDto.getNote());
        orderBaseInfo.setIsEvaluated(ConverterUtils.toClientAppraiseFlag(saleOrderDto.getAppraiseFlag()));
        orderDetailVO.setOrderBaseInfo(orderBaseInfo);

        // 订单费用信息
        OrderFeeInfoVO orderFeeInfoVO = new OrderFeeInfoVO();
        Long payableAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                + ArithUtils.converLongTolong(saleOrderDto.getTransferFee())
                - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
        if (payableAmount < 0) {
            payableAmount = 0L;
        }
        orderFeeInfoVO.setPayableAmount(payableAmount);
        orderFeeInfoVO.setPreferentialAmt(saleOrderDto.getPreferentialAmt());
        orderFeeInfoVO.setTotalAmount(saleOrderDto.getTotalAmount());
        orderFeeInfoVO.setTransferFee(saleOrderDto.getTransferFee());
        orderDetailVO.setOrderFeeInfo(orderFeeInfoVO);

        // 地址信息
        if (null != orderConsigneeAddressDto) {
            ConsigneeAddressBeanVO consigneeAddressBean = new ConsigneeAddressBeanVO();
            consigneeAddressBean.setAddress(orderConsigneeAddressDto.getAddressDetail());
            consigneeAddressBean.setConsigneeName(orderConsigneeAddressDto.getUserName());
            consigneeAddressBean.setPhoneNo(orderConsigneeAddressDto.getPhoneNo());
            orderDetailVO.setConsigneeAddressBean(consigneeAddressBean);
        }

        // 商品列表
        List<OrderDetailItemVO> orderDetailItemList = new ArrayList<OrderDetailItemVO>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                OrderDetailItemVO orderDetailItemVO = new OrderDetailItemVO();
                orderDetailItemVO.setBrandName(saleOrderItemDto.getBrandName());
                orderDetailItemVO.setCartNum(saleOrderItemDto.getQuantity());
                orderDetailItemVO.setOrderPrice(saleOrderItemDto.getOrderPrice());
                orderDetailItemVO.setSaleProductId(saleOrderItemDto.getSaleProductId());
                orderDetailItemVO.setSaleProductName(saleOrderItemDto.getProductName());
                orderDetailItemVO.setSaleProductSpec(saleOrderItemDto.getSpecifications());
                orderDetailItemVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(saleOrderItemDto.getProductImageUrl3()));
                orderDetailItemList.add(orderDetailItemVO);
            }
        }
        orderDetailVO.setSaleOrderItemList(orderDetailItemList);

        // 订单状态列表
        List<OrderDetailStatusVO> orderDetailStatusList = new ArrayList<OrderDetailStatusVO>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderHistoryDtoList)) {
            for (SaleOrderHistoryDto saleOrderHistoryDto : saleOrderHistoryDtoList) {
                OrderDetailStatusVO orderDetailStatusVO = new OrderDetailStatusVO();
                String statusCode = saleOrderHistoryDto.getOrderStatus();
                orderDetailStatusVO.setStatusCode(SaleOrderStatusMapping.getType(statusCode));
                orderDetailStatusVO
                        .setStatusCodeName(SaleOrderStatusMapping.getTypeName(statusCode, saleOrderDto.getDeliveryMode()));
                orderDetailStatusVO.setStatusNote(saleOrderHistoryDto.getOperationDesc());
                orderDetailStatusVO.setStatusTime(
                        DateUtils.formatDate(saleOrderHistoryDto.getOperateTime(), CommonConstants.DATE_FORMAT_CURRENTTIME));
                orderDetailStatusList.add(orderDetailStatusVO);
            }
        }
        orderDetailVO.setOrderStatusList(orderDetailStatusList);
        // 设置店铺信息
        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(saleOrderDto.getStoreId(), null);
        if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            StoreInfoVO storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(storeProfileDto, storeInfoVo);
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeProfileDto.getStoreStatus()));
            storeInfoVo.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            storeInfoVo.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
            }
            orderDetailVO.setStoreInfo(storeInfoVo);
        }
        boolean isVip = isVip();
        GiftInfoVO giftInfoVO = new GiftInfoVO();
        List<OrderGiftInfoDto> saleProductInfoDtos = saleOrderDetailDto.getSaleProductGiftInfoDtos();
        List<OrderGiftInfoDto> ticketProductInfoDtos = saleOrderDetailDto.getTicketGiftInfoDtos();
        if (!ObjectUtils.isNullOrEmpty(saleProductInfoDtos)) {
            List<RewardSaleProductVO> rewardSaleProductVOs = new ArrayList<RewardSaleProductVO>(saleProductInfoDtos.size());
            for (OrderGiftInfoDto orderGiftInfoDto : saleProductInfoDtos) {
                SaleProductAppDto saleProductAppDto = saleProductService.loadSaleProductById(orderGiftInfoDto.getGiftId(),
                        null, null, null);
                if (!ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
                    RewardSaleProductVO rewardSaleProductVO = new RewardSaleProductVO();
                    rewardSaleProductVO.setSaleProductId(orderGiftInfoDto.getGiftId());
                    rewardSaleProductVO.setCartNum(orderGiftInfoDto.getGiftCount());
                    rewardSaleProductVO.setBrandName(saleProductAppDto.getBrandName());
                    Long orderPrice = saleProductAppDto.getRetailPrice();
                    if (isVip) {
                        orderPrice = saleProductAppDto.getPromotionalPrice();
                    }
                    if (!ObjectUtils.isNullOrEmpty(saleProductAppDto.getSaleProductProfileDto())) {
                        rewardSaleProductVO
                                .setSaleProductSpec(saleProductAppDto.getSaleProductProfileDto().getSaleProductSpec());
                    }
                    rewardSaleProductVO.setOrderPrice(orderPrice);
                    rewardSaleProductVO
                            .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductAppDto.getSaleProductImageUrl()));
                    rewardSaleProductVOs.add(rewardSaleProductVO);
                }
            }
            giftInfoVO.setGiftProductList(rewardSaleProductVOs);
        }
        if (!ObjectUtils.isNullOrEmpty(ticketProductInfoDtos)) {
            List<RewardTicketVO> rewardTicketVOs = new ArrayList<RewardTicketVO>(ticketProductInfoDtos.size());
            for (OrderGiftInfoDto orderGiftInfoDto : ticketProductInfoDtos) {
                UserCouponDto userCouponDto = couponService.loadUserCouponByUserIdAndConId(saleOrderDto.getUserId(),
                        orderGiftInfoDto.getGiftId());
                CouponDto couponDto = couponService.loadCouponById(orderGiftInfoDto.getGiftId());
                CouponPackageDto couponPackageDto = couponService.loadCouponPackageById(couponDto.getConPackId());
                if (!ObjectUtils.isNullOrEmpty(userCouponDto)) {
                    RewardTicketVO rewardTicketVO = new RewardTicketVO();
                    rewardTicketVO.setCartNum(orderGiftInfoDto.getGiftCount());
                    rewardTicketVO.setTicketId(orderGiftInfoDto.getGiftId());
                    rewardTicketVO.setBeginTime(userCouponDto.getBeginTime());
                    rewardTicketVO.setEndTime(userCouponDto.getEndTime());
                    rewardTicketVO.setLimitedAmount(couponPackageDto.getUseCondition());
                    rewardTicketVO.setTicketAmount(couponPackageDto.getAmount());
                    rewardTicketVO.setTicketDescription(couponDto.getRule());
                    rewardTicketVO.setTicketType(TICKETTYPE_COUPON);
                    rewardTicketVO.setTicketTypeName(TICKETTYPENAME_COUPON);
                    rewardTicketVO.setUseScope(couponDto.getUseRangeCodeName());
                    rewardTicketVOs.add(rewardTicketVO);
                }
            }
            giftInfoVO.setGiftCouponList(rewardTicketVOs);
        }
        orderDetailVO.setGiftInfo(giftInfoVO);
        return super.encapsulateParam(orderDetailVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 取消订单
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return HttpServletResponse
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/cancel")
    @ResponseBody
    public ResultParamModel orderCancel(HttpServletRequest req, HttpServletResponse resp) {
        OrderCancelParam orderCancelParam = super.getEntityParam(req, OrderCancelParam.class);
        String saleOrderNo = orderCancelParam.getSaleOrderNo();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        orderService.updateOrderForBuyerCancel(saleOrderNo, userSession.getUserId(), null);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "取消订单成功");
    }

    /**
     * 订单确认收货
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/confirm")
    @ResponseBody
    public ResultParamModel orderConfirm(HttpServletRequest req, HttpServletResponse resp) {
        OrderConfirmParam orderConfirmParam = super.getEntityParam(req, OrderConfirmParam.class);
        String saleOrderNo = orderConfirmParam.getSaleOrderNo(); // 订单编码
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        orderService.updateOrderConfirm(saleOrderNo, userSession.getUserId());
        Date nowTime = new Date();
        // 发送用户分享下单奖励消息
        userShareService.sendUserShareAwardMessage(userSession.getUserId(), nowTime, saleOrderNo,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_PRODUCT);
        userShareService.sendUserShareAwardMessage(userSession.getUserId(), nowTime, saleOrderNo,
                SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_ANYORDER);
        // 发送买赠奖励
        couponService.sendBuyActivityCouponMessage(saleOrderNo, userSession.getUserId(), nowTime);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "确认收货成功");
    }

    /**
     * 获取订单支付成功信息
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/paysuccessinfo")
    @ResponseBody
    public ResultParamModel paySuccessInfo(HttpServletRequest req, HttpServletResponse resp) {
        PaySuccessInfoParam orderConfirmParam = super.getEntityParam(req, PaySuccessInfoParam.class);
        String saleOrderNo = orderConfirmParam.getSaleOrderNo(); // 订单编码
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(saleOrderNo);
        if (ObjectUtils.isNullOrEmpty(saleOrderDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "操作成功");
        }
        PaySuccessInfoVO paySuccessInfoVO = new PaySuccessInfoVO();
        ObjectUtils.fastCopy(saleOrderDto, paySuccessInfoVO);
        String deliveryModeName = systemBasicDataInfoUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.SALEORDERDELIVERYMODE.getValue(), saleOrderDto.getDeliveryMode());
        String deliveryTimeNote = systemBasicDataInfoUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(), saleOrderDto.getBestTime());
        paySuccessInfoVO.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(saleOrderDto.getDeliveryMode()));
        paySuccessInfoVO.setDeliveryModeName(deliveryModeName);
        paySuccessInfoVO.setDeliveryTimeNote(deliveryTimeNote);
        long payAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                + ArithUtils.converLongTolong(saleOrderDto.getTransferFee())
                - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
        if (payAmount <= 0) {
            payAmount = 0;
        }
        paySuccessInfoVO.setPaidAmount(payAmount);
        String payTypeName = systemBasicDataInfoUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.SALEORDERPAYTYPE.getValue(), saleOrderDto.getPayTypeCode());
        paySuccessInfoVO.setPayTypeName(payTypeName);
        // 设置店铺信息
        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(saleOrderDto.getStoreId(), null);
        if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            StoreInfoVO storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(storeProfileDto, storeInfoVo);
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeProfileDto.getStoreStatus()));
            storeInfoVo.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            storeInfoVo.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCountyCode()));
            }
            storeInfoVo.setHotline(StringUtils.defaultIfBlank(storeProfileDto.getMobile(), storeProfileDto.getTelPhone()));
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeProfileDto.getStoreStatus()));
            paySuccessInfoVO.setStoreInfo(storeInfoVo);
        }
        return super.encapsulateParam(paySuccessInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 3.97查询订单退款详细信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/order/refundinfo")
    @ResponseBody
    public ResultParamModel refundInfo(HttpServletRequest req, HttpServletResponse resp) {
        RefundInfoParam refundInfoParam = super.getEntityParam(req, RefundInfoParam.class);
        String saleOrderNo = refundInfoParam.getSaleOrderNo(); // 订单编码
        OrderRefundDto orderRefundDto = orderRefundService.loadBySaleOrderNo(saleOrderNo);
        OrderRefundInfoVO orderRefundInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(orderRefundDto)) {
            orderRefundInfoVO = new OrderRefundInfoVO();
            orderRefundInfoVO.setReason(orderRefundDto.getRefundReason());
            orderRefundInfoVO.setRefundAmount(orderRefundDto.getRefundAmount());
            orderRefundInfoVO.setSaleOrderNo(saleOrderNo);
            String statusName = systemBasicDataInfoUtils.getSystemDictName(
                    SystemContext.OrderDomain.DictType.ORDERREFUNDSTATUS.getValue(), orderRefundDto.getStatus());
            orderRefundInfoVO.setStatusCodeName(statusName);
            String refundTypeName = systemBasicDataInfoUtils.getSystemDictName(
                    SystemContext.OrderDomain.DictType.ORDERREFUNDWAY.getValue(), orderRefundDto.getRefundWay());
            orderRefundInfoVO.setRefundTypeName(refundTypeName);
            orderRefundInfoVO.setStatusCode(convertStatusCode(orderRefundDto.getStatus()));
            String payTypeName = systemBasicDataInfoUtils.getSystemDictName(
                    SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(), orderRefundDto.getPayPlatformCode());
            orderRefundInfoVO.setPayTypeName(payTypeName);
            List<OrderRefundStatusHistoryDto> refundHistoryDtos = orderRefundDto.getOrderRefundStatusHistoreyDtos();
            if (!ObjectUtils.isNullOrEmpty(refundHistoryDtos)) {
                List<OrderRefundStatusVO> orderRefundStatusVOs = new ArrayList<OrderRefundStatusVO>(
                        refundHistoryDtos.size());
                for (OrderRefundStatusHistoryDto orderRefundStatusHistoryDto : refundHistoryDtos) {
                    OrderRefundStatusVO orderRefundStatusVO = new OrderRefundStatusVO();
                    orderRefundStatusVO.setStatusCode(convertStatusCode(orderRefundStatusHistoryDto.getStatus()));
                    String statusCodeName = systemBasicDataInfoUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.ORDERREFUNDSTATUS.getValue(),
                            orderRefundStatusHistoryDto.getStatus());
                    orderRefundStatusVO.setStatusCodeName(statusCodeName);
                    orderRefundStatusVO.setStatusNote(orderRefundStatusHistoryDto.getOperationDesc());
                    orderRefundStatusVO.setStatusTime(orderRefundStatusHistoryDto.getOperateTime());
                    orderRefundStatusVOs.add(orderRefundStatusVO);
                }
                orderRefundInfoVO.setRefundStatusList(orderRefundStatusVOs);
            }
        }
        return super.encapsulateParam(orderRefundInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private Integer convertStatusCode(String statusCode) {
        if (SystemContext.OrderDomain.ORDERREFUNDSTATUS_APPLY.equals(statusCode)) {
            return 11;
        }
        if (SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING.equals(statusCode)) {
            return 8;
        }
        if (SystemContext.OrderDomain.ORDERREFUNDSTATUS_SUCCESS.equals(statusCode)) {
            return 9;
        }
        if (SystemContext.OrderDomain.ORDERREFUNDSTATUS_FAILURE.equals(statusCode)) {
            return 10;
        }
        return null;
    }
}
