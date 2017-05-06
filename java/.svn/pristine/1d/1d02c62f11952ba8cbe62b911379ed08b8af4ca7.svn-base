/**
 * 文件名称：OrderService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SaleOrderStatusMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.DistanceUtils;
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.ActivityOrderCustomerRecMapper;
import com.yilidi.o2o.order.dao.FirstOrderCustomerRecMapper;
import com.yilidi.o2o.order.dao.OrderGiftInfoMapper;
import com.yilidi.o2o.order.dao.OrderPaymentMapper;
import com.yilidi.o2o.order.dao.OrderRefundMapper;
import com.yilidi.o2o.order.dao.OrderRefundStatusHistoryMapper;
import com.yilidi.o2o.order.dao.OrderReminderPayMessageMapper;
import com.yilidi.o2o.order.dao.OrderStockShareRecordMapper;
import com.yilidi.o2o.order.dao.SaleOrderHistoryMapper;
import com.yilidi.o2o.order.dao.SaleOrderItemMapper;
import com.yilidi.o2o.order.dao.SaleOrderMapper;
import com.yilidi.o2o.order.dao.UserCouponMapper;
import com.yilidi.o2o.order.dao.UserVoucherMapper;
import com.yilidi.o2o.order.model.ActivityOrderCustomerRec;
import com.yilidi.o2o.order.model.FirstOrderCustomerRec;
import com.yilidi.o2o.order.model.OrderGiftInfo;
import com.yilidi.o2o.order.model.OrderPayment;
import com.yilidi.o2o.order.model.OrderRefund;
import com.yilidi.o2o.order.model.OrderRefundStatusHistory;
import com.yilidi.o2o.order.model.OrderReminderPayMessage;
import com.yilidi.o2o.order.model.OrderStockShareRecord;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.SaleOrderHistory;
import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.query.RecommendOrderInfoQuery;
import com.yilidi.o2o.order.model.query.SaleOrderQuery;
import com.yilidi.o2o.order.model.query.SellerListOrderQuery;
import com.yilidi.o2o.order.model.query.SettleDetailQuery;
import com.yilidi.o2o.order.model.result.AllVolumeStatisticsInfo;
import com.yilidi.o2o.order.model.result.BaseVolumeStatisticsInfo;
import com.yilidi.o2o.order.model.result.RecommendOrderInfo;
import com.yilidi.o2o.order.model.result.SaleOrderInfo;
import com.yilidi.o2o.order.model.result.SaleOrderItemInfo;
import com.yilidi.o2o.order.model.result.SaleOrderStatisticsInfo;
import com.yilidi.o2o.order.model.result.SaleProductStatisticsInfo;
import com.yilidi.o2o.order.model.result.SettleDetailInfo;
import com.yilidi.o2o.order.model.result.UserCouponInfo;
import com.yilidi.o2o.order.model.result.UserVoucherInfo;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IOrderConsigneeAddressService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.IRefundApplyService;
import com.yilidi.o2o.order.service.ISaleOrderItemService;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.ISecKillSaleProductInventoryService;
import com.yilidi.o2o.order.service.IStockInService;
import com.yilidi.o2o.order.service.IStockOutService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.AllVolumeStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.CreateOrderDto;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.OrderConsigneeAddressDto;
import com.yilidi.o2o.order.service.dto.OrderGiftInfoDto;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.RecommendOrderInfoDto;
import com.yilidi.o2o.order.service.dto.RefundApplyDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.SaleOrderInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderStatisticsDto;
import com.yilidi.o2o.order.service.dto.SaleProductSettleDto;
import com.yilidi.o2o.order.service.dto.SaleProductStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.SaveOrderDto;
import com.yilidi.o2o.order.service.dto.SellerOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SellerOrderListDto;
import com.yilidi.o2o.order.service.dto.SettleDetailDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.RecommendOrderInfoQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SellerListOrderQueryDto;
import com.yilidi.o2o.order.service.dto.query.SettleDetailQueryDto;
import com.yilidi.o2o.product.proxy.IBuyRewardActivityProxyService;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.ISecKillProductProxyService;
import com.yilidi.o2o.product.proxy.ISecKillSceneProxyService;
import com.yilidi.o2o.product.proxy.dto.BuyRewardGiftInfoProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SecKillProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SecKillSceneProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.ISystemMessageProxyService;
import com.yilidi.o2o.system.proxy.dto.CommunityProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemMessageProxyDto;
import com.yilidi.o2o.user.proxy.ICommunityProxyService;
import com.yilidi.o2o.user.proxy.IConsigneeAddressProxyService;
import com.yilidi.o2o.user.proxy.ICustomerProxyService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IStoreSubsidyRecordProxyService;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.AllSubsidyInfoProxyDto;
import com.yilidi.o2o.user.proxy.dto.ConsigneeAddressProxyDto;
import com.yilidi.o2o.user.proxy.dto.CustomerProxyDto;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 功能描述：订单服务实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("orderService")
public class OrderServiceImpl extends BasicDataService implements IOrderService {

    private static final String YESTERDAY = "yesterday";
    private static final String TODAY = "today";
    private static final String ONEWEEK = "oneweek";
    private static final String ONEMONTH = "onemonth";
    private static final String STARTTIME = StringUtils.STARTTIMESTRING;
    private static final String ENDTIME = StringUtils.ENDTIMESTRING;
    /** 订单明细列表最多显示条数 **/
    private static final int SALE_ORDER_ITEM_LIST_SIZE = 6;
    /** 付款超时时间，单位:分 **/
    private static final int SALE_ORDER_PAY_TIME_OUT = 30;
    /** 提醒付款时间,单位:分 **/
    private static final int REMINDDER_SALE_ORDER_PAY_TIME = 15;
    /** 卖家接单超时时间 **/
    private static final int SALE_ORDER_RECEIVE_TIME_OUT = 60;
    /** 热线电话 **/
    private static final String CUSTOMER_HOTLINE_DEFAULT = "4001-333-866";
    /** 退款默认到账工作日 **/
    private static final String REFUND_INTERVAL_DAYS_DEFAULT = "3-5";
    private static final String DISTRIBUTED_FIRSTORDER_LOCK_PREFIX = "SAVE_FIRSTORDER_";
    private static final String DISTRIBUTED_ACTIVITYIDORDER_LOCK_PREFIX = "SAVE_ACTIVITYIDORDER_";
    /** 购买VIP商品升级会员有效时间(单位“月”，默认12个月) **/
    private static final int BUYERPRODUCTTO_VIP_DEFAULT_EXPIRE_MONTH = 12;
    /** 一分钱可购买数量 **/
    private static final Integer PENNY_PRODUCT_LIMIT_COUNT = 1;
    /** 需要自动收货时间间隔，单位：天 **/
    private static final String NEED_AUTO_RECEIVE_INTERVAL_TIME_DEFAULT = "5";
    /** VIP商品佣金计算基数,单位:厘 **/
    private static final String VIP_COMMISSION_BASE = "45000";

    private static final String SALEORDERSTATUS_FORSEND_NAME = "待发货";

    private static final String SALEORDERSTATUS_FORRECEIVE_NAME = "待收货";

    private static final String SALEORDERSTATUS_FINISHED_NAME = "交易成功";

    private static final String SALEORDERSTATUS_APPRAISE_NAME = "已评价";
    /** 奖券信息是否是单选:单选 **/
    private static final int TICKET_SELECT_ONE = 1;

    private static final String ORDER_REFUND_APPLY_DESC = "申请退款";
    private static final String ORDER_REFUNDING_DESC = "一里递接受退款申请";
    private static final String ORDER_REFUND_SELLERCANCEL_DESC = "合伙人未接单";
    private static final String ORDER_REFUND_SUCCESS_DESC = "退款完成";
    private static final String ORDER_REFUND_FAILURE_DESC = "退款失败";
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private SaleOrderMapper saleOrderMapper;
    @Autowired
    private SaleOrderItemMapper saleOrderItemMapper;
    @Autowired
    private SaleOrderHistoryMapper saleOrderHistoryMapper;
    @Autowired
    private ISaleOrderItemService saleOrderItemService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
    @Autowired
    private IUserProxyService userProxyService;
    @Autowired
    private IOrderConsigneeAddressService orderConsigneeAddressService;
    @Autowired
    private IStoreSubsidyRecordProxyService storeSubsidyRecordProxyService;
    @Autowired
    private IConsigneeAddressProxyService consigneeAddressProxyService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private ICommunityProxyService communityProxyService;
    @Autowired
    private IRefundApplyService refundApplyService;
    @Autowired
    private IStockOutService stockOutService;
    @Autowired
    private IStockInService stockInService;
    @Autowired
    private IMessageProxyService messageProxyService;
    @Autowired
    private IPayLogService payLogService;
    @Autowired
    private OrderPaymentMapper orderPaymentMapper;
    @Autowired
    private OrderReminderPayMessageMapper orderReminderPayMessageMapper;
    @Autowired
    private FirstOrderCustomerRecMapper firstOrderCustomerRecMapper;
    @Autowired
    private ICustomerProxyService customerProxyService;
    @Autowired
    private ISecKillProductProxyService secKillProductProxyService;
    @Autowired
    private ISecKillSceneProxyService secKillSceneProxyService;
    @Autowired
    private ISecKillSaleProductInventoryService secKillSaleProductInventoryService;
    @Autowired
    private ActivityOrderCustomerRecMapper activityOrderCustomerRecMapper;
    @Autowired
    private UserCouponMapper userCouponMapper;
    @Autowired
    private ICouponService couponService;
    @Autowired
    private IVoucherService voucherService;
    @Autowired
    private UserVoucherMapper userVoucherMapper;
    @Autowired
    private IStoreWarehouseProxyService storeWarehouseProxyService;
    @Autowired
    private OrderStockShareRecordMapper orderStockShareRecordMapper;
    @Autowired
    private ISystemMessageProxyService systemMessageProxyService;
    @Autowired
    private IBuyRewardActivityProxyService buyRewardActivityProxyService;
    @Autowired
    private OrderGiftInfoMapper orderGiftInfoMapper;
    @Autowired
    private OrderRefundMapper orderRefundMapper;
    @Autowired
    private OrderRefundStatusHistoryMapper orderRefundStatusHistoryMapper;

    @Override
    public SaleOrderDto loadBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            SaleOrderDto saleOrderDto = null;
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (!ObjectUtils.isNullOrEmpty(saleOrder)) {
                saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderDto);
            }
            return saleOrderDto;
        } catch (ProductServiceException e) {
            logger.error("通过订单编号查询订单信息失败", e);
            throw new OrderServiceException("订单编号查询订单信息异常");
        }
    }

    @Override
    public YiLiDiPage<SaleOrderInfoDto> findSaleOrderInfos(SaleOrderQueryDto query) throws OrderServiceException {
        if (null == query.getStart() || query.getStart() <= 0) {
            query.setStart(1);
        }
        if (null == query.getPageSize() || query.getPageSize() <= 0) {
            query.setPageSize(CommonConstants.PAGE_SIZE);
        }
        PageHelper.startPage(query.getStart(), query.getPageSize());
        if (!ObjectUtils.isNullOrEmpty(query.getDateType())) {
            if (query.getDateType().equals(YESTERDAY)) {
                try {
                    query.setStartOrderDate(DateUtils.addDays(DateUtils.getTodayStartDate(), -1));
                    query.setEndOrderDate(DateUtils.addDays(DateUtils.getTodayEndDate(), -1));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (query.getDateType().equals(TODAY)) {
                try {
                    query.setStartOrderDate(DateUtils.getTodayStartDate());
                    query.setEndOrderDate(DateUtils.getTodayEndDate());
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (query.getDateType().equals(ONEWEEK)) {
                try {
                    query.setStartOrderDate(DateUtils.addDays(DateUtils.getTodayStartDate(), -6));
                    query.setEndOrderDate(DateUtils.getTodayEndDate());
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (query.getDateType().equals(ONEMONTH)) {
                try {
                    query.setStartOrderDate(DateUtils.addDays(DateUtils.getTodayStartDate(), -29));
                    query.setEndOrderDate(DateUtils.getTodayEndDate());
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } else {
            if (!ObjectUtils.isNullOrEmpty(query.getStrBeginOrderTime())) {
                try {
                    Date startOrderDate = DateUtils.parseDate(query.getStrBeginOrderTime() + STARTTIME);
                    query.setStartOrderDate(startOrderDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrEndOrderTime())) {
                try {
                    Date endOrderDate = DateUtils.parseDate(query.getStrEndOrderTime() + ENDTIME);
                    query.setEndOrderDate(endOrderDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrBeginPriceTime())) {
                try {
                    Date startPayDate = DateUtils.parseDate(query.getStrBeginPriceTime() + STARTTIME);
                    query.setStartPayDate(startPayDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrEndPriceTime())) {
                try {
                    Date endPayDate = DateUtils.parseDate(query.getStrEndPriceTime() + ENDTIME);
                    query.setEndPayDate(endPayDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
        Page<SaleOrderInfo> page = saleOrderMapper.findSaleOrderInfos(query);
        Page<SaleOrderInfoDto> pageDto = new Page<SaleOrderInfoDto>(query.getStart(), query.getPageSize());
        ObjectUtils.fastCopy(page, pageDto);
        List<SaleOrderInfo> saleOrderInfos = page.getResult();

        if (!ObjectUtils.isNullOrEmpty(saleOrderInfos)) {
            for (SaleOrderInfo orderInfo : saleOrderInfos) {
                if (!ObjectUtils.isNullOrEmpty(orderInfo)) {
                    SaleOrderInfoDto saleOrderInfoDto = new SaleOrderInfoDto();
                    ObjectUtils.fastCopy(orderInfo, saleOrderInfoDto);
                    if (!ObjectUtils.isNullOrEmpty(saleOrderInfoDto.getStatusCode())) {
                        String statusName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERSTATUS.getValue(),
                                saleOrderInfoDto.getStatusCode());
                        saleOrderInfoDto.setStatusName(statusName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(saleOrderInfoDto.getChannelCode())) {
                        String channelName = super.getSystemDictName(
                                SystemContext.UserDomain.DictType.CHANNELTYPE.getValue(), saleOrderInfoDto.getChannelCode());
                        saleOrderInfoDto.setChannelName(channelName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(saleOrderInfoDto.getPayPlatformCode())) {
                        String payPlatformName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
                                saleOrderInfoDto.getPayPlatformCode());
                        saleOrderInfoDto.setPayPlatformName(payPlatformName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(saleOrderInfoDto.getPayTypeCode())) {
                        String payTypeName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERPAYTYPE.getValue(),
                                saleOrderInfoDto.getPayTypeCode());
                        saleOrderInfoDto.setPayTypeName(payTypeName);
                    }
                    saleOrderInfoDto.setDeliveryModeName(
                            super.getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERDELIVERYMODE.getValue(),
                                    saleOrderInfoDto.getDeliveryMode()));
                    if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderInfoDto.getDeliveryMode())) {
                        CustomerProxyDto customerProxyDto = customerProxyService
                                .loadCustomerInfoById(orderInfo.getBuyerCustomerId());
                        if (!ObjectUtils.isNullOrEmpty(customerProxyDto)) {
                            saleOrderInfoDto.setPhoneNo(customerProxyDto.getMasterUserName());
                        }
                    }
                    pageDto.add(saleOrderInfoDto);
                }
            }
        }
        return YiLiDiPageUtils.encapsulatePageResult(pageDto);
    }

    @Override
    public SaleOrderDetailDto findOrderDetailByOrderNo(String orderNo) throws OrderServiceException {
        logger.debug("========orderNo = " + orderNo);
        if (ObjectUtils.isNullOrEmpty(orderNo)) {
            logger.error("orderService.findOrderDetailByOrderNo -> orderNo为空");
            throw new OrderServiceException("按条件查询orderNo为空");
        }
        SaleOrderDetailDto saleOrderDetailDto = new SaleOrderDetailDto();
        // 封装订单基本信息
        SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(orderNo);
        SaleOrderDto saleOrderDto = new SaleOrderDto();
        if (!ObjectUtils.isNullOrEmpty(saleOrder)) {
            ObjectUtils.fastCopy(saleOrder, saleOrderDto);
            if (!ObjectUtils.isNullOrEmpty(saleOrder.getStatusCode())) {
                String statusName = super.getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERSTATUS.getValue(),
                        saleOrder.getStatusCode());
                saleOrderDto.setStatusName(statusName);
            }
            if (!ObjectUtils.isNullOrEmpty(saleOrder.getPayTypeCode())) {
                String payTypeName = super.getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERPAYTYPE.getValue(),
                        saleOrder.getPayTypeCode());
                saleOrderDto.setPayTypeName(payTypeName);
            }
            if (!ObjectUtils.isNullOrEmpty(saleOrder.getDeliveryMode())) {
                String deliveryModeName = super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.SALEORDERDELIVERYMODE.getValue(), saleOrder.getDeliveryMode());
                saleOrderDto.setDeliveryModeName(deliveryModeName);
            }
            // 封装订单收货地址信息
            OrderConsigneeAddressDto address = orderConsigneeAddressService.loadByOrderNo(orderNo);
            saleOrderDto.setOrderConsigneeAddressDto(address);
        }
        saleOrderDetailDto.setSaleOrderDto(saleOrderDto);
        // 封装订单明细信息
        List<SaleOrderItemDto> itemDtos = saleOrderItemService.listBySaleOrderNo(orderNo);
        saleOrderDetailDto.setItems(itemDtos);
        List<SaleOrderHistory> saleOrderHistoryList = saleOrderHistoryMapper.listBySaleOrderNo(orderNo);
        List<SaleOrderHistoryDto> saleOrderHistoryDtoList = new ArrayList<SaleOrderHistoryDto>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderHistoryList)) {
            for (SaleOrderHistory saleOrderHistory : saleOrderHistoryList) {
                SaleOrderHistoryDto saleOrderHistoryDto = new SaleOrderHistoryDto();
                ObjectUtils.fastCopy(saleOrderHistory, saleOrderHistoryDto);
                saleOrderHistoryDtoList.add(saleOrderHistoryDto);
            }
        }
        saleOrderDetailDto.sethList(saleOrderHistoryDtoList);
        List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(orderNo, null, null, null);
        if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
            List<OrderGiftInfoDto> saleProductGiftInfoDtos = new ArrayList<OrderGiftInfoDto>();
            List<OrderGiftInfoDto> ticketGiftInfoDtos = new ArrayList<OrderGiftInfoDto>();
            for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON.equals(orderGiftInfo.getGiftType())) {
                    OrderGiftInfoDto ticketInfoDto = new OrderGiftInfoDto();
                    ObjectUtils.fastCopy(orderGiftInfo, ticketInfoDto);
                    ticketGiftInfoDtos.add(ticketInfoDto);
                }
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT.equals(orderGiftInfo.getGiftType())) {
                    OrderGiftInfoDto productInfoDto = new OrderGiftInfoDto();
                    ObjectUtils.fastCopy(orderGiftInfo, productInfoDto);
                    saleProductGiftInfoDtos.add(productInfoDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(ticketGiftInfoDtos)) {
                saleOrderDetailDto.setTicketGiftInfoDtos(ticketGiftInfoDtos);
            }
            if (!ObjectUtils.isNullOrEmpty(saleProductGiftInfoDtos)) {
                saleOrderDetailDto.setSaleProductGiftInfoDtos(saleProductGiftInfoDtos);
            }
        }
        return saleOrderDetailDto;
    }

    @Override
    public void updateOrderForBuyerCancel(String saleOrderNo, Integer userId, String cancelReason)
            throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单号为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户为空");
            }
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("订单不存在");
            }
            String status = saleOrderDto.getStatusCode();
            Date operationDate = new Date();
            long preferentiaPayAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                    - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
            if (preferentiaPayAmount <= 0) {
                preferentiaPayAmount = 0L;
            }
            long payAmount = preferentiaPayAmount + ArithUtils.converLongTolong(saleOrderDto.getTransferFee());
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY.equals(status)) { // 没有付款,直接取消成功
                updateOrderStatusCancelForUnPay(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_BUYER,
                        cancelReason, CommonConstants.SALEORDERSTATUS_BUYERCANCEL_DESC, userId, operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                return;
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_PAID.equals(status)) { // 已付款,
                                                                                 // 走退款流程
                boolean isPaid = true;
                if (payAmount <= 0) {
                    isPaid = false;
                }
                updateOrderStatusCancelForPaid(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_BUYER,
                        cancelReason, CommonConstants.SALEORDERSTATUS_BUYERCANCEL_DESC, userId,
                        saleOrderDto.getBuyerCustomerId(), operationDate, isPaid);
                cancelVipOrderType(saleOrderNo, saleOrderDto.getStoreId(), saleOrderDto.getBuyerCustomerId(), userId,
                        operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                String phoneNo = null;
                if (!ObjectUtils.isNullOrEmpty(saleOrderDto.getOrderConsigneeAddressDto())) {
                    phoneNo = saleOrderDto.getOrderConsigneeAddressDto().getPhoneNo();
                }
                if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                    phoneNo = customerProxyService.loadCustomerInfoById(saleOrderDto.getBuyerCustomerId())
                            .getMasterUserName();
                }
                // 发退款短信
                if (!ObjectUtils.isNullOrEmpty(phoneNo)) {
                    sendSmsForOrderRefund(phoneNo, payAmount);
                }
                // 推送消息
                messageProxyService.sendRefundMessage(saleOrderDto.getUserId(), saleOrderNo, payAmount);
                return;
            }
            throw new OrderServiceException("用户不能取消订单状态");
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateOrderForOperationCancel(String saleOrderNo, Integer userId, String cancelReason)
            throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单号为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户为空");
            }
            if (StringUtils.isEmpty(cancelReason)) {
                throw new OrderServiceException("取消原因不能为空");
            }
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("订单不存在");
            }
            String status = saleOrderDto.getStatusCode();
            Date operationDate = new Date();
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY.equals(status)) { // 没有付款,直接取消成功
                updateOrderStatusCancelForUnPay(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_OPERATOR,
                        cancelReason, cancelReason, userId, operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                return;
            }
            String phoneNo = null;
            if (!ObjectUtils.isNullOrEmpty(saleOrderDto.getOrderConsigneeAddressDto())) {
                phoneNo = saleOrderDto.getOrderConsigneeAddressDto().getPhoneNo();
            }
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                phoneNo = customerProxyService.loadCustomerInfoById(saleOrderDto.getBuyerCustomerId()).getMasterUserName();
            }
            long preferentiaPayAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                    - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
            if (preferentiaPayAmount <= 0) {
                preferentiaPayAmount = 0L;
            }
            long refundAmount = preferentiaPayAmount + ArithUtils.converLongTolong(saleOrderDto.getTransferFee());
            boolean isPaid = true;
            if (refundAmount > 0) {
                isPaid = false;
            }
            boolean flag = false;// 是否可以推送消息
            if (SystemContext.OrderDomain.SALEORDERSTATUS_PAID.equals(status)) { // 已付款,
                                                                                 // 走退款流程
                updateOrderStatusCancelForPaid(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_OPERATOR,
                        cancelReason, CommonConstants.SALEORDERSTATUS_OPERATORCANCEL_DESC, userId,
                        saleOrderDto.getBuyerCustomerId(), operationDate, isPaid);
                cancelVipOrderType(saleOrderNo, saleOrderDto.getStoreId(), saleOrderDto.getBuyerCustomerId(), userId,
                        operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                flag = true;
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND.equals(status)) { // 卖家已接单,取消需要更新库存订购数量
                updateOrderStatusCancelForSend(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_OPERATOR,
                        cancelReason, CommonConstants.SALEORDERSTATUS_OPERATORCANCEL_DESC, userId,
                        saleOrderDto.getBuyerCustomerId(), operationDate, isPaid);
                cancelVipOrderType(saleOrderNo, saleOrderDto.getStoreId(), saleOrderDto.getBuyerCustomerId(), userId,
                        operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                flag = true;
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(status)) { // 卖家已发货,取消需要更新库存
                updateOrderStatusCancelForReceive(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_OPERATOR,
                        cancelReason, cancelReason, userId, saleOrderDto.getBuyerCustomerId(), operationDate, isPaid);
                cancelVipOrderType(saleOrderNo, saleOrderDto.getStoreId(), saleOrderDto.getBuyerCustomerId(), userId,
                        operationDate);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderNo,
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);

                flag = true;
            }
            if (flag) {
                // 发退款短信
                if (!ObjectUtils.isNullOrEmpty(phoneNo)) {
                    sendSmsForOrderRefund(phoneNo, refundAmount);
                }
                // 推送消息
                messageProxyService.sendRefundMessage(saleOrderDto.getUserId(), saleOrderNo, refundAmount);
            }

            throw new OrderServiceException("该订单不能取消");
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    private void updateCouponStatusForCancelOrder(String saleOrderNo, Date nowTime) {
        if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(nowTime)) {
            nowTime = new Date();
        }
        SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
        if (!ObjectUtils.isNullOrEmpty(saleOrder)) {
            String userCouponIds = saleOrder.getUserCouponId();
            List<Integer> userCouponIdList = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(userCouponIds)) {
                String[] userCouponIdArr = userCouponIds.split(CommonConstants.DELIMITER_COMMA);
                for (String userCouponIdStr : userCouponIdArr) {
                    int userCouponId = Integer.parseInt(userCouponIdStr.trim());
                    userCouponIdList.add(userCouponId);
                }
            }
            couponService.updateUserCouponStatusIfEffectiveByIds(userCouponIdList,
                    SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
        }
    }

    private void updateVoucherStatusForCancelOrder(String saleOrderNo, Date nowTime) {
        if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(nowTime)) {
            nowTime = new Date();
        }
        SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
        if (!ObjectUtils.isNullOrEmpty(saleOrder)) {
            String userVoucherIds = saleOrder.getUserVoucherId();
            List<Integer> userVoucherIdList = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(userVoucherIds)) {
                String[] userVoucherIdArr = userVoucherIds.split(CommonConstants.DELIMITER_COMMA);
                for (String voucherIdStr : userVoucherIdArr) {
                    int userVoucherId = Integer.parseInt(voucherIdStr.trim());
                    userVoucherIdList.add(userVoucherId);
                }
                voucherService.updateUserVoucherStatusIfEffectiveByVoucherIds(userVoucherIdList,
                        SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE);
            }
        }
    }

    private void sendSmsForOrderRefund(String phoneNo, Long refundAmount) {
        // 发退款短信
        try {
            if (refundAmount > 0) {
                messageProxyService.systemSendSms(SmsTypeModelClassMapping.ORDERREFUND, Arrays.asList(phoneNo),
                        String.valueOf(ArithUtils.div(refundAmount, 1000, 3)), getSystemConfigRefundDays(),
                        getSystemConfigCustomerHotline());
            }
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    @Override
    public void updateOrderForOperationRefundAuditPassed(String saleOrderNo, Integer userId) throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单号为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户为空");
            }
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrder) {
                throw new OrderServiceException("订单不存在");
            }
            String status = saleOrder.getStatusCode();
            Date nowTime = new Date();
            if (!SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING.equals(status)) { // 退款中的订单才能退款审核
                throw new OrderServiceException("该订单不允许此操作");
            }
            updateOrderStatusForRefundSuccess(saleOrderNo, userId, nowTime);
            // 修改订单退款表
            Integer effectCount = orderRefundMapper.updateStatusBySaleOrderNo(saleOrderNo,
                    SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING,
                    SystemContext.OrderDomain.ORDERREFUNDSTATUS_SUCCESS, null, userId, nowTime);
            if (ObjectUtils.isNullOrEmpty(effectCount) || 1 != effectCount) {
                throw new OrderServiceException("修改退款订单状态失败");
            }
            OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
            orderRefundStatusHistory.setCreateTime(nowTime);
            orderRefundStatusHistory.setCreateUserId(userId);
            orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundStatusHistory.setOperateTime(nowTime);
            orderRefundStatusHistory.setOperateUserId(userId);
            orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_SUCCESS_DESC);
            orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_SUCCESS);
            orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateOrderForOperationRefundAuditUnpassed(String saleOrderNo, String refundReason, Integer userId)
            throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单号为空");
            }
            if (StringUtils.isEmpty(refundReason)) {
                throw new OrderServiceException("审核不通过原因不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户为空");
            }
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrder) {
                throw new OrderServiceException("订单不存在");
            }
            String status = saleOrder.getStatusCode();
            Date nowTime = new Date();
            if (!SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING.equals(status)) { // 退款中的订单才能退款审核
                throw new OrderServiceException("该订单不允许此操作");
            }
            updateOrderStatusForRefundFailure(saleOrderNo, refundReason, userId, nowTime);
            // 修改订单退款表
            Integer effectCount = orderRefundMapper.updateStatusBySaleOrderNo(saleOrderNo,
                    SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING,
                    SystemContext.OrderDomain.ORDERREFUNDSTATUS_FAILURE, refundReason, userId, nowTime);
            if (ObjectUtils.isNullOrEmpty(effectCount) || 1 != effectCount) {
                throw new OrderServiceException("修改退款订单状态失败");
            }
            OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
            orderRefundStatusHistory.setCreateTime(nowTime);
            orderRefundStatusHistory.setCreateUserId(userId);
            orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundStatusHistory.setOperateTime(nowTime);
            orderRefundStatusHistory.setOperateUserId(userId);
            orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_FAILURE_DESC);
            orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_FAILURE);
            orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateOrderForSystemCancel(SaleOrderDto saleOrderDto, Date operationTime) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleOrderDto)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(operationTime)) {
                operationTime = new Date();
            }
            String phoneNo = null;
            if (!ObjectUtils.isNullOrEmpty(saleOrderDto.getOrderConsigneeAddressDto())) {
                phoneNo = saleOrderDto.getOrderConsigneeAddressDto().getPhoneNo();
            }
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                phoneNo = customerProxyService.loadCustomerInfoById(saleOrderDto.getBuyerCustomerId()).getMasterUserName();
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY.equals(saleOrderDto.getStatusCode())) {
                long elapsedTime = DateUtils.secondsBetween(operationTime, saleOrderDto.getCreateTime());
                if (elapsedTime >= REMINDDER_SALE_ORDER_PAY_TIME * 60 && elapsedTime < SALE_ORDER_PAY_TIME_OUT * 60) {
                    // 发短信提示付款
                    try {
                        OrderReminderPayMessage orderReminderPayMessage = orderReminderPayMessageMapper
                                .loadBySaleOrderNoAndPhoneNo(saleOrderDto.getSaleOrderNo(), phoneNo);
                        if (ObjectUtils.isNullOrEmpty(orderReminderPayMessage)) {
                            orderReminderPayMessage = new OrderReminderPayMessage();
                            orderReminderPayMessage.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
                            orderReminderPayMessage.setSendTime(operationTime);
                            orderReminderPayMessage.setToUser(phoneNo);
                            orderReminderPayMessageMapper.save(orderReminderPayMessage);
                            messageProxyService.systemSendSms(SmsTypeModelClassMapping.ORDERREMINDERPAY,
                                    Arrays.asList(phoneNo), String.valueOf(REMINDDER_SALE_ORDER_PAY_TIME),
                                    getSystemConfigCustomerHotline());
                        }
                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
                if (elapsedTime >= SALE_ORDER_PAY_TIME_OUT * 60) { // 系统自动取消
                    updateOrderStatusCancelForUnPay(saleOrderDto.getSaleOrderNo(),
                            SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_SYSTEM_NO_PAID,
                            CommonConstants.SALEORDERSTATUS_NOTPAID_SYSTEMCANCEL_DESC,
                            CommonConstants.SALEORDERSTATUS_NOTPAID_SYSTEMCANCEL_DESC, CommonConstants.SYSTEM_USER_ID,
                            operationTime);
                    activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderDto.getSaleOrderNo(),
                            SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                }
                return;
            }
            long preferentiaPayAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                    - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
            if (preferentiaPayAmount <= 0) {
                preferentiaPayAmount = 0L;
            }
            long payAmount = preferentiaPayAmount + ArithUtils.converLongTolong(saleOrderDto.getTransferFee());
            boolean isPaid = true;
            if (payAmount <= 0) {
                isPaid = false;
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_PAID.equals(saleOrderDto.getStatusCode())) {
                long elapsedTime = DateUtils.secondsBetween(operationTime, saleOrderDto.getCreateTime());
                if (elapsedTime >= SALE_ORDER_RECEIVE_TIME_OUT * 60) { // 系统自动取消
                    updateOrderStatusCancelForPaid(saleOrderDto.getSaleOrderNo(),
                            SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_SYSTEM_NO_ACCEPTED,
                            CommonConstants.SALEORDERSTATUS_PAID_SYSTEMCANCEL_DESC,
                            CommonConstants.SALEORDERSTATUS_PAID_SYSTEMCANCEL_DESC, CommonConstants.SYSTEM_USER_ID,
                            saleOrderDto.getBuyerCustomerId(), operationTime, isPaid);
                    // 发退款短信
                    if (!ObjectUtils.isNullOrEmpty(phoneNo)) {
                        sendSmsForOrderRefund(saleOrderDto.getOrderConsigneeAddressDto().getPhoneNo(), payAmount);
                    }
                    cancelVipOrderType(saleOrderDto.getSaleOrderNo(), saleOrderDto.getStoreId(),
                            saleOrderDto.getBuyerCustomerId(), CommonConstants.SYSTEM_USER_ID, operationTime);
                    activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderDto.getSaleOrderNo(),
                            SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                }
                return;
            }
            if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(saleOrderDto.getStatusCode())
                    && SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                updateOrderStatusCancelForReceive(saleOrderDto.getSaleOrderNo(),
                        SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_OPERATOR,
                        CommonConstants.SALEORDERSTATUS_OPERATORCANCEL_FORCEIVEER_PICKUP,
                        CommonConstants.SALEORDERSTATUS_OPERATORCANCEL_FORCEIVEER_PICKUP, CommonConstants.SYSTEM_USER_ID,
                        saleOrderDto.getBuyerCustomerId(), operationTime, isPaid);
                long refundAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                        + ArithUtils.converLongTolong(saleOrderDto.getTransferFee())
                        - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
                UserProxyDto userProxyDto = userProxyService.getUserById(saleOrderDto.getUserId());
                cancelVipOrderType(saleOrderDto.getSaleOrderNo(), saleOrderDto.getStoreId(),
                        saleOrderDto.getBuyerCustomerId(), CommonConstants.SYSTEM_USER_ID, operationTime);
                activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderDto.getSaleOrderNo(),
                        SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
                // 发退款短信
                if (!ObjectUtils.isNullOrEmpty(userProxyDto) && !ObjectUtils.isNullOrEmpty(userProxyDto.getUserName())) {
                    sendSmsForOrderRefund(userProxyDto.getUserName(), refundAmount);
                }
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private String getSystemConfigCustomerHotline() {
        String systemConfigCustomerHotline = super.getSystemParamValue(SystemContext.SystemParams.CUSTOMER_HOTLINE);
        systemConfigCustomerHotline = StringUtils.isEmpty(systemConfigCustomerHotline) ? CUSTOMER_HOTLINE_DEFAULT
                : systemConfigCustomerHotline;
        return systemConfigCustomerHotline;
    }

    private String getSystemConfigRefundDays() {
        String systemConfigRefundDays = super.getSystemParamValue(SystemContext.SystemParams.REFUND_INTERVAL_DAYS);
        systemConfigRefundDays = StringUtils.isEmpty(systemConfigRefundDays) ? REFUND_INTERVAL_DAYS_DEFAULT
                : systemConfigRefundDays;
        return systemConfigRefundDays;
    }

    @Override
    public YiLiDiPage<SaleOrderStatisticsDto> findOrderStatisticsDtos(SaleOrderStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());

            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取全部订单的笔数
            Page<SaleOrderStatisticsInfo> page = saleOrderMapper.findOrderStatisticsInfos(query);
            Page<SaleOrderStatisticsDto> pageDto = new Page<SaleOrderStatisticsDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleOrderStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleOrderStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleOrderStatisticsDto dto = new SaleOrderStatisticsDto();
                        ObjectUtils.fastCopy(info, dto);
                        query.setUserName(info.getUserName());
                        // 成交的笔数，订单状态为已完成的。
                        List<String> orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromSuccess = saleOrderMapper.getOrderStatisticsInfoFromSuccess(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromSuccess)) {
                            dto.setTotalAmountFromSuccess(infoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalOrderCountFromSuccess(infoFromSuccess.getTotalOrderCountFromSuccess());
                        }

                        // 取消的笔数，订单状态为已取消和已退款
                        orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromCancel = saleOrderMapper.getOrderStatisticsInfoFromCancel(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromCancel)) {
                            dto.setTotalAmountFromCancel(infoFromCancel.getTotalAmountFromCancel());
                            dto.setTotalOrderCountFromCancel(infoFromCancel.getTotalOrderCountFromCancel());
                        }
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findOrderStatisticsDtos异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportOrderStatistics(SaleOrderStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportOrderStatistics(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportOrderStatistics异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderStatisticsDto> listDataForExportOrderStatistics(SaleOrderStatisticsQuery query, Long startLineNum,
            Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取全部订单的笔数
            List<SaleOrderStatisticsInfo> infoList = saleOrderMapper.listDataForExportOrderStatistics(query, startLineNum,
                    pageSize);
            List<SaleOrderStatisticsDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleOrderStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleOrderStatisticsDto dto = new SaleOrderStatisticsDto();
                        ObjectUtils.fastCopy(info, dto);
                        query.setUserName(info.getUserName());
                        // 成交的笔数，订单状态为已完成的。
                        List<String> orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromSuccess = saleOrderMapper.getOrderStatisticsInfoFromSuccess(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromSuccess)) {
                            dto.setTotalAmountFromSuccess(infoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalOrderCountFromSuccess(infoFromSuccess.getTotalOrderCountFromSuccess());
                        }

                        // 取消的笔数，订单状态为已取消和已退款
                        orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromCancel = saleOrderMapper.getOrderStatisticsInfoFromCancel(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromCancel)) {
                            dto.setTotalAmountFromCancel(infoFromCancel.getTotalAmountFromCancel());
                            dto.setTotalOrderCountFromCancel(infoFromCancel.getTotalOrderCountFromCancel());
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportOrderStatistics异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderDto> listSaleOrderByStatusCodes(List<String> statusCodes) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(statusCodes)) {
                return null;
            }
            List<SaleOrderInfo> saleOrderList = saleOrderMapper.listSaleOrderByStatusCodes(statusCodes);
            if (ObjectUtils.isNullOrEmpty(saleOrderList)) {
                return null;
            }
            List<SaleOrderDto> saleOrderDtoList = new ArrayList<SaleOrderDto>();
            for (SaleOrderInfo saleOrderInfo : saleOrderList) {
                SaleOrderDto saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrderInfo, saleOrderDto);
                OrderConsigneeAddressDto orderConsigneeAddressDto = new OrderConsigneeAddressDto();
                orderConsigneeAddressDto.setUserName(saleOrderInfo.getConsigneeUserName());
                orderConsigneeAddressDto.setPhoneNo(saleOrderInfo.getPhoneNo());
                orderConsigneeAddressDto.setSaleOrderNo(saleOrderInfo.getSaleOrderNo());
                orderConsigneeAddressDto.setAddressDetail(saleOrderInfo.getAddressDetail());
                saleOrderDto.setOrderConsigneeAddressDto(orderConsigneeAddressDto);
                saleOrderDto.setTypeCode(saleOrderInfo.getOrderType());
                saleOrderDtoList.add(saleOrderDto);
            }
            return saleOrderDtoList;
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleOrderStatisticsDto> findOrderStatisticsDtosByDate(SaleOrderStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());

            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取全部订单的笔数
            Page<SaleOrderStatisticsInfo> page = saleOrderMapper.findOrderStatisticsInfosByDate(query);
            Page<SaleOrderStatisticsDto> pageDto = new Page<SaleOrderStatisticsDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleOrderStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleOrderStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleOrderStatisticsDto dto = new SaleOrderStatisticsDto();
                        ObjectUtils.fastCopy(info, dto);
                        query.setUserName(info.getUserName());
                        query.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                        query.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                        // 成交的笔数，订单状态为已完成的。
                        List<String> orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromSuccess = saleOrderMapper
                                .getOrderStatisticsInfoFromSuccessByDate(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromSuccess)) {
                            dto.setTotalAmountFromSuccess(infoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalOrderCountFromSuccess(infoFromSuccess.getTotalOrderCountFromSuccess());
                        }

                        // 取消的笔数，订单状态为已取消和已退款
                        orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromCancel = saleOrderMapper
                                .getOrderStatisticsInfoFromCancelByDate(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromCancel)) {
                            dto.setTotalAmountFromCancel(infoFromCancel.getTotalAmountFromCancel());
                            dto.setTotalOrderCountFromCancel(infoFromCancel.getTotalOrderCountFromCancel());
                        }
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findOrderStatisticsDtosByDate异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportOrderStatisticsByDate(SaleOrderStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportOrderStatisticsByDate(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportOrderStatisticsByDate异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderStatisticsDto> listDataForExportOrderStatisticsByDate(SaleOrderStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取全部订单的笔数
            List<SaleOrderStatisticsInfo> infoList = saleOrderMapper.listDataForExportOrderStatisticsByDate(query,
                    startLineNum, pageSize);
            List<SaleOrderStatisticsDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleOrderStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleOrderStatisticsDto dto = new SaleOrderStatisticsDto();
                        ObjectUtils.fastCopy(info, dto);
                        query.setUserName(info.getUserName());
                        query.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                        query.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                        // 成交的笔数，订单状态为已完成的。
                        List<String> orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromSuccess = saleOrderMapper
                                .getOrderStatisticsInfoFromSuccessByDate(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromSuccess)) {
                            dto.setTotalAmountFromSuccess(infoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalOrderCountFromSuccess(infoFromSuccess.getTotalOrderCountFromSuccess());
                        }

                        // 取消的笔数，订单状态为已取消和已退款
                        orderStatusList = new ArrayList<>();
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        query.setOrderStatusList(orderStatusList);
                        SaleOrderStatisticsInfo infoFromCancel = saleOrderMapper
                                .getOrderStatisticsInfoFromCancelByDate(query);
                        if (!ObjectUtils.isNullOrEmpty(infoFromCancel)) {
                            dto.setTotalAmountFromCancel(infoFromCancel.getTotalAmountFromCancel());
                            dto.setTotalOrderCountFromCancel(infoFromCancel.getTotalOrderCountFromCancel());
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportOrderStatisticsByDate异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public AllVolumeStatisticsInfoDto loadAllVolumeStatisticsInfoDto() throws OrderServiceException {
        try {
            AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
            // 获取所有的补贴金额
            AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService.statisticsAllSubsidyInfo(null);
            if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
            }
            // 获取总下单笔数，总下单金额
            BaseVolumeStatisticsInfo totalInfo = saleOrderMapper.getBaseVolumeStatisticsInfoByStatusList(null);
            if (!ObjectUtils.isNullOrEmpty(totalInfo)) {
                dto.setTotalOrderCount(totalInfo.getTotalOrderCount());
                dto.setTotalAmount(totalInfo.getTotalAmount());
            }
            // 获取成交下单笔数，成交下单金额
            List<String> orderStatusList = new ArrayList<String>();
            // 添加交易成功的状态
            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            BaseVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                    .getBaseVolumeStatisticsInfoByStatusList(orderStatusList);
            if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCount());
                dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmount());
                dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCount());
            }
            // 获取取消下单笔数，取消下单金额
            orderStatusList = new ArrayList<String>();
            // 添加已取消和已退款的状态
            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
            BaseVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                    .getBaseVolumeStatisticsInfoByStatusList(orderStatusList);
            if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCount());
                dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmount());
            }
            return dto;
        } catch (Exception e) {
            logger.error("loadAllVolumeStatisticsInfoDto异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosDetail(AllVolumeStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            // 获取销售汇总统计总的订单数
            Page<AllVolumeStatisticsInfo> page = saleOrderMapper.findAllVolumeStatisticsInfos(query);
            Page<AllVolumeStatisticsInfoDto> pageDto = new Page<AllVolumeStatisticsInfoDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<AllVolumeStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        if (!ObjectUtils.isNullOrEmpty(info.getOrderTime())) {
                            // 1.找到指定日期的所有订单号 列表
                            AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                            tempQuery.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                            List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                            // 2.获取指定日期的补贴金额
                            AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                    .statisticsAllSubsidyInfo(orderNoList);
                            if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                                dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                                dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                                dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                                dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                            }
                            // 3.获取成交下单笔数，成交下单金额
                            List<String> orderStatusList = new ArrayList<String>();
                            // 添加交易成功的状态
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                            tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setOrderNoList(orderNoList);
                            tempQuery.setOrderStatusList(orderStatusList);
                            AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                    .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                            if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                                dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                                dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                                dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                            }

                            // 4.获取取消下单笔数，取消下单金额
                            orderStatusList = new ArrayList<String>();
                            // 添加已取消和已退款的状态
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                            tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setOrderNoList(orderNoList);
                            tempQuery.setOrderStatusList(orderStatusList);
                            AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                    .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                            if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                                dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                                dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                            }
                        }
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAllVolumeStatisticsInfosDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportVolumeStatisticsDetail(AllVolumeStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportVolumeStatisticsDetail(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportVolumeStatisticsDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<AllVolumeStatisticsInfoDto> listDataForExportVolumeStatisticsDetail(AllVolumeStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取销售汇总统计总的订单数
            List<AllVolumeStatisticsInfo> infoList = saleOrderMapper.listDataForExportVolumeStatisticsDetail(query,
                    startLineNum, pageSize);
            List<AllVolumeStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        if (!ObjectUtils.isNullOrEmpty(info.getOrderTime())) {
                            // 1.找到指定日期的所有订单号 列表
                            AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                            tempQuery.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                            List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                            // 2.获取指定日期的补贴金额
                            AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                    .statisticsAllSubsidyInfo(orderNoList);
                            if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                                dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                                dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                                dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                                dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                            }
                            // 3.获取成交下单笔数，成交下单金额
                            List<String> orderStatusList = new ArrayList<String>();
                            // 添加交易成功的状态
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                            tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setOrderNoList(orderNoList);
                            tempQuery.setOrderStatusList(orderStatusList);
                            AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                    .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                            if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                                dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                                dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                                dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                            }

                            // 4.获取取消下单笔数，取消下单金额
                            orderStatusList = new ArrayList<String>();
                            // 添加已取消和已退款的状态
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                            orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                            tempQuery = new AllVolumeStatisticsQuery();
                            tempQuery.setOrderNoList(orderNoList);
                            tempQuery.setOrderStatusList(orderStatusList);
                            AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                    .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                            if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                                dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                                dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                            }
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportVolumeStatisticsDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosForStore(AllVolumeStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            // 获取销售汇总统计总的订单数
            Page<AllVolumeStatisticsInfo> page = saleOrderMapper.findAllVolumeStatisticsInfosForStore(query);
            Page<AllVolumeStatisticsInfoDto> pageDto = new Page<AllVolumeStatisticsInfoDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<AllVolumeStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        // 1.找到指定日期的所有订单号 列表
                        AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setStrBeginOrderTime(query.getStrBeginOrderTime());
                        tempQuery.setStrEndOrderTime(query.getStrEndOrderTime());
                        tempQuery.setStoreCode(info.getStoreCode());
                        tempQuery.setStoreName(info.getStoreName());
                        List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                        // 2.获取指定日期的补贴金额
                        AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                .statisticsAllSubsidyInfo(orderNoList);
                        if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                            dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                            dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                            dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                            dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                        }
                        // 3.获取成交下单笔数，成交下单金额
                        List<String> orderStatusList = new ArrayList<String>();
                        // 添加交易成功的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                            dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                            dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                        }

                        // 4.获取取消下单笔数，取消下单金额
                        orderStatusList = new ArrayList<String>();
                        // 添加已取消和已退款的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                            dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                            dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                        }
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAllVolumeStatisticsInfosForStore异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStoreVolumeByOneDay(AllVolumeStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportStoreVolumeByOneDay(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportStoreVolumeByOneDay异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeByOneDay(AllVolumeStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取销售汇总统计总的订单数
            List<AllVolumeStatisticsInfo> infoList = saleOrderMapper.listDataForExportStoreVolumeByOneDay(query,
                    startLineNum, pageSize);
            List<AllVolumeStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        // 1.找到指定日期的所有订单号 列表
                        AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setStrBeginOrderTime(query.getStrBeginOrderTime());
                        tempQuery.setStrEndOrderTime(query.getStrEndOrderTime());
                        tempQuery.setStoreCode(info.getStoreCode());
                        tempQuery.setStoreName(info.getStoreName());
                        List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                        // 2.获取指定日期的补贴金额
                        AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                .statisticsAllSubsidyInfo(orderNoList);
                        if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                            dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                            dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                            dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                            dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                        }
                        // 3.获取成交下单笔数，成交下单金额
                        List<String> orderStatusList = new ArrayList<String>();
                        // 添加交易成功的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                            dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                            dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                        }

                        // 4.获取取消下单笔数，取消下单金额
                        orderStatusList = new ArrayList<String>();
                        // 添加已取消和已退款的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                            dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                            dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportStoreVolumeByOneDay异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStoreVolumeList(AllVolumeStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportStoreVolumeList(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportStoreVolumeList异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeList(AllVolumeStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取销售汇总统计总的订单数
            List<AllVolumeStatisticsInfo> infoList = saleOrderMapper.listDataForExportStoreVolumeList(query, startLineNum,
                    pageSize);
            List<AllVolumeStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        // 1.找到指定日期的所有订单号 列表
                        AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setStrBeginOrderTime(query.getStrBeginOrderTime());
                        tempQuery.setStrEndOrderTime(query.getStrEndOrderTime());
                        tempQuery.setStoreCode(info.getStoreCode());
                        tempQuery.setStoreName(info.getStoreName());
                        List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                        // 2.获取指定日期的补贴金额
                        AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                .statisticsAllSubsidyInfo(orderNoList);
                        if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                            dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                            dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                            dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                            dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                        }
                        // 3.获取成交下单笔数，成交下单金额
                        List<String> orderStatusList = new ArrayList<String>();
                        // 添加交易成功的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                            dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                            dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                        }

                        // 4.获取取消下单笔数，取消下单金额
                        orderStatusList = new ArrayList<String>();
                        // 添加已取消和已退款的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                            dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                            dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportStoreVolumeList异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosForStoreByDay(AllVolumeStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            // 获取销售汇总统计总的订单数
            Page<AllVolumeStatisticsInfo> page = saleOrderMapper.findAllVolumeStatisticsInfosForStoreByDay(query);
            Page<AllVolumeStatisticsInfoDto> pageDto = new Page<AllVolumeStatisticsInfoDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<AllVolumeStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        // 1.找到指定日期的所有订单号 列表
                        AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                        tempQuery.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                        tempQuery.setStoreCode(query.getStoreCode());
                        tempQuery.setStoreName(query.getStoreName());
                        List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                        // 2.获取指定日期的补贴金额
                        AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                .statisticsAllSubsidyInfo(orderNoList);
                        if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                            dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                            dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                            dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                            dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                        }
                        // 3.获取成交下单笔数，成交下单金额
                        List<String> orderStatusList = new ArrayList<String>();
                        // 添加交易成功的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                            dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                            dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                        }

                        // 4.获取取消下单笔数，取消下单金额
                        orderStatusList = new ArrayList<String>();
                        // 添加已取消和已退款的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                            dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                            dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                        }
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAllVolumeStatisticsInfosForStoreByDay异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStoreVolumeListForDay(AllVolumeStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportStoreVolumeListForDay(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportStoreVolumeListForDay异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeListForDay(AllVolumeStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            // 获取销售汇总统计总的订单数
            List<AllVolumeStatisticsInfo> infoList = saleOrderMapper.listDataForExportStoreVolumeListForDay(query,
                    startLineNum, pageSize);
            List<AllVolumeStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (AllVolumeStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        AllVolumeStatisticsInfoDto dto = new AllVolumeStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        // 1.找到指定日期的所有订单号 列表
                        AllVolumeStatisticsQuery tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setStrBeginOrderTime(info.getOrderTime() + STARTTIME);
                        tempQuery.setStrEndOrderTime(info.getOrderTime() + ENDTIME);
                        tempQuery.setStoreCode(query.getStoreCode());
                        tempQuery.setStoreName(query.getStoreName());
                        List<String> orderNoList = saleOrderMapper.listSaleOrderNosByTime(tempQuery);
                        // 2.获取指定日期的补贴金额
                        AllSubsidyInfoProxyDto subsidyDto = storeSubsidyRecordProxyService
                                .statisticsAllSubsidyInfo(orderNoList);
                        if (!ObjectUtils.isNullOrEmpty(subsidyDto)) {
                            dto.setCashSubsidy(subsidyDto.getCashSubsidy());
                            dto.setPriceSubsidy(subsidyDto.getPriceSubsidy());
                            dto.setCouponSubsidy(subsidyDto.getCouponSubsidy());
                            dto.setLogisticsSubsidy(subsidyDto.getLogisticsSubsidy());
                        }
                        // 3.获取成交下单笔数，成交下单金额
                        List<String> orderStatusList = new ArrayList<String>();
                        // 添加交易成功的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromSuccess = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromSuccessByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromSuccess)) {
                            dto.setTotalOrderCountFromSuccess(totalInfoFromSuccess.getTotalOrderCountFromSuccess());
                            dto.setTotalAmountFromSuccess(totalInfoFromSuccess.getTotalAmountFromSuccess());
                            dto.setTotalUserCountFromSuccess(totalInfoFromSuccess.getTotalUserCountFromSuccess());
                        }

                        // 4.获取取消下单笔数，取消下单金额
                        orderStatusList = new ArrayList<String>();
                        // 添加已取消和已退款的状态
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
                        orderStatusList.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
                        tempQuery = new AllVolumeStatisticsQuery();
                        tempQuery.setOrderNoList(orderNoList);
                        tempQuery.setOrderStatusList(orderStatusList);
                        AllVolumeStatisticsInfo totalInfoFromCancel = saleOrderMapper
                                .getAllVolumeStatisticsInfoFromCancelByDate(tempQuery);
                        if (!ObjectUtils.isNullOrEmpty(totalInfoFromCancel)) {
                            dto.setTotalOrderCountFromCancel(totalInfoFromCancel.getTotalOrderCountFromCancel());
                            dto.setTotalAmountFromCancel(totalInfoFromCancel.getTotalAmountFromCancel());
                        }
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportStoreVolumeListForDay异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleProductStatisticsInfoDto> findSaleProductStatistics(SaleProductStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());

            Page<SaleProductStatisticsInfo> page = saleOrderMapper.findSaleProductStatistics(query);
            Page<SaleProductStatisticsInfoDto> pageDto = new Page<SaleProductStatisticsInfoDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleProductStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleProductStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleProductStatisticsInfoDto dto = new SaleProductStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findSaleProductStatistics异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportProductStatisticsList(SaleProductStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportProductStatisticsList(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportProductStatisticsList异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductStatisticsInfoDto> listDataForExportProductStatisticsList(SaleProductStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }

            List<SaleProductStatisticsInfo> infoList = saleOrderMapper.listDataForExportProductStatisticsList(query,
                    startLineNum, pageSize);
            List<SaleProductStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleProductStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleProductStatisticsInfoDto dto = new SaleProductStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportProductStatisticsList异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleProductStatisticsInfoDto> findSaleProductStatisticsDetail(SaleProductStatisticsQuery query)
            throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());

            Page<SaleProductStatisticsInfo> page = saleOrderMapper.findSaleProductStatisticsDetail(query);
            Page<SaleProductStatisticsInfoDto> pageDto = new Page<SaleProductStatisticsInfoDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleProductStatisticsInfo> infoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleProductStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleProductStatisticsInfoDto dto = new SaleProductStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        pageDto.add(dto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findSaleProductStatisticsDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportProductStatisticsDetail(SaleProductStatisticsQuery query) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            Long counts = this.saleOrderMapper.getCountsForExportProductStatisticsDetail(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportProductStatisticsDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductStatisticsInfoDto> listDataForExportProductStatisticsDetail(SaleProductStatisticsQuery query,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            String strBeginOrderTime = query.getStrBeginOrderTime();
            String strEndOrderTime = query.getStrEndOrderTime();
            if (!ObjectUtils.isNullOrEmpty(strBeginOrderTime)) {
                query.setStrBeginOrderTime(strBeginOrderTime + STARTTIME);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndOrderTime)) {
                query.setStrEndOrderTime(strEndOrderTime + ENDTIME);
            }
            List<SaleProductStatisticsInfo> infoList = saleOrderMapper.listDataForExportProductStatisticsDetail(query,
                    startLineNum, pageSize);
            List<SaleProductStatisticsInfoDto> dtos = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(infoList)) {
                for (SaleProductStatisticsInfo info : infoList) {
                    if (!ObjectUtils.isNullOrEmpty(info)) {
                        SaleProductStatisticsInfoDto dto = new SaleProductStatisticsInfoDto();
                        ObjectUtils.fastCopy(info, dto);
                        dtos.add(dto);
                    }
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportProductStatisticsDetail异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportOrder(SaleOrderQueryDto query) throws OrderServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(query.getStrBeginOrderTime())) {
                try {
                    Date startOrderDate = DateUtils.parseDate(query.getStrBeginOrderTime() + STARTTIME);
                    query.setStartOrderDate(startOrderDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrEndOrderTime())) {
                try {
                    Date endOrderDate = DateUtils.parseDate(query.getStrEndOrderTime() + ENDTIME);
                    query.setEndOrderDate(endOrderDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrBeginPriceTime())) {
                try {
                    Date startPayDate = DateUtils.parseDate(query.getStrBeginPriceTime() + STARTTIME);
                    query.setStartPayDate(startPayDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (!ObjectUtils.isNullOrEmpty(query.getStrEndPriceTime())) {
                try {
                    Date endPayDate = DateUtils.parseDate(query.getStrEndPriceTime() + ENDTIME);
                    query.setEndPayDate(endPayDate);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            Long counts = this.saleOrderMapper.getCountsForExportOrder(query);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderInfoDto> listDataForExportOrder(SaleOrderQueryDto saleOrderQuery, Long startLineNum,
            Integer pageSize) throws OrderServiceException {
        try {
            List<SaleOrderInfo> saleOrderInfos = this.saleOrderMapper.listDataForExportOrder(saleOrderQuery, startLineNum,
                    pageSize);
            List<SaleOrderInfoDto> dtos = new ArrayList<SaleOrderInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(saleOrderInfos)) {
                for (SaleOrderInfo info : saleOrderInfos) {
                    SaleOrderInfoDto dto = new SaleOrderInfoDto();
                    ObjectUtils.fastCopy(info, dto);
                    if (!ObjectUtils.isNullOrEmpty(dto.getStatusCode())) {
                        String statusName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERSTATUS.getValue(), dto.getStatusCode());
                        dto.setStatusName(statusName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(dto.getChannelCode())) {
                        String channelName = super.getSystemDictName(
                                SystemContext.UserDomain.DictType.CHANNELTYPE.getValue(), dto.getChannelCode());
                        dto.setChannelName(channelName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(dto.getPayPlatformCode())) {
                        String payPlatformName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
                                dto.getPayPlatformCode());
                        dto.setPayPlatformName(payPlatformName);
                    }
                    if (!ObjectUtils.isNullOrEmpty(dto.getPayTypeCode())) {
                        String payTypeName = super.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERPAYTYPE.getValue(), dto.getPayTypeCode());
                        dto.setPayTypeName(payTypeName);
                    }
                    dtos.add(dto);
                }
            }
            return dtos;
        } catch (Exception e) {
            logger.error("listDataForExportOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SaveOrderDto saveCreateOrder(CreateOrderDto createOrderDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(createOrderDto)
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCreateOrderItemDtos())) {
                throw new OrderServiceException("没有下单的商品信息");
            }
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getAddressId())
                    && ObjectUtils.isNullOrEmpty(createOrderDto.getStoreId())) {
                throw new OrderServiceException("收货地址和店铺不能同时为空");
            }
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getUserId())
                    || ObjectUtils.isNullOrEmpty(createOrderDto.getCustomerId())) {
                throw new OrderServiceException("用户不能为空");
            }
            Date currentTime = new Date();
            List<CreateOrderItemDto> createOrderItemDtoList = createOrderDto.getCreateOrderItemDtos();
            StoreProfileProxyDto storeProfileProxyDto = null;
            ConsigneeAddressProxyDto consigneeAddressProxyDto = null;
            String longitude = createOrderDto.getLongitude();
            String latitude = createOrderDto.getLatitude();
            if (ObjectUtils.isNullOrEmpty(createOrderDto.getStoreId())
                    || !SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(createOrderDto.getDeliveryMode())) {
                if (ObjectUtils.isNullOrEmpty(createOrderDto.getAddressId())) {
                    throw new OrderServiceException("没有选择收货地址");
                }
                consigneeAddressProxyDto = consigneeAddressProxyService.loadById(createOrderDto.getAddressId());
                if (null == consigneeAddressProxyDto
                        || SystemContext.UserDomain.CONSADDRSTATUS_OFF.equals(consigneeAddressProxyDto.getStatus())) {
                    logger.error("收货地址[" + createOrderDto.getAddressId() + "]不存在");
                    throw new OrderServiceException("收货地址不存在");
                }

                if (consigneeAddressProxyDto.getCustomerId().intValue() != createOrderDto.getCustomerId().intValue()) {
                    logger.error("收货地址[" + createOrderDto.getAddressId() + "]不属于用户[" + createOrderDto.getCustomerId() + "]");
                    throw new OrderServiceException("收货地址数据异常");
                }
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(consigneeAddressProxyDto.getCommunityId(),
                        SystemContext.UserDomain.STORESTATUS_OPEN);
                // 设置更合理的经纬度
                setRationalLngAndLat(longitude, latitude, consigneeAddressProxyDto.getCommunityId(),
                        storeProfileProxyDto.getStoreId());
            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(createOrderDto.getStoreId());
            }
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                throw new OrderServiceException("店铺不存在");
            }
            UserProxyDto userProxyDto = userProxyService.getUserById(createOrderDto.getUserId());

            List<Integer> saleProductIds = new ArrayList<Integer>();
            List<Integer> notActivitySaleProductIds = new ArrayList<Integer>();
            List<Integer> activitySaleProductIds = new ArrayList<Integer>();
            List<Map<Integer, Integer>> activityIdProductIdMaps = new ArrayList<Map<Integer, Integer>>();
            List<KeyValuePair<Integer, Integer>> keyValueParis = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtoList) {
                saleProductIds.add(createOrderItemDto.getSaleProductId());
                KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(
                        createOrderItemDto.getSaleProductId(), createOrderItemDto.getCartNum());
                keyValueParis.add(pair);
                if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())
                        && createOrderItemDto.getActId().intValue() > 0) {
                    Map<Integer, Integer> activityIdProductIdMap = new HashMap<Integer, Integer>();
                    activityIdProductIdMap.put(createOrderItemDto.getActId(), createOrderItemDto.getSaleProductId());
                    activityIdProductIdMaps.add(activityIdProductIdMap);
                    activitySaleProductIds.add(createOrderItemDto.getSaleProductId());
                } else {
                    notActivitySaleProductIds.add(createOrderItemDto.getSaleProductId());
                }
            }
            List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)
                    || saleProductProxyDtoList.size() != saleProductIds.size()) {
                throw new OrderServiceException("存在找不到的商品");
            }
            validateSaleProduct(saleProductProxyDtoList, saleProductIds);
            // 校验下单商品跟店铺是否符合业务要求
            Integer validateStoreId = storeProfileProxyDto.getStoreId();
            boolean isStockShare = false;
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                // 店铺共享库存查询微仓商品信息
                validateStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                isStockShare = true;
            }
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                if (saleProductProxyDto.getStoreId().intValue() != validateStoreId.intValue()) {
                    throw new OrderServiceException("下单的商品存在与该店不符合的商品,您可以先清除购物车再选择商品");
                }
            }
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
                validatePennySaleProduct(createOrderDto.getCustomerId(), pennySaleProductProxyDtoList,
                        createOrderItemDtoList);
                validatePennySaleProductByDeviceId(createOrderDto.getDeviceId(), pennySaleProductProxyDtoList,
                        createOrderItemDtoList);
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
            List<SecKillProductProxyDto> secKillProductProxyDtos = null;
            List<SecKillSceneProxyDto> secKillSceneProxyDtos = null;
            if (!ObjectUtils.isNullOrEmpty(activityIdProductIdMaps)) {
                secKillProductProxyDtos = secKillProductProxyService
                        .listByActivityIdAndSaleProductIdMaps(activityIdProductIdMaps);
                secKillSceneProxyDtos = secKillSceneProxyService.listStartedAndStaring(currentTime);
            }
            List<Integer> pennySaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(pennySaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : pennySaleProductProxyDtoList) {
                    pennySaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            List<Integer> vipSaleProductIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
                    vipSaleProductIds.add(saleProductProxyDto.getId());
                }
            }
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
            // 非vip商品,一分钱商品和活动商品
            List<Integer> commonSaleProductIds = new ArrayList<Integer>();
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtoList) {
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
            List<SaleOrderItemDto> saleOrderItemDtoList = new ArrayList<SaleOrderItemDto>();
            String orderNo = StringUtils.generateSaleOrderNo();
            Long totalAmount = 0L; // 订单金额
            Long preferentialAmt = 0L; // 优惠金额
            Long transferFee = 0L; // 配送运费
            Long payableAmount = 0L; // 应付金额
            Integer orderCount = 0; // 订单商品数量
            Long commissionAmount = 0L; // 商品总佣金
            Integer commissionCount = 0; // 商品佣金数量
            boolean isIncludePennySaleProductId = false;
            for (CreateOrderItemDto createOrderItemDto : createOrderItemDtoList) {
                long commissionPrice = 0;
                Integer saleProductId = createOrderItemDto.getSaleProductId();
                if (pennySaleProductIds.contains(saleProductId)
                        && ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId())) { // 非活动一分钱商品免运费
                    // 含有一分钱商品
                    isIncludePennySaleProductId = true;
                }
                if (saleProductProxyDtoMap.containsKey(saleProductId)) {
                    SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleProductId);
                    Long orderPrice = ArithUtils.converLongTolong(saleProductProxyDto.getRetailPrice());
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
                        if (ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice()) > 0
                                || ArithUtils.converLongTolong(saleProductProxyDto.getCommissionPrice()) > 0) {
                            subsidisedSaleProductIds.add(saleProductProxyDto.getId());
                        }
                        if (SystemContext.UserDomain.BUYERLEVEL_B.equals(userProxyDto.getBuyerLevelCode())) {
                            orderPrice = ArithUtils.converLongTolong(saleProductProxyDto.getPromotionalPrice());
                            if (0 < ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice())) {
                                commissionPrice = saleProductProxyDto.getVipCommissionPrice();
                                commissionAmount += commissionPrice * createOrderItemDto.getCartNum();
                                commissionCount += createOrderItemDto.getCartNum();
                            }
                        } else {
                            if (0 < ArithUtils.converLongTolong(saleProductProxyDto.getCommissionPrice())) {
                                commissionPrice = saleProductProxyDto.getCommissionPrice();
                                commissionAmount += commissionPrice * createOrderItemDto.getCartNum();
                                commissionCount += createOrderItemDto.getCartNum();
                            }
                        }
                    }
                    // 订单总金额
                    orderCount += createOrderItemDto.getCartNum();
                    Long saleProductAmount = createOrderItemDto.getCartNum() * orderPrice;
                    totalAmount += saleProductAmount;

                    SaleOrderItemDto saleOrderItemDto = new SaleOrderItemDto();
                    saleOrderItemDto.setSaleOrderNo(orderNo);
                    saleOrderItemDto.setStoreId(storeProfileProxyDto.getStoreId());
                    saleOrderItemDto.setSaleProductId(createOrderItemDto.getSaleProductId());
                    saleOrderItemDto.setQuantity(createOrderItemDto.getCartNum());
                    saleOrderItemDto.setActivityId(createOrderItemDto.getActId());

                    saleOrderItemDto.setProductClassName(saleProductProxyDto.getProductClassName());
                    saleOrderItemDto.setProductClassCode(saleProductProxyDto.getProductClassCode());
                    saleOrderItemDto.setBrandName(saleProductProxyDto.getBrandName());
                    saleOrderItemDto.setBrandCode(saleProductProxyDto.getBrandCode());
                    saleOrderItemDto.setProductName(saleProductProxyDto.getSaleProductName());

                    saleOrderItemDto.setSpecifications(saleProductProxyDto.getSaleProductSpec());
                    saleOrderItemDto.setBarCode(saleProductProxyDto.getBarCode());
                    saleOrderItemDto.setProductImageUrl3(saleProductProxyDto.getSaleProductImageUrl());
                    saleOrderItemDto.setGiftFlag(SystemContext.OrderDomain.SALEORDERITEMGIFTFLAG_NO);
                    saleOrderItemDto.setOrderPrice(orderPrice);
                    saleOrderItemDto.setCommissionPrice(commissionPrice);
                    saleOrderItemDto.setTotalPrice(orderPrice * createOrderItemDto.getCartNum());
                    saleOrderItemDto.setSendCount(createOrderItemDto.getCartNum());
                    saleOrderItemDtoList.add(saleOrderItemDto);
                }
            }
            String couponIds = null;
            String voucherIds = null;
            List<UserCouponInfoDto> userCouponInfoDtoList = new ArrayList<UserCouponInfoDto>();
            List<UserVoucherInfoDto> userVoucherInfoDtoList = new ArrayList<UserVoucherInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserCouponIdList())) {
                StringBuffer couponSb = new StringBuffer();
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
                    if (userCouponInfo.getBeginTime().after(currentTime)) {
                        throw new OrderServiceException("优惠券(" + userCouponInfo.getConName() + ")还未到开始使用时间");
                    }
                    if (userCouponInfo.getEndTime().before(currentTime)) {
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
                    userCouponInfoDtoList.add(userCouponInfoDto);
                    if (couponSb.length() > 0) {
                        couponSb.append(CommonConstants.DELIMITER_COMMA);
                    }
                    couponSb.append(userCouponId);
                }
                couponIds = couponSb.toString();
            }
            if (!ObjectUtils.isNullOrEmpty(createOrderDto.getUserVoucherIdList())) {
                StringBuffer voucherSb = new StringBuffer();
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
                    if (userVoucherInfo.getValidStartTime().after(currentTime)) {
                        throw new OrderServiceException("抵用券(" + userVoucherInfo.getVouName() + ")还未到开始使用时间");
                    }
                    if (userVoucherInfo.getValidEndTime().before(currentTime)) {
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
                        unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByClassCode);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getProductLimit())) {
                        List<Integer> limitSaleProductIdsByProductId = getVoucherLimitSaleProductIdsByProductId(
                                saleProductProxyDtoList, userVoucherInfo.getProductLimit());
                        unUseableSaleProductIdsSet.addAll(limitSaleProductIdsByProductId);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getBusinessRuleLimit())
                            && userVoucherInfo.getBusinessRuleLimit().indexOf(
                                    SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE) != -1) {
                        unUseableSaleProductIdsSet.addAll(activitySaleProductIds);
                    }
                    if (!ObjectUtils.isNullOrEmpty(userVoucherInfo.getBusinessRuleLimit())
                            && userVoucherInfo.getBusinessRuleLimit().indexOf(
                                    SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE) != -1) {
                        // 补贴商品不可用
                        unUseableSaleProductIdsSet.addAll(subsidisedSaleProductIds);
                    }
                    if (unUseableSaleProductIdsSet.size() == saleProductProxyDtoList.size()) {
                        throw new OrderServiceException("订单商品限制使用抵用券");
                    }
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
                    if (voucherSb.length() > 0) {
                        voucherSb.append(CommonConstants.DELIMITER_COMMA);
                    }
                    voucherSb.append(voucherId);
                }
                voucherIds = voucherSb.toString();
            }
            Long useCouponSaleProductAmount = 0L;
            Long useVoucherSaleProductAmount = 0L;
            Map<Integer, Long> saleProductIdAndTotalPriceMap = new HashMap<Integer, Long>();
            for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtoList) {
                List<Integer> userCouponSaleProductIds = userCouponInfoDto.getSaleProductIds();
                for (Integer saleProductId : userCouponSaleProductIds) {
                    for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                        if (saleOrderItemDto.getSaleProductId().intValue() == saleProductId.intValue()) {
                            saleProductIdAndTotalPriceMap.put(saleOrderItemDto.getSaleProductId(),
                                    saleOrderItemDto.getTotalPrice());
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
                    for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                        if (saleOrderItemDto.getSaleProductId().intValue() == saleProductId.intValue()) {
                            saleProductIdAndTotalPriceMap.put(saleOrderItemDto.getSaleProductId(),
                                    saleOrderItemDto.getTotalPrice());
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
            if (preferentialAmt > 0) {
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    if (saleProductIdAndTotalPriceMap.containsKey(saleOrderItemDto.getSaleProductId())) {
                        Long saleProductTotalPrice = saleProductIdAndTotalPriceMap.get(saleOrderItemDto.getSaleProductId());
                        Long itemPreferentialAmt = new Double(
                                ((ArithUtils.div(ArithUtils.convertLongTodouble(saleProductTotalPrice),
                                        ArithUtils.convertLongTodouble(
                                                useCouponSaleProductAmount + useVoucherSaleProductAmount))
                                        * preferentialAmt))).longValue();
                        logger.info("useCouponSaleProductAmount:" + useCouponSaleProductAmount);
                        saleOrderItemDto.setPreferentialAmt(itemPreferentialAmt);
                    }
                }
            }
            if (totalAmount - preferentialAmt < storeProfileProxyDto.getStartSendingPrice()) { // 增加配送运费
                transferFee = storeProfileProxyDto.getAddSendingPrice();
            }
            if (isIncludePennySaleProductId) {
                // 含有一分钱商品免运费
                transferFee = 0L;
                FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                        .loadByBuyerCustomerIdAndFirstOrderType(createOrderDto.getCustomerId(),
                                SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
                if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                    // 一分钱商品首单
                    firstOrderCustomerRec = new FirstOrderCustomerRec();
                    firstOrderCustomerRec.setBuyerCustomerId(createOrderDto.getCustomerId());
                    firstOrderCustomerRec.setCreateTime(currentTime);
                    firstOrderCustomerRec.setFirstOrderType(SystemContext.OrderDomain.FIRSTORDERTYPE_PENNYPRODUCT);
                    firstOrderCustomerRec.setSaleOrderNo(orderNo);
                    firstOrderCustomerRec.setCreateUserId(createOrderDto.getUserId());
                    Integer effectCount = firstOrderCustomerRecMapper.save(firstOrderCustomerRec);
                    if (1 != effectCount) {
                        logger.error("首单信息保存失败");
                        throw new OrderServiceException("下单失败");
                    }
                }
            }
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(createOrderDto.getDeliveryMode())) {
                transferFee = 0L;
            }
            if (totalAmount - preferentialAmt <= 0) {
                payableAmount = transferFee;
            } else {
                payableAmount = totalAmount + transferFee - preferentialAmt;
            }
            if (payableAmount <= 0) {
                payableAmount = 0L;
                // throw new OrderServiceException("配送运费有误,生成订单失败");
            }
            SaleOrder saleOrder = new SaleOrder();
            saleOrder.setSaleOrderNo(orderNo);
            saleOrder.setPreferentialAmt(preferentialAmt);
            saleOrder.setTotalAmount(totalAmount);
            saleOrder.setTransferFee(transferFee);
            saleOrder.setOrderCount(orderCount);
            saleOrder.setCommissionAmount(commissionAmount);
            saleOrder.setCommissionCount(commissionCount);
            String receiveCode = getAvailableReceiveCode(storeProfileProxyDto.getStoreId());
            saleOrder.setReceiveCode(receiveCode);
            ObjectUtils.fastCopy(storeProfileProxyDto, saleOrder);
            saleOrder.setChannelCode(createOrderDto.getChannelCode());
            saleOrder.setNote(createOrderDto.getNote());
            saleOrder.setUserName(createOrderDto.getUserName());
            saleOrder.setBuyerCustomerId(createOrderDto.getCustomerId());
            saleOrder.setUserId(createOrderDto.getUserId());
            saleOrder.setDeviceId(createOrderDto.getDeviceId());
            saleOrder.setCreateUserId(createOrderDto.getUserId());
            saleOrder.setCreateTime(currentTime);
            saleOrder.setUserCouponId(couponIds);
            saleOrder.setUserVoucherId(voucherIds);
            String typeCode = SystemContext.OrderDomain.SALEORDERTYPE_ORDINARY;
            if (!ObjectUtils.isNullOrEmpty(activityIdProductIdMaps)) {
                // 含有活动(秒杀)商品为秒杀订单
                typeCode = SystemContext.OrderDomain.SALEORDERTYPE_SECKILL;
            }
            saleOrder.setTypeCode(typeCode);
            saleOrder.setPayTypeCode(SystemContext.OrderDomain.SALEORDERPAYTYPE_ONLINE);
            saleOrder.setStatusCode(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY);
            saleOrder.setPayStatus(SystemContext.OrderDomain.SALEORDERPAYSTATUS_NOTPAY);
            saleOrder.setDeliveryMode(StringUtils.defaultIfBlank(createOrderDto.getDeliveryMode(),
                    SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION));
            String bestTime = SystemContext.OrderDomain.SALEORDERBESTTIME_FASTESTTIME;
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrder.getDeliveryMode())) {
                bestTime = SystemContext.OrderDomain.SALEORDERBESTTIME_PICKUP;
            }
            saleOrder.setBestTime(bestTime);
            CustomerProxyDto customerProxyDto = customerProxyService.loadCustomerInfoById(saleOrder.getBuyerCustomerId());
            if (ObjectUtils.isNullOrEmpty(customerProxyDto)) {
                throw new OrderServiceException("客户不存在");
            }
            Integer recommendCustomerId = customerProxyDto.getRecommendCustomerId();
            if (!ObjectUtils.isNullOrEmpty(recommendCustomerId)) {
                saleOrder.setRecommendCustomerId(recommendCustomerId);
            }
            // 保存订单基础信息
            saveSaleOrder(saleOrder);
            // 保存订单明细
            saleOrderItemService.saveBatch(saleOrderItemDtoList);
            // TODO 保存订单赠品信息
            List<BuyRewardGiftInfoProxyDto> rewardGiftDtos = buyRewardActivityProxyService
                    .listBySaleProductIdsAndNumber(keyValueParis);
            if (!ObjectUtils.isNullOrEmpty(rewardGiftDtos)) {
                for (BuyRewardGiftInfoProxyDto buyRewardGiftInfoProxyDto : rewardGiftDtos) {
                    if (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT
                            .equals(buyRewardGiftInfoProxyDto.getGiftType())) {
                        KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(
                                buyRewardGiftInfoProxyDto.getGiftId(), buyRewardGiftInfoProxyDto.getGiftNumber());
                        keyValueParis.add(pair);
                    }
                    OrderGiftInfo orderGiftInfo = new OrderGiftInfo();
                    ObjectUtils.fastCopy(buyRewardGiftInfoProxyDto, orderGiftInfo);
                    orderGiftInfo.setOrderGiftStatus(SystemContext.OrderDomain.ORDERGIFTSTATUS_UNSEND);
                    orderGiftInfo.setActivityType(SystemContext.ProductDomain.ACTIVITYTYPE_BUYERREWARD);
                    orderGiftInfo.setCreateUserId(saleOrder.getCreateUserId());
                    orderGiftInfo.setCreateTime(saleOrder.getCreateTime());
                    orderGiftInfoMapper.save(orderGiftInfo);
                }
            }
            // 记录共享库存下单记录
            if (isStockShare) {
                OrderStockShareRecord orderStockShareRecord = new OrderStockShareRecord();
                orderStockShareRecord.setSaleOrderNo(saleOrder.getSaleOrderNo());
                orderStockShareRecord.setStoreId(saleOrder.getStoreId());
                orderStockShareRecord.setWarehouseId(validateStoreId);
                orderStockShareRecord.setCreateUserId(saleOrder.getCreateUserId());
                orderStockShareRecord.setCreateTime(currentTime);
                orderStockShareRecordMapper.save(orderStockShareRecord);
            }

            DistributedLockUtils.lock(DISTRIBUTED_ACTIVITYIDORDER_LOCK_PREFIX + saleOrder.getUserId());

            saveActivityOrderCustomerRec(saleOrder, secKillProductProxyDtos, createOrderItemDtoList, currentTime,
                    secKillSceneProxyDtos);
            DistributedLockUtils.unlock();
            if (!SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrder.getDeliveryMode())) {
                // 保存订单收货地址信息
                saveOrderConsigneeAddressForDelivery(orderNo, consigneeAddressProxyDto, longitude, latitude,
                        storeProfileProxyDto);
            } else {
                saveOrderConsigneeAddressForPickUp(orderNo, createOrderDto.getUserName(), longitude, latitude,
                        storeProfileProxyDto);
            }
            // 更新优惠券状态
            couponService.updateUseCouponById(createOrderDto.getUserCouponIdList(),
                    SystemContext.OrderDomain.USERCOUPONSSTATUS_USED, new Date());
            // 更新抵用券状态
            voucherService.updateUseVoucherById(createOrderDto.getUserVoucherIdList(),
                    SystemContext.OrderDomain.USERVOUCHERSTATUS_USED, new Date());
            // 更新库存
            saleProductInventoryService.updateOrderedCountBatch(keyValueParis, orderNo, createOrderDto.getUserId(),
                    currentTime);
            // 更新秒杀库存
            secKillSaleProductInventoryService.updateDecreaseRemainCountBatch(createOrderItemDtoList, currentTime);

            SaveOrderDto saveOrderDto = new SaveOrderDto();
            saveOrderDto.setSaleOrderId(saleOrder.getId());
            saveOrderDto.setPaidAmount(payableAmount);
            saveOrderDto.setReceiveCode(receiveCode);
            saveOrderDto.setSaleOrderNo(saleOrder.getSaleOrderNo());
            saveOrderDto.setDeliveryTimeCode(saleOrder.getBestTime());
            saveOrderDto.setDeliveryMode(saleOrder.getDeliveryMode());
            if (payableAmount <= 0) {
                // 更新订单状态
                int effectCount = saleOrderMapper.updateOrderStatusForPaid(saleOrder.getSaleOrderNo(),
                        SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY, SystemContext.OrderDomain.SALEORDERSTATUS_PAID,
                        SystemContext.OrderDomain.SALEORDERPAYSTATUS_PAID, currentTime, null);
                if (1 != effectCount) {
                    throw new OrderServiceException("当前订单状态不是等待买家付款，无法更新");
                }
                // 保存订单状态变更记录
                SaleOrderHistory saleOrderPaidHistory = new SaleOrderHistory();
                saleOrderPaidHistory.setSaleOrderNo(saleOrder.getSaleOrderNo());
                saleOrderPaidHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_PAID);
                saleOrderPaidHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_PAID_DESC);
                saleOrderPaidHistory.setOperateUserId(createOrderDto.getUserId());
                saleOrderPaidHistory.setOperateTime(DateUtils.addSeconds(currentTime, 1));
                effectCount = saleOrderHistoryMapper.save(saleOrderPaidHistory);
                if (1 != effectCount) {
                    throw new OrderServiceException("保存订单状态历史记录失败");
                }
                List<SaleOrderItem> saleOrderItemList = new ArrayList<SaleOrderItem>();
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    SaleOrderItem saleOrderItem = new SaleOrderItem();
                    ObjectUtils.fastCopy(saleOrderItemDto, saleOrderItem);
                    saleOrderItemList.add(saleOrderItem);
                }
                // 开始锁,防止多线程同时处理
                DistributedLockUtils.lock(DISTRIBUTED_FIRSTORDER_LOCK_PREFIX + createOrderDto.getUserId());
                if (isVipOrderType(saleOrderItemList, saleOrder.getStoreId(), createOrderDto.getCustomerId())) {
                    Date vipStartDate = customerProxyDto.getVipExpireDate();
                    if (ObjectUtils.isNullOrEmpty(vipStartDate)) {
                        vipStartDate = currentTime;
                    }
                    // 首单VIP升级会员
                    FirstOrderCustomerRec firstOrderCustomerRec = new FirstOrderCustomerRec();
                    firstOrderCustomerRec.setBuyerCustomerId(saleOrder.getBuyerCustomerId());
                    firstOrderCustomerRec.setCreateTime(currentTime);
                    firstOrderCustomerRec.setFirstOrderType(SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
                    firstOrderCustomerRec.setSaleOrderNo(saleOrder.getSaleOrderNo());
                    firstOrderCustomerRec.setCreateUserId(saleOrder.getCreateUserId());
                    firstOrderCustomerRecMapper.save(firstOrderCustomerRec);
                    Date vipExpireDate = DateUtils.addMonths(vipStartDate,
                            ArithUtils.converStringToInt(
                                    super.getSystemParamValue(SystemContext.SystemParams.U_BUYERPRODUCTTO_VIP_EXPIRE_MONTH),
                                    BUYERPRODUCTTO_VIP_DEFAULT_EXPIRE_MONTH));
                    customerProxyService.updateBuyerLevelCodeById(saleOrder.getBuyerCustomerId(),
                            SystemContext.UserDomain.BUYERLEVEL_B, vipExpireDate, currentTime, saleOrder.getCreateUserId(),
                            currentTime);
                    saleOrderMapper.updateOrderTypeBySaleOrderNo(saleOrder.getSaleOrderNo(),
                            SystemContext.OrderDomain.SALEORDERTYPE_VIP, commissionAmount, commissionCount);
                }
                // 释放锁
                DistributedLockUtils.unlock();
            }
            return saveOrderDto;
        } catch (OrderServiceException e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        } finally {
            DistributedLockUtils.unlock();
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

    private int getSystemConfigTicketSelect() {
        String systemConfigTicketSelectStr = super.getSystemParamValue(SystemContext.SystemParams.P_TICKET_SELECT_CONFIG);
        if (StringUtils.isEmpty(systemConfigTicketSelectStr)) {
            return TICKET_SELECT_ONE;
        }
        int systemConfigTicketSelect = Integer.parseInt(systemConfigTicketSelectStr);
        return systemConfigTicketSelect;
    }

    // 校验商品是否存在
    private void validateSaleProduct(List<SaleProductProxyDto> allSaleProductProxyDtoList, List<Integer> saleProductIdList) {
        Map<Integer, SaleProductProxyDto> saleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        if (!ObjectUtils.isNullOrEmpty(allSaleProductProxyDtoList)) {
            for (SaleProductProxyDto saleProductProxyDto : allSaleProductProxyDtoList) {
                saleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
        }
        for (Integer saleProductId : saleProductIdList) {
            SaleProductProxyDto saleProductProxyDto = saleProductMap.get(saleProductId);
            if (ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
                throw new OrderServiceException("商品[" + saleProductId + "]不存在");
            }
            if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
                throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已删除");
            }
            if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
                throw new OrderServiceException("商品:" + saleProductProxyDto.getSaleProductName() + " 已下架");
            }
        }
    }

    private void saveActivityOrderCustomerRec(SaleOrder saleOrder, List<SecKillProductProxyDto> secKillProductProxyDtos,
            List<CreateOrderItemDto> createOrderItemDtos, Date currentTime,
            List<SecKillSceneProxyDto> secKillSceneProxyDtos) {
        List<Map<Integer, Integer>> activityIdProductIdMaps = new ArrayList<Map<Integer, Integer>>();
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId()) && createOrderItemDto.getActId().intValue() > 0) {
                Map<Integer, Integer> activityIdProductIdMap = new HashMap<Integer, Integer>();
                activityIdProductIdMap.put(createOrderItemDto.getActId(), createOrderItemDto.getSaleProductId());
                activityIdProductIdMaps.add(activityIdProductIdMap);
            }
        }
        if (ObjectUtils.isNullOrEmpty(activityIdProductIdMaps)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(secKillSceneProxyDtos)) {
            throw new OrderServiceException("活动已结束,不能购买");
        }
        List<Integer> avaliableActivityIds = new ArrayList<Integer>();
        for (SecKillSceneProxyDto secKillSceneProxyDto : secKillSceneProxyDtos) {
            avaliableActivityIds.add(secKillSceneProxyDto.getActivityId());
        }
        for (CreateOrderItemDto createOrderItemDto : createOrderItemDtos) {
            if (!ObjectUtils.isNullOrEmpty(createOrderItemDto.getActId()) && createOrderItemDto.getActId().intValue() > 0) {
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
                        Integer cusomerOrderCount = ArithUtils.converIntegerToInt(
                                activityOrderCustomerRecMapper.loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(
                                        saleOrder.getBuyerCustomerId(), secKillProductProxyDto.getActivityId(),
                                        secKillProductProxyDto.getSaleProductId(), saleOrder.getDeviceId(), null));
                        if (cusomerOrderCount + createOrderItemDto.getCartNum().intValue() > secKillProductProxyDto
                                .getLimitOrderCount().intValue()) {
                            throw new OrderServiceException(
                                    "秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]购买数量已经超出限制");
                        }
                    }
                    // 限购数量校验
                    Integer orderCount = activityOrderCustomerRecMapper
                            .loadSaleProductOrderCountByActivityIdAndSaleProductId(secKillProductProxyDto.getActivityId(),
                                    secKillProductProxyDto.getSaleProductId(),
                                    SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL);
                    orderCount = ArithUtils.converIntegerToInt(orderCount);
                    if (orderCount + createOrderItemDto.getCartNum() > secKillProductProxyDto.getSecKillCount()) {
                        throw new OrderServiceException("秒杀商品[" + secKillProductProxyDto.getSaleProductName() + "]已抢光");
                    }
                    break;
                }
                ActivityOrderCustomerRec activityOrderCustomerRec = new ActivityOrderCustomerRec();
                activityOrderCustomerRec.setActivityId(createOrderItemDto.getActId());
                activityOrderCustomerRec.setBuyerCustomerId(saleOrder.getBuyerCustomerId());
                activityOrderCustomerRec.setCreateTime(currentTime);
                activityOrderCustomerRec.setCreateUserId(saleOrder.getCreateUserId());
                activityOrderCustomerRec.setStatus(SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL);
                activityOrderCustomerRec.setDeviceId(saleOrder.getDeviceId());
                activityOrderCustomerRec.setOrderCount(createOrderItemDto.getCartNum());
                activityOrderCustomerRec.setSaleOrderNo(saleOrder.getSaleOrderNo());
                activityOrderCustomerRec.setSaleProductId(createOrderItemDto.getSaleProductId());
                activityOrderCustomerRec.setAddressDetail(null);
                activityOrderCustomerRecMapper.save(activityOrderCustomerRec);
            }
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
        if (!ObjectUtils.isNullOrEmpty(vipSaleProductProxyDtoList)) {
            return;
        }
        Map<Integer, SaleProductProxyDto> vipSaleProductMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : vipSaleProductProxyDtoList) {
            vipSaleProductMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        int vipProductCount = 0;
        for (Integer saleProductId : saleProductIdList) {
            if (vipSaleProductMap.containsKey(saleProductId)) {
                SaleProductProxyDto saleProductProxyDto = vipSaleProductMap.get(saleProductId);
                if (!SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON.equals(saleProductProxyDto.getEnabledFlag())) {
                    throw new OrderServiceException("VIP商品:" + saleProductProxyDto.getSaleProductName() + "已删除");
                }
                if (!SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleProductProxyDto.getSaleStatus())) {
                    throw new OrderServiceException("VIP商品:" + saleProductProxyDto.getSaleProductName() + "已下架");
                }
                vipProductCount++;
            }
        }
        if (vipProductCount != 0 && vipProductCount != saleProductIdList.size()) {
            throw new OrderServiceException("不能购买VIP商品和普通商品");
        }
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

    private void setRationalLngAndLat(String longitude, String latitude, Integer communityId, Integer storeId) {
        if (null == communityId) {
            return;
        }
        CommunityProxyDto communityProxyDto = communityProxyService.loadById(communityId);
        if (null == communityProxyDto) {
            return;
        }
        if (StringUtils.isEmpty(longitude) || StringUtils.isEmpty(latitude)) {
            longitude = communityProxyDto.getLongitude();
            latitude = communityProxyDto.getLatitude();
            return;
        }
        // 根据传过来的经纬度查找最近店铺信息
        StoreProfileProxyDto storeProfileNearestProxyDto = storeProfileProxyService
                .loadNearestStoreProfileByLngAndLat(longitude, latitude);
        // 不在配送范围,以小区的经纬度为准
        if (null == storeProfileNearestProxyDto
                || storeId.intValue() != storeProfileNearestProxyDto.getStoreId().intValue()) {
            longitude = communityProxyDto.getLongitude();
            latitude = communityProxyDto.getLatitude();
        }
    }

    private void saveOrderConsigneeAddressForDelivery(String orderNo, ConsigneeAddressProxyDto consigneeAddressProxyDto,
            String longitude, String latitude, StoreProfileProxyDto storeProfileProxyDto) {
        OrderConsigneeAddressDto orderConsigneeAddressDto = new OrderConsigneeAddressDto();
        orderConsigneeAddressDto.setPhoneNo(consigneeAddressProxyDto.getPhoneNo());
        orderConsigneeAddressDto.setSaleOrderNo(orderNo);
        orderConsigneeAddressDto.setUserName(consigneeAddressProxyDto.getConsigneeName());
        // 设置更合理的经纬度
        // setRationalLngAndLat(longitude, latitude,
        // consigneeAddressProxyDto.getCommunityId(),
        // storeProfileProxyDto.getStoreId());
        orderConsigneeAddressDto.setLatitude(latitude);
        orderConsigneeAddressDto.setLongitude(longitude);
        String provinceName = super.getAreaName(consigneeAddressProxyDto.getProvinceCode());
        String cityName = super.getAreaName(consigneeAddressProxyDto.getCityCode());
        String countryName = super.getAreaName(consigneeAddressProxyDto.getCountyCode());
        String addressDetail = StringUtils.join(provinceName, cityName, countryName, storeProfileProxyDto.getCommunityName(),
                consigneeAddressProxyDto.getAddressDetail());
        orderConsigneeAddressDto.setAddressDetail(addressDetail);
        orderConsigneeAddressService.save(orderConsigneeAddressDto);
    }

    private void saveOrderConsigneeAddressForPickUp(String orderNo, String userName, String longitude, String latitude,
            StoreProfileProxyDto storeProfileProxyDto) {
        OrderConsigneeAddressDto orderConsigneeAddressDto = new OrderConsigneeAddressDto();
        orderConsigneeAddressDto.setPhoneNo(
                StringUtils.defaultIfBlank(storeProfileProxyDto.getMobile(), storeProfileProxyDto.getTelPhone()));
        orderConsigneeAddressDto.setSaleOrderNo(orderNo);
        orderConsigneeAddressDto.setUserName(userName);
        orderConsigneeAddressDto.setLatitude(storeProfileProxyDto.getLatitude());
        orderConsigneeAddressDto.setLongitude(storeProfileProxyDto.getLongitude());
        String provinceName = super.getAreaName(storeProfileProxyDto.getProvinceCode());
        String cityName = super.getAreaName(storeProfileProxyDto.getCityCode());
        String countryName = super.getAreaName(storeProfileProxyDto.getCountyCode());
        String addressDetail = StringUtils.join(provinceName, cityName, countryName, storeProfileProxyDto.getCommunityName(),
                storeProfileProxyDto.getAddressDetail());
        orderConsigneeAddressDto.setAddressDetail(addressDetail);
        orderConsigneeAddressService.save(orderConsigneeAddressDto);
    }

    // 获取可用的收货码
    private String getAvailableReceiveCode(Integer storeId) {
        if (null == storeId) {
            throw new OrderServiceException("店铺不能为空");
        }
        String receiveCode = StringUtils.generateArabicNumerals(4);
        for (int i = 0; i < 9000; i++) {
            Integer count = saleOrderMapper.getTotalByStoreIdAndReceiveCodeAndStatusCodes(storeId, receiveCode,
                    Arrays.asList(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY,
                            SystemContext.OrderDomain.SALEORDERSTATUS_PAID,
                            SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND,
                            SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE));
            if (null == count || count.intValue() == 0) { // 订单表里不存在则可用
                return receiveCode;
            }
            receiveCode = StringUtils.generateArabicNumerals(4);
        }
        throw new OrderServiceException("该门店处理的订单太多,请稍候再试!");
    }

    private SaleOrder saveSaleOrder(SaleOrder saleOrder) {
        // 保存订单基础信息
        saleOrderMapper.save(saleOrder);

        // 保存订单状态变更记录
        SaleOrderHistory saleOrderHistory = new SaleOrderHistory();
        saleOrderHistory.setSaleOrderNo(saleOrder.getSaleOrderNo());
        saleOrderHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY);
        saleOrderHistory.setOperationDesc(
                CommonConstants.SALEORDERSTATUS_FORPAY_DESC.replace("{0}", String.valueOf(SALE_ORDER_PAY_TIME_OUT)));
        saleOrderHistory.setOperateUserId(saleOrder.getCreateUserId());
        saleOrderHistory.setOperateTime(saleOrder.getCreateTime());
        saleOrderHistoryMapper.save(saleOrderHistory);
        return saleOrder;
    }

    @Override
    public YiLiDiPage<SaleOrderDto> findSaleOrders(SaleOrderQueryDto query) throws OrderServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());

            SaleOrderQuery saleOrderQuery = new SaleOrderQuery();
            ObjectUtils.fastCopy(query, saleOrderQuery);
            List<String> statusCodes = saleOrderQuery.getStatusCodes();
            if (!ObjectUtils.isNullOrEmpty(statusCodes)) {
                if (statusCodes.size() == 1) {
                    saleOrderQuery.setStatusCode(statusCodes.get(0));
                    saleOrderQuery.setStatusCodes(null);
                } else {
                    saleOrderQuery.setStatusCode(null);
                }
            }
            Page<SaleOrder> page = saleOrderMapper.findSaleOrders(saleOrderQuery);
            Page<SaleOrderDto> pageDto = new Page<SaleOrderDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleOrder> saleOrders = page.getResult();
            if (ObjectUtils.isNullOrEmpty(saleOrders)) {
                return YiLiDiPageUtils.encapsulatePageResult(pageDto);
            }
            List<String> saleOrderNos = new ArrayList<String>();
            for (SaleOrder saleOrder : saleOrders) {
                saleOrderNos.add(saleOrder.getSaleOrderNo());
                SaleOrderDto saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderDto);
                pageDto.add(saleOrderDto);
            }
            List<SaleOrderItem> saleOrderItemList = saleOrderItemMapper.listSaleOrderItemsBySaleOrderNos(saleOrderNos);
            if (ObjectUtils.isNullOrEmpty(saleOrderItemList)) {
                return YiLiDiPageUtils.encapsulatePageResult(pageDto);
            }
            for (SaleOrderDto saleOrderDto : pageDto.getResult()) {
                List<SaleOrderItemDto> saleOrderItemDtos = new ArrayList<SaleOrderItemDto>();
                int i = 0;
                for (SaleOrderItem saleOrderItem : saleOrderItemList) {
                    if (saleOrderDto.getSaleOrderNo().equals(saleOrderItem.getSaleOrderNo())) {
                        if (++i > SALE_ORDER_ITEM_LIST_SIZE) {
                            break;
                        }
                        SaleOrderItemDto saleOrderItemDto = new SaleOrderItemDto();
                        saleOrderItemDto.setProductImageUrl3(saleOrderItem.getProductImageUrl3());
                        saleOrderItemDtos.add(saleOrderItemDto);
                    }
                }
                saleOrderDto.setSaleOrderItemDtoList(saleOrderItemDtos);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException("订单列表异常");
        }
    }

    @Override
    public Integer getForAcceptOrderCount(Integer storeId) throws OrderServiceException {
        try {
            return this.saleOrderMapper.getForAcceptOrderCount(storeId, SystemContext.OrderDomain.SALEORDERSTATUS_PAID);
        } catch (Exception e) {
            String msg = "获取待接单数量出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Long getFinishOrderAmount(Integer storeId, Date beginDate, Date endDate) throws OrderServiceException {
        try {
            return this.saleOrderMapper.getFinishOrderAmount(storeId, SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED,
                    beginDate, endDate);
        } catch (Exception e) {
            String msg = "获取完成订单金额出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<SellerOrderListDto> findOrderListForSeller(SellerListOrderQueryDto sellerListOrderQueryDto)
            throws OrderServiceException {
        try {
            if (null == sellerListOrderQueryDto.getStart() || sellerListOrderQueryDto.getStart() <= 0) {
                sellerListOrderQueryDto.setStart(1);
            }
            if (null == sellerListOrderQueryDto.getPageSize() || sellerListOrderQueryDto.getPageSize() <= 0) {
                sellerListOrderQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            SellerListOrderQuery sellerListOrderQuery = new SellerListOrderQuery();
            ObjectUtils.fastCopy(sellerListOrderQueryDto, sellerListOrderQuery);
            PageHelper.startPage(sellerListOrderQuery.getStart(), sellerListOrderQuery.getPageSize());
            Page<SaleOrder> page = null;
            if (StringUtils.isEmpty(sellerListOrderQueryDto.getKeyword())) {
                page = saleOrderMapper.findOrderBasicInfoListForSeller(sellerListOrderQuery);
            } else {
                sellerListOrderQuery.setPayStatus(SystemContext.OrderDomain.SALEORDERPAYSTATUS_PAID);
                page = saleOrderMapper.findOrderBasicInfoListForSellerWithKeyword(sellerListOrderQuery);
            }
            Page<SellerOrderListDto> pageDto = new Page<SellerOrderListDto>(sellerListOrderQueryDto.getStart(),
                    sellerListOrderQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleOrder> saleOrders = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(saleOrders)) {
                for (SaleOrder saleOrder : saleOrders) {
                    SellerOrderListDto sellerListOrderDto = new SellerOrderListDto();
                    sellerListOrderDto.setSaleOrderNo(saleOrder.getSaleOrderNo());
                    sellerListOrderDto.setCreateTime(DateUtils.formatDateLong(saleOrder.getCreateTime()));
                    sellerListOrderDto.setPayTime(
                            null == saleOrder.getPayTime() ? null : DateUtils.formatDateLong(saleOrder.getPayTime()));
                    sellerListOrderDto.setTotalAmount(saleOrder.getTotalAmount());
                    sellerListOrderDto.setPayableAmount(ArithUtils.converLongTolong(saleOrder.getTotalAmount())
                            + ArithUtils.converLongTolong(saleOrder.getTransferFee())
                            - ArithUtils.converLongTolong(saleOrder.getPreferentialAmt()));
                    sellerListOrderDto.setDeliveryMode(saleOrder.getDeliveryMode());
                    sellerListOrderDto.setUserId(saleOrder.getUserId());
                    if (!SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrder.getDeliveryMode())) {
                        OrderConsigneeAddressDto address = orderConsigneeAddressService
                                .loadByOrderNo(saleOrder.getSaleOrderNo());
                        sellerListOrderDto.setConsignee(address.getUserName());
                        sellerListOrderDto.setConsMobile(address.getPhoneNo());
                        sellerListOrderDto.setConsAddress(address.getAddressDetail());
                        sellerListOrderDto.setDistance(DistanceUtils.distance(sellerListOrderQueryDto.getLongitude(),
                                sellerListOrderQueryDto.getLatitude(), address.getLongitude(), address.getLatitude()));
                    }
                    pageDto.add(sellerListOrderDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "分页获取卖家订单列表信息出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public SellerOrderDetailDto showOrderDetailForSeller(String saleOrderNo, Integer storeId, String storePhoneNo)
            throws OrderServiceException {
        try {
            SellerOrderDetailDto sellerOrderDetailDto = new SellerOrderDetailDto();
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto || storeId.intValue() != saleOrderDto.getStoreId().intValue()
                    || SystemContext.OrderDomain.SALEORDERPAYSTATUS_NOTPAY.equals(saleOrderDto.getStatusCode())) {
                throw new OrderServiceException("该订单不存在");
            }
            if (!ObjectUtils.isNullOrEmpty(saleOrderDto)) {
                sellerOrderDetailDto.setStatusCode(SaleOrderStatusMapping.getType(saleOrderDto.getStatusCode()));
                sellerOrderDetailDto.setStatusCodeName(SaleOrderStatusMapping.getTypeName(saleOrderDto.getStatusCode()));
                sellerOrderDetailDto.setRefundAuditFailureReason(saleOrderDto.getRefundAuditFailureReason());
                sellerOrderDetailDto.setSaleOrderId(saleOrderDto.getId());
                sellerOrderDetailDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
                sellerOrderDetailDto.setCreateTime(DateUtils.formatDateLong(saleOrderDto.getCreateTime()));
                sellerOrderDetailDto.setAcceptTime(null == saleOrderDto.getAcceptTime() ? null
                        : DateUtils.formatDateLong(saleOrderDto.getAcceptTime()));
                sellerOrderDetailDto.setCancelTime(null == saleOrderDto.getCancelTime() ? null
                        : DateUtils.formatDateLong(saleOrderDto.getCancelTime()));
                sellerOrderDetailDto.setFinishTime(
                        null == saleOrderDto.getTakeTime() ? null : DateUtils.formatDateLong(saleOrderDto.getTakeTime()));
                sellerOrderDetailDto.setPayTypeCode(saleOrderDto.getPayTypeCode());
                sellerOrderDetailDto.setPayTypeName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.SALEORDERPAYTYPE.getValue(), saleOrderDto.getPayTypeCode()));
                if (null != saleOrderDto.getPayTime()) {
                    sellerOrderDetailDto.setPayTime(DateUtils.formatDateLong(saleOrderDto.getPayTime()));
                }
                sellerOrderDetailDto.setDeliveryMode(saleOrderDto.getDeliveryMode());
                sellerOrderDetailDto.setDeliveryModeName(
                        super.getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERDELIVERYMODE.getValue(),
                                saleOrderDto.getDeliveryMode()));
                String deliverTimeNote = super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(), saleOrderDto.getBestTime());
                if (ObjectUtils.isNullOrEmpty(deliverTimeNote)) {
                    deliverTimeNote = CommonConstants.DELIVERY_TIME_NOTE;
                }
                sellerOrderDetailDto.setBestTime(deliverTimeNote);
                sellerOrderDetailDto.setNote(saleOrderDto.getNote());
                sellerOrderDetailDto.setStorePhoneNo(storePhoneNo);
                sellerOrderDetailDto.setOrderCount(saleOrderDto.getOrderCount());
                sellerOrderDetailDto.setTotalAmount(saleOrderDto.getTotalAmount());
                sellerOrderDetailDto.setPreferentialAmt(saleOrderDto.getPreferentialAmt());
                sellerOrderDetailDto.setTransferFee(saleOrderDto.getTransferFee());
                sellerOrderDetailDto.setPayableAmount(saleOrderDto.getOrderTotalAmount());
                sellerOrderDetailDto.setSettleProductCount(saleOrderDto.getCommissionCount());
                sellerOrderDetailDto.setSettleTotalAmount(saleOrderDto.getCommissionAmount());
                sellerOrderDetailDto.setReceiveNo(saleOrderDto.getReceiveCode());
                sellerOrderDetailDto.setTypeCode(saleOrderDto.getTypeCode());
                sellerOrderDetailDto.setUserId(saleOrderDto.getUserId());
            }
            OrderConsigneeAddressDto orderConsigneeAddressDto = orderConsigneeAddressService.loadByOrderNo(saleOrderNo);
            sellerOrderDetailDto.setOrderConsigneeAddressDto(orderConsigneeAddressDto);
            List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
            sellerOrderDetailDto.setSaleOrderItemDtoList(saleOrderItemDtoList);
            List<SaleProductSettleDto> saleProductSettleDtoList = new ArrayList<SaleProductSettleDto>();
            if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    if (0L != saleOrderItemDto.getCommissionPrice().longValue()
                            && !SystemContext.OrderDomain.SALEORDERTYPE_VIP.equals(sellerOrderDetailDto.getTypeCode())) {
                        SaleProductSettleDto saleProductSettleDto = new SaleProductSettleDto();
                        saleProductSettleDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                        saleProductSettleDto.setSaleProductName(saleOrderItemDto.getProductName());
                        saleProductSettleDto.setBrandName(saleOrderItemDto.getBrandName());
                        saleProductSettleDto.setSettleAmount(saleOrderItemDto.getCommissionPrice());
                        saleProductSettleDto.setSettleCount(saleOrderItemDto.getQuantity());
                        saleProductSettleDtoList.add(saleProductSettleDto);
                    }
                }
            }
            sellerOrderDetailDto.setSaleProductSettleDtoList(saleProductSettleDtoList);
            return sellerOrderDetailDto;
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "显示订单详细信息出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Integer updateForAccept(String saleOrderNo, Integer storeId, String storePhoneNo, Integer acceptUserId,
            Date acceptTime) throws OrderServiceException {
        try {
            // 验证该订单是否是属于卖家自己的订单
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto || storeId.intValue() != saleOrderDto.getStoreId().intValue()) {
                throw new OrderServiceException("该订单不存在");
            }
            // 根据当前订单是否是“已付款”订单验证是否可以进行接单操作
            int affectedCount = this.updateOrderStatusForAccept(saleOrderNo, acceptTime, acceptUserId);
            if (1 != affectedCount) {
                throw new OrderServiceException("订单已被接单,不能重复接单");
            }
            // 保存订单状态变更记录
            SaleOrderHistory saleOrderHistory = new SaleOrderHistory();
            saleOrderHistory.setSaleOrderNo(saleOrderNo);
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                saleOrderHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
                saleOrderHistory
                        .setOperationDesc(CommonConstants.SALEORDERSTATUS_FORPICKUP_DESC.replace("{0}", storePhoneNo));
            } else {
                saleOrderHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND);
                saleOrderHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_FORSEND_DESC);
            }
            saleOrderHistory.setOperateUserId(acceptUserId);
            saleOrderHistory.setOperateTime(acceptTime);
            saleOrderHistoryMapper.save(saleOrderHistory);
            // 更新商品库存并记录库存变更记录
            List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
            if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
                List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(
                            saleOrderItemDto.getSaleProductId(), saleOrderItemDto.getQuantity());
                    pairs.add(pair);
                }
                saleProductInventoryService.updateInventoryForSellerAccept(pairs, saleOrderNo, acceptUserId, acceptTime);
            }
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                Date sendTime = acceptTime;
                int sendUserId = acceptUserId.intValue();
                updateForSellerSend(saleOrderNo, storeId, storePhoneNo, SystemContext.OrderDomain.SALEORDERSENDSTATUS_SENT,
                        sendUserId, sendTime);
            }
            return saleOrderDto.getId();
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "订单接单出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public int updateOrderStatusForAccept(String saleOrderNo, Date acceptTime, Integer acceptUserId)
            throws OrderServiceException {
        try {
            int affectedCount = saleOrderMapper.updateOrderStatusForAccept(saleOrderNo,
                    SystemContext.OrderDomain.SALEORDERSTATUS_PAID, SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND,
                    acceptTime, acceptUserId);
            return affectedCount;
        } catch (Exception e) {
            String msg = "接单时改变订单状态出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Integer updateForSellerCancel(String saleOrderNo, Integer storeId, Integer cancelUserId, Date cancelTime)
            throws OrderServiceException {
        try {
            // 验证该订单是否是属于卖家自己的订单
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto || storeId.intValue() != saleOrderDto.getStoreId().intValue()) {
                throw new OrderServiceException("该订单不存在");
            }
            long preferentiaPayAmount = ArithUtils.converLongTolong(saleOrderDto.getTotalAmount())
                    - ArithUtils.converLongTolong(saleOrderDto.getPreferentialAmt());
            if (preferentiaPayAmount <= 0) {
                preferentiaPayAmount = 0L;
            }
            long payAmount = preferentiaPayAmount + ArithUtils.converLongTolong(saleOrderDto.getTransferFee());
            boolean isPaid = true;
            if (payAmount <= 0) {
                isPaid = false;
            }
            // 根据当前订单是否是“已付款”订单验证是否可以进行取消操作
            int affectedCount = this
                    .updateOrderStatusForSellerCancel(saleOrderNo, SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_SELLER,
                            super.getSystemDictName(SystemContext.OrderDomain.DictType.SALEORDERCANCELTYPECODE.getValue(),
                                    SystemContext.OrderDomain.SALEORDERCANCELTYPECODE_SELLER),
                            cancelTime, cancelUserId, isPaid);
            if (1 != affectedCount) {
                throw new OrderServiceException("当前订单状态不是已付款，无法取消");
            }
            // 保存订单状态变更记录(订单取消)
            SaleOrderHistory saleOrderCancelHistory = new SaleOrderHistory();
            saleOrderCancelHistory.setSaleOrderNo(saleOrderNo);
            saleOrderCancelHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
            saleOrderCancelHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_SELLERCANCEL_DESC);
            saleOrderCancelHistory.setOperateUserId(cancelUserId);
            saleOrderCancelHistory.setOperateTime(cancelTime);
            saleOrderHistoryMapper.save(saleOrderCancelHistory);
            if (isPaid) {
                // 保存订单状态变更记录(订单退款中)
                SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
                saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
                saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
                saleOrderRefundHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_REFUNDING_DESC);
                saleOrderRefundHistory.setOperateUserId(cancelUserId);
                saleOrderRefundHistory.setOperateTime(DateUtils.addSeconds(cancelTime, 1));
                saleOrderHistoryMapper.save(saleOrderRefundHistory);
                // 生成退款信息并记录退款变更记录
                RefundApplyDto refundApplyDto = new RefundApplyDto();
                refundApplyDto.setApplyUserId(saleOrderDto.getUserId());
                refundApplyDto.setBuyerCustomerId(saleOrderDto.getBuyerCustomerId());
                refundApplyDto.setRefundAmount(saleOrderDto.getOrderTotalAmount());
                refundApplyDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
                refundApplyDto.setStoreId(saleOrderDto.getStoreId());
                refundApplyDto.setStatusCode(SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING);
                refundApplyDto.setApplyTime(cancelTime);
                refundApplyDto.setOperationTime(cancelTime);
                refundApplyDto.setOperationUserId(cancelUserId);
                refundApplyService.save(refundApplyDto);

                // 保存订单退款表
                OrderRefund orderRefund = new OrderRefund();
                orderRefund.setCreateTime(cancelTime);
                orderRefund.setCreateUserId(cancelUserId);
                orderRefund.setPayPlatformCode(saleOrderDto.getPayPlatformCode());
                orderRefund.setRefundAmount(saleOrderDto.getOrderTotalAmount());
                orderRefund.setRefundReason(ORDER_REFUND_SELLERCANCEL_DESC);
                orderRefund.setRefundWay(SystemContext.OrderDomain.ORDERREFUNDWAY_WEEK);
                orderRefund.setSaleOrderNo(saleOrderNo);
                orderRefund.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
                orderRefundMapper.save(orderRefund);

                OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
                orderRefundStatusHistory.setCreateTime(cancelTime);
                orderRefundStatusHistory.setCreateUserId(cancelUserId);
                orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
                orderRefundStatusHistory.setOperateTime(cancelTime);
                orderRefundStatusHistory.setOperateUserId(cancelUserId);
                orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_APPLY_DESC);
                orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_APPLY);
                orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);

                OrderRefundStatusHistory orderRefundingStatusHistory = new OrderRefundStatusHistory();
                orderRefundingStatusHistory.setCreateTime(DateUtils.addSeconds(cancelTime, 1));
                orderRefundingStatusHistory.setCreateUserId(cancelUserId);
                orderRefundingStatusHistory.setSaleOrderNo(saleOrderNo);
                orderRefundingStatusHistory.setOperateTime(DateUtils.addSeconds(cancelTime, 1));
                orderRefundingStatusHistory.setOperateUserId(cancelUserId);
                orderRefundingStatusHistory.setOperationDesc(ORDER_REFUNDING_DESC);
                orderRefundingStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
                orderRefundStatusHistoryMapper.save(orderRefundingStatusHistory);
            }
            // 更新商品库存并记录库存变更记录
            List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
            List<CreateOrderItemDto> activityOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
            if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
                List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(
                            saleOrderItemDto.getSaleProductId(), saleOrderItemDto.getQuantity());
                    pairs.add(pair);
                    if (!ObjectUtils.isNullOrEmpty(saleOrderItemDto.getActivityId())
                            && saleOrderItemDto.getActivityId().intValue() > 0) {
                        CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
                        createOrderItemDto.setActId(saleOrderItemDto.getActivityId());
                        createOrderItemDto.setCartNum(saleOrderItemDto.getQuantity());
                        createOrderItemDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                        activityOrderItemDtoList.add(createOrderItemDto);
                    }
                }
                List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(saleOrderNo,
                        SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT, null, null);
                if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                    for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                        KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(orderGiftInfo.getGiftId(),
                                orderGiftInfo.getGiftCount());
                        pairs.add(pair);
                    }

                }
                saleProductInventoryService.updateInventoryForSellerCancel(pairs, saleOrderNo, cancelUserId, cancelTime);
                if (!ObjectUtils.isNullOrEmpty(activityOrderItemDtoList)) {
                    secKillSaleProductInventoryService.updateIncreaseRemainCountBatch(activityOrderItemDtoList, cancelTime);
                }
            }
            cancelVipOrderType(saleOrderNo, saleOrderDto.getStoreId(), saleOrderDto.getBuyerCustomerId(), cancelUserId,
                    cancelTime);
            activityOrderCustomerRecMapper.updateStatusBySaleOrderNo(saleOrderDto.getSaleOrderNo(),
                    SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_CANCEL);
            updateCouponStatusForCancelOrder(saleOrderNo, cancelTime);
            updateVoucherStatusForCancelOrder(saleOrderNo, cancelTime);
            return saleOrderDto.getId();
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "订单取消出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    private int updateOrderStatusForSellerCancel(String saleOrderNo, String cancelTypeCode, String cancelReason,
            Date cancelTime, Integer cancelUserId, boolean isPaid) throws OrderServiceException {
        try {
            String updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING;
            if (!isPaid) {
                updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL;
            }
            int affectedCount = saleOrderMapper.updateOrderStatusForSellerCancel(saleOrderNo,
                    SystemContext.OrderDomain.SALEORDERSTATUS_PAID, updateStatus, cancelTypeCode, cancelReason, cancelTime,
                    cancelUserId);
            return affectedCount;
        } catch (Exception e) {
            String msg = "取消订单时改变订单状态出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    // 未付款取消订单时修改订单状态
    private void updateOrderStatusCancelForUnPay(String saleOrderNo, String cancelTypeCode, String cancelReason,
            String operationDesc, Integer userId, Date operationTime) {
        // 修改订单表中状态为已取消
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForUnPayCancel(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY, SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL,
                cancelTypeCode, cancelReason, userId, operationTime);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状[已取消]态异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderCancelHistory = new SaleOrderHistory();
        saleOrderCancelHistory.setSaleOrderNo(saleOrderNo);
        saleOrderCancelHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
        saleOrderCancelHistory.setOperationDesc(operationDesc);
        saleOrderCancelHistory.setOperateUserId(userId);
        saleOrderCancelHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderCancelHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
        // 更新商品库存并记录库存变更记录
        List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
        List<CreateOrderItemDto> activityOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(saleOrderItemDto.getSaleProductId(),
                        saleOrderItemDto.getQuantity());
                pairs.add(pair);
                if (!ObjectUtils.isNullOrEmpty(saleOrderItemDto.getActivityId())
                        && saleOrderItemDto.getActivityId().intValue() > 0) {
                    CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
                    createOrderItemDto.setActId(saleOrderItemDto.getActivityId());
                    createOrderItemDto.setCartNum(saleOrderItemDto.getQuantity());
                    createOrderItemDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    activityOrderItemDtoList.add(createOrderItemDto);
                }
            }
            List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(saleOrderNo,
                    SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT, null, null);
            if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(orderGiftInfo.getGiftId(),
                            orderGiftInfo.getGiftCount());
                    pairs.add(pair);
                }

            }
            saleProductInventoryService.updateInventoryForSellerCancel(pairs, saleOrderNo, userId, operationTime);
            if (!ObjectUtils.isNullOrEmpty(activityOrderItemDtoList)) {
                secKillSaleProductInventoryService.updateIncreaseRemainCountBatch(activityOrderItemDtoList, operationTime);
            }
        }
        updateCouponStatusForCancelOrder(saleOrderNo, operationTime);
        updateVoucherStatusForCancelOrder(saleOrderNo, operationTime);
    }

    // 已付款取消订单时修改订单状态
    private void updateOrderStatusCancelForPaid(String saleOrderNo, String cancelTypeCode, String cancelReason,
            String operationDesc, Integer cancelUserId, Integer buyerCustomerId, Date operationTime, boolean isPaid) {
        String updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING;
        if (!isPaid) {
            updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL;
        }
        // 修改订单表中状态为已取消
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForSellerCancel(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_PAID, updateStatus, cancelTypeCode, cancelReason, operationTime,
                cancelUserId);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderCancelHistory = new SaleOrderHistory();
        saleOrderCancelHistory.setSaleOrderNo(saleOrderNo);
        saleOrderCancelHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
        saleOrderCancelHistory.setOperationDesc(operationDesc);
        saleOrderCancelHistory.setOperateUserId(cancelUserId);
        saleOrderCancelHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderCancelHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
        if (isPaid) {
            // 保存订单状态变更记录(订单退款中)
            SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
            saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
            saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
            saleOrderRefundHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_REFUNDING_DESC);
            saleOrderRefundHistory.setOperateUserId(cancelUserId);
            saleOrderRefundHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            saleOrderHistoryMapper.save(saleOrderRefundHistory);
            // 生成退款信息并记录退款变更记录
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("该订单不存在");
            }
            RefundApplyDto refundApplyDto = new RefundApplyDto();
            refundApplyDto.setApplyUserId(cancelUserId);
            refundApplyDto.setBuyerCustomerId(buyerCustomerId);
            refundApplyDto.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            refundApplyDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
            refundApplyDto.setStoreId(saleOrderDto.getStoreId());
            refundApplyDto.setStatusCode(SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING);
            refundApplyDto.setApplyTime(operationTime);
            refundApplyDto.setOperationTime(operationTime);
            refundApplyDto.setOperationUserId(cancelUserId);
            refundApplyService.save(refundApplyDto);

            // 保存订单退款表
            OrderRefund orderRefund = new OrderRefund();
            orderRefund.setCreateTime(operationTime);
            orderRefund.setCreateUserId(cancelUserId);
            orderRefund.setPayPlatformCode(saleOrderDto.getPayPlatformCode());
            orderRefund.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            orderRefund.setRefundReason(operationDesc);
            orderRefund.setRefundWay(SystemContext.OrderDomain.ORDERREFUNDWAY_WEEK);
            orderRefund.setSaleOrderNo(saleOrderNo);
            orderRefund.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundMapper.save(orderRefund);

            OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
            orderRefundStatusHistory.setCreateTime(operationTime);
            orderRefundStatusHistory.setCreateUserId(cancelUserId);
            orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundStatusHistory.setOperateTime(operationTime);
            orderRefundStatusHistory.setOperateUserId(cancelUserId);
            orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_APPLY_DESC);
            orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_APPLY);
            orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);

            OrderRefundStatusHistory orderRefundingStatusHistory = new OrderRefundStatusHistory();
            orderRefundingStatusHistory.setCreateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setCreateUserId(cancelUserId);
            orderRefundingStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundingStatusHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setOperateUserId(cancelUserId);
            orderRefundingStatusHistory.setOperationDesc(ORDER_REFUNDING_DESC);
            orderRefundingStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundStatusHistoryMapper.save(orderRefundingStatusHistory);
        }
        // 更新商品库存并记录库存变更记录
        List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
        List<CreateOrderItemDto> activityOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(saleOrderItemDto.getSaleProductId(),
                        saleOrderItemDto.getQuantity());
                pairs.add(pair);
                if (!ObjectUtils.isNullOrEmpty(saleOrderItemDto.getActivityId())
                        && saleOrderItemDto.getActivityId().intValue() > 0) {
                    CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
                    createOrderItemDto.setActId(saleOrderItemDto.getActivityId());
                    createOrderItemDto.setCartNum(saleOrderItemDto.getQuantity());
                    createOrderItemDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    activityOrderItemDtoList.add(createOrderItemDto);
                }
            }
            List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(saleOrderNo,
                    SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT, null, null);
            if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(orderGiftInfo.getGiftId(),
                            orderGiftInfo.getGiftCount());
                    pairs.add(pair);
                }

            }
            saleProductInventoryService.updateInventoryForSellerCancel(pairs, saleOrderNo, cancelUserId, operationTime);
            if (!ObjectUtils.isNullOrEmpty(activityOrderItemDtoList)) {
                secKillSaleProductInventoryService.updateIncreaseRemainCountBatch(activityOrderItemDtoList, operationTime);
            }
        }
        updateCouponStatusForCancelOrder(saleOrderNo, operationTime);
        updateVoucherStatusForCancelOrder(saleOrderNo, operationTime);
    }

    // 订单状态为待发货状态时,取消订单
    private void updateOrderStatusCancelForSend(String saleOrderNo, String cancelTypeCode, String cancelReason,
            String operationDesc, Integer cancelUserId, Integer buyerCustomerId, Date operationTime, boolean isPaid) {
        String updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING;
        if (!isPaid) {
            updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL;
        }
        // 修改订单表中状态为已取消
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForSendCancel(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND, updateStatus, cancelTypeCode, cancelReason, operationTime,
                cancelUserId);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderCancelHistory = new SaleOrderHistory();
        saleOrderCancelHistory.setSaleOrderNo(saleOrderNo);
        saleOrderCancelHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
        saleOrderCancelHistory.setOperationDesc(operationDesc);
        saleOrderCancelHistory.setOperateUserId(cancelUserId);
        saleOrderCancelHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderCancelHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
        if (isPaid) {
            // 保存订单状态变更记录(订单退款中)
            SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
            saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
            saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
            saleOrderRefundHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_REFUNDING_DESC);
            saleOrderRefundHistory.setOperateUserId(cancelUserId);
            saleOrderRefundHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            saleOrderHistoryMapper.save(saleOrderRefundHistory);
            // 生成退款信息并记录退款变更记录
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("该订单不存在");
            }
            RefundApplyDto refundApplyDto = new RefundApplyDto();
            refundApplyDto.setApplyUserId(cancelUserId);
            refundApplyDto.setBuyerCustomerId(buyerCustomerId);
            refundApplyDto.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            refundApplyDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
            refundApplyDto.setStoreId(saleOrderDto.getStoreId());
            refundApplyDto.setStatusCode(SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING);
            refundApplyDto.setApplyTime(operationTime);
            refundApplyDto.setOperationTime(operationTime);
            refundApplyDto.setOperationUserId(cancelUserId);
            refundApplyService.save(refundApplyDto);

            // 保存订单退款表
            OrderRefund orderRefund = new OrderRefund();
            orderRefund.setCreateTime(operationTime);
            orderRefund.setCreateUserId(cancelUserId);
            orderRefund.setPayPlatformCode(saleOrderDto.getPayPlatformCode());
            orderRefund.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            orderRefund.setRefundReason(operationDesc);
            orderRefund.setRefundWay(SystemContext.OrderDomain.ORDERREFUNDWAY_WEEK);
            orderRefund.setSaleOrderNo(saleOrderNo);
            orderRefund.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundMapper.save(orderRefund);

            OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
            orderRefundStatusHistory.setCreateTime(operationTime);
            orderRefundStatusHistory.setCreateUserId(cancelUserId);
            orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundStatusHistory.setOperateTime(operationTime);
            orderRefundStatusHistory.setOperateUserId(cancelUserId);
            orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_APPLY_DESC);
            orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_APPLY);
            orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);

            OrderRefundStatusHistory orderRefundingStatusHistory = new OrderRefundStatusHistory();
            orderRefundingStatusHistory.setCreateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setCreateUserId(cancelUserId);
            orderRefundingStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundingStatusHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setOperateUserId(cancelUserId);
            orderRefundingStatusHistory.setOperationDesc(ORDER_REFUNDING_DESC);
            orderRefundingStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundStatusHistoryMapper.save(orderRefundingStatusHistory);
        }
        // 更新商品库存并记录库存变更记录
        List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
        List<CreateOrderItemDto> activityOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(saleOrderItemDto.getSaleProductId(),
                        saleOrderItemDto.getQuantity());
                pairs.add(pair);
                if (!ObjectUtils.isNullOrEmpty(saleOrderItemDto.getActivityId())
                        && saleOrderItemDto.getActivityId().intValue() > 0) {
                    CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
                    createOrderItemDto.setActId(saleOrderItemDto.getActivityId());
                    createOrderItemDto.setCartNum(saleOrderItemDto.getQuantity());
                    createOrderItemDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    activityOrderItemDtoList.add(createOrderItemDto);
                }
            }
            List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(saleOrderNo,
                    SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT, null, null);
            if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(orderGiftInfo.getGiftId(),
                            orderGiftInfo.getGiftCount());
                    pairs.add(pair);
                }

            }
            saleProductInventoryService.updateInventoryForSendCancel(pairs, saleOrderNo, cancelUserId, operationTime);
            if (!ObjectUtils.isNullOrEmpty(activityOrderItemDtoList)) {
                secKillSaleProductInventoryService.updateIncreaseRemainCountBatch(activityOrderItemDtoList, operationTime);
            }
        }
        updateCouponStatusForCancelOrder(saleOrderNo, operationTime);
        updateVoucherStatusForCancelOrder(saleOrderNo, operationTime);
    }

    // 订单状态为待发货状态时,取消订单
    private void updateOrderStatusCancelForReceive(String saleOrderNo, String cancelTypeCode, String cancelReason,
            String operationDesc, Integer cancelUserId, Integer buyerCustomerId, Date operationTime, boolean isPaid) {
        String updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING;
        if (!isPaid) {
            updateStatus = SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL;
        }
        // 修改订单表中状态为已取消
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForReceiveCancel(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE, updateStatus, cancelTypeCode, cancelReason,
                operationTime, cancelUserId);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderCancelHistory = new SaleOrderHistory();
        saleOrderCancelHistory.setSaleOrderNo(saleOrderNo);
        saleOrderCancelHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL);
        saleOrderCancelHistory.setOperationDesc(operationDesc);
        saleOrderCancelHistory.setOperateUserId(cancelUserId);
        saleOrderCancelHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderCancelHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
        if (isPaid) {
            // 保存订单状态变更记录(订单退款中)
            SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
            saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
            saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
            saleOrderRefundHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_REFUNDING_DESC);
            saleOrderRefundHistory.setOperateUserId(cancelUserId);
            saleOrderRefundHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            saleOrderHistoryMapper.save(saleOrderRefundHistory);
            // 生成退款信息并记录退款变更记录
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("该订单不存在");
            }
            RefundApplyDto refundApplyDto = new RefundApplyDto();
            refundApplyDto.setApplyUserId(cancelUserId);
            refundApplyDto.setBuyerCustomerId(buyerCustomerId);
            refundApplyDto.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            refundApplyDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
            refundApplyDto.setStoreId(saleOrderDto.getStoreId());
            refundApplyDto.setStatusCode(SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING);
            refundApplyDto.setApplyTime(operationTime);
            refundApplyDto.setOperationTime(operationTime);
            refundApplyDto.setOperationUserId(cancelUserId);
            refundApplyService.save(refundApplyDto);

            // 保存订单退款表
            OrderRefund orderRefund = new OrderRefund();
            orderRefund.setCreateTime(operationTime);
            orderRefund.setCreateUserId(cancelUserId);
            orderRefund.setPayPlatformCode(saleOrderDto.getPayPlatformCode());
            orderRefund.setRefundAmount(saleOrderDto.getOrderTotalAmount());
            orderRefund.setRefundReason(operationDesc);
            orderRefund.setRefundWay(SystemContext.OrderDomain.ORDERREFUNDWAY_WEEK);
            orderRefund.setSaleOrderNo(saleOrderNo);
            orderRefund.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundMapper.save(orderRefund);

            OrderRefundStatusHistory orderRefundStatusHistory = new OrderRefundStatusHistory();
            orderRefundStatusHistory.setCreateTime(operationTime);
            orderRefundStatusHistory.setCreateUserId(cancelUserId);
            orderRefundStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundStatusHistory.setOperateTime(operationTime);
            orderRefundStatusHistory.setOperateUserId(cancelUserId);
            orderRefundStatusHistory.setOperationDesc(ORDER_REFUND_APPLY_DESC);
            orderRefundStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_APPLY);
            orderRefundStatusHistoryMapper.save(orderRefundStatusHistory);

            OrderRefundStatusHistory orderRefundingStatusHistory = new OrderRefundStatusHistory();
            orderRefundingStatusHistory.setCreateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setCreateUserId(cancelUserId);
            orderRefundingStatusHistory.setSaleOrderNo(saleOrderNo);
            orderRefundingStatusHistory.setOperateTime(DateUtils.addSeconds(operationTime, 1));
            orderRefundingStatusHistory.setOperateUserId(cancelUserId);
            orderRefundingStatusHistory.setOperationDesc(ORDER_REFUNDING_DESC);
            orderRefundingStatusHistory.setStatus(SystemContext.OrderDomain.ORDERREFUNDSTATUS_REFUNDING);
            orderRefundStatusHistoryMapper.save(orderRefundingStatusHistory);
        }
        // 生成入库记录
        stockInService.saveStockInBySaleOrderNo(saleOrderNo);
        // 更新商品库存并记录库存变更记录
        List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
        List<CreateOrderItemDto> activityOrderItemDtoList = new ArrayList<CreateOrderItemDto>();
        if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
            List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
            for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(saleOrderItemDto.getSaleProductId(),
                        saleOrderItemDto.getQuantity());
                pairs.add(pair);
                if (!ObjectUtils.isNullOrEmpty(saleOrderItemDto.getActivityId())
                        && saleOrderItemDto.getActivityId().intValue() > 0) {
                    CreateOrderItemDto createOrderItemDto = new CreateOrderItemDto();
                    createOrderItemDto.setActId(saleOrderItemDto.getActivityId());
                    createOrderItemDto.setCartNum(saleOrderItemDto.getQuantity());
                    createOrderItemDto.setSaleProductId(saleOrderItemDto.getSaleProductId());
                    activityOrderItemDtoList.add(createOrderItemDto);
                }
            }
            List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(saleOrderNo,
                    SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT, null, null);
            if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(orderGiftInfo.getGiftId(),
                            orderGiftInfo.getGiftCount());
                    pairs.add(pair);
                }

            }
            saleProductInventoryService.updateInventoryForReceiveCancel(pairs, saleOrderNo, cancelUserId, operationTime);
            if (!ObjectUtils.isNullOrEmpty(activityOrderItemDtoList)) {
                secKillSaleProductInventoryService.updateIncreaseRemainCountBatch(activityOrderItemDtoList, operationTime);
            }
        }
        updateCouponStatusForCancelOrder(saleOrderNo, operationTime);
        updateVoucherStatusForCancelOrder(saleOrderNo, operationTime);
    }

    @Override
    public void updateOrderConfirm(String saleOrderNo, Integer userId) throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单编号不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            updateOrderStatusForFinished(saleOrderNo, userId, new Date());
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    private void updateOrderStatusForFinished(String saleOrderNo, Integer userId, Date operationTime) {
        SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
        if (null == saleOrderDto) {
            throw new OrderServiceException("该订单不存在");
        }
        // 修改订单表中状态为交易完成
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForFinished(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE, SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED,
                SystemContext.OrderDomain.SALEORDERTAKESTATUS_RECEIVED, userId, operationTime);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态[交易完成]异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderConfirmReceiveHistory = new SaleOrderHistory();
        saleOrderConfirmReceiveHistory.setSaleOrderNo(saleOrderNo);
        saleOrderConfirmReceiveHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
        if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
            String customerHotline = StringUtils.defaultIfBlank(
                    super.getSystemParamValue(SystemContext.SystemParams.CUSTOMER_HOTLINE),
                    CommonConstants.CUSTOMER_HOTLINE_DEFAULT);
            saleOrderConfirmReceiveHistory
                    .setOperationDesc(CommonConstants.SALEORDERSTATUS_PICKUP_DESC.replace("{0}", customerHotline));
        } else {
            saleOrderConfirmReceiveHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_FINISHED_DESC);
        }
        saleOrderConfirmReceiveHistory.setOperateUserId(userId);
        saleOrderConfirmReceiveHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderConfirmReceiveHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
    }

    @Override
    public void updateOrderStatusForAppraise(String saleOrderNo, Integer userId) throws OrderServiceException {
        try {
            if (StringUtils.isEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单编号不能为空");
            }
            if (null == userId) {
                throw new OrderServiceException("用户不能为空");
            }
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto) {
                throw new OrderServiceException("该订单不存在");
            }
            // 修改订单表中状态为已评价
            Integer affectedCount = 0;
            Date operationTime = new Date();
            affectedCount = saleOrderMapper.updateOrderStatusForAppraise(saleOrderNo,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED, SystemContext.OrderDomain.APPRAISEFLAG_YES, userId,
                    operationTime);
            if (affectedCount != 1) {
                throw new OrderServiceException("修改订单状态[已评价]异常");
            }
            // 保存订单状态历史记录
            /*
             * SaleOrderHistory saleOrderAppraiseHistory = new
             * SaleOrderHistory();
             * saleOrderAppraiseHistory.setSaleOrderNo(saleOrderNo);
             * saleOrderAppraiseHistory.setOrderStatus(SystemContext.OrderDomain
             * .SALEORDERSTATUS_APPRAISE);
             * saleOrderAppraiseHistory.setOperationDesc(CommonConstants.
             * SALEORDERSTATUS_APPRAISE_DESC);
             * saleOrderAppraiseHistory.setOperateUserId(userId);
             * saleOrderAppraiseHistory.setOperateTime(operationTime);
             * affectedCount =
             * saleOrderHistoryMapper.save(saleOrderAppraiseHistory); if
             * (affectedCount != 1) { throw new
             * OrderServiceException("保存订单状态历史记录异常"); }
             */
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    // 退款审核成功,修改状态为退款成功
    private void updateOrderStatusForRefundSuccess(String saleOrderNo, Integer userId, Date operationTime) {
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForRefundSuccess(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING, SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS,
                userId, operationTime);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态[退款成功]异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
        saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
        saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
        saleOrderRefundHistory.setOperationDesc(
                CommonConstants.SALEORDERSTATUS_REFUNDSUCCESS_DESC.replace("{0}", DateUtils.formatDateLong(operationTime)));
        saleOrderRefundHistory.setOperateUserId(userId);
        saleOrderRefundHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderRefundHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
    }

    // 退款审核失败,修改状态为退款失败
    private void updateOrderStatusForRefundFailure(String saleOrderNo, String refundFailureReason, Integer userId,
            Date operationTime) {
        Integer affectedCount = 0;
        affectedCount = saleOrderMapper.updateOrderStatusForRefundFailure(saleOrderNo,
                SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING, SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE,
                refundFailureReason, userId, operationTime);
        if (affectedCount != 1) {
            throw new OrderServiceException("修改订单状态[退款失败]异常");
        }
        // 保存订单状态历史记录
        SaleOrderHistory saleOrderRefundHistory = new SaleOrderHistory();
        saleOrderRefundHistory.setSaleOrderNo(saleOrderNo);
        saleOrderRefundHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE);
        saleOrderRefundHistory.setOperationDesc(refundFailureReason);
        saleOrderRefundHistory.setOperateUserId(userId);
        saleOrderRefundHistory.setOperateTime(operationTime);
        affectedCount = saleOrderHistoryMapper.save(saleOrderRefundHistory);
        if (affectedCount != 1) {
            throw new OrderServiceException("保存订单状态历史记录异常");
        }
    }

    @Override
    public Integer updateForSellerSend(String saleOrderNo, Integer storeId, String storePhoneNo, String sendStatus,
            Integer sendUserId, Date sendTime) throws OrderServiceException {
        try {
            // 验证该订单是否是属于卖家自己的订单
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto || storeId.intValue() != saleOrderDto.getStoreId().intValue()) {
                throw new OrderServiceException("该订单不存在");
            }
            // 根据当前订单是否是“等待卖家发货”订单验证是否可以进行发货操作
            int affectedCount = this.updateOrderStatusForSellerSend(saleOrderNo, saleOrderDto.getOrderCount(), sendStatus,
                    sendTime, sendUserId);
            if (1 != affectedCount) {
                throw new OrderServiceException("当前订单状态不是等待卖家发货，无法发货");
            }
            if (!SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                // 保存订单状态变更记录
                SaleOrderHistory saleOrderSendHistory = new SaleOrderHistory();
                saleOrderSendHistory.setSaleOrderNo(saleOrderNo);
                saleOrderSendHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
                saleOrderSendHistory
                        .setOperationDesc(CommonConstants.SALEORDERSTATUS_FORRECEIVE_DESC.replace("{0}", storePhoneNo));
                saleOrderSendHistory.setOperateUserId(sendUserId);
                saleOrderSendHistory.setOperateTime(sendTime);
                saleOrderHistoryMapper.save(saleOrderSendHistory);
            }
            // 生成出库单
            stockOutService.saveStockOutBySaleOrderNo(saleOrderNo);
            // 更新商品库存并记录库存变更记录
            List<SaleOrderItemDto> saleOrderItemDtoList = saleOrderItemService.listBySaleOrderNo(saleOrderNo);
            if (!ObjectUtils.isNullOrEmpty(saleOrderItemDtoList)) {
                List<KeyValuePair<Integer, Integer>> pairs = new ArrayList<KeyValuePair<Integer, Integer>>();
                for (SaleOrderItemDto saleOrderItemDto : saleOrderItemDtoList) {
                    KeyValuePair<Integer, Integer> pair = new KeyValuePair<Integer, Integer>(
                            saleOrderItemDto.getSaleProductId(), saleOrderItemDto.getQuantity());
                    pairs.add(pair);
                }
                saleProductInventoryService.updateInventoryForSellerSend(pairs, saleOrderNo, sendUserId, sendTime);
            }
            return saleOrderDto.getId();
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "订单发货出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public int updateOrderStatusForSellerSend(String saleOrderNo, Integer sendCount, String sendStatus, Date sendTime,
            Integer sendUserId) throws OrderServiceException {
        try {
            int affectedCount = saleOrderMapper.updateOrderStatusForSellerSend(saleOrderNo,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND, SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE,
                    sendCount, sendStatus, sendTime, sendUserId);
            return affectedCount;
        } catch (Exception e) {
            String msg = "发货时改变订单状态出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Integer updateForSellerConfirmReceive(String saleOrderNo, String receiveNo, Integer storeId, String takeStatus,
            Integer takeUserId, Date takeTime) throws OrderServiceException {
        try {
            // 验证该订单是否是属于卖家自己的订单
            SaleOrderDto saleOrderDto = this.loadBySaleOrderNo(saleOrderNo);
            if (null == saleOrderDto || storeId.intValue() != saleOrderDto.getStoreId().intValue()) {
                throw new OrderServiceException("该订单不存在");
            }
            // 根据当前订单是否是“等待买家收货”订单验证是否可以进行确认收货操作
            int affectedCount = this.updateOrderStatusForSellerConfirmReceive(saleOrderNo, receiveNo, takeStatus, takeTime,
                    takeUserId);
            if (1 != affectedCount) {
                throw new OrderServiceException("当前订单状态不是等待买家收货，无法确认收货");
            }
            // 保存订单状态变更记录
            SaleOrderHistory saleOrderConfirmReceiveHistory = new SaleOrderHistory();
            saleOrderConfirmReceiveHistory.setSaleOrderNo(saleOrderNo);
            saleOrderConfirmReceiveHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            saleOrderConfirmReceiveHistory.setOperateUserId(takeUserId);
            saleOrderConfirmReceiveHistory.setOperateTime(takeTime);
            if (SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(saleOrderDto.getDeliveryMode())) {
                String customerHotline = StringUtils
                        .isEmpty(super.getSystemParamValue(SystemContext.SystemParams.CUSTOMER_HOTLINE))
                                ? CommonConstants.CUSTOMER_HOTLINE_DEFAULT
                                : super.getSystemParamValue(SystemContext.SystemParams.CUSTOMER_HOTLINE);
                saleOrderConfirmReceiveHistory
                        .setOperationDesc(CommonConstants.SALEORDERSTATUS_PICKUP_DESC.replace("{0}", customerHotline));
            } else {
                saleOrderConfirmReceiveHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_FINISHED_DESC);
            }
            saleOrderHistoryMapper.save(saleOrderConfirmReceiveHistory);
            return saleOrderDto.getId();
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "确认收货出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public int updateOrderStatusForSellerConfirmReceive(String saleOrderNo, String receiveNo, String takeStatus,
            Date takeTime, Integer takeUserId) throws OrderServiceException {
        try {
            int affectedCount = saleOrderMapper.updateOrderStatusForSellerConfirmReceive(saleOrderNo, receiveNo,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE, SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED,
                    takeStatus, takeTime, takeUserId);
            return affectedCount;
        } catch (Exception e) {
            String msg = "确认收货时改变订单状态出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Long getTotalCommissionAmountByTimes(Integer storeId, Date beginDate, Date endDate) throws OrderServiceException {
        try {
            Long totalCommissionAmount = saleOrderMapper.getTotalCommissionAmountByTimes(storeId,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED, beginDate, endDate);
            return totalCommissionAmount;
        } catch (Exception e) {
            String msg = "获取某一时间段内销售佣金总费用出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Integer getTotalCommissionCountByTimes(Integer storeId, Date beginDate, Date endDate)
            throws OrderServiceException {
        try {
            Integer totalCommissionCount = saleOrderMapper.getTotalCommissionCountByTimes(storeId,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED, beginDate, endDate);
            return totalCommissionCount;
        } catch (Exception e) {
            String msg = "获取卖家某一时间段内应结算订单总数量出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public Integer getFinishOrderCountByTimes(Integer storeId, Date beginDate, Date endDate) throws OrderServiceException {
        try {
            return this.saleOrderMapper.getFinishOrderCountByTimes(storeId,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED, beginDate, endDate);
        } catch (Exception e) {
            String msg = "获取某一时间段内所完成订单笔数出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<SettleDetailDto> findSettleDetails(SettleDetailQueryDto settleDetailQueryDto)
            throws OrderServiceException {
        try {
            if (null == settleDetailQueryDto.getStart() || settleDetailQueryDto.getStart() <= 0) {
                settleDetailQueryDto.setStart(1);
            }
            if (null == settleDetailQueryDto.getPageSize() || settleDetailQueryDto.getPageSize() <= 0) {
                settleDetailQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            SettleDetailQuery settleDetailQuery = new SettleDetailQuery();
            ObjectUtils.fastCopy(settleDetailQueryDto, settleDetailQuery);
            PageHelper.startPage(settleDetailQuery.getStart(), settleDetailQuery.getPageSize());
            Page<SettleDetailInfo> page = this.saleOrderMapper.findSettleDetails(settleDetailQuery);
            Page<SettleDetailDto> pageDto = new Page<SettleDetailDto>(settleDetailQueryDto.getStart(),
                    settleDetailQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SettleDetailInfo> settleDetailInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(settleDetailInfos)) {
                for (SettleDetailInfo settleDetailInfo : settleDetailInfos) {
                    SettleDetailDto settleDetailDto = new SettleDetailDto();
                    ObjectUtils.fastCopy(settleDetailInfo, settleDetailDto);
                    pageDto.add(settleDetailDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "分页获取订单结算统计详细信息出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public String getSaleOrderNoBySellerWithReceiveCode(Integer storeId, String receiveCode) throws OrderServiceException {
        try {
            String saleOrderNo = null;
            saleOrderNo = this.saleOrderMapper.getSaleOrderNoByStoreIdAndReceiveCodeAndStatusCodes(storeId, receiveCode,
                    Arrays.asList(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE));
            return saleOrderNo;
        } catch (Exception e) {
            String msg = "卖家利用收货码获取订单编号出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void updateOrderOnlinePay(String payLogOrderNo, String paySequence, String payerId, String payerEmail)
            throws OrderServiceException {
        try {
            if (StringUtils.isBlank(payLogOrderNo)) {
                throw new OrderServiceException("支付日志编码不能为空");
            }
            PayLogDto payLogDto = payLogService.loadByPayLogOrderNo(payLogOrderNo);
            if (ObjectUtils.isNullOrEmpty(payLogDto)) {
                throw new OrderServiceException("支付日志信息不存在");
            }
            // 更新支付日志信息
            Date nowDate = new Date();
            payLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_PAYSECCEED);
            payLogDto.setPaySequence(paySequence);
            payLogDto.setPayerId(payerId);
            payLogDto.setPayerEmail(payerEmail);
            payLogDto.setUpdateTime(nowDate);
            payLogService.updatePayLogForNotify(payLogDto, payLogOrderNo);

            // 查询订单信息
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(payLogDto.getSaleOrderNo());
            if (ObjectUtils.isNullOrEmpty(saleOrder)) {
                throw new OrderServiceException("该订单不存在");
            }
            // 更新订单状态
            int effectCount = saleOrderMapper.updateOrderStatusForPaid(saleOrder.getSaleOrderNo(),
                    SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY, SystemContext.OrderDomain.SALEORDERSTATUS_PAID,
                    SystemContext.OrderDomain.SALEORDERPAYSTATUS_PAID, nowDate, payLogDto.getPayPlatformCode());
            if (1 != effectCount) {
                throw new OrderServiceException("当前订单状态不是等待买家付款，无法支付");
            }

            // 保存订单状态变更记录
            SaleOrderHistory saleOrderPaidHistory = new SaleOrderHistory();
            saleOrderPaidHistory.setSaleOrderNo(saleOrder.getSaleOrderNo());
            saleOrderPaidHistory.setOrderStatus(SystemContext.OrderDomain.SALEORDERSTATUS_PAID);
            saleOrderPaidHistory.setOperationDesc(CommonConstants.SALEORDERSTATUS_PAID_DESC);
            saleOrderPaidHistory.setOperateUserId(payLogDto.getCreateUserId());
            saleOrderPaidHistory.setOperateTime(nowDate);
            effectCount = saleOrderHistoryMapper.save(saleOrderPaidHistory);
            if (1 != effectCount) {
                throw new OrderServiceException("保存订单状态历史记录失败");
            }
            // 保存订单支付记录信息
            OrderPayment orderPayment = new OrderPayment();
            orderPayment.setSaleOrderNo(saleOrder.getSaleOrderNo());
            orderPayment.setCreateTime(nowDate);
            orderPayment.setCreateUserId(payLogDto.getCreateUserId());
            if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXIN.equals(payLogDto.getPayPlatformCode())) {
                orderPayment.setPayTypeCode(SystemContext.OrderDomain.ORDERPAYMENTPAYTYPE_WXPAY);
            } else if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_ALIPAY.equals(payLogDto.getPayPlatformCode())) {
                orderPayment.setPayTypeCode(SystemContext.OrderDomain.ORDERPAYMENTPAYTYPE_ALIPAY);
            } else if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXINPUBLIC.equals(payLogDto.getPayPlatformCode())) {
                orderPayment.setPayTypeCode(SystemContext.OrderDomain.ORDERPAYMENTPAYTYPE_WXPAYPUBLIC);
            }
            orderPayment.setSeriesNo(paySequence);
            orderPayment.setPayAmount(payLogDto.getPayPrice());
            effectCount = orderPaymentMapper.save(orderPayment);
            if (1 != effectCount) {
                throw new OrderServiceException("保存订单支付记录失败");
            }
            CustomerProxyDto customerProxyDto = customerProxyService.loadCustomerInfoByUserId(payLogDto.getUserId());
            if (ObjectUtils.isNullOrEmpty(customerProxyDto)) {
                throw new OrderServiceException("客户不存在");
            }
            Integer customerId = customerProxyDto.getCustomerId();
            List<Integer> saleProductIds = new ArrayList<Integer>();
            List<SaleOrderItem> saleOrderItemList = saleOrderItemMapper.listBySaleOrderNo(saleOrder.getSaleOrderNo());
            for (SaleOrderItem saleOrderItem : saleOrderItemList) {
                saleProductIds.add(saleOrderItem.getSaleProductId());
            }
            List<SaleProductProxyDto> saleProductProxyDtos = productProxyService
                    .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
            Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
            for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtos) {
                saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
            }
            Integer commissionCount = 0;
            Long commissionAmount = 0L;
            for (SaleOrderItem saleOrderItem : saleOrderItemList) {
                SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleOrderItem.getSaleProductId());
                if (ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice()) > 0) {
                    commissionCount += saleOrderItem.getQuantity();
                    commissionAmount += getSystemConfigVipCommissionBase() * saleOrderItem.getQuantity();
                }
            }
            // 开始锁,防止多线程同时处理
            DistributedLockUtils.lock(DISTRIBUTED_FIRSTORDER_LOCK_PREFIX + payLogDto.getUserId());
            if (isVipOrderType(saleOrderItemList, saleOrder.getStoreId(), customerId)) {
                Date vipStartDate = customerProxyDto.getVipExpireDate();
                if (ObjectUtils.isNullOrEmpty(vipStartDate)) {
                    vipStartDate = nowDate;
                }
                // 首单VIP升级会员
                FirstOrderCustomerRec firstOrderCustomerRec = new FirstOrderCustomerRec();
                firstOrderCustomerRec.setBuyerCustomerId(customerId);
                firstOrderCustomerRec.setCreateTime(nowDate);
                firstOrderCustomerRec.setFirstOrderType(SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
                firstOrderCustomerRec.setSaleOrderNo(saleOrder.getSaleOrderNo());
                firstOrderCustomerRec.setCreateUserId(payLogDto.getUserId());
                firstOrderCustomerRecMapper.save(firstOrderCustomerRec);
                Date vipExpireDate = DateUtils.addMonths(vipStartDate,
                        ArithUtils.converStringToInt(
                                super.getSystemParamValue(SystemContext.SystemParams.U_BUYERPRODUCTTO_VIP_EXPIRE_MONTH),
                                BUYERPRODUCTTO_VIP_DEFAULT_EXPIRE_MONTH));
                customerProxyService.updateBuyerLevelCodeById(customerId, SystemContext.UserDomain.BUYERLEVEL_B,
                        vipExpireDate, nowDate, payLogDto.getCreateUserId(), nowDate);
                saleOrderMapper.updateOrderTypeBySaleOrderNo(saleOrder.getSaleOrderNo(),
                        SystemContext.OrderDomain.SALEORDERTYPE_VIP, commissionAmount, commissionCount);
            }
            // 释放锁
            DistributedLockUtils.unlock();
            // 发送付款成功短信
            try {
                StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleOrder.getStoreId());
                if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)
                        && !ObjectUtils.isNullOrEmpty(storeProfileProxyDto.getMobile())) {
                    messageProxyService.systemSendSms(SmsTypeModelClassMapping.ORDERPAYSUCCESS,
                            Arrays.asList(storeProfileProxyDto.getMobile()), saleOrder.getSaleOrderNo());
                }
            } catch (Exception e) {
                logger.error(e, e);
            }
        } catch (Exception e) {
            logger.error("updateSaleOrderForOnlinePay异常", e);
            throw new OrderServiceException(e.getMessage());
        } finally {
            DistributedLockUtils.unlock();
        }
    }

    private boolean isVipOrderType(List<SaleOrderItem> saleOrderItemList, Integer storeId, Integer customerId) {
        if (isOrderIncludeVipProduct(saleOrderItemList, storeId)) {
            FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                    .loadByBuyerCustomerIdAndFirstOrderType(customerId, SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                return true;
            }
        }
        return false;
    }

    private boolean isOrderIncludeVipProduct(List<SaleOrderItem> saleOrderItemList, Integer storeId) {
        List<Integer> vipProductIds = getVipProductIds();
        if (ObjectUtils.isNullOrEmpty(vipProductIds)) {
            return false;
        }
        List<SaleProductProxyDto> saleProductProxyDtoList = productProxyService
                .listSaleProductByProductIdsAndStoreId(vipProductIds, null, null, storeId);
        if (ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
            return false;
        }
        if (ObjectUtils.isNullOrEmpty(saleOrderItemList)) {
            return false;
        }
        List<Integer> vipSaleProductIds = new ArrayList<Integer>();
        for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
            vipSaleProductIds.add(saleProductProxyDto.getId());
        }
        for (SaleOrderItem saleOrderItem : saleOrderItemList) {
            if (vipSaleProductIds.contains(saleOrderItem.getSaleProductId())) {
                return true;
            }
        }
        return false;
    }

    private void cancelVipOrderType(String saleOrderNo, Integer storeId, Integer customerId, Integer operationUserId,
            Date operationDate) throws ParseException {
        List<SaleOrderItem> saleOrderItemList = saleOrderItemMapper.listBySaleOrderNo(saleOrderNo);
        if (!isOrderIncludeVipProduct(saleOrderItemList, storeId)) {
            return;
        }
        FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                .loadByBuyerCustomerIdAndFirstOrderType(customerId, SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
        if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
            return;
        }
        if (!firstOrderCustomerRec.getSaleOrderNo().equals(saleOrderNo)) {
            return;
        }
        CustomerProxyDto customerProxyDto = customerProxyService.loadCustomerInfoById(customerId);
        if (ObjectUtils.isNullOrEmpty(customerProxyDto)) {
            throw new OrderServiceException("客户不存在");
        }
        Date vipExpireDate = customerProxyDto.getVipExpireDate();
        String buyerLevelCode = SystemContext.UserDomain.BUYERLEVEL_A;
        if (!ObjectUtils.isNullOrEmpty(vipExpireDate)) {
            vipExpireDate = DateUtils.addMonths(vipExpireDate,
                    -ArithUtils.converStringToInt(
                            super.getSystemParamValue(SystemContext.SystemParams.U_BUYERPRODUCTTO_VIP_EXPIRE_MONTH),
                            BUYERPRODUCTTO_VIP_DEFAULT_EXPIRE_MONTH));
            vipExpireDate = DateUtils.getSpecificStartDate(vipExpireDate);
            Date nowDate = DateUtils.getSpecificStartDate(new Date());
            if (vipExpireDate.getTime() >= nowDate.getTime()) {
                buyerLevelCode = SystemContext.UserDomain.BUYERLEVEL_B;
            } else {
                vipExpireDate = null;
            }
        }
        List<Integer> saleProductIds = new ArrayList<Integer>();
        for (SaleOrderItem saleOrderItem : saleOrderItemList) {
            saleProductIds.add(saleOrderItem.getSaleProductId());
        }
        List<SaleProductProxyDto> saleProductProxyDtos = productProxyService
                .listSaleProductByIdsAndChannelCode(saleProductIds, null, null, null);
        Map<Integer, SaleProductProxyDto> saleProductProxyDtoMap = new HashMap<Integer, SaleProductProxyDto>();
        for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtos) {
            saleProductProxyDtoMap.put(saleProductProxyDto.getId(), saleProductProxyDto);
        }
        Integer commissionCount = 0;
        Long commissionAmount = 0L;
        for (SaleOrderItem saleOrderItem : saleOrderItemList) {
            SaleProductProxyDto saleProductProxyDto = saleProductProxyDtoMap.get(saleOrderItem.getSaleProductId());
            if (SystemContext.UserDomain.BUYERLEVEL_B.equals(buyerLevelCode)) {
                if (ArithUtils.converLongTolong(saleProductProxyDto.getVipCommissionPrice()) > 0) {
                    commissionCount += saleOrderItem.getQuantity();
                    commissionAmount += saleProductProxyDto.getVipCommissionPrice() * saleOrderItem.getQuantity();
                }
            } else if (SystemContext.UserDomain.BUYERLEVEL_A.equals(buyerLevelCode)) {
                if (ArithUtils.converLongTolong(saleProductProxyDto.getCommissionPrice()) > 0) {
                    commissionCount += saleOrderItem.getQuantity();
                    commissionAmount += saleProductProxyDto.getCommissionPrice() * saleOrderItem.getQuantity();
                }
            }
        }
        firstOrderCustomerRecMapper.deleteByBuyerCustomerIdAndFirstOrderType(customerId,
                SystemContext.OrderDomain.FIRSTORDERTYPE_VIPUPGRADE);
        customerProxyService.updateBuyerLevelCodeById(customerId, buyerLevelCode, vipExpireDate, null, operationUserId,
                operationDate);
        saleOrderMapper.updateOrderTypeBySaleOrderNo(saleOrderNo, SystemContext.OrderDomain.SALEORDERTYPE_ORDINARY,
                commissionAmount, commissionCount);
    }

    @Override
    public List<SaleOrderDto> listOrdersForNeedAutoReceived(String forReceiveStatusCode, Date takeTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(forReceiveStatusCode)) {
                return null;
            }
            Date sendTimeForNeedAutoReceive = DateUtils.addDays(takeTime, -getSystemConfigNeedAutoReceiveIntervalTime());
            List<SaleOrder> saleOrderList = saleOrderMapper.listOrdersForNeedAutoReceived(forReceiveStatusCode,
                    sendTimeForNeedAutoReceive, SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION);
            if (ObjectUtils.isNullOrEmpty(saleOrderList)) {
                return null;
            }
            List<SaleOrderDto> saleOrderDtoList = new ArrayList<SaleOrderDto>();
            for (SaleOrder saleOrder : saleOrderList) {
                SaleOrderDto saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderDto);
                saleOrderDtoList.add(saleOrderDto);
            }
            return saleOrderDtoList;
        } catch (Exception e) {
            String msg = "获取需要自动收货的订单列表出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    private Integer getSystemConfigNeedAutoReceiveIntervalTime() {
        String systemConfigNeedAutoReceiveIntervalTimeStr = super.getSystemParamValue(
                SystemContext.SystemParams.NEED_AUTO_RECEIVE_INTERVAL_TIME);
        systemConfigNeedAutoReceiveIntervalTimeStr = StringUtils.isEmpty(systemConfigNeedAutoReceiveIntervalTimeStr)
                ? NEED_AUTO_RECEIVE_INTERVAL_TIME_DEFAULT : systemConfigNeedAutoReceiveIntervalTimeStr;
        Integer systemConfigNeedAutoReceiveIntervalTime = Integer.parseInt(systemConfigNeedAutoReceiveIntervalTimeStr);
        return systemConfigNeedAutoReceiveIntervalTime;
    }

    private Long getSystemConfigVipCommissionBase() {
        String systemConfigVipCommissionBaseStr = super.getSystemParamValue(
                SystemContext.SystemParams.T_VIP_COMMISSION_BASE);
        systemConfigVipCommissionBaseStr = StringUtils.isEmpty(systemConfigVipCommissionBaseStr) ? VIP_COMMISSION_BASE
                : systemConfigVipCommissionBaseStr;
        Long systemConfigVipCommissionBase = Long.parseLong(systemConfigVipCommissionBaseStr);
        return systemConfigVipCommissionBase;
    }

    @Override
    public List<SaleOrderDto> listOrderByDeliveryModeAndStatusCode(String deliveryMode, String statusCode)
            throws OrderServiceException {
        try {
            List<SaleOrder> saleOrderList = saleOrderMapper.listOrderByDeliveryModeAndStatusCode(deliveryMode, statusCode);
            if (ObjectUtils.isNullOrEmpty(saleOrderList)) {
                return Collections.emptyList();
            }
            List<SaleOrderDto> saleOrderDtoList = new ArrayList<SaleOrderDto>();
            for (SaleOrder saleOrder : saleOrderList) {
                SaleOrderDto saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderDto);
                saleOrderDtoList.add(saleOrderDto);
            }
            return saleOrderDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<RecommendOrderInfoDto> findRecommendOrderInfos(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto)
            throws OrderServiceException {
        try {
            if (null == recommendOrderInfoQueryDto.getStart() || recommendOrderInfoQueryDto.getStart() <= 0) {
                recommendOrderInfoQueryDto.setStart(1);
            }
            if (null == recommendOrderInfoQueryDto.getPageSize() || recommendOrderInfoQueryDto.getPageSize() <= 0) {
                recommendOrderInfoQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            RecommendOrderInfoQuery recommendOrderInfoQuery = new RecommendOrderInfoQuery();
            ObjectUtils.fastCopy(recommendOrderInfoQueryDto, recommendOrderInfoQuery);
            PageHelper.startPage(recommendOrderInfoQuery.getStart(), recommendOrderInfoQuery.getPageSize());
            List<String> statusCodes = new ArrayList<String>();
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE);
            Page<RecommendOrderInfo> page = saleOrderMapper.findRecommendOrderInfos(statusCodes, recommendOrderInfoQuery);
            Page<RecommendOrderInfoDto> pageDto = new Page<RecommendOrderInfoDto>(recommendOrderInfoQueryDto.getStart(),
                    recommendOrderInfoQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<RecommendOrderInfo> recommendOrderInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(recommendOrderInfos)) {
                for (RecommendOrderInfo info : recommendOrderInfos) {
                    RecommendOrderInfoDto rDto = new RecommendOrderInfoDto();
                    ObjectUtils.fastCopy(info, rDto);
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FORSEND_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FORRECEIVE_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FINISHED_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_APPRAISE_NAME);
                    }
                    pageDto.add(rDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findRecommendOrderInfos异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportRecommendOrder(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto)
            throws OrderServiceException {
        try {
            RecommendOrderInfoQuery recommendOrderInfoQuery = new RecommendOrderInfoQuery();
            ObjectUtils.fastCopy(recommendOrderInfoQueryDto, recommendOrderInfoQuery);
            List<String> statusCodes = new ArrayList<String>();
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE);
            Long counts = this.saleOrderMapper.getCountsForExportRecommendOrder(statusCodes, recommendOrderInfoQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportRecommendOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<RecommendOrderInfoDto> listDataForExportRecommendOrder(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto,
            Long startLineNum, Integer pageSize) throws OrderServiceException {
        try {
            RecommendOrderInfoQuery recommendOrderInfoQuery = new RecommendOrderInfoQuery();
            ObjectUtils.fastCopy(recommendOrderInfoQueryDto, recommendOrderInfoQuery);
            List<String> statusCodes = new ArrayList<String>();
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE);
            List<RecommendOrderInfo> recommendOrderInfos = saleOrderMapper.listDataForExportRecommendOrder(statusCodes,
                    recommendOrderInfoQuery, startLineNum, pageSize);
            List<RecommendOrderInfoDto> recommendOrderInfoDtos = new ArrayList<RecommendOrderInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(recommendOrderInfos)) {
                for (RecommendOrderInfo info : recommendOrderInfos) {
                    RecommendOrderInfoDto rDto = new RecommendOrderInfoDto();
                    ObjectUtils.fastCopy(info, rDto);
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FORSEND_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FORRECEIVE_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_FINISHED_NAME);
                    }
                    if (SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE.equals(info.getSaleOrderStatus())) {
                        rDto.setSaleOrderStatusName(SALEORDERSTATUS_APPRAISE_NAME);
                    }
                    recommendOrderInfoDtos.add(rDto);
                }
            }
            return recommendOrderInfoDtos;
        } catch (Exception e) {
            logger.error("listDataForExportRecommendOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderItemInfoDto> listSaleOrderItemInfoByOrderNo(String saleOrderNo, List<String> statusCodes)
            throws OrderServiceException {
        try {
            List<SaleOrderItemInfoDto> saleOrderItemInfoDtos = new ArrayList<SaleOrderItemInfoDto>();
            if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
                return saleOrderItemInfoDtos;
            }
            if (ObjectUtils.isNullOrEmpty(statusCodes)) {
                statusCodes = null;
            }
            List<SaleOrderItemInfo> saleOrderItemInfos = saleOrderMapper.listSaleOrderItemInfoByOrderNo(saleOrderNo,
                    statusCodes);
            if (ObjectUtils.isNullOrEmpty(saleOrderItemInfos)) {
                return saleOrderItemInfoDtos;
            }
            for (SaleOrderItemInfo saleOrderItemInfo : saleOrderItemInfos) {
                SaleOrderItemInfoDto saleOrderItemInfoDto = new SaleOrderItemInfoDto();
                ObjectUtils.fastCopy(saleOrderItemInfo, saleOrderItemInfoDto);
                saleOrderItemInfoDtos.add(saleOrderItemInfoDto);
            }
            return saleOrderItemInfoDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleOrderDto> getChildAccountOrder(SaleOrderQueryDto saleOrderQueryDto) {
        if (null == saleOrderQueryDto.getStart() || saleOrderQueryDto.getStart() <= 0) {
            saleOrderQueryDto.setStart(1);
        }
        if (null == saleOrderQueryDto.getPageSize() || saleOrderQueryDto.getPageSize() <= 0) {
            saleOrderQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
        }
        SaleOrderQuery saleOrderQuery = new SaleOrderQuery();
        ObjectUtils.fastCopy(saleOrderQueryDto, saleOrderQuery);
        PageHelper.startPage(saleOrderQuery.getStart(), saleOrderQuery.getPageSize());
        Page<SaleOrder> page = saleOrderMapper.findChildAccountOrder(saleOrderQuery);
        Page<SaleOrderDto> pageDto = new Page<SaleOrderDto>(saleOrderQueryDto.getStart(), saleOrderQueryDto.getPageSize());
        List<SaleOrder> saleOrderList = page.getResult();
        SaleOrderDto saleOrderDto = null;
        if (!ObjectUtils.isNullOrEmpty(saleOrderList)) {
            UserProxyDto userProxyDto = null;
            for (SaleOrder saleOrder : saleOrderList) {
                saleOrderDto = new SaleOrderDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderDto);
                userProxyDto = userProxyService.getUserById(saleOrderDto.getAcceptUserId());
                if (!ObjectUtils.isNullOrEmpty(userProxyDto)) {
                    saleOrderDto.setAcceptAccount(userProxyDto.getUserName());
                }
                userProxyDto = userProxyService.getUserById(saleOrderDto.getUserId());
                if (!ObjectUtils.isNullOrEmpty(userProxyDto)) {
                    saleOrderDto.setBuyerUserName(userProxyDto.getRealName());
                }

                if (saleOrderDto.getStatusCode().equals(SaleOrderStatusMapping.FORSEND.getCode())) {
                    saleOrderDto.setStatusName("待发货");
                    saleOrderDto.setDisposeTime(saleOrderDto.getAcceptTime());
                } else if (saleOrderDto.getStatusCode().equals(SaleOrderStatusMapping.FORRECEIVE.getCode())) {
                    saleOrderDto.setStatusName("待确认");
                    saleOrderDto.setDisposeTime(saleOrderDto.getSendTime());
                } else if (saleOrderDto.getStatusCode().equals(SaleOrderStatusMapping.FINISHED.getCode())) {
                    saleOrderDto.setStatusName("已完成");
                    saleOrderDto.setDisposeTime(saleOrderDto.getTakeTime());
                }
                pageDto.add(saleOrderDto);
            }
        }
        return YiLiDiPageUtils.encapsulatePageResult(pageDto);
    }

}
