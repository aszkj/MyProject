/**
 * All rights Reserved, Designed By YiLiDi
 * @Title: 	AdvertisementService.java 
 * @Package com.yilidi.o2o.product.service.impl 
 * @Description: 	TODO(用一句话描述该文件做什么) 
 * @author:	HP   
 * @date:	2015-10-19 下午4:02:54 
 * @version	V1.0   
 */
package com.yilidi.o2o.product.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleDailyMapper;
import com.yilidi.o2o.product.model.SaleDaily;
import com.yilidi.o2o.product.service.ISaleDailyService;
import com.yilidi.o2o.product.service.dto.SaleDailyDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 商品销量服务类
 * 
 * @author: chenb
 * @date: 2016年7月15日 下午7:02:08
 */
@Service("saleDailyService")
public class SaleDailyServiceImpl extends BasicDataService implements ISaleDailyService {

    @Autowired
    private SaleDailyMapper saleDailyMapper;

    @Override
    public void saveSaleDaily(SaleDailyDto saleDailyDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleDailyDto)) {
                throw new ProductServiceException("参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleDailyDto.getSaleDate())) {
                throw new ProductServiceException("销售日期不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleDailyDto.getStoreId())) {
                throw new ProductServiceException("店铺不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleDailyDto.getWarehouseId())) {
                throw new ProductServiceException("微仓ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleDailyDto.getSaleProductId())
                    || ObjectUtils.isNullOrEmpty(saleDailyDto.getProductName())
                    || ObjectUtils.isNullOrEmpty(saleDailyDto.getProductClassName())) {
                throw new ProductServiceException("商品信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleDailyDto.getAmount())
                    || ObjectUtils.isNullOrEmpty(saleDailyDto.getSaleCount())) {
                throw new ProductServiceException("商品销量信息不能为空");
            }
            SaleDaily saleDaily = new SaleDaily();
            ObjectUtils.fastCopy(saleDailyDto, saleDaily);
            saleDailyMapper.deleteByWareHouseIdAndStoreIdAndSaleProductIdAndSaleDate(saleDaily.getWarehouseId(),
                    saleDaily.getStoreId(), saleDaily.getSaleProductId(), saleDaily.getSaleDate());
            Integer effectCount = saleDailyMapper.save(saleDaily);
            if (1 != effectCount) {
                throw new ProductServiceException("保存销量信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
