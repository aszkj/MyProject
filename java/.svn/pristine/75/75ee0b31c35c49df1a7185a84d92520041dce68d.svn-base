/**
 * 文件名称：SaleReportServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.AllVolumeStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderStatisticsDto;
import com.yilidi.o2o.order.service.dto.SaleProductStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;

/**
 * 
 * 测试类
 * 
 * @author: heyong
 * @date: 2015年11月5日 下午8:48:03
 * 
 */
public class SaleOrderServiceTest extends BaseServiceTest {

    @Autowired
    private IOrderService orderService;

    @Test
    public void testFindOrderDetailByOrderNo() {
        try {
            SaleOrderDetailDto saleOrderDetailDto = orderService.findOrderDetailByOrderNo("20151112182202795b7l");
            printInfo(saleOrderDetailDto);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindOrderStatisticsDtos() {
        try {
            SaleOrderStatisticsQuery query = new SaleOrderStatisticsQuery();
            YiLiDiPage<SaleOrderStatisticsDto> saleOrderDto = orderService.findOrderStatisticsDtos(query);
            printInfo(saleOrderDto);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindOrderStatisticsDtosByDate() {
        try {
            SaleOrderStatisticsQuery query = new SaleOrderStatisticsQuery();
            query.setUserName("13788999988");
            YiLiDiPage<SaleOrderStatisticsDto> saleOrderDto = orderService.findOrderStatisticsDtosByDate(query);
            printInfo(saleOrderDto);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testLoadAllVolumeStatisticsInfoDto() {
        try {
            orderService.loadAllVolumeStatisticsInfoDto();
            printInfo("----------->success");
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindAllVolumeStatisticsInfos() {
        try {
            AllVolumeStatisticsQuery query = new AllVolumeStatisticsQuery();
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosDetail(query);
            printInfo(page);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindAllVolumeStatisticsInfosForStore() {
        try {
            AllVolumeStatisticsQuery query = new AllVolumeStatisticsQuery();
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosForStore(query);
            printInfo(page);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindAllVolumeStatisticsInfosForStoreByDay() {
        try {
            AllVolumeStatisticsQuery query = new AllVolumeStatisticsQuery();
            query.setStrBeginOrderTime("2015-11-12");
            query.setStrEndOrderTime("2015-11-16");
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosForStoreByDay(query);
            printInfo(page);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindSaleProductStatistics() {
        try {
            SaleProductStatisticsQuery query = new SaleProductStatisticsQuery();
            YiLiDiPage<SaleProductStatisticsInfoDto> page = orderService.findSaleProductStatistics(query);
            printInfo(page);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testFindSaleProductStatisticsDetail() {
        try {
            SaleProductStatisticsQuery query = new SaleProductStatisticsQuery();
            query.setBarCode("XJJ123");
            YiLiDiPage<SaleProductStatisticsInfoDto> page = orderService.findSaleProductStatisticsDetail(query);
            printInfo(page);
        } catch (OrderServiceException e) {
            e.printStackTrace();
        }
    }
}
