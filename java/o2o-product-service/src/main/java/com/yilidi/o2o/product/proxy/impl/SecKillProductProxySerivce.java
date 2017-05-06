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
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.dao.SecKillProductMapper;
import com.yilidi.o2o.product.dao.SecKillSceneMapper;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.SecKillScene;
import com.yilidi.o2o.product.model.combination.SecKillProductRelatedInfo;
import com.yilidi.o2o.product.proxy.ISecKillProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SecKillProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述：秒杀商品代理服务接口实现 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("secKillProductProxyService")
public class SecKillProductProxySerivce extends BasicDataService implements ISecKillProductProxyService {

    @Autowired
    private SaleProductMapper saleProductMapper;
    @Autowired
    private SecKillProductMapper secKillProductMapper;
    @Autowired
    private SecKillSceneMapper secKillSceneMapper;

    @Override
    public SecKillProductProxyDto loadByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(activityId) || ObjectUtils.isNullOrEmpty(saleProductId)) {
                throw new ProductServiceException("参数不能为空");
            }
            SaleProduct saleProduct = saleProductMapper.loadByIdAndEnabledFlag(saleProductId, null);
            if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                return null;
            }
            SecKillProductRelatedInfo secKillProductRelatedInfo = secKillProductMapper
                    .loadByActivityIdAndProductId(activityId, saleProduct.getProductId());
            if (ObjectUtils.isNullOrEmpty(secKillProductRelatedInfo)) {
                return null;
            }
            SecKillProductProxyDto secKillProductProxyDto = new SecKillProductProxyDto();
            ObjectUtils.fastCopy(secKillProductRelatedInfo, secKillProductProxyDto);
            secKillProductProxyDto.setSaleProductName(saleProduct.getSaleProductName());
            secKillProductProxyDto.setSaleProductId(saleProductId);
            SecKillScene nextSecKillScene = secKillSceneMapper
                    .loadNextSecKillSceneByCurrentTime(secKillProductRelatedInfo.getStartTime());
            if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                secKillProductProxyDto.setEndTime(nextSecKillScene.getStartTime());
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductProxyDto.getEndTime())) {
                secKillProductProxyDto.setEndTime(
                        DateUtils.addHours(secKillProductProxyDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
            }
            return secKillProductProxyDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillProductProxyDto> listByActivityIdAndSaleProductIdMaps(
            List<Map<Integer, Integer>> actIdAndSaleProductIdMapList) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(actIdAndSaleProductIdMapList)) {
                return Collections.emptyList();
            }
            List<SecKillProductProxyDto> secKillProductProxyDtos = new ArrayList<SecKillProductProxyDto>();
            for (Map<Integer, Integer> map : actIdAndSaleProductIdMapList) {
                for (Integer activityId : map.keySet()) {
                    SecKillProductProxyDto secKillProductProxyDto = loadByActivityIdAndSaleProductId(activityId,
                            map.get(activityId));
                    if (!ObjectUtils.isNullOrEmpty(secKillProductProxyDto)) {
                        secKillProductProxyDtos.add(secKillProductProxyDto);
                    }
                }
            }
            Collections.sort(secKillProductProxyDtos, new Comparator<SecKillProductProxyDto>() {
                @Override
                public int compare(SecKillProductProxyDto o1, SecKillProductProxyDto o2) {
                    return (int) (o1.getStartTime().getTime() - o2.getStartTime().getTime());
                }
            });
            return secKillProductProxyDtos;
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
