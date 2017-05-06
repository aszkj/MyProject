package com.yilidi.o2o.schedule.order;

import java.util.Arrays;
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
 * 扫描用户订单状态,自动取消长期未付款和未接单的订单
 * 
 * @author chenb
 * 
 */
public class OrderStatusCancelJob {

    private Logger logger = Logger.getLogger(OrderStatusCancelJob.class);

    private IOrderService orderService;
    private IStoreProfileService storeProfileService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描用户订单状态,取消30分钟内未付款和接单的订单开始===============");
            List<SaleOrderDto> saleOrderDtoList = orderService.listSaleOrderByStatusCodes(Arrays.asList(
                    SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY, SystemContext.OrderDomain.SALEORDERSTATUS_PAID));
            if (ObjectUtils.isNullOrEmpty(saleOrderDtoList)) {
                logger.info("没有需要取消的订单");
                return;
            }
            Date nowTime = new Date();
            for (SaleOrderDto saleOrderDto : saleOrderDtoList) {
                try {
                    Integer storeId = saleOrderDto.getStoreId();
                    StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeId,
                            SystemContext.UserDomain.STORESTATUS_OPEN);
                    if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                        // 店铺不存在或者关闭营业,订单直接取消
                        orderService.updateOrderForSystemCancel(saleOrderDto, nowTime);
                        continue;
                    }
                    Date createOrderTime = saleOrderDto.getCreateTime();
                    String businessHoursStart = storeProfileDto.getBusinessHoursBegin();
                    String businessHoursEnd = storeProfileDto.getBusinessHoursEnd();
                    Calendar createOrderCalendar = Calendar.getInstance();
                    Calendar businessHoursEndCalendar = Calendar.getInstance();
                    Calendar businessHoursStartCalendar = Calendar.getInstance();
                    Calendar currentBusinessEndDate = Calendar.getInstance();
                    Calendar currentBusinessStartDate = Calendar.getInstance();
                    currentBusinessEndDate.setTime(createOrderTime);
                    currentBusinessStartDate.setTime(createOrderTime);
                    
                    businessHoursEndCalendar.setTime(DateUtils.parseDate(businessHoursEnd, "HH:mm"));
                    businessHoursStartCalendar.setTime(DateUtils.parseDate(businessHoursStart, "HH:mm"));
                    
                    createOrderCalendar.setTime(createOrderTime);
                    createOrderCalendar.set(Calendar.SECOND, 0);
                    createOrderCalendar.set(Calendar.MILLISECOND, 0);
                    
                    currentBusinessEndDate.set(Calendar.HOUR_OF_DAY, businessHoursEndCalendar.get(Calendar.HOUR_OF_DAY));
                    currentBusinessEndDate.set(Calendar.MINUTE, businessHoursEndCalendar.get(Calendar.MINUTE));
                    currentBusinessEndDate.set(Calendar.SECOND, 0);
                    currentBusinessEndDate.set(Calendar.MILLISECOND, 0);
                    
                    currentBusinessStartDate.set(Calendar.HOUR_OF_DAY, businessHoursStartCalendar.get(Calendar.HOUR_OF_DAY));
                    currentBusinessStartDate.set(Calendar.MINUTE, businessHoursStartCalendar.get(Calendar.MINUTE));
                    currentBusinessStartDate.set(Calendar.SECOND, 0);
                    currentBusinessStartDate.set(Calendar.MILLISECOND, 0);
                    if (createOrderCalendar.after(currentBusinessEndDate)
                            && SystemContext.OrderDomain.SALEORDERSTATUS_PAID.equals(saleOrderDto.getStatusCode())) {
                        // 当天在营业时间后下单并且付款的第二天处理
                        createOrderCalendar.add(Calendar.DATE, 1);
                        createOrderCalendar.set(Calendar.HOUR_OF_DAY, businessHoursStartCalendar.get(Calendar.HOUR_OF_DAY));
                        createOrderCalendar.set(Calendar.MINUTE, businessHoursStartCalendar.get(Calendar.MINUTE));
                        Calendar nowCalendar = Calendar.getInstance();
                        nowCalendar.setTime(nowTime);
                        if (createOrderCalendar.before(nowCalendar)) {
                            saleOrderDto.setCreateTime(createOrderCalendar.getTime());
                        } else {
                            continue;
                        }
                    } else if (createOrderCalendar.before(currentBusinessStartDate)
                            && SystemContext.OrderDomain.SALEORDERSTATUS_PAID.equals(saleOrderDto.getStatusCode())) {
                        // 当天在营业时间前下单并且付款的营业时间开始后处理
                        createOrderCalendar.set(Calendar.HOUR_OF_DAY, businessHoursStartCalendar.get(Calendar.HOUR_OF_DAY));
                        createOrderCalendar.set(Calendar.MINUTE, businessHoursStartCalendar.get(Calendar.MINUTE));
                        Calendar nowCalendar = Calendar.getInstance();
                        nowCalendar.setTime(nowTime);
                        if (createOrderCalendar.before(nowCalendar)) {
                            saleOrderDto.setCreateTime(createOrderCalendar.getTime());
                        } else {
                            continue;
                        }
                    }
                    orderService.updateOrderForSystemCancel(saleOrderDto, nowTime);
                } catch (Exception e) {
                    logger.error(e, e);
                }
            }
            logger.info("===============扫描用户订单状态,取消30分钟内未付款和接单的订单结束===============");
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
