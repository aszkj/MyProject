package com.yilidi.o2o.controller.operation.user;

import java.text.ParseException;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.report.export.user.BuyerFeedbackExport;
import com.yilidi.o2o.user.service.IBuyerFeedbackService;
import com.yilidi.o2o.user.service.dto.BuyerFeedbackDto;
import com.yilidi.o2o.user.service.dto.query.BuyerFeedbackQueryDto;

/**
 * 运营端买家反馈管理
 *
 * @author: zhangkun
 * @date: 2016年11月22日 下午12:53:01
 */
@Controller
@RequestMapping(value = "/operation")
public class BuyerFeedbackController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IBuyerFeedbackService buyerFeedbackService;

    @Autowired
    private BuyerFeedbackExport buyerFeedbackExport;

    private void operateParam(BuyerFeedbackQueryDto buyerFeedbackQueryDto) throws ParseException {
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getBeginSubmitTime())) {
            buyerFeedbackQueryDto
                    .setSubmitBeginTime(DateUtils.getSpecificStartDate(buyerFeedbackQueryDto.getBeginSubmitTime()));
        }
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getEndSubmitTime())) {
            buyerFeedbackQueryDto.setSubmitEndTime(DateUtils.getSpecificEndDate(buyerFeedbackQueryDto.getEndSubmitTime()));
        }
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getBeginOperateTime())) {
            buyerFeedbackQueryDto
                    .setOperateBeginTime(DateUtils.getSpecificStartDate(buyerFeedbackQueryDto.getBeginOperateTime()));
        }
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getEndOperateTime())) {
            buyerFeedbackQueryDto.setOperateEndTime(DateUtils.getSpecificEndDate(buyerFeedbackQueryDto.getEndOperateTime()));
        }

        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getUserMobile())) {
            buyerFeedbackQueryDto.setUserMobile(buyerFeedbackQueryDto.getUserMobile().trim());
        }
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getOperateStatus())) {
            buyerFeedbackQueryDto.setOperateStatus(buyerFeedbackQueryDto.getOperateStatus().trim());
        }
        if (!StringUtils.isEmpty(buyerFeedbackQueryDto.getContentClassify())) {
            buyerFeedbackQueryDto.setContentClassify(buyerFeedbackQueryDto.getContentClassify().trim());
        }
    }

    /**
     * 获取买家反馈列表
     * 
     * @param userId
     * @param userMobile
     * @param content
     * @return MsgBean
     */
    @RequestMapping(value = "/getAllBuyerFeedback")
    @ResponseBody
    public MsgBean getAllBuyerFeedback(@RequestBody BuyerFeedbackQueryDto buyerFeedbackQueryDto) {
        try {
            operateParam(buyerFeedbackQueryDto);
            YiLiDiPage<BuyerFeedbackDto> page = buyerFeedbackService.getAllBuyerFeedback(buyerFeedbackQueryDto);
            logger.info("YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询买家反馈列表成功");
        } catch (ParseException e) {
            logger.info("查询买家反馈列表异常");
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据id获取买家反馈
     * 
     * @param userId
     * @param userMobile
     * @param content
     * @return MsgBean
     */
    @RequestMapping(value = "/getBuyerFeedbackById/{id}")
    @ResponseBody
    public MsgBean getBuyerFeedbackById(@PathVariable(value = "id") Integer id) {
        if (null == id) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误请重试");
        }
        BuyerFeedbackDto buyerFeedbackDto = buyerFeedbackService.getBuyerFeedbackById(id);
        if (!ObjectUtils.isNullOrEmpty(buyerFeedbackDto)) {
            return super.encapsulateMsgBean(buyerFeedbackDto, MsgBean.MsgCode.SUCCESS, "");
        }
        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "此数据有误");
    }

    /**
     * 修改买家反馈（处理买家反馈）
     * 
     * @param userId
     * @param userMobile
     * @param content
     * @return MsgBean
     */
    @RequestMapping(value = "/updateBuyerFeedback")
    @ResponseBody
    public MsgBean updateBuyerFeedback(@RequestBody BuyerFeedbackDto buyerFeedbackDto) {
        if (null == buyerFeedbackDto.getId()) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误请重试");
        }
        if (StringUtils.isEmpty(buyerFeedbackDto.getContentClassify())) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择反馈类型");
        }
        buyerFeedbackDto.setOperateTime(new Date());
        buyerFeedbackDto.setOperateId(super.getUserId());
        buyerFeedbackDto.setOperateName(super.getUserName());
        buyerFeedbackDto.setOperateStatus(SystemContext.UserDomain.FEEDBACKSTATIS_YESDISPOSE);
        boolean flag = buyerFeedbackService.updateBuyerFeedback(buyerFeedbackDto);
        if (flag) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        }
        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "操作失败");
    }

    /**
     * 导出买家反馈列表
     * 
     * @param query
     * @return MsgBean
     */
    @RequestMapping("/exportBuyerFeedback")
    @ResponseBody
    public MsgBean exportBuyerFeedback(@RequestBody BuyerFeedbackQueryDto buyerFeedbackQueryDto) {
        try {
            operateParam(buyerFeedbackQueryDto);
            ReportFileModel reportFileModel = buyerFeedbackExport.exportExcel(buyerFeedbackQueryDto, "买家反馈表");
            logger.info("exportBuyerFeedback : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "买家反馈表导出成功");
        } catch (Exception e) {
            logger.error("买家反馈表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
