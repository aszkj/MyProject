package com.yilidi.o2o.controller.warehouse.order;

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
import com.yilidi.o2o.controller.common.WarehouseBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IFlittingOrderService;
import com.yilidi.o2o.order.service.dto.FlittingOrderDetailDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDto;
import com.yilidi.o2o.order.service.dto.query.FlittingOrderQueryDto;

/**
 * 调拨订单管理
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:39:42
 */
@Controller("warehouseFlittingOrderController")
@RequestMapping(value = "/warehouse")
public class FlittingOrderController extends WarehouseBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IFlittingOrderService flittingOrderService;

    /**
     * 查询调拨订单列表
     * 
     * @param flittingOrderQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/search")
    @ResponseBody
    public MsgBean searchFlittingOrders(@RequestBody FlittingOrderQueryDto flittingOrderQueryDto) {
        try {
            flittingOrderQueryDto.setSrcStoreId(super.getStoreId());
           // flittingOrderQueryDto.setSrcStoreName(super.getUserName());
            flittingOrderQueryDto.setDestCityCode(flittingOrderQueryDto.getSrcCityCode());
            flittingOrderQueryDto.setDestCountyCode(flittingOrderQueryDto.getSrcCountyCode());
            String strBeginCreateTime = null;
            String strEndCreateTime = null;
            // TODO 校验输入条件
            if (!StringUtils.isEmpty(strBeginCreateTime)) {
                flittingOrderQueryDto
                        .setBeginCreateTime(DateUtils.parseDate(strBeginCreateTime, CommonConstants.DATE_FORMAT_DAY));
            }
            if (!StringUtils.isEmpty(strEndCreateTime)) {
                flittingOrderQueryDto
                        .setBeginCreateTime(DateUtils.parseDate(strEndCreateTime, CommonConstants.DATE_FORMAT_DAY));
            }
            YiLiDiPage<FlittingOrderDto> flittingOrderPage = flittingOrderService.findFlittingOrders(flittingOrderQueryDto);
            return super.encapsulateMsgBean(flittingOrderPage, MsgBean.MsgCode.SUCCESS, "查询调拨订单列表成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单详情
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorderdetail/{flittingOrderNo}")
    @ResponseBody
    public MsgBean getFlittingOrderDetail(@PathVariable String flittingOrderNo) {
        try {
            FlittingOrderDetailDto flittingOrderDetailDto = flittingOrderService
                    .loadDetailByFlittingOrderNo(flittingOrderNo);
            return super.encapsulateMsgBean(flittingOrderDetailDto, MsgBean.MsgCode.SUCCESS, "获取采购单详情信息成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单初审通过
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/{flittingOrderNo}/firstauditpassed")
    @ResponseBody
    public MsgBean firstAuditPassedFlittingOrder(@PathVariable String flittingOrderNo) {
        try {
            flittingOrderService.updateForAcceptPassed(flittingOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "初审成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单初审不通过
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/{flittingOrderNo}/firstauditnotpassed")
    @ResponseBody
    public MsgBean firstAuditFlittingOrder(@PathVariable String flittingOrderNo) {
        try {
            String rejectReason = "微仓初审不同意";
            flittingOrderService.updateForAcceptRejected(flittingOrderNo, super.getUserId(), rejectReason);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单发货
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/send/{flittingOrderNo}")
    @ResponseBody
    public MsgBean sendFlittingOrder(@PathVariable String flittingOrderNo) {
        try {
            flittingOrderService.updateForSend(flittingOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "发货成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单再审核通过
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/reauditpassed/{flittingOrderNo}")
    @ResponseBody
    public MsgBean reAuditPassedFlittingOrder(@PathVariable String flittingOrderNo) {
        try {
            flittingOrderService.updateForAuditPassed(flittingOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单再审核不通过
     * 
     * @param req
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/reauditnotpassed")
    @ResponseBody
    public MsgBean reAuditNotPassedFlittingOrder(HttpServletRequest req) {
        try {
            String flittingOrderNo = req.getParameter("flittingOrderNo");
            String rejectReason = req.getParameter("rejectReason");
            if (ObjectUtils.isNullOrEmpty(flittingOrderNo)) {
                throw new Exception("调拨单不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(rejectReason)) {
                throw new Exception("不通过理由不能为空");
            }
            flittingOrderService.updateForAuditRejected(flittingOrderNo, super.getUserId(), rejectReason);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
