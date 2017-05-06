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
import com.yilidi.o2o.report.export.user.SellerAccountPayLogReportExport;
import com.yilidi.o2o.report.export.user.SellerAccountReportExport;
import com.yilidi.o2o.report.export.user.SellerCountAccountDetailReportExport;
import com.yilidi.o2o.report.export.user.SellerOnlinePayLogReportExport;
import com.yilidi.o2o.report.export.user.SellerRefundLogReportExport;
import com.yilidi.o2o.report.export.user.StoreProductSubsidyReportExport;
import com.yilidi.o2o.report.export.user.StoreSubsidyRecordReportExport;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.IStoreProductSubsidyService;
import com.yilidi.o2o.user.service.IStoreSubsidyRecordService;
import com.yilidi.o2o.user.service.dto.AccountDetailCountDto;
import com.yilidi.o2o.user.service.dto.AccountDetailDto;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.OnlinePayDetailDto;
import com.yilidi.o2o.user.service.dto.StoreProductSubsidyDto;
import com.yilidi.o2o.user.service.dto.StoreSubsidyRecordDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

/**
 * @Description:TODO(卖家/门店：账户账本，账本交易，在线交易管理控制器)
 * @author: llp
 * @date: 2015年11月18日 下午16:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class SellerAccountController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IAccountService accountService;

    @Autowired
    private IStoreSubsidyRecordService storeSubsidyRecordService;

    @Autowired
    private IStoreProductSubsidyService storeProductSubsidyService;

    @Autowired
    private SellerAccountReportExport sellerAccountReportExport;

    @Autowired
    private SellerAccountPayLogReportExport sellerAccountPayLogReportExport;

    @Autowired
    private SellerOnlinePayLogReportExport sellerOnlinePayLogReportExport;

    @Autowired
    private SellerRefundLogReportExport sellerRefundLogReportExport;

    @Autowired
    private StoreProductSubsidyReportExport storeProductSubsidyReportExport;

    @Autowired
    private StoreSubsidyRecordReportExport storeSubsidyRecordReportExport;

    @Autowired
    private SellerCountAccountDetailReportExport sellerCountAccountDetailReportExport;

    /**
     * @Description TODO(查询门店账户账本管理) 账户余额=现金账本+补贴金额账本(优惠券补贴+商品差价补贴+运费补贴)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listSellerAccountManage")
    @ResponseBody
    public MsgBean listSellerAccountManage(@RequestBody CustomerBalanceQuery query) {
        try {
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            YiLiDiPage<AccountDto> page = accountService.findCountSellerAccountsBalance(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店账户余额记录成功");
        } catch (Exception e) {
            logger.error("查询门店账户余额记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店账户账本交易明细管理: 账本收入和支出明细统计)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listCountSellerAccountDetail")
    @ResponseBody
    public MsgBean listCountSellerAccountDetail(@RequestBody CustomerBalanceQuery customerBalanceQuery) {
        try {
            YiLiDiPage<AccountDetailCountDto> page = accountService.findCountSellerAccountsDetail(customerBalanceQuery);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店账户账本交易明细管理: 账本收入和支出明细统计成功");
        } catch (Exception e) {
            logger.error("查询门店账户账本交易明细管理: 账本收入和支出明细统计失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据门店ID，查询该门店的商品差价补贴明细详情列表)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listStoreProductSubsidyBystoreId")
    @ResponseBody
    public MsgBean listStoreProductSubsidyBystoreId(@RequestBody StoreProductSubsidyQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 补贴时间
            query.setSort("DESC");
            YiLiDiPage<StoreProductSubsidyDto> page = storeProductSubsidyService.findStoreProductSubsidies(query);
            logger.info("=========page : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "根据门店ID，查询该门店的商品差价补贴明细详情列表信息成功");
        } catch (Exception e) {
            logger.error("根据门店ID，查询该门店的商品差价补贴明细详情列表信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据门店ID，查询该门店的现金，商品差价，优惠券和物流补贴明细详情列表)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listStoreSubsidyRecordsBystoreId")
    @ResponseBody
    public MsgBean listStoreSubsidyRecordsBystoreId(@RequestBody StoreSubsidyRecordQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 补贴时间
            query.setSort("DESC");
            YiLiDiPage<StoreSubsidyRecordDto> page = storeSubsidyRecordService.findStoreSubsidyRecords(query);
            logger.info("=========page : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "根据门店ID，查询该门店的现金，商品差价，优惠券和物流补贴明细详情列表成功");
        } catch (Exception e) {
            logger.error("根据门店ID，查询该门店的现金，商品差价，优惠券和物流补贴明细详情列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店卖家账本支付日志明细列表管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listSellerAccountPlayLog")
    @ResponseBody
    public MsgBean listSellerAccountPlayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER); // 门店
            query.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY); // 账本支付
            // 账本支付，就是订单使用了账本余额支付过的订单
            YiLiDiPage<AccountDetailDto> page = accountService.findAccountDetails(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店卖家账本支付日志明细列表成功");
        } catch (Exception e) {
            logger.error("查询门店卖家账本支付日志明细列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店在线交易明细日志：订单在线支付和订单退款的明细列表管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listSellerOnlinePlayLog")
    @ResponseBody
    public MsgBean listSellerOnlinePlayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            // 订单在线支付日志:使用在线支付的订单，存在已支付和已退款的订单交易明细
            YiLiDiPage<OnlinePayDetailDto> page = accountService.findOnlinePayDetails(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店卖家在线交易明细列表成功");
        } catch (Exception e) {
            logger.error("查询门店卖家在线交易明细列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店账本支付退款明细列表管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listSellerAccountRefundLog")
    @ResponseBody
    public MsgBean listSellerAccountRefundLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            query.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND); // 订单退款
            YiLiDiPage<AccountDetailDto> page = accountService.findAccountDetails(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店账本支付退款明细列表成功");
        } catch (Exception e) {
            logger.error("查询门店账本支付退款明细列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店账本管理列表数据报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportSellerAccount")
    @ResponseBody
    public MsgBean exportSellerAccount(@RequestBody CustomerBalanceQuery query) {
        try {
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            ReportFileModel reportFileModel = sellerAccountReportExport.exportExcel(query, "门店账本统计报表");
            logger.info("exportSellerAccount : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店账本报表导出成功");
        } catch (Exception e) {
            logger.error("门店账本报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店账本支付明细数据报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportSellerAccountPayLog")
    @ResponseBody
    public MsgBean exportSellerAccountPayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER); // 门店
            query.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY); // 账本支付
            // 账本支付，就是订单使用了账本余额支付过的订单
            ReportFileModel reportFileModel = sellerAccountPayLogReportExport.exportExcel(query, "门店账本支付日志报表");
            logger.info("exportSellerAccountPayLog : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店账本支付日志报表导出成功");
        } catch (Exception e) {
            logger.error("门店账本支付日志报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店在线支付交易（订单在线支付和订单退款）日志数据)
     * @param query
     * @return
     */
    @RequestMapping("/exportSellerOnlinePayLog")
    @ResponseBody
    public MsgBean exportSellerOnlinePayLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            // 订单在线支付日志:使用在线支付的订单，存在已支付和已退款的订单交易明细
            ReportFileModel reportFileModel = sellerOnlinePayLogReportExport.exportExcel(query, "门店线上交易日志报表");
            logger.info("exportSellerOnlinePayLog : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店线上交易日志报表导出成功");
        } catch (Exception e) {
            logger.error("门店线上交易日志报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店账本退款明细数据报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportSellerAccountRefundLog")
    @ResponseBody
    public MsgBean exportSellerAccountRefundLog(@RequestBody AccountDetailQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 交易时间
            query.setSort("DESC");
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            query.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND); // 订单退款
            ReportFileModel reportFileModel = sellerRefundLogReportExport.exportExcel(query, "门店账本退款日志报表");
            logger.info("exportSellerRefundLog : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店账本退款日志报表导出成功");
        } catch (Exception e) {
            logger.error("门店账本退款日志报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店商品差价补贴明细日志数据报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportStoreProductSubsidy")
    @ResponseBody
    public MsgBean exportStoreProductSubsidy(@RequestBody StoreProductSubsidyQuery query) {
        try {
            ReportFileModel reportFileModel = storeProductSubsidyReportExport.exportExcel(query, "门店商品补贴明细报表");
            logger.info("exportStoreProductSubsidy : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店商品补贴明细报表导出成功");
        } catch (Exception e) {
            logger.error("门店商品补贴明细报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店账本补贴明细日志数据报表：门店账本收入明细报表)
     * @param query
     * @return
     */
    @RequestMapping("/exportStoreSubsidyRecord")
    @ResponseBody
    public MsgBean exportStoreSubsidyRecord(@RequestBody StoreSubsidyRecordQuery query) {
        try {
            ReportFileModel reportFileModel = storeSubsidyRecordReportExport.exportExcel(query, "门店账本补贴明细报表");
            logger.info("exportStoreSubsidyRecord : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店账本补贴明细报表导出成功");
        } catch (Exception e) {
            logger.error("门店账本补贴明细报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店账户账本交易明细管理: 账本收入和支出明细统计报表)
     * @param query
     * @return
     */
    @RequestMapping(value = "/exportCountSellerAccountDetail")
    @ResponseBody
    public MsgBean exportCountSellerAccountDetail(@RequestBody CustomerBalanceQuery customerBalanceQuery) {
        try {
            ReportFileModel reportFileModel = sellerCountAccountDetailReportExport.exportExcel(customerBalanceQuery,
                    " 门店账本交易统计报表");
            logger.info("exportStoreSubsidyRecord : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "导出门店账户账本交易: 账本收入和支出明细统计报表导出成功");
        } catch (Exception e) {
            logger.error("导出门店账户账本交易: 账本收入和支出明细统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}