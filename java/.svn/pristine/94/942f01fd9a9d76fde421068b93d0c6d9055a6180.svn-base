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
import com.yilidi.o2o.order.service.dto.AllVolumeStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;
import com.yilidi.o2o.report.export.order.StoreVolumeByOneDayReportExport;
import com.yilidi.o2o.report.export.order.StoreVolumeListForDayReportExport;
import com.yilidi.o2o.report.export.order.StoreVolumeListReportExport;
import com.yilidi.o2o.report.export.order.VolumeStatisticsDetailReportExport;

/**
 * 
 * 数据统计->销售汇总统计
 * 
 * @author: heyong
 * @date: 2015年11月27日 下午2:49:15
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class VolumeStatisticsController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IOrderService orderService;

    @Autowired
    private VolumeStatisticsDetailReportExport volumeStatisticsDetailReportExport;

    @Autowired
    private StoreVolumeByOneDayReportExport storeVolumeByOneDayReportExport;

    @Autowired
    private StoreVolumeListReportExport storeVolumeListReportExport;

    @Autowired
    private StoreVolumeListForDayReportExport storeVolumeListForDayReportExport;

    /**
     * 
     * 销量汇总统计
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listVolumeStatistics")
    @ResponseBody
    public MsgBean listVolumeStatistics() {
        try {
            AllVolumeStatisticsInfoDto dto = orderService.loadAllVolumeStatisticsInfoDto();
            logger.info("listVolumeStatistics->dto:" + JsonUtils.toJsonStringWithDateFormat(dto));
            return super.encapsulateMsgBean(dto, MsgBean.MsgCode.SUCCESS, "查询销量汇总统计成功");
        } catch (Exception e) {
            logger.error("查询销量汇总统计失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 销量汇总统计明细
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listVolumeStatisticsDetail")
    @ResponseBody
    public MsgBean listVolumeStatisticsDetail(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosDetail(allVolumeStatisticsQuery);
            logger.info("listVolumeStatisticsDetail->page:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询销量汇总统计明细列表成功");
        } catch (Exception e) {
            logger.error("查询销量汇总统计明细列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出销量汇总统计明细列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchVolumeStatisticsDetail")
    @ResponseBody
    public MsgBean exportSearchOrderStatisticsByDate(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = volumeStatisticsDetailReportExport.exportExcel(allVolumeStatisticsQuery,
                    "销量汇总统计明细报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchVolumeStatisticsDetail->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "销量汇总统计明细报表导出成功");
        } catch (Exception e) {
            logger.error("销量汇总统计明细报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 销量汇总统计明细 ->查看每天门店排名/ 门店销售统计
     * 
     * @param query
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listVolumeStatisticsDetailForStoreByOneDay")
    @ResponseBody
    public MsgBean listVolumeStatisticsDetailForStoreByOneDay(@RequestBody AllVolumeStatisticsQuery query) {
        try {
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosForStore(query);
            logger.info("listVolumeStatisticsDetailForStoreByOneDay->page:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查看每天门店排名列表成功");
        } catch (Exception e) {
            logger.error("查看每天门店排名列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 销量汇总统计明细 ->查看每天门店排名导出列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/exportSearchStoreVolumeByOneDay")
    @ResponseBody
    public MsgBean exportSearchStoreVolumeByOneDay(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = storeVolumeByOneDayReportExport.exportExcel(allVolumeStatisticsQuery,
                    "每天门店销售排行报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchStoreVolumeByOneDay->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "每天门店销售排行报表导出成功");
        } catch (Exception e) {
            logger.error("每天门店销售排行报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 门店销售统计导出
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/exportSearchStoreVolumeList")
    @ResponseBody
    public MsgBean exportSearchStoreVolumeList(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = storeVolumeListReportExport.exportExcel(allVolumeStatisticsQuery, "门店销售统计报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchStoreVolumeList->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店销售统计报表导出成功");
        } catch (Exception e) {
            logger.error("门店销售统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 门店销售统计->下单记录
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listVolumeStatisticsForStoreByDay")
    @ResponseBody
    public MsgBean listVolumeStatisticsForStoreByDay(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            YiLiDiPage<AllVolumeStatisticsInfoDto> page = orderService.findAllVolumeStatisticsInfosForStoreByDay(allVolumeStatisticsQuery);
            logger.info("listVolumeStatisticsForStoreByDay->page:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查看下单记录列表成功");
        } catch (Exception e) {
            logger.error("查看下单记录列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 门店销售统计->下单记录导出
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/exportSearchStoreVolumeListForDay")
    @ResponseBody
    public MsgBean exportSearchStoreVolumeListForDay(@RequestBody AllVolumeStatisticsQuery allVolumeStatisticsQuery) {
        try {
            ReportFileModel reportFileModel = storeVolumeListForDayReportExport.exportExcel(allVolumeStatisticsQuery,
                    "门店下单记录报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchStoreVolumeListForDay->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店下单记录报表导出成功");
        } catch (Exception e) {
            logger.error("门店下单记录报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
