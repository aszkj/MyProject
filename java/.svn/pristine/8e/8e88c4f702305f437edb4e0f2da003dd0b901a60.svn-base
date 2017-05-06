package com.yilidi.o2o.schedule.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;

/**
 * 秒杀场次状态更新定时任务
 * 
 * @author chenb
 * 
 */
public class SecKillSceneStatusUpdateJob {

    private Logger logger = Logger.getLogger(SecKillSceneStatusUpdateJob.class);

    @Autowired
    private ISecKillSceneService secKillSceneService;

    protected synchronized void performance() {
        try {
            logger.info("===============秒杀场次状态更新定时任务开始===============");
            Date nowTime = new Date();
            List<SecKillSceneDto> secKillSceneDtos = secKillSceneService.listSecKillSceneBeforOrEqualsStartTime(nowTime, 3);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDtos)) {
                try {
                    if (secKillSceneDtos.size() == 1) {
                        if (secKillSceneDtos.get(0).getEndTime().before(nowTime)) {
                            updateStatusForStarted(secKillSceneDtos.get(0), nowTime);
                        } else {
                            updateStatusForStarting(secKillSceneDtos.get(0), nowTime);
                        }
                    }
                } catch (Exception e) {
                    logger.error(e, e);
                }
                try {
                    if (secKillSceneDtos.size() == 2) {
                        if (secKillSceneDtos.get(0).getEndTime().before(nowTime)) {
                            updateStatusForStarted(secKillSceneDtos.get(0), nowTime);
                            updateStatusForExpired(secKillSceneDtos.get(1), nowTime);
                        } else {
                            updateStatusForStarting(secKillSceneDtos.get(0), nowTime);
                            updateStatusForStarted(secKillSceneDtos.get(1), nowTime);
                        }
                    }
                } catch (Exception e) {
                    logger.error(e, e);
                }
                try {
                    if (secKillSceneDtos.size() == 3) {
                        if (secKillSceneDtos.get(0).getEndTime().before(nowTime)) {
                            updateStatusForStarted(secKillSceneDtos.get(0), nowTime);
                            updateStatusForExpired(secKillSceneDtos.get(1), nowTime);
                        } else {
                            updateStatusForStarting(secKillSceneDtos.get(0), nowTime);
                            updateStatusForStarted(secKillSceneDtos.get(1), nowTime);
                            updateStatusForExpired(secKillSceneDtos.get(2), nowTime);
                        }
                    }
                } catch (Exception e) {
                    logger.error(e, e);
                }
            }
            logger.info("===============秒杀场次状态更新定时任务结束===============");
        } catch (Exception e) {
            logger.error(e, e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    private void updateStatusForStarting(SecKillSceneDto secKillSceneDto, Date operationTime) {
        if (ObjectUtils.isNullOrEmpty(secKillSceneDto)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(operationTime)) {
            operationTime = new Date();
        }
        secKillSceneService.updateStatusCodeById(secKillSceneDto.getId(),
                SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTING, CommonConstants.SYSTEM_USER_ID, operationTime);
    }

    private void updateStatusForStarted(SecKillSceneDto secKillSceneDto, Date operationTime) {
        if (ObjectUtils.isNullOrEmpty(secKillSceneDto)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(operationTime)) {
            operationTime = new Date();
        }
        secKillSceneService.updateStatusCodeById(secKillSceneDto.getId(),
                SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTED, CommonConstants.SYSTEM_USER_ID, operationTime);
    }

    private void updateStatusForExpired(SecKillSceneDto secKillSceneDto, Date operationTime) {
        if (ObjectUtils.isNullOrEmpty(secKillSceneDto)) {
            return;
        }
        if (ObjectUtils.isNullOrEmpty(operationTime)) {
            operationTime = new Date();
        }
        secKillSceneService.updateStatusCodeForExpiredByStartTime(secKillSceneDto.getStartTime(),
                CommonConstants.SYSTEM_USER_ID, operationTime);
    }

    public ISecKillSceneService getSecKillSceneService() {
        return secKillSceneService;
    }

    public void setSecKillSceneService(ISecKillSceneService secKillSceneService) {
        this.secKillSceneService = secKillSceneService;
    }

}
