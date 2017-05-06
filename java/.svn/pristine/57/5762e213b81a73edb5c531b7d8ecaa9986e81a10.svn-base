package com.yilidi.o2o.controller.operation.user;

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
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.report.export.user.WithdrawApplyReportExport;
import com.yilidi.o2o.report.export.user.WithdrawApplySuccessDetailReportExport;
import com.yilidi.o2o.user.service.IWithdrawApplyService;
import com.yilidi.o2o.user.service.dto.WithdrawApplyDto;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * @Description:TODO(用户提现申请类别控制器)
 * @author: llp
 * @date: 2015年11月14日 下午3:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class WithdrawApplyController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IWithdrawApplyService withdrawApplyService;

    @Autowired
    private WithdrawApplyReportExport withdrawApplyReportExport;

    @Autowired
    private WithdrawApplySuccessDetailReportExport withdrawApplySuccessDetailReportExport;

    /**
     * @Description TODO(查询提现申请记录管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listWithdrawApply")
    @ResponseBody
    public MsgBean listWithdrawApply(@RequestBody WithdrawApplyQuery query) {
        try {
            query.setOrder("A.APPLYTIME");
            query.setSort("DESC");
            YiLiDiPage<WithdrawApplyDto> page = withdrawApplyService.findWithdrawApplies(query);
            logger.info("YiLiDiPage listWithdrawApply: " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询提现申请成功");
        } catch (Exception e) {
            logger.error("查询提现申请失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询提现历史记录,查询的是提现成功的记录)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listWithdrawApplyLog")
    @ResponseBody
    public MsgBean listWithdrawApplyLog(@RequestBody WithdrawApplyQuery query) {
        try {
            query.setOrder("A.APPLYTIME");
            query.setSort("DESC");
            query.setStatusCode(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED);
            YiLiDiPage<WithdrawApplyDto> page = withdrawApplyService.findWithdrawApplies(query);
            logger.info("YiLiDiPage listWithdrawApplyLog : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询提现申请成功");
        } catch (Exception e) {
            logger.error("查询提现申请失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询提现申请记录详情)
     * @param query
     * @return
     */
    @RequestMapping(value = "/{id}/loadWithdrawApplyDetail")
    @ResponseBody
    public MsgBean loadWithdrawApplyDetail(@PathVariable("id") Integer id) {
        try {
            WithdrawApplyDto withdrawApply = withdrawApplyService.loadWithdrawApplyById(id);
            logger.info("withdrawApply : " + JsonUtils.toJsonStringWithDateFormat(withdrawApply));
            return super.encapsulateMsgBean(withdrawApply, MsgBean.MsgCode.SUCCESS, "查询提现申请记录详细信息成功");
        } catch (Exception e) {
            logger.error("查询提现申请记录详细信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(申请审核：修改审核状态)
     * @param id
     * @param statusCode
     * @param auditNote
     * @return
     */
    @RequestMapping(value = "/{id}-{statusCode}-{auditNote}/updateWithdrawApplyAuditStatus")
    @ResponseBody
    public MsgBean updateWithdrawApplyAuditStatus(@PathVariable("id") Integer id,
            @PathVariable("statusCode") String statusCode, @PathVariable("auditNote") String auditNote) {
        try {
            Param statusCodeTemp = new Param.Builder("审核状态", Param.ParamType.STR_NORMAL.getType(), statusCode, false)
                    .build();
            Param auditNoteTemp = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), auditNote, true).maxLength(
                    50).build();
            super.validateParams(statusCodeTemp, auditNoteTemp);
            withdrawApplyService.updateForAudit(id, statusCode, auditNote, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改提现申请审核状态成功");
        } catch (Exception e) {
            logger.error("修改提现申请审核状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(提现转账：修改提现成功状态)
     * @param id
     * @param statusCode
     * @return
     */
    @RequestMapping(value = "/{id}/updateForWithdrawTransferStatus")
    @ResponseBody
    public MsgBean updateForWithdrawTransferStatus(@PathVariable("id") Integer id) {
        try {
            String statusCode = SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED;
            withdrawApplyService.updateForWithdrawTransferStatus(id, statusCode);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改提现转账状态成功");
        } catch (Exception e) {
            logger.error("修改提现转账状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量审核通过：修改提现申请审核状态)
     * @param param
     * @return
     */
    @RequestMapping(value = "/{param}/batchAuditPassWithdrawApplyStatus")
    @ResponseBody
    public MsgBean batchAuditPassWithdrawApplyStatus(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    Integer applyId = Integer.valueOf(paramString);
                    WithdrawApplyDto withdrawApplyDto = withdrawApplyService.loadById(applyId);
                    // 未审核状态的记录才可进行审核
                    if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto)) {
                        if (withdrawApplyDto.getStatusCode().equals(
                                SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_NOT_YET)) {
                            String auditStatus = SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_PASSED;
                            Integer auditUserId = super.getUserId();
                            String auditNote = "批量审核通过";
                            withdrawApplyService.updateForAudit(applyId, auditStatus, auditNote, auditUserId);
                        }
                    }
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量审核通过：修改提现申请审核状态成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "批量审核通过：修改提现申请审核状态失败");
            }
        } catch (Exception e) {
            logger.error("批量审核通过：修改提现申请审核状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量审核不通过：修改提现申请审核状态)
     * @param param
     * @return
     */
    @RequestMapping(value = "/{param}/batchAuditNotPassWithdrawApplyStatus")
    @ResponseBody
    public MsgBean batchAuditNotPassWithdrawApplyStatus(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    Integer applyId = Integer.valueOf(paramString);
                    WithdrawApplyDto withdrawApplyDto = withdrawApplyService.loadById(applyId);
                    // 未审核状态的记录才可进行审核
                    if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto)) {
                        if (withdrawApplyDto.getStatusCode().equals(
                                SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_NOT_YET)) {
                            String auditStatus = SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_NOT_PASSED;
                            Integer auditUserId = super.getUserId();
                            String auditNote = "批量审核不通过";
                            withdrawApplyService.updateForAudit(applyId, auditStatus, auditNote, auditUserId);
                        }
                    }
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量审核不通过：修改提现申请审核状态成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "批量审核不通过：修改提现申请审核状态失败");
            }
        } catch (Exception e) {
            logger.error("批量审核不通过：修改提现申请审核状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    // 提现转账：通过银行卡提现转账，提现成功，用户账户余额减少，提现申请记录状态改为提现成功，以及更新提现时间

    /**
     * @Description TODO(导出门店提现列表)
     * @param query
     * @return
     */
    @RequestMapping("/exportWithdrawApply")
    @ResponseBody
    public MsgBean exportWithdrawApply(@RequestBody WithdrawApplyQuery query) {
        try {
            query.setOrder("A.APPLYTIME");
            query.setSort("DESC");
            ReportFileModel reportFileModel = withdrawApplyReportExport.exportExcel(query, "门店提现申请记录统计报表");
            logger.info("exportWithdrawApply : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店提现申请记录统计报表导出成功");
        } catch (Exception e) {
            logger.error("门店提现申请记录统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店提现明细记录（提现成功的记录）列表) 导出门店提现成功的明细报表：具体的提现金额扣除相关账本金额详细记录报表数据
     * @param query
     * @return
     */
    @RequestMapping("/exportWithdrawApplySuccessLog")
    @ResponseBody
    public MsgBean exportWithdrawApplySuccessLog(@RequestBody WithdrawApplyQuery query) {
        try {
            query.setOrder("A.APPLYTIME");
            query.setSort("DESC");
            // 提现成功的提现明细
            query.setStatusCode(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED);
            ReportFileModel reportFileModel = withdrawApplySuccessDetailReportExport.exportExcel(query, "门店提现明细统计报表");
            logger.info("exportWithdrawApplySuccessDetail : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店提现明细统计报表导出成功");
        } catch (Exception e) {
            logger.error("提门店提现明细统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}