package com.yilidi.o2o.controller.operation.order;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.order.service.IStockOutOrderService;
import com.yilidi.o2o.order.service.dto.StockOutOrderCreateParamDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderSaveDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.query.StockOutOrderQueryDto;
import com.yilidi.o2o.report.export.order.StockOutOrderReportExport;

/**
 * 出库订单管理
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:39:42
 */
@Controller("operationStockOutOrderController")
@RequestMapping(value = "/operation")
public class StockOutOrderController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IStockOutOrderService stockOutOrderService;

    @Autowired
    private StockOutOrderReportExport stockOutOrderReportExport;

    /**
     * 创建出库订单
     * 
     * @param stockOutOrderCreateParamDto
     *            接收参数对象
     * @return MsgBean
     */
    @RequestMapping(value = "/stockoutorder/create")
    @ResponseBody
    public MsgBean createStockOutOrder(@RequestBody StockOutOrderCreateParamDto stockOutOrderCreateParamDto) {
        try {
            String storeId = stockOutOrderCreateParamDto.getStoreId(); // 店铺ID
            String saleProductIdAndQuantity = stockOutOrderCreateParamDto.getProductItems(); // 出库商品明细组合,商品IDx商品数量_商品IDx商品数量组合
            String stockOutOrderType = stockOutOrderCreateParamDto.getStockOutOrderType(); // 出库单类型
            if (StringUtils.isEmpty(storeId)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择商户");
            }
            if (StringUtils.isEmpty(saleProductIdAndQuantity)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择商品");
            }
            if (StringUtils.isEmpty(stockOutOrderType)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择出库单类型");
            }
            String[] saleProductIdAndQuantityArr = saleProductIdAndQuantity.split(CommonConstants.DELIMITER_UNDERLINE);
            StockOutOrderSaveDto purchaseOrderSaveDto = new StockOutOrderSaveDto();
            purchaseOrderSaveDto.setStoreId(ArithUtils.converStringToInt(storeId));
            purchaseOrderSaveDto.setStockOutOrderType(stockOutOrderType);
            List<StockOutOrderSaveItemDto> stockOutOrderSaveItemDtoList = new ArrayList<StockOutOrderSaveItemDto>();
            for (String saleProductStr : saleProductIdAndQuantityArr) {
                String[] saleProductArr = saleProductStr.split(CommonConstants.DELIMITER_MULTIPLY);
                if (null == saleProductArr || saleProductArr.length != 2) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "存在不合法的商品");
                }
                int saleProductId = ArithUtils.converStringToInt(saleProductArr[0]);
                int quantity = ArithUtils.converStringToInt(saleProductArr[1]);
                if (saleProductId <= 0 || quantity <= 0) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "存在不合法的产品");
                }
                StockOutOrderSaveItemDto stockOutOrderSaveItemDto = new StockOutOrderSaveItemDto();
                stockOutOrderSaveItemDto.setSaleProductId(saleProductId);
                stockOutOrderSaveItemDto.setStockOutCount(quantity);
                stockOutOrderSaveItemDtoList.add(stockOutOrderSaveItemDto);
            }
            purchaseOrderSaveDto.setStockOutOrderSaveItemDtos(stockOutOrderSaveItemDtoList);
            stockOutOrderService.saveCreateStockOutOrder(purchaseOrderSaveDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建出库订单成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "创建出库订单失败");
        }
    }

    /**
     * 查询出库订单列表
     * 
     * @param stockOutOrderQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/stockoutorder/search")
    @ResponseBody
    public MsgBean searchStockOutOrders(@RequestBody StockOutOrderQueryDto stockOutOrderQueryDto) {
        try {
            YiLiDiPage<StockOutOrderDto> yiLiDiPage = stockOutOrderService.findStockOutOrders(stockOutOrderQueryDto);
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询出库订单列表成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 出库订单详情
     * 
     * @param stockOutOrderNo
     *            出库订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/stockoutorderdetail/{stockOutOrderNo}")
    @ResponseBody
    public MsgBean getSaleOrderDetail(@PathVariable String stockOutOrderNo) {
        try {
            StockOutOrderDto stockOutOrderDto = stockOutOrderService.loadByStockOutOrderNo(stockOutOrderNo);
            return super.encapsulateMsgBean(stockOutOrderDto, MsgBean.MsgCode.SUCCESS, "获取订单详情信息成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 出库单审核通过
     * 
     * @param stockOutOrderNo
     *            出库订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/stockoutorder/auditpassed/{stockOutOrderNo}")
    @ResponseBody
    public MsgBean auditPassedPurchaseOrder(@PathVariable String stockOutOrderNo) {
        try {
            stockOutOrderService.updateForAuditPassed(stockOutOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 出库单审核不通过
     * 
     * @param req
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/stockoutorder/auditreject")
    @ResponseBody
    public MsgBean auditRejectPurchaseOrder(HttpServletRequest req) {
        try {
            String stockOutOrderNo = req.getParameter("stockOutOrderNo"); // 出库单号
            String rejectReason = req.getParameter("rejectReason"); // 不能过理由
            if (StringUtils.isEmpty(stockOutOrderNo)) {
                throw new Exception("出库单号不能为空");
            }
            if (StringUtils.isEmpty(rejectReason)) {
                throw new Exception("不通过理由不能为空");
            }
            stockOutOrderService.updateForAuditRejected(stockOutOrderNo, super.getUserId(), rejectReason);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核不通过成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出出库单显示信息列表
     * 
     * @param stockOutOrderQueryDto
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/stockoutorder/export")
    @ResponseBody
    public MsgBean exportSearchOrder(@RequestBody StockOutOrderQueryDto stockOutOrderQueryDto) {
        try {
            ReportFileModel reportFileModel = stockOutOrderReportExport.exportExcel(stockOutOrderQueryDto, "出库单报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "订单报表导出成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
