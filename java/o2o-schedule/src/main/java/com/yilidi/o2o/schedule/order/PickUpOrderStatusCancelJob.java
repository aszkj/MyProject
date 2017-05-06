package com.yilidi.o2o.schedule.order;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 扫描自提订单在营业时间内没有提货自动取消
 * 
 * @author chenb
 * 
 */
public class PickUpOrderStatusCancelJob {

    private Logger logger = Logger.getLogger(PickUpOrderStatusCancelJob.class);

    private IOrderService orderService;
    private IStoreProfileService storeProfileService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描自提订单在营业时间内没有提货自动取消开始===============");
            List<SaleOrderDto> saleOrderDtoList = orderService.listOrderByDeliveryModeAndStatusCode(
                    SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP,
                    SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            if (ObjectUtils.isNullOrEmpty(saleOrderDtoList)) {
                logger.info("没有需要取消的订单,扫描结束");
                return;
            }
            Date nowTime = new Date();
            for (SaleOrderDto saleOrderDto : saleOrderDtoList) {
                try {
                    Integer storeId = saleOrderDto.getStoreId();
                    StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeId,
                            SystemContext.UserDomain.STORESTATUS_OPEN);
                    if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                        // 店铺不存在或者关闭营业,自提订单直接取消
                        orderService.updateOrderForSystemCancel(saleOrderDto, nowTime);
                        continue;
                    }

                    Date createOrderTime = saleOrderDto.getCreateTime();
                    String businessHoursEnd = storeProfileDto.getBusinessHoursEnd();
                    Calendar createOrderCalendar = Calendar.getInstance();
                    Calendar businessHoursEndCalendar = Calendar.getInstance();
                    Calendar currentDate = Calendar.getInstance();
                    currentDate.setTime(nowTime);
                    currentDate.set(Calendar.SECOND, 0);
                    currentDate.set(Calendar.MILLISECOND, 0);
                    businessHoursEndCalendar.setTime(DateUtils.parseDate(businessHoursEnd, "HH:mm"));
                    createOrderCalendar.setTime(createOrderTime);
                    createOrderCalendar.set(Calendar.HOUR_OF_DAY, businessHoursEndCalendar.get(Calendar.HOUR_OF_DAY));
                    createOrderCalendar.set(Calendar.MINUTE, businessHoursEndCalendar.get(Calendar.MINUTE));
                    createOrderCalendar.set(Calendar.SECOND, 0);
                    createOrderCalendar.set(Calendar.MILLISECOND, 0);
                    createOrderCalendar.add(Calendar.DATE, 1);
                    if (createOrderCalendar.before(currentDate)) {
                        orderService.updateOrderForSystemCancel(saleOrderDto, nowTime);
                    }
                } catch (Exception e) {
                    logger.error(e, e);
                }
            }
            logger.info("===============扫描自提订单在营业时间内没有提货自动取消结束===============");
        } catch (Exception e) {
            logger.error("系统取消订单失败！", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IOrderService getOrderService() {
        return orderService;
    }

    public void setOrderService(IOrderService orderService) {
        this.orderService = orderService;
    }

    public IStoreProfileService getStoreProfileService() {
        return storeProfileService;
    }

    public void setStoreProfileService(IStoreProfileService storeProfileService) {
        this.storeProfileService = storeProfileService;
    }

}
