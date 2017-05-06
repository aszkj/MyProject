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
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.order.service.IPurchaseOrderService;
import com.yilidi.o2o.order.service.dto.PurchaseOrderCreateParamDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderSaveDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.query.PurchaseOrderQueryDto;
import com.yilidi.o2o.report.export.order.PurchaseOrderReportExport;

/**
 * 采购订单管理
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:39:42
 */
@Controller
@RequestMapping(value = "/operation")
public class PurchaseOrderController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IPurchaseOrderService purchaseOrderService;

    @Autowired
    private PurchaseOrderReportExport purchaseOrderReportExport;

    /**
     * 创建采购订单
     * 
     * @param purchaseOrderCreateParamDto
     *            接收参数对象
     * @return MsgBean
     */
    @RequestMapping(value = "/purchaseorder/create")
    @ResponseBody
    public MsgBean createPurchaseOrder(@RequestBody PurchaseOrderCreateParamDto purchaseOrderCreateParamDto) {
        try {
            String storeId = purchaseOrderCreateParamDto.getStoreId(); // 店铺ID
            String productIdAndQuantity = purchaseOrderCreateParamDto.getProductItems(); // 产品采购明细组合,产品IDx产品数量_产品IDx产品数量组合
            if (StringUtils.isEmpty(storeId)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择微仓");
            }
            if (StringUtils.isEmpty(productIdAndQuantity)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择产品");
            }
            String[] productIdAndQuantityArr = productIdAndQuantity.split(CommonConstants.DELIMITER_UNDERLINE);
            PurchaseOrderSaveDto purchaseOrderSaveDto = new PurchaseOrderSaveDto();
            purchaseOrderSaveDto.setStoreId(ArithUtils.converStringToInt(storeId));
            List<PurchaseOrderSaveItemDto> purchaseOrderSaveItemDtoList = new ArrayList<PurchaseOrderSaveItemDto>();
            for (String productStr : productIdAndQuantityArr) {
                String[] productArr = productStr.split(CommonConstants.DELIMITER_MULTIPLY);
                if (null == productArr || productArr.length != 2) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "存在不合法的产品");
                }
                int productId = ArithUtils.converStringToInt(productArr[0]);
                int quantity = ArithUtils.converStringToInt(productArr[1]);
                if (productId <= 0 || quantity <= 0) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "存在不合法的产品");
                }
                PurchaseOrderSaveItemDto purchaseOrderSaveItemDto = new PurchaseOrderSaveItemDto();
                purchaseOrderSaveItemDto.setProductId(productId);
                purchaseOrderSaveItemDto.setPurchaseCount(quantity);
                purchaseOrderSaveItemDtoList.add(purchaseOrderSaveItemDto);
            }
            purchaseOrderSaveDto.setPurchaseOrderSaveItemDtoList(purchaseOrderSaveItemDtoList);
            String purchaseOrderNo = purchaseOrderService.saveCreatePurchaseOrder(purchaseOrderSaveDto, super.getUserId());
            logger.info("createPurchaseOrder->purchaseOrderNo : " + purchaseOrderNo);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建采购订单成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询采购订单列表
     * 
     * @param purchaseOrderQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/purchaseorder/search")
    @ResponseBody
    public MsgBean searchPurchaseOrders(@RequestBody PurchaseOrderQueryDto purchaseOrderQueryDto) {
        try {
            YiLiDiPage<PurchaseOrderDto> yiLiDiPage = purchaseOrderService.findPurchaseOrders(purchaseOrderQueryDto);
            logger.info("searchPurchaseOrders->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询采购订单列表成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 采购订单详情
     * 
     * @param purchaseOrderNo
     *            采购订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/purchaseorderdetail/{purchaseOrderNo}")
    @ResponseBody
    public MsgBean getSaleOrderDetail(@PathVariable String purchaseOrderNo) {
        try {
            PurchaseOrderDto purchaseOrderDto = purchaseOrderService.loadByPurchaseOrderNo(purchaseOrderNo);
            return super.encapsulateMsgBean(purchaseOrderDto, MsgBean.MsgCode.SUCCESS, "获取订单详情信息成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 采购单审核通过
     * 
     * @param purchaseOrderNo
     *            采购订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/purchaseorder/auditpassed/{purchaseOrderNo}")
    @ResponseBody
    public MsgBean auditPassedPurchaseOrder(@PathVariable String purchaseOrderNo) {
        try {
            purchaseOrderService.updateForAuditPassed(purchaseOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 采购单审核不通过
     * 
     * @param req
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/purchaseorder/auditreject")
    @ResponseBody
    public MsgBean auditRejectPurchaseOrder(HttpServletRequest req) {
        try {
            String purchaseOrderNo = req.getParameter("purchaseOrderNo"); // 采购单号
            String rejectReason = req.getParameter("rejectReason"); // 不能过理由
            if (StringUtils.isEmpty(purchaseOrderNo)) {
                throw new Exception("采购单号不能为空");
            }
            if (StringUtils.isEmpty(rejectReason)) {
                throw new Exception("不通过理由不能为空");
            }
            purchaseOrderService.updateForAuditRejected(purchaseOrderNo, super.getUserId(), rejectReason);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核不通过成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出采购 单显示信息列表
     * 
     * @param purchaseOrderQueryDto
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/purchaseorder/export")
    @ResponseBody
    public MsgBean exportSearchOrder(@RequestBody PurchaseOrderQueryDto purchaseOrderQueryDto) {
        try {
            ReportFileModel reportFileModel = purchaseOrderReportExport.exportExcel(purchaseOrderQueryDto, "采购单报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "订单报表导出成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
