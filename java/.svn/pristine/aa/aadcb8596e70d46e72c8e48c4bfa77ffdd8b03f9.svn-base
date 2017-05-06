package com.yilidi.o2o.schedule.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;

/**
 * 功能描述：更新买赠活动状态定时任务 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年3月8日
 */
public class BuyRewardActivityStatusUpdateJob {

    private Logger logger = Logger.getLogger(BuyRewardActivityStatusUpdateJob.class);

    private IBuyRewardActivityAuditService buyRewardActivityAuditService;

    protected synchronized void performance() {
        try {
            logger.info("===============更新买赠活动状态任务开始===============");
            Date currentDate = new Date();
            String statusCode = SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED;
            String auditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINISHED;
            List<BuyRewardActivityAuditDto> buyRewardActivityDtos = buyRewardActivityAuditService
                    .listBuyRewardActivityByActivityStatusCode(statusCode, auditStatus);
            int count = 0;
            if (!ObjectUtils.isNullOrEmpty(buyRewardActivityDtos)) {
                for (BuyRewardActivityAuditDto buyRewardActivityDto : buyRewardActivityDtos) {
                    try {
                        if (currentDate.after(buyRewardActivityDto.getActivityEnd())) {
                            buyRewardActivityDto
                                    .setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED);
                            buyRewardActivityAuditService.updateActivityStatus(buyRewardActivityDto.getId(),
                                    buyRewardActivityDto.getStatusCode());
                            count++;
                        } else if (currentDate.before(buyRewardActivityDto.getActivityEnd())
                                && currentDate.after(buyRewardActivityDto.getActivityBegin())
                                && SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_NOTSTART
                                        .equals(buyRewardActivityDto.getStatusCode())) {
                            buyRewardActivityDto
                                    .setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_STARTED);
                            buyRewardActivityAuditService.updateActivityStatus(buyRewardActivityDto.getId(),
                                    buyRewardActivityDto.getStatusCode());
                            count++;
                        }

                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
            }
            logger.info("===============更新买赠活动状态任务结束(更新了" + count + "条)===============");
        } catch (Exception e) {
            logger.error(e, e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IBuyRewardActivityAuditService getBuyRewardActivityService() {
        return buyRewardActivityAuditService;
    }

    public void setBuyRewardActivityService(IBuyRewardActivityAuditService buyRewardActivityAuditService) {
        this.buyRewardActivityAuditService = buyRewardActivityAuditService;
    }
}
