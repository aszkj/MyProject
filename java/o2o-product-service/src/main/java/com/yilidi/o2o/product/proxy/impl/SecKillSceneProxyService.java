/**
 * 文件名称：ProductProxySerivce.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.proxy.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SecKillSceneMapper;
import com.yilidi.o2o.product.model.SecKillScene;
import com.yilidi.o2o.product.proxy.ISecKillSceneProxyService;
import com.yilidi.o2o.product.proxy.dto.SecKillSceneProxyDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述：秒杀商品代理服务接口实现 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("secKillSceneProxyService")
public class SecKillSceneProxyService extends BasicDataService implements ISecKillSceneProxyService {

    @Autowired
    private SecKillSceneMapper secKillSceneMapper;

    @Override
    public List<SecKillSceneProxyDto> listStartedAndStaring(Date currentTime) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listBeforeOrEqualsByCurrentTime(currentTime, 2);
            if (ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                return Collections.emptyList();
            }
            SecKillScene startingSecKillScene = secKillSceneList.get(0);
            SecKillScene startedSecKillScene = null;
            if (secKillSceneList.size() == 2) {
                startedSecKillScene = secKillSceneList.get(1);
            }
            SecKillSceneProxyDto startingSceneProxyDto = new SecKillSceneProxyDto();
            SecKillSceneProxyDto startedSceneProxyDto = new SecKillSceneProxyDto();
            ObjectUtils.fastCopy(startingSecKillScene, startingSceneProxyDto);
            List<SecKillSceneProxyDto> secKillSceneProxyDtos = new ArrayList<SecKillSceneProxyDto>();
            SecKillScene nextSecKillScene = secKillSceneMapper.loadNextSecKillSceneByCurrentTime(currentTime);
            if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                startingSceneProxyDto.setEndTime(nextSecKillScene.getStartTime());
            } else {
                startingSceneProxyDto.setEndTime(
                        DateUtils.addHours(startingSceneProxyDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
            }
            secKillSceneProxyDtos.add(startingSceneProxyDto);
            if (!ObjectUtils.isNullOrEmpty(startedSecKillScene)) {
                ObjectUtils.fastCopy(startedSecKillScene, startedSceneProxyDto);
                startedSceneProxyDto.setEndTime(startingSceneProxyDto.getStartTime());
            }
            if (currentTime.before(startingSceneProxyDto.getEndTime()) && !ObjectUtils.isNullOrEmpty(startedSecKillScene)) {
                secKillSceneProxyDtos.add(startedSceneProxyDto);
            }
            return secKillSceneProxyDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private int getSystemParamSecKillSceneEndTime() {
        String endTime = super.getSystemParamValue(SystemContext.SystemParams.SECKILLSCENE_ENDTIME);
        if (ObjectUtils.isNullOrEmpty(endTime)) {
            return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
        }
        try {
            return Integer.parseInt(endTime.trim());
        } catch (Exception e) {
            logger.warn(e);
        }
        return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
    }
}
