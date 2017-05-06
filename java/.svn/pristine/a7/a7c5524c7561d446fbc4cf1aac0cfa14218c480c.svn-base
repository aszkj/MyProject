package com.yilidi.o2o.schedule.user;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreEvaluationScoreDto;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

/**
 * 店铺评分统计及更新定时任务
 * 
 * @author xiasl
 * 
 */
public class StoreScoreDailyStatisticsJob {

    private Logger logger = Logger.getLogger(StoreScoreDailyStatisticsJob.class);

    private IStoreEvaluationService storeEvaluationService;
    
    private IStoreProfileService storeProfileService;
    
    protected synchronized void performance() {
        try {
            logger.info("===============统计及更新店铺评分任务开始===============");
            Date currentDate = new Date();
            Date yesterDate = DateUtils.addDays(currentDate, -1);
            Date endDate = DateUtils.getSpecificEndDate(yesterDate);
            StoreEvaluateQuery query = new StoreEvaluateQuery();
            query.setEndCreateTime(DateUtils.formatDateLong(endDate));
            List<StoreEvaluationScoreDto>  storeEvaluationScoreDtos = storeEvaluationService.listStoreEvaluations(query);
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationScoreDtos)) {
                for (StoreEvaluationScoreDto storeEvaluationScoreDto : storeEvaluationScoreDtos) {
                    try {
                        storeProfileService.updateStoreScoreByStoreId(storeEvaluationScoreDto.getStoreId(), storeEvaluationScoreDto.getStoreScore());
                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
            }
            logger.info("===============统计及更新店铺评分任务结束===============");
        } catch (Exception e) {
            logger.error(e, e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public IStoreEvaluationService getStoreEvaluationService() {
        return storeEvaluationService;
    }

    public void setStoreEvaluationService(IStoreEvaluationService storeEvaluationService) {
        this.storeEvaluationService = storeEvaluationService;
    }

    public IStoreProfileService getStoreProfileService() {
        return storeProfileService;
    }

    public void setStoreProfileService(IStoreProfileService storeProfileService) {
        this.storeProfileService = storeProfileService;
    }

}
