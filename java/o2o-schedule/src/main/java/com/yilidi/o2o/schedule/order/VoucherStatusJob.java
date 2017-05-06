package com.yilidi.o2o.schedule.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.UserVoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;

/**
 * 扫描抵用券状态，根据当前时间定时更新其状态
 * 
 * @author: chenlian
 * @date: 2016年10月31日 上午11:07:59
 */
public class VoucherStatusJob {

    private Logger logger = Logger.getLogger(VoucherStatusJob.class);

    private IVoucherService voucherService;

    protected synchronized void performance() {
        try {
            logger.info("===============扫描抵用券状态，根据当前时间定时更新其状态开始===============");
            Date currentDate = DateUtils.getCurrentDateTime();
            List<String> statusList = new ArrayList<String>();
            statusList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED);
            statusList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE);
            List<UserVoucherDto> userVoucherDtoList = voucherService.listVouchersForNeedAutoUpdateStatus(statusList);
            if (ObjectUtils.isNullOrEmpty(userVoucherDtoList)) {
                logger.info("没有需要定时更新其状态的抵用券");
                return;
            }
            for (UserVoucherDto userVoucherDto : userVoucherDtoList) {
                try {
                    VoucherDto voucherDto = voucherService.loadVoucherById(userVoucherDto.getVouId());
                    if (!ObjectUtils.isNullOrEmpty(voucherDto)) {
                        String status = "";
                        if (SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED.equals(userVoucherDto.getStatus())) {
                            if (currentDate.after(voucherDto.getValidStartTime())
                                    && currentDate.before(voucherDto.getValidEndTime())) {
                                status = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                            }
                            if (currentDate.after(voucherDto.getValidEndTime())) {
                                status = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                            }
                        }
                        if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE.equals(userVoucherDto.getStatus())) {
                            if (currentDate.after(voucherDto.getValidEndTime())) {
                                status = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                            }
                        }
                        if (!StringUtils.isEmpty(status)) {
                            voucherService.updateUserVoucherStatusById(userVoucherDto.getId(), status);
                        }
                    }
                } catch (Exception e) {
                    logger.error("定时更新抵用券的状态出现系统异常", e);
                }
            }
            logger.info("===============扫描抵用券状态，根据当前时间定时更新其状态结束===============");
        } catch (Exception e) {
            logger.error("定时更新抵用券的状态出现系统异常", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IVoucherService getVoucherService() {
        return voucherService;
    }

    public void setVoucherService(IVoucherService voucherService) {
        this.voucherService = voucherService;
    }

}
