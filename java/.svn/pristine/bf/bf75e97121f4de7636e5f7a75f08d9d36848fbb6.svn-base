package com.yilidi.o2o.controller.operation.order;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.RecommendOrderInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderInfoDto;
import com.yilidi.o2o.order.service.dto.query.RecommendOrderInfoQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.report.export.order.OrderReportExport;
import com.yilidi.o2o.report.export.order.RecommendOrderReportExport;
import com.yilidi.o2o.report.export.order.SecKillOrderReportExport;

/**
 * 
 * 订单管理
 * 
 * @author: heyong
 * @date: 2015年11月14日 下午4:57:43
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class OrderController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IOrderService orderService;

    @Autowired
    private OrderReportExport orderReportExport;
    @Autowired
    private SecKillOrderReportExport secKillOrderReportExport;

    @Autowired
    private RecommendOrderReportExport recommendOrderReportExport;

    /**
     * 查询订单列表
     * 
     * @param saleOrderQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchOrders")
    @ResponseBody
    public MsgBean searchOrders(@RequestBody SaleOrderQueryDto saleOrderQuery) {
        try {
            saleOrderQuery.setOrder(DBTablesColumnsName.SaleOrder.CREATETIME);
            saleOrderQuery.setSort(CommonConstants.SORT_ORDER_DESC);
            YiLiDiPage<SaleOrderInfoDto> yiLiDiPage = orderService.findSaleOrderInfos(saleOrderQuery);
            logger.info("searchOrders->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询订单列表成功");
        } catch (Exception e) {
            logger.error("查询订单列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 查询订单详情
     * 
     * @param orderNo
     *            订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/{orderNo}/getSaleOrderDetail")
    @ResponseBody
    public MsgBean getSaleOrderDetail(@PathVariable String orderNo) {
        try {
            SaleOrderDetailDto saleOrderDetailDto = orderService.findOrderDetailByOrderNo(orderNo);
            if (!ObjectUtils.isNullOrEmpty(saleOrderDetailDto)
                    && !ObjectUtils.isNullOrEmpty(saleOrderDetailDto.getSaleOrderDto())) {
                saleOrderDetailDto.getSaleOrderDto()
                        .setBestTime(systemBasicDataInfoUtils.getSystemDictName(
                                SystemContext.OrderDomain.DictType.SALEORDERBESTTIME.getValue(),
                                saleOrderDetailDto.getSaleOrderDto().getBestTime()));
            }
            return super.encapsulateMsgBean(saleOrderDetailDto, MsgBean.MsgCode.SUCCESS, "获取订单详情信息成功");
        } catch (Exception e) {
            logger.error("获取订单详情失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 取消订单
     * 
     * @param req
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/saleOrder/cancel")
    @ResponseBody
    public MsgBean cancelOrder(HttpServletRequest req) {
        try {
            String saleOrderNo = req.getParameter("saleOrderNo"); // 订单编号
            String reason = req.getParameter("reason"); // 取消原因
            if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
                throw new IllegalArgumentException("订单编号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(reason)) {
                throw new IllegalArgumentException("取消原因不能为空");
            }
            orderService.updateOrderForOperationCancel(saleOrderNo, super.getUserId(), reason);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "取消订单成功");
        } catch (Exception e) {
            logger.error("取消订单失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 退款审核通过
     * 
     * @param saleOrderNo
     *            订单编号
     * @return MsgBean
     */
    @RequestMapping(value = "/saleOrder/{saleOrderNo}/refundaudit")
    @ResponseBody
    public MsgBean refundAuditOrder(@PathVariable String saleOrderNo) {
        try {
            orderService.updateOrderForOperationRefundAuditPassed(saleOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "退款成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 退款审核不通过
     * 
     * @param HttpServletRequest
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/saleOrder/refundauditunpass")
    @ResponseBody
    public MsgBean refundAuditUnpassOrder(HttpServletRequest req) {
        try {
            String saleOrderNo = req.getParameter("saleOrderNo");
            String refundReason = req.getParameter("refundReason");
            orderService.updateOrderForOperationRefundAuditUnpassed(saleOrderNo, refundReason, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "退款审核不通过成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出订单显示信息列表
     * 
     * @param saleOrderQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchOrder")
    @ResponseBody
    public MsgBean exportSearchOrder(@RequestBody SaleOrderQueryDto saleOrderQuery) {
        try {
            ReportFileModel reportFileModel = orderReportExport.exportExcel(saleOrderQuery, "订单报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchOrder->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "订单报表导出成功");
        } catch (Exception e) {
            logger.error("订单报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询推荐订单相关信息
     * 
     * @param recommendOrderInfoQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/findRecommendOrderInfos")
    @ResponseBody
    public MsgBean findRecommendOrderInfos(@RequestBody RecommendOrderInfoQueryDto recommendOrderInfoQueryDto) {
        try {
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getStartRegisterTime())) {
                recommendOrderInfoQueryDto.setStartRegisterDate(
                        DateUtils.getSpecificStartDate(recommendOrderInfoQueryDto.getStartRegisterTime()));
            }
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getEndRegisterTime())) {
                recommendOrderInfoQueryDto
                        .setEndRegisterDate(DateUtils.getSpecificEndDate(recommendOrderInfoQueryDto.getEndRegisterTime()));
            }
            YiLiDiPage<RecommendOrderInfoDto> page = orderService.findRecommendOrderInfos(recommendOrderInfoQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询推荐订单相关信息成功");
        } catch (Exception e) {
            logger.error("查询推荐订单相关信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出推荐订单相关信息
     * 
     * @param recommendOrderInfoQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping("/exportRecommendOrderInfos")
    @ResponseBody
    public MsgBean exportRecommendOrderInfos(@RequestBody RecommendOrderInfoQueryDto recommendOrderInfoQueryDto) {
        try {
            ReportFileModel reportFileModel = recommendOrderReportExport.exportExcel(recommendOrderInfoQueryDto, "订单报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchOrder->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "推广佣金结算报表导出成功");
        } catch (Exception e) {
            logger.error("推广佣金结算报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出秒杀订单显示信息列表
     * 
     * @param saleOrderQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchSecKillOrder")
    @ResponseBody
    public MsgBean exportSearchSecKillOrder(@RequestBody SaleOrderQueryDto saleOrderQuery) {
        try {
            ReportFileModel reportFileModel = secKillOrderReportExport.exportExcel(saleOrderQuery, "订单报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("exportSearchOrder->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "订单报表导出成功");
        } catch (Exception e) {
            logger.error("订单报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
