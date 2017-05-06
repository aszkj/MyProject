package com.yilidi.o2o.schedule.order;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.user.service.IUserShareService;

/**
 * 扫描用户订单状态,自动收货长期未收货的订单
 * 
 * @author: chenlian
 * @date: 2016年7月20日 上午9:21:41
 */
public class OrderStatusFinishedJob {

    private Logger logger = Logger.getLogger(OrderStatusFinishedJob.class);

    private IOrderService orderService;
    private IUserShareService userShareService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描用户订单状态,自动收货长期未收货的订单开始===============");
            Date currentDate = DateUtils.getCurrentDateTime();
            List<SaleOrderDto> saleOrderDtoList = orderService
                    .listOrdersForNeedAutoReceived(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE, currentDate);
            if (ObjectUtils.isNullOrEmpty(saleOrderDtoList)) {
                logger.info("没有需要自动收货的订单");
                return;
            }
            for (SaleOrderDto saleOrderDto : saleOrderDtoList) {
                try {
                    orderService.updateForSellerConfirmReceive(saleOrderDto.getSaleOrderNo(), saleOrderDto.getReceiveCode(),
                            saleOrderDto.getStoreId(), SystemContext.OrderDomain.SALEORDERTAKESTATUS_RECEIVED,
                            CommonConstants.SYSTEM_USER_ID, currentDate);
                    // 发送用户分享下单奖励消息
                    userShareService.sendUserShareAwardMessage(saleOrderDto.getUserId(), currentDate,
                            saleOrderDto.getSaleOrderNo(), SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_PRODUCT);
                    userShareService.sendUserShareAwardMessage(saleOrderDto.getUserId(), currentDate,
                            saleOrderDto.getSaleOrderNo(), SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_ANYORDER);
                } catch (Exception e) {
                    logger.error("系统自动收货出现系统异常", e);
                }
            }
            logger.info("===============扫描用户订单状态,自动收货长期未收货的订单结束===============");
        } catch (Exception e) {
            logger.error("系统自动收货出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IOrderService getOrderService() {
        return orderService;
    }

    public void setOrderService(IOrderService orderService) {
        this.orderService = orderService;
    }

}
