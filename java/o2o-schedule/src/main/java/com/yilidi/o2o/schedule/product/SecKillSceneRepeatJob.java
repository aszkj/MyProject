package com.yilidi.o2o.schedule.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;

/**
 * 秒杀场次复制定时任务
 * 
 * @author chenb
 * 
 */
public class SecKillSceneRepeatJob {

    private Logger logger = Logger.getLogger(SecKillSceneRepeatJob.class);

    @Autowired
    private ISecKillSceneService secKillSceneService;

    protected synchronized void performance() {
        try {
            logger.info("===============秒杀场次复制定时任务开始===============");
            Date nowTime = new Date();
            Date yesterDate = DateUtils.addDays(nowTime, -1);
            Date startDate = DateUtils.getSpecificStartDate(yesterDate);
            Date endDate = DateUtils.getSpecificEndDate(yesterDate);
            List<SecKillSceneDto> secKillSceneDtos = secKillSceneService.listSecKillSceneForRepeatByDate(startDate, endDate);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDtos)) {
                for (SecKillSceneDto secKillSceneDto : secKillSceneDtos) {
                    try {
                        SecKillSceneDto secKillSceneDtoCopy = new SecKillSceneDto();
                        ObjectUtils.fastCopy(secKillSceneDto, secKillSceneDtoCopy);
                        secKillSceneDtoCopy.setStartTime(DateUtils.addDays(secKillSceneDto.getStartTime(), 1));
                        if (nowTime.before(secKillSceneDtoCopy.getStartTime())) {
                            secKillSceneDtoCopy.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_NOTSTART);
                        } else {
                            secKillSceneDtoCopy.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTED);
                        }
                        secKillSceneDtoCopy.setCreateTime(nowTime);
                        secKillSceneDtoCopy.setCreateUserId(CommonConstants.SYSTEM_USER_ID);
                        secKillSceneDtoCopy.setUpdateTime(nowTime);
                        secKillSceneDtoCopy.setUpdateUserId(CommonConstants.SYSTEM_USER_ID);
                        secKillSceneService.saveCopyScene(secKillSceneDtoCopy);
                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
            }
            logger.info("===============秒杀场次复制定时任务结束===============");
        } catch (Exception e) {
            logger.error(e, e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public ISecKillSceneService getSecKillSceneService() {
        return secKillSceneService;
    }

    public void setSecKillSceneService(ISecKillSceneService secKillSceneService) {
        this.secKillSceneService = secKillSceneService;
    }

}
