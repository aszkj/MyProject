package com.yilidi.o2o.schedule.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.ISaleOrderItemService;
import com.yilidi.o2o.order.service.dto.SaleDailyStatisticsInfoDto;
import com.yilidi.o2o.product.service.ISaleDailyService;
import com.yilidi.o2o.product.service.dto.SaleDailyDto;
import com.yilidi.o2o.user.service.IStoreWarehouseService;

/**
 * 商品销量统计定时任务
 * 
 * @author chenb
 * 
 */
public class ProductSaleDailyStatisticsJob {

    private Logger logger = Logger.getLogger(ProductSaleDailyStatisticsJob.class);

    private ISaleOrderItemService saleOrderItemService;

    private ISaleDailyService saleDailyService;

    private IStoreWarehouseService storeWarehouseService;

    protected synchronized void performance() {
        try {
            logger.info("===============统计商品昨天销量任务开始===============");
            Date currentDate = new Date();
            Date yesterDate = DateUtils.addDays(currentDate, -1);
            Date startDate = DateUtils.getSpecificStartDate(yesterDate);
            Date endDate = DateUtils.getSpecificEndDate(yesterDate);
            List<SaleDailyStatisticsInfoDto> saleDailyStatisticsInfoDtos = saleOrderItemService
                    .listSaleDailyStatistictsByTakeTime(startDate, endDate);
            if (!ObjectUtils.isNullOrEmpty(saleDailyStatisticsInfoDtos)) {
                for (SaleDailyStatisticsInfoDto saleDailyStatisticsInfoDto : saleDailyStatisticsInfoDtos) {
                    SaleDailyDto saleDailyDto = new SaleDailyDto();
                    ObjectUtils.fastCopy(saleDailyStatisticsInfoDto, saleDailyDto);
                    try {
                        Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(saleDailyStatisticsInfoDto
                                .getStoreId());
                        saleDailyDto.setWarehouseId(warehouseId);
                        saleDailyService.saveSaleDaily(saleDailyDto);
                    } catch (Exception e) {
                        logger.error(e, e);
                    }
                }
            }
            logger.info("===============统计商品昨天销量任务结束===============");
        } catch (Exception e) {
            logger.error(e, e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public ISaleOrderItemService getSaleOrderItemService() {
        return saleOrderItemService;
    }

    public void setSaleOrderItemService(ISaleOrderItemService saleOrderItemService) {
        this.saleOrderItemService = saleOrderItemService;
    }

    public ISaleDailyService getSaleDailyService() {
        return saleDailyService;
    }

    public void setSaleDailyService(ISaleDailyService saleDailyService) {
        this.saleDailyService = saleDailyService;
    }

    public IStoreWarehouseService getStoreWarehouseService() {
        return storeWarehouseService;
    }

    public void setStoreWarehouseService(IStoreWarehouseService storeWarehouseService) {
        this.storeWarehouseService = storeWarehouseService;
    }

}
