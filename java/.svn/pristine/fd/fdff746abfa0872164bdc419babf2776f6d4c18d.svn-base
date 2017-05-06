package com.yilidi.o2o.controller.mobile.seller.order;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.order.AcceptOrderParam;
import com.yilidi.o2o.appparam.seller.order.CancelOrderParam;
import com.yilidi.o2o.appparam.seller.order.ListOrderParam;
import com.yilidi.o2o.appparam.seller.order.ReceiveOrderParam;
import com.yilidi.o2o.appparam.seller.order.SendOrderParam;
import com.yilidi.o2o.appparam.seller.order.ShowOrderDetailParam;
import com.yilidi.o2o.appvo.seller.order.OrderAcceptVO;
import com.yilidi.o2o.appvo.seller.order.OrderBaseVO;
import com.yilidi.o2o.appvo.seller.order.OrderCancelVO;
import com.yilidi.o2o.appvo.seller.order.OrderDeliveryVO;
import com.yilidi.o2o.appvo.seller.order.OrderDetailVO;
import com.yilidi.o2o.appvo.seller.order.OrderFinishVO;
import com.yilidi.o2o.appvo.seller.order.SaleProductOrderItemVO;
import com.yilidi.o2o.appvo.seller.order.SaleProductSettleVO;
import com.yilidi.o2o.appvo.seller.user.ConsigneeAddressVO;
import com.yilidi.o2o.appvo.seller.user.StoreSettleVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SaleOrderStatusMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.DistanceUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderConsigneeAddressService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.OrderConsigneeAddressDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaleProductSettleDto;
import com.yilidi.o2o.order.service.dto.SellerOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SellerOrderListDto;
import com.yilidi.o2o.order.service.dto.query.SellerListOrderQueryDto;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * @Description: TODO(订单Controller)
 * @author: chenlian
 * @date: 2016年6月1日 下午2:18:08
 */
@Controller("sellerOrderController")
@RequestMapping(value = "/interfaces/seller")
public class OrderController extends SellerBaseController {

    private static final String SALEORDERSTATUS_PAID_NAME = "待接单";

    private static final String SALEORDERSTATUS_FORSEND_NAME = "未发货";

    private static final String SALEORDERSTATUS_FORRECEIVE_NAME = "配送中";

    private static final String SALEORDERSTATUS_FINISHED_NAME = "已完成";

    private static final String SALEORDERSTATUS_APPRAISE_NAME = "已评价";

    private static final String SALEORDERSTATUS_CANCEL_NAME = "已取消";

    private static final String SALEORDERSTATUS_REFUNDING_NAME = "退款中";

    private static final String SALEORDERSTATUS_REFUNDSUCCESS_NAME = "退款完成";

    private static final String SALEORDERSTATUS_REFUNDFAILURE_NAME = "退款失败";

    private static final String SALEORDERSTATUS_FORPICKUP_NAME = "待提货";

    private static final String SALEORDERSTATUS_PICKUP_NAME = "已提货";

    private static final String REFUND_INTERVAL_DAYS_DEFAULT = "3-5";

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IOrderConsigneeAddressService orderConsigneeAddressService;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IMessageService messageService;
    @Autowired
    private IUserShareService userShareService;

