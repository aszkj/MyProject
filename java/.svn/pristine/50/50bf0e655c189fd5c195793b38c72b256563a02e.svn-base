package com.yilidi.o2o.schedule.user;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;

/**
 * 更新分享规则状态定时任务
 * 
 * @author chenb
 * 
 */
public class ShareRuleStatusUpdatelJob {

    private Logger logger = Logger.getLogger(ShareRuleStatusUpdatelJob.class);

    private IShareRuleService shareRuleService;

    protected synchronized void performance() {
        try {
            logger.info("===============更新分享规则状态定时任务开始===============");
            List<ShareRuleDto> shareRuleDtoList = shareRuleService
                    .listShareRulesByStatus(SystemContext.UserDomain.SHARERULESTATUS_OFF);
            if (!ObjectUtils.isNullOrEmpty(shareRuleDtoList)) {
                Date nowTime = new Date();
                for (ShareRuleDto shareRuleDto : shareRuleDtoList) {
                    try {
                        // 正常
                        if (nowTime.before(shareRuleDto.getStartValidTime())) {
                            shareRuleService.updateStatusById(shareRuleDto.getId(),
                                    SystemContext.UserDomain.SHARERULESTATUS_NORMAL, CommonConstants.SYSTEM_USER_ID,
                                    nowTime);
                        } else if (!nowTime.after(shareRuleDto.getEndValidTime())) {
                            shareRuleService.updateStatusById(shareRuleDto.getId(),
                                    SystemContext.UserDomain.SHARERULESTATUS_ON, CommonConstants.SYSTEM_USER_ID, nowTime);
                        } else {
                            shareRuleService.updateStatusById(shareRuleDto.getId(),
                                    SystemContext.UserDomain.SHARERULESTATUS_OFF, CommonConstants.SYSTEM_USER_ID, nowTime);
                        }
                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
            }
            logger.info("===============更新分享规则状态定时任务结束===============");
        } catch (Exception e) {
            logger.error("更新分享规则状态定时任务失败！", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IShareRuleService getShareRuleService() {
        return shareRuleService;
    }

    public void setShareRuleService(IShareRuleService shareRuleService) {
        this.shareRuleService = shareRuleService;
    }

}
