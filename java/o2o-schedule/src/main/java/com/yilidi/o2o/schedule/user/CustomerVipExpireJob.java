package com.yilidi.o2o.schedule.user;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.dto.CustomerDto;

/**
 * 扫描客户VIP是否过期定时任务
 * 
 * @author chenb
 * 
 */
public class CustomerVipExpireJob {

    private Logger logger = Logger.getLogger(CustomerVipExpireJob.class);

    private ICustomerService customerService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描客户会员过期任务开始===============");
            List<CustomerDto> customerDtoList = customerService.listByCustomerTypeAndBuyerLevelCode(
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER, SystemContext.UserDomain.BUYERLEVEL_B);
            if (!ObjectUtils.isNullOrEmpty(customerDtoList)) {
                Date operationDate = new Date();
                for (CustomerDto customerDto : customerDtoList) {
                    if (SystemContext.UserDomain.CUSTOMERTYPE_BUYER.equals(customerDto.getCustomerType())
                            && SystemContext.UserDomain.BUYERLEVEL_B.equals(customerDto.getBuyerLevelCode())) {
                        Date vipExpireDate = customerDto.getVipExpireDate();
                        if (!ObjectUtils.isNullOrEmpty(vipExpireDate)) {
                            vipExpireDate = DateUtils.addDays(DateUtils.getSpecificStartDate(vipExpireDate), 1);
                        }
                        Date nowDate = DateUtils.getSpecificStartDate(operationDate);
                        if (ObjectUtils.isNullOrEmpty(vipExpireDate) || (nowDate.getTime() - vipExpireDate.getTime()) >= 0) {
                            try {
                                customerService.updateBuyerLevelCodeById(customerDto.getId(),
                                        SystemContext.UserDomain.BUYERLEVEL_A, null, null, CommonConstants.SYSTEM_USER_ID,
                                        nowDate);
                            } catch (Exception e) {
                                logger.error(e, e);
                            }
                        }
                    }
                }
            }
            logger.info("===============扫描客户会员过期任务结束===============");
        } catch (Exception e) {
            logger.error("系统取消订单失败！", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public ICustomerService getCustomerService() {
        return customerService;
    }

    public void setCustomerService(ICustomerService customerService) {
        this.customerService = customerService;
    }

}
