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
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.order.service.IFlittingOrderService;
import com.yilidi.o2o.order.service.dto.FlittingOrderAuditDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderAuditItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDetailDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDto;
import com.yilidi.o2o.order.service.dto.query.FlittingOrderQueryDto;

/**
 * 调拨订单管理
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:39:42
 */
@Controller("operationFlittingOrderController")
@RequestMapping(value = "/operation")
public class FlittingOrderController extends OperationBaseController {

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
    public MsgBean firstAuditNotPassedFlittingOrder(@PathVariable String flittingOrderNo) {
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
     * 平台介入
     * 
     * @param flittingOrderNo
     *            调拨订单号
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/arbitrate/{flittingOrderNo}")
    @ResponseBody
    public MsgBean arbitrateFlittingOrder(@PathVariable String flittingOrderNo) {
        try {
            flittingOrderService.updateForArbitrateByOper(flittingOrderNo, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 调拨单终极修改
     * 
     * @param req
     *            HttpServletRequest
     * @return MsgBean
     */
    @RequestMapping(value = "/flittingorder/ulitmatemodify")
    @ResponseBody
    public MsgBean ulitmateModifyFlittingeOrder(HttpServletRequest req) {
        try {
            String flittingOrderNo = req.getParameter("flittingOrderNo");
            String flittingOrderItems = req.getParameter("flittingOrderItems"); // 调拨明细IDx实际接收数量_组合
            if (StringUtils.isEmpty(flittingOrderNo)) {
                throw new Exception("调拨单号不能为空");
            }
            if (StringUtils.isEmpty(flittingOrderItems)) {
                throw new Exception("调拨明细不能为空");
            }
            String[] itemIdAndQuantityArr = flittingOrderItems.split(CommonConstants.DELIMITER_UNDERLINE);
            FlittingOrderAuditDto flittingOrderAuditDto = new FlittingOrderAuditDto();
            flittingOrderAuditDto.setFlittingOrderNo(flittingOrderNo);
            List<FlittingOrderAuditItemDto> flittingOrderAuditItemDtoDtoList = new ArrayList<FlittingOrderAuditItemDto>();
            for (String itemIdAndQuantity : itemIdAndQuantityArr) {
                String[] itemArr = itemIdAndQuantity.split(CommonConstants.DELIMITER_MULTIPLY);
                if (null == itemArr || itemArr.length != 2) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "调拨明细参数不合法");
                }
                int itemId = ArithUtils.converStringToInt(itemArr[0]);
                int receiveQuantity = ArithUtils.converStringToInt(itemArr[1]);
                if (itemId <= 0 || receiveQuantity < 0) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "调拨明细参数不合法");
                }
                FlittingOrderAuditItemDto flittingOrderAuditItemDto = new FlittingOrderAuditItemDto();
                flittingOrderAuditItemDto.setFlittingOrderItemId(itemId);
                flittingOrderAuditItemDto.setRealReceiveQuantity(receiveQuantity);
                flittingOrderAuditItemDtoDtoList.add(flittingOrderAuditItemDto);
            }
            flittingOrderAuditDto.setFlittingOrderAuditItemDtoList(flittingOrderAuditItemDtoDtoList);
            flittingOrderService.updateForUlitmateModify(flittingOrderAuditDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "终极修改成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