    /**
     * 
     * 获取订单列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/orderlist")
    @ResponseBody
    public ResultParamModel getOrderList(HttpServletRequest req, HttpServletResponse resp) {
        ListOrderParam listOrderParam = super.getEntityParam(req, ListOrderParam.class);
        SellerListOrderQueryDto sellerListOrderQueryDto = new SellerListOrderQueryDto();
        sellerListOrderQueryDto.setStoreId(super.getStoreId());
        sellerListOrderQueryDto.setUserId(super.getUserId());
        sellerListOrderQueryDto.setMasterFlag(super.getMasterFlag());
        if (!StringUtils.isEmpty(listOrderParam.getStatusCode())) {
            sellerListOrderQueryDto
                    .setStatusCodeList(ConverterUtils.toServerOrderStatusCodeForSeller(listOrderParam.getStatusCode()));
        }
        if (!StringUtils.isEmpty(listOrderParam.getStatusCode())
                && (Integer.toString(WebConstants.SELLER_ORDERLIST_FINISHED).equals(listOrderParam.getStatusCode())
                        || Integer.toString(WebConstants.SELLER_ORDERLIST_CANCEL).equals(listOrderParam.getStatusCode()))) {
            sellerListOrderQueryDto.setOrder(DBTablesColumnsName.SaleOrder.CREATETIME);
            sellerListOrderQueryDto.setSort(CommonConstants.SORT_ORDER_DESC);
        }
        sellerListOrderQueryDto.setKeyword(listOrderParam.getKeyword());
        sellerListOrderQueryDto.setLongitude(super.getLongitude());
        sellerListOrderQueryDto.setLatitude(super.getLatitude());
        if (null != listOrderParam.getOrderType()) {
            sellerListOrderQueryDto.setOrderTypeCodeList(ConverterUtils.toServerOrderType(listOrderParam.getOrderType()));
        }
        if (null != listOrderParam.getDeliveryType()) {
            sellerListOrderQueryDto
                    .setDeliveryTypeCode(ConverterUtils.toServerDeliveryType(listOrderParam.getDeliveryType()));
        }
        sellerListOrderQueryDto.setStart(listOrderParam.getPageNum());
        sellerListOrderQueryDto.setPageSize(listOrderParam.getPageSize());
        YiLiDiPage<SellerOrderListDto> sellerListOrderDtoPageInfos = orderService
                .findOrderListForSeller(sellerListOrderQueryDto);
        List<SellerOrderListDto> sellerListOrderDtoList = sellerListOrderDtoPageInfos.getResultList();
        List<OrderBaseVO> orderBaseVOList = new ArrayList<OrderBaseVO>();
        if (!ObjectUtils.isNullOrEmpty(sellerListOrderDtoList)) {
            for (SellerOrderListDto sellerListOrderDto : sellerListOrderDtoList) {
                OrderBaseVO orderBaseVO = new OrderBaseVO();
                orderBaseVO.setSaleOrderNo(sellerListOrderDto.getSaleOrderNo());
                orderBaseVO.setCreateTime(sellerListOrderDto.getCreateTime());
                orderBaseVO.setPayTime(sellerListOrderDto.getPayTime());
                orderBaseVO.setTotalAmount(sellerListOrderDto.getTotalAmount());
                orderBaseVO.setPayableAmount(sellerListOrderDto.getPayableAmount());
                orderBaseVO.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(sellerListOrderDto.getDeliveryMode()));
                if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(sellerListOrderDto.getDeliveryMode())) {
                    UserDto uDto = userService.loadBuyerUserById(sellerListOrderDto.getUserId());
                    if (null != uDto && !StringUtils.isEmpty(uDto.getUserName())) {
                        orderBaseVO.setBuyerMobile(uDto.getUserName());
                    }
                } else {
                    ConsigneeAddressVO consigneeAddressVO = new ConsigneeAddressVO();
                    consigneeAddressVO.setConsignee(sellerListOrderDto.getConsignee());
                    consigneeAddressVO.setConsMobile(sellerListOrderDto.getConsMobile());
                    consigneeAddressVO.setConsAddress(sellerListOrderDto.getConsAddress());
                    consigneeAddressVO.setDistance(sellerListOrderDto.getDistance());
                    orderBaseVO.setConsigneeAddress(consigneeAddressVO);
                }
                orderBaseVOList.add(orderBaseVO);
            }
        }
        return super.encapsulatePageParam(sellerListOrderDtoPageInfos, orderBaseVOList, AppMsgBean.MsgCode.SUCCESS,
                "获取订单列表成功");
    }

    /**
     * 
     * 获取订单详情
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/orderdetails")
    @ResponseBody
    public ResultParamModel orderDetails(HttpServletRequest req, HttpServletResponse resp) {
        ShowOrderDetailParam showOrderDetailParam = super.getEntityParam(req, ShowOrderDetailParam.class);
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == storeProfileDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "您店铺不存在");
        }
        SellerOrderDetailDto sellerOrderDetailDto = null;
        if (StringUtils.isEmpty(showOrderDetailParam.getSaleOrderNo())) {
            String saleOrderNo = orderService.getSaleOrderNoBySellerWithReceiveCode(super.getStoreId(),
                    showOrderDetailParam.getReceiveNo());
            if (StringUtils.isEmpty(saleOrderNo)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该收货码不存在对应的未完成或未取消订单");
            }
            sellerOrderDetailDto = orderService.showOrderDetailForSeller(saleOrderNo, super.getStoreId(),
                    storeProfileDto.getMobile());
        } else {
            sellerOrderDetailDto = orderService.showOrderDetailForSeller(showOrderDetailParam.getSaleOrderNo(),
                    super.getStoreId(), storeProfileDto.getMobile());
        }
        if (null == sellerOrderDetailDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "订单不存在");
        }
        OrderDetailVO orderDetailVO = new OrderDetailVO();
        ObjectUtils.fastCopy(sellerOrderDetailDto, orderDetailVO);
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_PAID).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_PAID_NAME);
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_FORSEND_NAME);
        }
        if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(sellerOrderDetailDto.getDeliveryMode())) {
            if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                    .getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE).intValue()) {
                orderDetailVO.setStatusCodeName(SALEORDERSTATUS_FORPICKUP_NAME);
            }
            if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                    .getType(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED).intValue()) {
                orderDetailVO.setStatusCodeName(SALEORDERSTATUS_PICKUP_NAME);
            }
        } else {
            if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                    .getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE).intValue()) {
                orderDetailVO.setStatusCodeName(SALEORDERSTATUS_FORRECEIVE_NAME);
            }
            if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                    .getType(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED).intValue()) {
                orderDetailVO.setStatusCodeName(SALEORDERSTATUS_FINISHED_NAME);
            }
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_APPRAISE_NAME);
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_CANCEL_NAME);
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_REFUNDING_NAME);
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_REFUNDSUCCESS_NAME);
        }
        if (orderDetailVO.getStatusCode().intValue() == SaleOrderStatusMapping
                .getType(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE).intValue()) {
            orderDetailVO.setStatusCodeName(SALEORDERSTATUS_REFUNDFAILURE_NAME);
            orderDetailVO.setStatusDesc(sellerOrderDetailDto.getRefundAuditFailureReason());
        }
        orderDetailVO.setDeliveryModeCode(ConverterUtils.toClientDeliveryType(sellerOrderDetailDto.getDeliveryMode()));
        if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(sellerOrderDetailDto.getDeliveryMode())) {
            UserDto uDto = userService.loadBuyerUserById(sellerOrderDetailDto.getUserId());
            if (null != uDto && !StringUtils.isEmpty(uDto.getUserName())) {
                orderDetailVO.setBuyerMobile(uDto.getUserName());
            }
        }
        OrderConsigneeAddressDto orderConsigneeAddressDto = sellerOrderDetailDto.getOrderConsigneeAddressDto();
        if (null != orderConsigneeAddressDto) {
            ConsigneeAddressVO consigneeAddressVO = new ConsigneeAddressVO();
            consigneeAddressVO.setConsignee(orderConsigneeAddressDto.getUserName());
            consigneeAddressVO.setConsMobile(orderConsigneeAddressDto.getPhoneNo());
            consigneeAddressVO.setConsAddress(orderConsigneeAddressDto.getAddressDetail());
            consigneeAddressVO.setDistance(DistanceUtils.distance(super.getLongitude(), super.getLatitude(),
                    orderConsigneeAddressDto.getLongitude(), orderConsigneeAddressDto.getLatitude()));
            consigneeAddressVO.setLongitude(Double.valueOf(orderConsigneeAddressDto.getLongitude()));
            consigneeAddressVO.setLatitude(Double.valueOf(orderConsigneeAddressDto.getLatitude()));
            orderDetailVO.setConsigneeAddress(consigneeAddressVO);
        }
        List<SaleOrderItemDto> saleOrderItemDtoList = sellerOrderDetailDto.getSaleOrderItemDtoList();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            List<SaleProductOrderItemVO> saleOrderItemList = new ArrayList<SaleProductOrderItemVO>();
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                SaleProductOrderItemVO saleProductOrderItemVO = new SaleProductOrderItemVO();
                saleProductOrderItemVO.setSaleProductId(saleOrderItemDto.getSaleProductId());
                saleProductOrderItemVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleOrderItemDto.getProductImageUrl3()));
                saleProductOrderItemVO.setSaleProductName(saleOrderItemDto.getProductName());
                saleProductOrderItemVO.setSaleProductSpec(saleOrderItemDto.getSpecifications());
                saleProductOrderItemVO.setBrandName(saleOrderItemDto.getBrandName());
                saleProductOrderItemVO.setCartNum(saleOrderItemDto.getQuantity());
                saleProductOrderItemVO.setCurrentPrice(saleOrderItemDto.getOrderPrice());
                saleOrderItemList.add(saleProductOrderItemVO);
            }
            orderDetailVO.setSaleOrderItemList(saleOrderItemList);
        }
        List<SaleProductSettleDto> saleProductSettleDtoList = sellerOrderDetailDto.getSaleProductSettleDtoList();
        if (!ObjectUtils.isNullOrEmpty(saleProductSettleDtoList)) {
            List<SaleProductSettleVO> saleOrderItemSettleList = new ArrayList<SaleProductSettleVO>();
            for (SaleProductSettleDto saleProductSettleDto : saleProductSettleDtoList) {
                SaleProductSettleVO saleProductSettleVO = new SaleProductSettleVO();
                ObjectUtils.fastCopy(saleProductSettleDto, saleProductSettleVO);
                if (0L != saleProductSettleDto.getSettleAmount().longValue()
                        && !SystemContext.OrderDomain.SALEORDERTYPE_VIP.equals(sellerOrderDetailDto.getTypeCode())) {
                    saleOrderItemSettleList.add(saleProductSettleVO);
                }
            }
            orderDetailVO.setSaleOrderItemSettleList(saleOrderItemSettleList);
        }
        return super.encapsulateParam(orderDetailVO, AppMsgBean.MsgCode.SUCCESS, "获取订单详情成功");
    }

    /**
     * 
     * 订单接单
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/accept")
    @ResponseBody
    public ResultParamModel accept(HttpServletRequest req, HttpServletResponse resp) {
        AcceptOrderParam acceptOrderParam = super.getEntityParam(req, AcceptOrderParam.class);
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == storeProfileDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "您店铺不存在");
        }
        Date acceptTime = DateUtils.getCurrentDateTime();
        Integer saleOrderId = orderService.updateForAccept(acceptOrderParam.getSaleOrderNo(), super.getStoreId(),
                storeProfileDto.getMobile(), super.getUserId(), acceptTime);
        OrderAcceptVO orderAcceptVO = new OrderAcceptVO();
        orderAcceptVO.setSaleOrderId(saleOrderId);
        orderAcceptVO.setSaleOrderNo(acceptOrderParam.getSaleOrderNo());
        orderAcceptVO.setStatusCode(SaleOrderStatusMapping.getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND));
        orderAcceptVO.setStatusCodeName(SALEORDERSTATUS_FORSEND_NAME);
        orderAcceptVO.setAcceptTime(DateUtils.formatDateLong(acceptTime));
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(acceptOrderParam.getSaleOrderNo());
        UserDto uDto = userService.loadBuyerUserById(saleOrderDto.getUserId());
        if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
            orderAcceptVO
                    .setStatusCode(SaleOrderStatusMapping.getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE));
            orderAcceptVO.setStatusCodeName(SALEORDERSTATUS_FORRECEIVE_NAME);
            try {
                if (null != uDto && !StringUtils.isEmpty(uDto.getUserName())) {
                    messageService.systemSendSms(SmsTypeModelClassMapping.ORDERPREPARED, Arrays.asList(uDto.getUserName()),
                            storeProfileDto.getBusinessHoursEnd().substring(0,
                                    storeProfileDto.getBusinessHoursEnd().lastIndexOf(CommonConstants.DELIMITER_COLON)),
                            saleOrderDto.getReceiveCode(), storeProfileDto.getMobile());
                }
            } catch (SystemServiceException e) {
                logger.error(e.getMessage(), e);
            }
        }
        return super.encapsulateParam(orderAcceptVO, AppMsgBean.MsgCode.SUCCESS, "订单接单成功");
    }

    /**
     * 
     * 订单取消
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/cancel")
    @ResponseBody
    public ResultParamModel cancel(HttpServletRequest req, HttpServletResponse resp) {
        CancelOrderParam cancelOrderParam = super.getEntityParam(req, CancelOrderParam.class);
        Date cancelTime = DateUtils.getCurrentDateTime();
        Integer saleOrderId = orderService.updateForSellerCancel(cancelOrderParam.getSaleOrderNo(), super.getStoreId(),
                super.getUserId(), cancelTime);
        OrderCancelVO orderCancelVO = new OrderCancelVO();
        orderCancelVO.setSaleOrderId(saleOrderId);
        orderCancelVO.setSaleOrderNo(cancelOrderParam.getSaleOrderNo());
        orderCancelVO.setStatusCode(SaleOrderStatusMapping.getType(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING));
        orderCancelVO.setStatusCodeName(SALEORDERSTATUS_REFUNDING_NAME);
        orderCancelVO.setCancelTime(DateUtils.formatDateLong(cancelTime));
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(cancelOrderParam.getSaleOrderNo());
        Long preferentialAmt = null == saleOrderDto.getPreferentialAmt() ? 0L : saleOrderDto.getPreferentialAmt();
        Long refundAmount = saleOrderDto.getTotalAmount() + saleOrderDto.getTransferFee() - preferentialAmt;
        OrderConsigneeAddressDto orderConsigneeAddressDto = orderConsigneeAddressService
                .loadByOrderNo(cancelOrderParam.getSaleOrderNo());
        UserDto uDto = userService.loadBuyerUserById(saleOrderDto.getUserId());
        if (refundAmount <= 0) {
            return super.encapsulateParam(orderCancelVO, AppMsgBean.MsgCode.SUCCESS, "订单取消成功");
        }
        if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
            if (null != uDto && !StringUtils.isEmpty(uDto.getUserName())) {
                try {
                    messageService.systemSendSms(SmsTypeModelClassMapping.ORDERREFUND, Arrays.asList(uDto.getUserName()),
                            String.valueOf(ArithUtils.div(refundAmount, 1000, 3)), getSystemConfigRefundDays(),
                            getSystemConfigCustomerHotline());
                } catch (SystemServiceException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        } else {
            if (null != orderConsigneeAddressDto && !StringUtils.isEmpty(orderConsigneeAddressDto.getPhoneNo())) {
                try {
                    messageService.systemSendSms(SmsTypeModelClassMapping.ORDERREFUND,
                            Arrays.asList(orderConsigneeAddressDto.getPhoneNo()),
                            String.valueOf(ArithUtils.div(refundAmount, 1000, 3)), getSystemConfigRefundDays(),
                            getSystemConfigCustomerHotline());
                } catch (SystemServiceException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }
        return super.encapsulateParam(orderCancelVO, AppMsgBean.MsgCode.SUCCESS, "订单取消成功");
    }

    private String getSystemConfigRefundDays() {
        String systemConfigRefundDays = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.REFUND_INTERVAL_DAYS);
        systemConfigRefundDays = StringUtils.isEmpty(systemConfigRefundDays) ? REFUND_INTERVAL_DAYS_DEFAULT
                : systemConfigRefundDays;
        return systemConfigRefundDays;
    }

    private String getSystemConfigCustomerHotline() {
        String systemConfigCustomerHotline = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.CUSTOMER_HOTLINE);
        systemConfigCustomerHotline = StringUtils.isEmpty(systemConfigCustomerHotline)
                ? CommonConstants.CUSTOMER_HOTLINE_DEFAULT : systemConfigCustomerHotline;
        return systemConfigCustomerHotline;
    }

    /**
     * 
     * 订单配送
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/delivery")
    @ResponseBody
    public ResultParamModel delivery(HttpServletRequest req, HttpServletResponse resp) {
        SendOrderParam sendOrderParam = super.getEntityParam(req, SendOrderParam.class);
        Date sendTime = DateUtils.getCurrentDateTime();
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        Integer saleOrderId = orderService.updateForSellerSend(sendOrderParam.getSaleOrderNo(), super.getStoreId(),
                storeProfileDto.getMobile(), SystemContext.OrderDomain.SALEORDERSENDSTATUS_SENT, super.getUserId(),
                sendTime);
        OrderDeliveryVO orderDeliveryVO = new OrderDeliveryVO();
        orderDeliveryVO.setSaleOrderId(saleOrderId);
        orderDeliveryVO.setSaleOrderNo(sendOrderParam.getSaleOrderNo());
        orderDeliveryVO.setStatusCode(SaleOrderStatusMapping.getType(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE));
        orderDeliveryVO.setStatusCodeName(SALEORDERSTATUS_FORRECEIVE_NAME);
        orderDeliveryVO.setDeliveryTime(DateUtils.formatDateLong(sendTime));
        OrderConsigneeAddressDto orderConsigneeAddressDto = orderConsigneeAddressService
                .loadByOrderNo(sendOrderParam.getSaleOrderNo());
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(sendOrderParam.getSaleOrderNo());
        try {
            if (null != orderConsigneeAddressDto && !StringUtils.isEmpty(orderConsigneeAddressDto.getPhoneNo())) {
                messageService.systemSendSms(SmsTypeModelClassMapping.ORDERSEND,
                        Arrays.asList(orderConsigneeAddressDto.getPhoneNo()), saleOrderDto.getReceiveCode());
            }
        } catch (SystemServiceException e) {
            logger.error(e.getMessage(), e);
        }
        return super.encapsulateParam(orderDeliveryVO, AppMsgBean.MsgCode.SUCCESS, "订单配送成功");
    }

    /**
     * 
     * 订单收货
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/order/finish")
    @ResponseBody
    public ResultParamModel finish(HttpServletRequest req, HttpServletResponse resp) {
        ReceiveOrderParam receiveOrderParam = super.getEntityParam(req, ReceiveOrderParam.class);
        Date takeTime = DateUtils.getCurrentDateTime();
        Integer saleOrderId = orderService.updateForSellerConfirmReceive(receiveOrderParam.getSaleOrderNo(),
                receiveOrderParam.getReceiveNo(), super.getStoreId(), SystemContext.OrderDomain.SALEORDERTAKESTATUS_RECEIVED,
                super.getUserId(), takeTime);
        OrderFinishVO orderFinishVO = new OrderFinishVO();
        orderFinishVO.setSaleOrderId(saleOrderId);
        orderFinishVO.setSaleOrderNo(receiveOrderParam.getSaleOrderNo());
        orderFinishVO.setStatusCode(SaleOrderStatusMapping.getType(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED));
        orderFinishVO.setStatusCodeName(SALEORDERSTATUS_FINISHED_NAME);
        orderFinishVO.setFinishTime(DateUtils.formatDateLong(takeTime));
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(receiveOrderParam.getSaleOrderNo());
        // 发送用户分享下单奖励消息
        if (ObjectUtils.isNullOrEmpty(saleOrderDto)) {
            userShareService.sendUserShareAwardMessage(saleOrderDto.getUserId(), takeTime, receiveOrderParam.getSaleOrderNo(),
                    SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_PRODUCT);
            userShareService.sendUserShareAwardMessage(saleOrderDto.getUserId(), takeTime, receiveOrderParam.getSaleOrderNo(),
                    SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_ANYORDER);
        }
        return super.encapsulateParam(orderFinishVO, AppMsgBean.MsgCode.SUCCESS, "订单收货成功");
    }

    /**
     * 获取店铺首页结算信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/store/settlesimpleinfo")
    @ResponseBody
    public ResultParamModel settleSimpleInfo(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        Date lastMonday = DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.MONDAY);
        Date lastSunday = DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.SUNDAY);
        Date thisMonday = DateUtils.getConcreteDateByPutOffWeeks(0, Calendar.MONDAY);
        Long totalCommissionAmountLastWeek = orderService.getTotalCommissionAmountByTimes(super.getStoreId(),
                DateUtils.getSpecificStartDate(lastMonday), DateUtils.getSpecificEndDate(lastSunday));
        Long totalCommissionAmountThisWeek = orderService.getTotalCommissionAmountByTimes(super.getStoreId(),
                DateUtils.getSpecificStartDate(thisMonday), DateUtils.getCurrentDateTime());
        StoreSettleVO storeSettleVO = new StoreSettleVO();
        storeSettleVO.setLastWeekAmount(null == totalCommissionAmountLastWeek ? 0L : totalCommissionAmountLastWeek);
        storeSettleVO.setCurrentWeekAmount(null == totalCommissionAmountThisWeek ? 0L : totalCommissionAmountThisWeek);
        return super.encapsulateParam(storeSettleVO, AppMsgBean.MsgCode.SUCCESS, "获取店铺首页结算信息成功");
    }

}
