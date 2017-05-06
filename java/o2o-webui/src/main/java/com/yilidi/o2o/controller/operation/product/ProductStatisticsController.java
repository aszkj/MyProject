package com.yilidi.o2o.controller.operation.product;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleProductStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;
import com.yilidi.o2o.report.export.product.ProductStatisticsDetailReportExport;
import com.yilidi.o2o.report.export.product.ProductStatisticsListReportExport;

/**
 * 
 * 数据统计->商品销售统计
 * 
 * @author: heyong
 * @date: 2015年12月2日 上午10:25:50
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class ProductStatisticsController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ProductStatisticsListReportExport productStatisticsListReportExport;

    @Autowired
    private ProductStatisticsDetailReportExport productStatisticsDetailReportExport;

    /**
     * 
     * 商品销售统计
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listSaleProductStatistics")
    @ResponseBody
    public MsgBean listSaleProductStatistics(@RequestBody SaleProductStatisticsQuery saleProductStatisticsQuery) {
        try {
            YiLiDiPage<SaleProductStatisticsInfoDto> page = orderService.findSaleProductStatistics(saleProductStatisticsQuery);
            logger.info("listSaleProductStatistics->page:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查看商品销售统计列表成功");
        } catch (Exception e) {
            logger.error("查看商品销售统计列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 商品销售统计导出列表
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/exportSearchProductStatisticsList")
    @ResponseBody
    public MsgBean exportSearchProductStatisticsList(@RequestBody SaleProductStatisticsQuery saleProductStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = productStatisticsListReportExport.exportExcel(saleProductStatisticsQuery,
                    "商品销售统计报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchProductStatisticsList--->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商品销售统计报表导出成功");
        } catch (Exception e) {
            logger.error("商品销售统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 商品销售统计->查看交易明细
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listSaleProductStatisticsDetail")
    @ResponseBody
    public MsgBean listSaleProductStatisticsDetail(@RequestBody SaleProductStatisticsQuery saleProductStatisticsQuery) {
        try {
            YiLiDiPage<SaleProductStatisticsInfoDto> page = orderService.findSaleProductStatisticsDetail(saleProductStatisticsQuery);
            logger.info("listSaleProductStatisticsDetail->page:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查看交易明细列表成功");
        } catch (Exception e) {
            logger.error("查看交易明细列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 商品销售统计->查看交易明细导出列表
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/exportSearchProductStatisticsDetail")
    @ResponseBody
    public MsgBean exportSearchProductStatisticsDetail(@RequestBody SaleProductStatisticsQuery saleProductStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = productStatisticsDetailReportExport.exportExcel(saleProductStatisticsQuery,
                    "商品交易明细报表");
            String jsonString = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchProductStatisticsDetail--->success :" + jsonString);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商品交易明细报表导出成功");
        } catch (Exception e) {
            logger.error("商品交易明细报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
