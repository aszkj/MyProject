package com.yilidi.o2o.controller.operation.order;

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
import com.yilidi.o2o.order.service.dto.SaleOrderStatisticsDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;
import com.yilidi.o2o.report.export.order.OrderStatisticsByDateReportExport;
import com.yilidi.o2o.report.export.order.OrderStatisticsReportExport;

/**
 * 
 * 数据统计->用户销售统计
 * 
 * @author: heyong
 * @date: 2015年11月27日 下午2:49:15
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class OrderStatisticsController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IOrderService orderService;

    @Autowired
    private OrderStatisticsReportExport orderStatisticsReportExport;

    @Autowired
    private OrderStatisticsByDateReportExport orderStatisticsByDateReportExport;

    /**
     * 
     * 用户销售统计列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listOrderStatistics")
    @ResponseBody
    public MsgBean listOrderStatistics(@RequestBody SaleOrderStatisticsQuery saleOrderStatisticsQuery) {
        try {
            YiLiDiPage<SaleOrderStatisticsDto> yiLiDiPage = orderService.findOrderStatisticsDtos(saleOrderStatisticsQuery);
            logger.info("listOrderStatistics->yiLiDiPage:" + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询用户销售列表成功");
        } catch (Exception e) {
            logger.error("查询用户销售列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 用户下单记录列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listOrderStatisticsByDate")
    @ResponseBody
    public MsgBean listOrderStatisticsByDate(@RequestBody SaleOrderStatisticsQuery saleOrderStatisticsQuery) {
        try {
            YiLiDiPage<SaleOrderStatisticsDto> yiLiDiPage = orderService.findOrderStatisticsDtosByDate(saleOrderStatisticsQuery);
            logger.info("listOrderStatisticsByDate->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询用户下单记录列表成功");
        } catch (Exception e) {
            logger.error("查询用户下单记录列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出用户销售统计列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchOrderStatistics")
    @ResponseBody
    public MsgBean exportSearchOrderStatistics(@RequestBody SaleOrderStatisticsQuery saleOrderStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = orderStatisticsReportExport.exportExcel(saleOrderStatisticsQuery, "用户销售统计报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchOrderStatistics->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "用户销售统计报表导出成功");
        } catch (Exception e) {
            logger.error("用户销售统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出用户下单记录列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchOrderStatisticsByDate")
    @ResponseBody
    public MsgBean exportSearchOrderStatisticsByDate(@RequestBody SaleOrderStatisticsQuery saleOrderStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = orderStatisticsByDateReportExport.exportExcel(saleOrderStatisticsQuery,
                    "用户下单记录报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchOrderStatisticsByDate->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "用户下单记录报表导出成功");
        } catch (Exception e) {
            logger.error("用户下单记录报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
