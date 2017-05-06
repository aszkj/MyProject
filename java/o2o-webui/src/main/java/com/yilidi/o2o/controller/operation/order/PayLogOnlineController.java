package com.yilidi.o2o.controller.operation.order;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.query.PayLogQueryDto;
import com.yilidi.o2o.report.export.order.PayLogOnlineReportExport;

/**
 * 
 * 线上支付日志管理
 * 
 * @author: xiasl
 * @date: 2016年12月13日15:27:34
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class PayLogOnlineController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private PayLogOnlineReportExport payLogOnlineReportExport;
    
    
    @Autowired
    private IPayLogService payLogService;

    /**
     * 查询线上支付日志列表
     * 
     * @param payLogQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listPayLogOnline")
    @ResponseBody
    public MsgBean searchOrders(@RequestBody PayLogQueryDto payLogQueryDto) {
        try {
        	payLogQueryDto.setOrder(DBTablesColumnsName.SaleOrder.CREATETIME);
        	payLogQueryDto.setSort(CommonConstants.SORT_ORDER_DESC);
            YiLiDiPage<PayLogDto> yiLiDiPage = payLogService.findPayLogs(payLogQueryDto);
            logger.info("searchOrders->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询线上支付日志列表成功");
        } catch (Exception e) {
            logger.error("查询线上支付日志列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }


    /**
     * 导出线上支付日志显示信息列表
     * 
     * @param payLogDto
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportPayLogOnline")
    @ResponseBody
    public MsgBean exportPayLogOnline(@RequestBody PayLogQueryDto payLogQueryDto) {
        try {
            ReportFileModel reportFileModel = payLogOnlineReportExport.exportExcel(payLogQueryDto, "线上支付日志报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportPayLogOnline->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "线上支付日志报表导出成功");
        } catch (Exception e) {
            logger.error("线上支付日志报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}