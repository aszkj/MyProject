package com.yilidi.o2o.schedule.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;

/**
 * 扫描优惠券状态，根据当前时间定时更新其状态
 * 
 * @author: chenlian
 * @date: 2016年10月31日 上午9:46:47
 */
public class CouponStatusJob {

    private Logger logger = Logger.getLogger(CouponStatusJob.class);

    private ICouponService couponService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描优惠券状态，根据当前时间定时更新其状态开始===============");
            Date currentDate = DateUtils.getCurrentDateTime();
            List<String> statusList = new ArrayList<String>();
            statusList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
            statusList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
            List<UserCouponDto> userCouponDtoList = couponService.listCouponsForNeedAutoUpdateStatus(statusList);
            if (ObjectUtils.isNullOrEmpty(userCouponDtoList)) {
                logger.info("没有需要定时更新其状态的优惠券");
                return;
            }
            for (UserCouponDto userCouponDto : userCouponDtoList) {
                try {
                    String status = "";
                    if (SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED.equals(userCouponDto.getStatus())) {
                        if (currentDate.after(userCouponDto.getBeginTime())
                                && currentDate.before(userCouponDto.getEndTime())) {
                            status = SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE;
                        }
                        if (currentDate.after(userCouponDto.getEndTime())) {
                            status = SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED;
                        }
                    }
                    if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE.equals(userCouponDto.getStatus())) {
                        if (currentDate.after(userCouponDto.getEndTime())) {
                            status = SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED;
                        }
                    }
                    if (!StringUtils.isEmpty(status)) {
                        couponService.updateUserCouponStatusById(userCouponDto.getId(), status);
                    }
                } catch (Exception e) {
                    logger.error("定时更新优惠券的状态出现系统异常", e);
                }
            }
            logger.info("===============扫描优惠券状态，根据当前时间定时更新其状态结束===============");
        } catch (Exception e) {
            logger.error("定时更新优惠券的状态出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public ICouponService getCouponService() {
        return couponService;
    }

    public void setCouponService(ICouponService couponService) {
        this.couponService = couponService;
    }

}
