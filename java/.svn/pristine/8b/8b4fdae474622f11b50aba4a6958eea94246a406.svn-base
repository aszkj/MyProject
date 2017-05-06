package com.yilidi.o2o.controller.operation.user;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.report.export.user.UserAccountDetailReportExport;
import com.yilidi.o2o.report.export.user.UserAccountReportExport;
import com.yilidi.o2o.report.export.user.UserPayLogReportExport;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.dto.AccountDetailDto;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.OnlinePayDetailDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;

/**
 * @Description:TODO(买家用户账本、账本交易、在线交易管理控制器)
 * @author: llp
 * @date: 2015年11月18日 下午11:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class UserAccountController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IAccountService accountService;

    @Autowired
    private UserPayLogReportExport userPayLogReportExport;

    @Autowired
    private UserAccountReportExport userAccountReportExport;

    @Autowired
    private UserAccountDetailReportExport userAccountDetailReportExport;

    /**
     * @Description TODO(查询用户账本管理：欧币管理列表管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listUserEuroAccount")
    @ResponseBody
    public MsgBean listUserEuroAccount(@RequestBody CustomerBalanceQuery query) {
        try {
            query.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            YiLiDiPage<AccountDto> page = accountService.findAccountsForCustomerBalance(query);
            logger.info("listUserEuroAccount:" + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询用户欧币记录成功");
        } catch (Exception e) {
            logger.error("查询用户欧币记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询买家用户在线支付交易明细管理:订单在线支付和在线退款)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listUserOnlinePlayLog")
    @ResponseBody
    public MsgBean listUserOnlinePlayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            YiLiDiPage<OnlinePayDetailDto> page = accountService.findOnlinePayDetails(query);
            logger.info("listUserPlayLog: " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询买家用户支付日志列表成功");
        } catch (Exception e) {
            logger.error("查询买家用户支付日志列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据用户ID，查询用户(买家)欧币现金账户交易明细记录详情列表)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listAccountDetailByUserId")
    @ResponseBody
    public MsgBean listAccountDetailByUserId(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            YiLiDiPage<AccountDetailDto> page = accountService.findAccountDetails(query);
            logger.info("=========page : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询用户(买家)欧币现金账户交易明细信息成功");
        } catch (Exception e) {
            logger.error("查询用户(买家)欧币现金账户交易明细信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出买家用户在线交易(订单在线支付和订单退款)明细数据报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportUserOnlinePayLog")
    @ResponseBody
    public MsgBean exportUserOnlinePayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            ReportFileModel reportFileModel = userPayLogReportExport.exportExcel(query, "用户线上交易日志报表");
            logger.info("exportUserPayLog : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "用户线上交易日志报表导出成功");
        } catch (Exception e) {
            logger.error("用户线上交易日志报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出买家账本（买家用户只有现金账本：欧币）管理列表数据)
     * @param query
     * @return
     */
    @RequestMapping("/exportUserAccount")
    @ResponseBody
    public MsgBean exportUserAccount(@RequestBody CustomerBalanceQuery query) {
        try {
            query.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            ReportFileModel reportFileModel = userAccountReportExport.exportExcel(query, "用户欧币统计报表");
            logger.info("exportSellerAccount : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "用户欧币统计报表导出成功");
        } catch (Exception e) {
            logger.error("用户欧币统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出买家账本（买家用户只有现金账本：欧币）交易明细记录列表数据)
     * @param query
     * @return
     */
    @RequestMapping("/exportUserAccountDetails")
    @ResponseBody
    public MsgBean exportUserAccountDetails(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            ReportFileModel reportFileModel = userAccountDetailReportExport.exportExcel(query, "用户欧币交易明细报表");
            logger.info("exportSellerAccount : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "用户欧币统计报表导出成功");
        } catch (Exception e) {
            logger.error("用户欧币统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}