/**
 * 文件名称：SystemContext.java
 * 
 * 描述：系统使用的常量定义
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core;

/**
 * 功能描述：系统字典常量定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class SystemContext {

    private SystemContext() {
    }

    public static final class UserDomain {

        public static enum DictType {
            CUSTOMERTYPE("CUSTOMERTYPE", "客户类型"), USERAUDITSTATUS("USERAUDITSTATUS", "用户审核状态"), USERSTATUS("USERSTATUS",
                    "用户状态"), CUSTOMERSTATUS("CUSTOMERSTATUS", "客户状态"), USERMASTERFLAG("USERMASTERFLAG", "用户主帐号标识"), BUYERLEVEL(
                    "BUYERLEVEL", "终端用户级别"), SELLERLEVEL("SELLERLEVEL", "店铺用户级别"), OPERATORDEPARTMENTTYPE(
                    "OPERATORDEPARTMENTTYPE", "运营商用户所属部门类型"), TRANSFERACCOUNTTYPE("TRANSFERACCOUNTTYPE", "账户提现转账类型"), ACCOUNTTYPECODE(
                    "ACCOUNTTYPECODE", "账本类型"), ACCOUNTPAYMODE("ACCOUNTPAYMODE", "账本支付模式"), ACCOUNTBINDINGTYPE(
                    "ACCOUNTBINDINGTYPE", "绑定账户类型"), PAYSTATUSCODE("PAYSTATUSCODE", "支付状态类型"), REFUNDTYPE("REFUNDTYPE",
                    "退款操作类型"), ACCOUNTDETAILTYPE("ACCOUNTDETAILTYPE", "账户明细类别"), ACCOUNTCHANGETYPE("ACCOUNTCHANGETYPE",
                    "账户资金变动类型"), DEPOSITENABLEDFLAG("DEPOSITENABLEDFLAG", "保证金监控有效状态"), DEPOSITCHANGETYPE(
                    "DEPOSITCHANGETYPE", "保证金变化类型"), DEPOSITSOURCE("DEPOSITSOURCE", "保证金来源"), DEPOSITTARGET("DEPOSITTARGET",
                    "保证金去向"), COMMISSIONCLEARTYPE("COMMISSIONCLEARTYPE", "佣金设置结算方式"), COMMISSIONSTATUS("COMMISSIONSTATUS",
                    "佣金设置状态"), COMMISSIONSYNCFLAG("COMMISSIONSYNCFLAG", "佣金设置同步标识"), COMMISSIONCLEARUPOPERTYPE(
                    "COMMISSIONCLEARUPOPERTYPE", "佣金结算记录类型"), COMMISSIONCLEARUPSTATUS("COMMISSIONCLEARUPSTATUS", "佣金结算状态"), WITHDRAWAPPLYAUDITSTATUS(
                    "WITHDRAWAPPLYAUDITSTATUS", "提款申请审核状态"), CONSADDRDEFAULTFLAG("CONSADDRDEFAULTFLAG", "默认收货地址标识"), CONSADDRSTATUS(
                    "CONSADDRSTATUS", "收货地址状态"), LOGISTFEETYPE("LOGISTFEETYPE", "物流计价方式"), LOGISTENABLEDFLAG(
                    "LOGISTENABLEDFLAG", "物流设置有效状态"), LOGISTICS("LOGISTICS", "物流商"), LOGISTICSFREESETTING(
                    "LOGISTICSFREESETTING", "物流包邮设置"), STOREEVALUATIONANONYMITYEVAL("STOREEVALUATIONANONYMITYEVAL", "是否匿名评价"), STOREEVALUATIONSYSTEMEVAL(
                    "STOREEVALUATIONSYSTEMEVAL", "是否系统评价"), STOREEVALUATIONSTATUS("STOREEVALUATIONSTATUS", "门店评论是否显示"), CHANNELTYPE(
                    "CHANNELTYPE", "用户注册渠道类型"), STORESTATUS("STORESTATUS", "店铺状态"), COMMUNITYDISPLAY("COMMUNITYDISPLAY",
                    "小区是否显示"), SALEPRODUCTEVALUATIONPHOTOFLAG("SALEPRODUCTEVALUATIONPHOTOFLAG", "产品评论是否上传图片"), STOREDELIVERYSTATE(
                    "STOREDELIVERYSTATE", "店铺接单员是否有效"), STOREDELIVERYORDERRECORDSTEP("STOREDELIVERYORDERRECORDSTEP",
                    "店铺接单员处理订单步骤"), STORETYPE("STORETYPE", "店铺类型"), ISFIRSTORDERFORUSER("ISFIRSTORDERFORUSER", "是否是用户的首单"), LOGINTYPE(
                    "LOGINTYPE", "登录类型"), FEEDBACKTYPE("FEEDBACKTYPE", " 用户反馈类型"), FEEDBACKSTATIS("FEEDBACKSTATIS", "用户反馈状态"), CONNECTUSERCONNECTTYPE(
                    "CONNECTUSERCONNECTTYPE", "第三方接入类型"), SHARERULEROLETYPE("SHARERULEROLETYPE", "分享规则角色类型"), SHARERULESTATUS(
                    "SHARERULESTATUS", "分享规则状态"), SHARERULEINVITERCONDITIONTYPE("SHARERULEINVITERCONDITIONTYPE",
                    "分享规则邀请人限制条件"), SHARERULEINVITEDCONDITIONTYPE("SHARERULEINVITEDCONDITIONTYPE", "分享规则被邀请人限制条件"), SHARERULEAWARDTYPE(
                    "SHARERULEAWARDTYPE", "分享规则奖励设置"), STORESTOCKSHARE("STORESTOCKSHARE", "是否共享库存"), INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE(
                    "INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE", "修改批次编码"), USERGENDER("USERGENDER", "用户性别类型"), SETTLEMENTRULEHISTORYOPERTYPE("SETTLEMENTRULEHISTORYOPERTYPE", "结算规则设置历史操作类型");

            private final String value;
            private final String text;

            private DictType(String value, String text) {
                this.value = value;
                this.text = text;
            }

            public String getValue() {
                return value;
            }

            public String getText() {
                return text;
            }

            public static DictType getEnum(String value) {
                if (value != null) {
                    DictType[] values = DictType.values();
                    for (DictType val : values) {
                        if (val.getValue().equals(value)) {
                            return val;
                        }
                    }
                }
                return null;
            }
        }

        /**
         * 客户类型： CUSTOMERTYPE_OPERATOR 运营商（平台运营机构） （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CUSTOMERTYPE的内容）
         */
        public static final String CUSTOMERTYPE_OPERATOR = "CUSTOMERTYPE_OPERATOR";
        /**
         * 客户类型：CUSTOMERTYPE_SELLER 门店（卖家）名称 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CUSTOMERTYPE的内容）
         */
        public static final String CUSTOMERTYPE_SELLER = "CUSTOMERTYPE_SELLER";
        /**
         * 客户类型：CUSTOMERTYPE_BUYER 终端用户（买家） （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CUSTOMERTYPE的内容）
         */
        public static final String CUSTOMERTYPE_BUYER = "CUSTOMERTYPE_BUYER";

        /**
         * 用户审核状态： USERAUDITSTATUS_NOT_YET 未审核 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERAUDITSTATUS的内容）
         */
        public static final String USERAUDITSTATUS_NOT_YET = "USERAUDITSTATUS_NOT_YET";
        /**
         * 用户审核状态： USERAUDITSTATUS_PASSED 审核通过 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERAUDITSTATUS的内容）
         */
        public static final String USERAUDITSTATUS_PASSED = "USERAUDITSTATUS_PASSED";
        /**
         * 用户审核状态： USERAUDITSTATUS_NOT_PASSED 审核不通过 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERAUDITSTATUS的内容）
         */
        public static final String USERAUDITSTATUS_NOT_PASSED = "USERAUDITSTATUS_NOT_PASSED";

        /**
         * 用户状态： USERSTATUS_ON 启用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERSTATUS的内容）
         */
        public static final String USERSTATUS_ON = "USERSTATUS_ON";
        /**
         * 用户状态： USERSTATUS_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERSTATUS的内容）
         */
        public static final String USERSTATUS_OFF = "USERSTATUS_OFF";

        /**
         * 客户状态： CUSTOMERSTATUS_ON 启用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CUSTOMERSTATUS的内容）
         */
        public static final String CUSTOMERSTATUS_ON = "CUSTOMERSTATUS_ON";
        /**
         * 客户状态： CUSTOMERSTATUS_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CUSTOMERSTATUS的内容）
         */
        public static final String CUSTOMERSTATUS_OFF = "CUSTOMERSTATUS_OFF";

        /**
         * 用户主帐号标识： USERMASTERFLAG_MAIN 主账号（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERMASTERFLAG的内容）
         */
        public static final String USERMASTERFLAG_MAIN = "USERMASTERFLAG_MAIN";
        /**
         * 用户主帐号标识： USERMASTERFLAG_SUB 子账号（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERMASTERFLAG的内容）
         */
        public static final String USERMASTERFLAG_SUB = "USERMASTERFLAG_SUB";

        /**
         * 终端用户级别：BUYERLEVEL_A A类买家 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=BUYERLEVEL的内容）
         */
        public static final String BUYERLEVEL_A = "BUYERLEVEL_A";
        /**
         * 终端用户级别：BUYERLEVEL_B B类买家 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=BUYERLEVEL的内容）
         */
        public static final String BUYERLEVEL_B = "BUYERLEVEL_B";

        /**
         * 店铺用户级别：SELLERLEVEL_A A类卖家 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SELLERLEVEL的内容）
         */
        public static final String SELLERLEVEL_A = "SELLERLEVEL_A";
        /**
         * 店铺用户级别：SELLERLEVEL_B B类卖家 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SELLERLEVEL的内容）
         */
        public static final String SELLERLEVEL_B = "SELLERLEVEL_B";

        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_PRESIDENT_OFFICE 总裁办
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_PRESIDENT_OFFICE = "OPERATORDEPARTMENTTYPE_PRESIDENT_OFFICE";
        /**
         * 运营商用户所属部门类型： OPERATORDEPARTMENTTYPE_TECHNOLOG 技术部 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_TECHNOLOG = "OPERATORDEPARTMENTTYPE_TECHNOLOG";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_FINANCIAL 财务部 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_FINANCIAL = "OPERATORDEPARTMENTTYPE_FINANCIAL";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_SERVICE 客服部 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_SERVICE = "OPERATORDEPARTMENTTYPE_SERVICE";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_INVESTMENT 招商部 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_INVESTMENT = "OPERATORDEPARTMENTTYPE_INVESTMENT";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_BUSINESS_EXPENDING_SALES 拓展销售部
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_BUSINESS_EXPENDING_SALES = "OPERATORDEPARTMENTTYPE_BUSINESS_EXPENDING_SALES";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_HR 人事行政部 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_HR = "OPERATORDEPARTMENTTYPE_HR";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_OPERATION_MARKETING_CENTER 运营营销中心
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_OPERATION_MARKETING_CENTER = "OPERATORDEPARTMENTTYPE_OPERATION_MARKETING_CENTER";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_LOGISTICS_CENTER 物流中心
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_LOGISTICS_CENTER = "OPERATORDEPARTMENTTYPE_LOGISTICS_CENTER";
        /**
         * 运营商用户所属部门类型：OPERATORDEPARTMENTTYPE_COMMODITY_CENTER 商品中心
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=OPERATORDEPARTMENTTYPE的内容）
         */
        public static final String OPERATORDEPARTMENTTYPE_COMMODITY_CENTER = "OPERATORDEPARTMENTTYPE_COMMODITY_CENTER";

        /**
         * 账本类型： ACCOUNTTYPECODE_CASH 现金账本（买家：欧币，卖家：订单补贴金额，可提现金额）（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTTYPECODE的内容）
         */
        public static final String ACCOUNTTYPECODE_CASH = "ACCOUNTTYPECODE_CASH";
        /**
         * 账本类型： ACCOUNTTYPECODE_LOGISTICSSUBSIDY 物流补贴账本（卖家）（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTTYPECODE的内容）
         */
        public static final String ACCOUNTTYPECODE_LOGISTICSSUBSIDY = "ACCOUNTTYPECODE_LOGISTICSSUBSIDY";
        /**
         * 账本类型： ACCOUNTTYPECODE_PRODCUTPRICESUBSIDY 商品差价补贴账本（卖家）（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTTYPECODE的内容）
         */
        public static final String ACCOUNTTYPECODE_PRODCUTPRICESUBSIDY = "ACCOUNTTYPECODE_PRODCUTPRICESUBSIDY";
        /**
         * 账本类型： ACCOUNTTYPECODE_COUPONSUBSIDY 优惠券补贴账本（卖家）（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTTYPECODE的内容）
         */
        public static final String ACCOUNTTYPECODE_COUPONSUBSIDY = "ACCOUNTTYPECODE_COUPONSUBSIDY";

        /**
         * 账本支付模式： ACCOUNTPAYMODE_FULLPAY 全额支付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTPAYMODE的内容）
         */
        public static final String ACCOUNTPAYMODE_FULLPAY = "ACCOUNTPAYMODE_FULLPAY";
        /**
         * 账本支付模式： ACCOUNTPAYMODE_PERCENTPAY 按比例支付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTPAYMODE的内容）
         */
        public static final String ACCOUNTPAYMODE_PERCENTPAY = "ACCOUNTPAYMODE_PERCENTPAY";
        /**
         * 账本支付模式： ACCOUNTPAYMODE_COUNTPAY 按张数支付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTPAYMODE的内容）
         */
        public static final String ACCOUNTPAYMODE_COUNTPAY = "ACCOUNTPAYMODE_COUNTPAY";

        /**
         * 绑定在线支付支付状态类别： PAYSTATUSCODE_HAVEPAY 已支付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PAYSTATUSCODE的内容）
         */
        public static final String PAYSTATUSCODE_HAVEPAY = "PAYSTATUSCODE_HAVEPAY";
        /**
         * 绑定在线支付支付状态类别： PAYSTATUSCODE_REFUND 退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PAYSTATUSCODE的内容）
         */
        public static final String PAYSTATUSCODE_REFUND = "PAYSTATUSCODE_REFUND";

        /**
         * 绑定用户退款操作类别：REFUNDTYPE_USER 用户取消退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDTYPE的内容）
         */
        public static final String REFUNDTYPE_USER = "REFUNDTYPE_USER";
        /**
         * 绑定用户退款操作类别： REFUNDTYPE_OPERATOR 运营取消退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDTYPE的内容）
         */
        public static final String REFUNDTYPE_OPERATOR = "REFUNDTYPE_OPERATOR";

        /**
         * 门店提现绑定银行卡账户转账类型： TRANSFERACCOUNTTYPE_PUBLIC
         * 门店提现绑定银行卡账户转账类型：对公（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=TRANSFERACCOUNTTYPE的内容）
         */
        public static final String TRANSFERACCOUNTTYPE_PUBLIC = "TRANSFERACCOUNTTYPE_PUBLIC";
        /**
         * 门店提现绑定银行卡账户转账类型： TRANSFERACCOUNTTYPE_PRIVATE
         * 门店提现绑定银行卡账户转账类型：对私（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=TRANSFERACCOUNTTYPE的内容）
         */
        public static final String TRANSFERACCOUNTTYPE_PRIVATE = "TRANSFERACCOUNTTYPE_PRIVATE";

        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_ALIPAY 支付宝（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_ALIPAY = "ACCOUNTBINDINGTYPE_ALIPAY";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_WXPAY 微支付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_WXPAY = "ACCOUNTBINDINGTYPE_WXPAY";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_BOC 中国银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_BOC = "ACCOUNTBINDINGTYPE_BOC";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CCB 中国建设银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CCB = "ACCOUNTBINDINGTYPE_CCB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_ICBC 中国工商银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_ICBC = "ACCOUNTBINDINGTYPE_ICBC";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_ABC 中国农业银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_ABC = "ACCOUNTBINDINGTYPE_ABC";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_BCM 中国交通银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_BCM = "ACCOUNTBINDINGTYPE_BCM";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CMB 中国招商银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CMB = "ACCOUNTBINDINGTYPE_CMB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CMBC 中国民生银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CMBC = "ACCOUNTBINDINGTYPE_CMBC";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CIB 中国兴业银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CIB = "ACCOUNTBINDINGTYPE_CIB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CEB 中国光大银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CEB = "ACCOUNTBINDINGTYPE_CEB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_HSBC 汇丰银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_HSBC = "ACCOUNTBINDINGTYPE_HSBC";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_HXB 华夏银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_HXB = "ACCOUNTBINDINGTYPE_HXB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_SPDB 浦发银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_SPDB = "ACCOUNTBINDINGTYPE_SPDB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_PAB 平安银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_PAB = "ACCOUNTBINDINGTYPE_PAB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CZB 浙商银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CZB = "ACCOUNTBINDINGTYPE_CZB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CGB 广发银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CGB = "ACCOUNTBINDINGTYPE_CGB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_EB 恒丰银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_EB = "ACCOUNTBINDINGTYPE_EB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CBB 渤海银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CBB = "ACCOUNTBINDINGTYPE_CBB";
        /**
         * 绑定账户类型： ACCOUNTBINDINGTYPE_CCIB 中信银行（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTBINDINGTYPE的内容）
         */
        public static final String ACCOUNTBINDINGTYPE_CCIB = "ACCOUNTBINDINGTYPE_CCIB";

        /**
         * 账户交易明细类别： ACCOUNTDETAILTYPE_IN 收入（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTDETAILTYPE的内容）
         */
        public static final String ACCOUNTDETAILTYPE_IN = "ACCOUNTDETAILTYPE_IN";
        /**
         * 账户交易明细类别： ACCOUNTDETAILTYPE_OUT 支出（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTDETAILTYPE的内容）
         */
        public static final String ACCOUNTDETAILTYPE_OUT = "ACCOUNTDETAILTYPE_OUT";

        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_CHARGE 在线/系统充值（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         * 门店/买家暂时未做在线、系统充值功能
         */
        public static final String ACCOUNTCHANGETYPE_CHARGE = "ACCOUNTCHANGETYPE_CHARGE";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_WITHDRAW 账本提现（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         * 门店提现已单独有提现申请记录，买家目前未做提现
         */
        public static final String ACCOUNTCHANGETYPE_WITHDRAW = "ACCOUNTCHANGETYPE_WITHDRAW";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_PAY 订单付款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_PAY = "ACCOUNTCHANGETYPE_PAY";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_REFUND 订单退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_REFUND = "ACCOUNTCHANGETYPE_REFUND";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_PAY_DEPOSIT 缴纳保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_PAY_DEPOSIT = "ACCOUNTCHANGETYPE_PAY_DEPOSIT";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_RELEASE_DEPOSIT 解冻保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_RELEASE_DEPOSIT = "ACCOUNTCHANGETYPE_RELEASE_DEPOSIT";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_ADJUST_BALANCE 调整账户余额（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_ADJUST_BALANCE = "ACCOUNTCHANGETYPE_ADJUST_BALANCE";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_FREEZE_FUND 冻结资金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_FREEZE_FUND = "ACCOUNTCHANGETYPE_FREEZE_FUND";
        /**
         * 账户资金变动类型： ACCOUNTCHANGETYPE_UNFREEZE_FROZEN_FUND 解冻冻结资金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ACCOUNTCHANGETYPE的内容）
         */
        public static final String ACCOUNTCHANGETYPE_UNFREEZE_FROZEN_FUND = "ACCOUNTCHANGETYPE_UNFREEZE_FROZEN_FUND";

        /**
         * 保证金监控有效状态： DEPOSITENABLEDFLAG_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITENABLEDFLAG的内容）
         */
        public static final String DEPOSITENABLEDFLAG_ON = "DEPOSITENABLEDFLAG_ON";
        /**
         * 保证金监控有效状态： DEPOSITENABLEDFLAG_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITENABLEDFLAG的内容）
         */
        public static final String DEPOSITENABLEDFLAG_OFF = "DEPOSITENABLEDFLAG_OFF";

        /**
         * 保证金变化类型： DEPOSITCHANGETYPE_CHARGE 缴纳保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITCHANGETYPE的内容）
         */
        public static final String DEPOSITCHANGETYPE_CHARGE = "DEPOSITCHANGETYPE_CHARGE";
        /**
         * 保证金变化类型： DEPOSITCHANGETYPE_PAY 保证金赔付（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITCHANGETYPE的内容）
         */
        public static final String DEPOSITCHANGETYPE_PAY = "DEPOSITCHANGETYPE_PAY";
        /**
         * 保证金变化类型： DEPOSITCHANGETYPE_UNFREEZE 解冻保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITCHANGETYPE的内容）
         */
        public static final String DEPOSITCHANGETYPE_UNFREEZE = "DEPOSITCHANGETYPE_UNFREEZE";

        /**
         * 保证金来源： DEPOSITSOURCE_ACCOUNT 余额（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITSOURCE的内容）
         */
        public static final String DEPOSITSOURCE_ACCOUNT = "DEPOSITSOURCE_ACCOUNT";
        /**
         * 保证金来源： DEPOSITSOURCE_DEPOSIT 保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITSOURCE的内容）
         */
        public static final String DEPOSITSOURCE_DEPOSIT = "DEPOSITSOURCE_DEPOSIT";

        /**
         * 保证金去向： DEPOSITTARGET_ACCOUNT 余额（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITTARGET的内容）
         */
        public static final String DEPOSITTARGET_ACCOUNT = "DEPOSITTARGET_ACCOUNT";
        /**
         * 保证金去向： DEPOSITTARGET_DEPOSIT 保证金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITTARGET的内容）
         */
        public static final String DEPOSITTARGET_DEPOSIT = "DEPOSITTARGET_DEPOSIT";
        /**
         * 保证金去向： DEPOSITTARGET_BUYERACCOUNT 买家账户（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=DEPOSITTARGET的内容）
         */
        public static final String DEPOSITTARGET_BUYERACCOUNT = "DEPOSITTARGET_BUYERACCOUNT";

        /**
         * 佣金设置结算方式： COMMISSIONCLEARTYPE_MONTH 按月结算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARTYPE的内容）
         */
        public static final String COMMISSIONCLEARTYPE_MONTH = "COMMISSIONCLEARTYPE_MONTH";
        /**
         * 佣金设置结算方式： COMMISSIONCLEARTYPE_ORDER 按单结算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARTYPE的内容）
         */
        public static final String COMMISSIONCLEARTYPE_ORDER = "COMMISSIONCLEARTYPE_ORDER";

        /**
         * 佣金设置状态： COMMISSIONSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONSTATUS的内容）
         */
        public static final String COMMISSIONSTATUS_ON = "COMMISSIONSTATUS_ON";
        /**
         * 佣金设置状态： COMMISSIONSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONSTATUS的内容）
         */
        public static final String COMMISSIONSTATUS_OFF = "COMMISSIONSTATUS_OFF";

        /**
         * 佣金设置同步标识： COMMISSIONSYNCFLAG_YES 已同步（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONSYNCFLAG的内容）
         */
        public static final String COMMISSIONSYNCFLAG_YES = "COMMISSIONSYNCFLAG_YES";
        /**
         * 佣金设置同步标识： COMMISSIONSYNCFLAG_NO 未同步（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONSYNCFLAG的内容）
         */
        public static final String COMMISSIONSYNCFLAG_NO = "COMMISSIONSYNCFLAG_NO";

        /**
         * 佣金结算记录类型： COMMISSIONCLEARUPOPERTYPE_IN 扣除佣金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARUPOPERTYPE的内容）
         */
        public static final String COMMISSIONCLEARUPOPERTYPE_IN = "COMMISSIONCLEARUPOPERTYPE_IN";
        /**
         * 佣金结算记录类型： COMMISSIONCLEARUPOPERTYPE_OUT 退还佣金（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARUPOPERTYPE的内容）
         */
        public static final String COMMISSIONCLEARUPOPERTYPE_OUT = "COMMISSIONCLEARUPOPERTYPE_OUT";

        /**
         * 佣金结算状态： COMMISSIONCLEARUPSTATUS_YES 已结算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARUPSTATUS的内容）
         */
        public static final String COMMISSIONCLEARUPSTATUS_YES = "COMMISSIONCLEARUPSTATUS_YES";
        /**
         * 佣金结算状态： COMMISSIONCLEARUPSTATUS_NO 未结算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMISSIONCLEARUPSTATUS的内容）
         */
        public static final String COMMISSIONCLEARUPSTATUS_NO = "COMMISSIONCLEARUPSTATUS_NO";

        /**
         * 提款申请审核状态： WITHDRAWAPPLYAUDITSTATUS_NOT_YET 未审核 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=WITHDRAWAPPLYAUDITSTATUS的内容）
         */
        public static final String WITHDRAWAPPLYAUDITSTATUS_NOT_YET = "WITHDRAWAPPLYAUDITSTATUS_NOT_YET";
        /**
         * 提款申请审核状态： WITHDRAWAPPLYAUDITSTATUS_PASSED 审核通过 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=WITHDRAWAPPLYAUDITSTATUS的内容）
         */
        public static final String WITHDRAWAPPLYAUDITSTATUS_PASSED = "WITHDRAWAPPLYAUDITSTATUS_PASSED";
        /**
         * 提款申请审核状态： WITHDRAWAPPLYAUDITSTATUS_NOT_PASSED 审核不通过 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=WITHDRAWAPPLYAUDITSTATUS的内容）
         */
        public static final String WITHDRAWAPPLYAUDITSTATUS_NOT_PASSED = "WITHDRAWAPPLYAUDITSTATUS_NOT_PASSED";
        /**
         * 提款申请审核状态： WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED 提现成功 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=WITHDRAWAPPLYAUDITSTATUS的内容）
         */
        public static final String WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED = "WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED";

        /**
         * 默认收货地址标识： CONSADDRDEFAULTFLAG_YES 是（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CONSADDRDEFAULTFLAG的内容）
         */
        public static final String CONSADDRDEFAULTFLAG_YES = "CONSADDRDEFAULTFLAG_YES";
        /**
         * 默认收货地址标识： CONSADDRDEFAULTFLAG_NO 否（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CONSADDRDEFAULTFLAG的内容）
         */
        public static final String CONSADDRDEFAULTFLAG_NO = "CONSADDRDEFAULTFLAG_NO";

        /**
         * 收货地址状态： CONSADDRSTATUS_ON 启用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CONSADDRSTATUS的内容）
         */
        public static final String CONSADDRSTATUS_ON = "CONSADDRSTATUS_ON";
        /**
         * 收货地址状态： CONSADDRSTATUS_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CONSADDRSTATUS的内容）
         */
        public static final String CONSADDRSTATUS_OFF = "CONSADDRSTATUS_OFF";

        /**
         * 物流计价方式： LOGISTFEETYPE_WEIGHT 按重量计算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTFEETYPE的内容）
         */
        public static final String LOGISTFEETYPE_WEIGHT = "LOGISTFEETYPE_WEIGHT";
        /**
         * 物流计价方式： LOGISTFEETYPE_COUNT 按数量计算（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTFEETYPE的内容）
         */
        public static final String LOGISTFEETYPE_COUNT = "LOGISTFEETYPE_COUNT";

        /**
         * 物流设置有效状态： LOGISTENABLEDFLAG_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTENABLEDFLAG的内容）
         */
        public static final String LOGISTENABLEDFLAG_ON = "LOGISTENABLEDFLAG_ON";
        /**
         * 物流设置有效状态： LOGISTENABLEDFLAG_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTENABLEDFLAG的内容）
         */
        public static final String LOGISTENABLEDFLAG_OFF = "LOGISTENABLEDFLAG_OFF";

        /**
         * 物流商： LOGISTICS_SFEXPRESS 顺丰（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICS的内容）
         */
        public static final String LOGISTICS_SFEXPRESS = "LOGISTICS_SFEXPRESS";
        /**
         * 物流商： LOGISTICS_YTO 圆通（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICS的内容）
         */
        public static final String LOGISTICS_YTO = "LOGISTICS_YTO";
        /**
         * 物流商： LOGISTICS_EMS 中国邮政（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICS的内容）
         */
        public static final String LOGISTICS_EMS = "LOGISTICS_EMS";

        /**
         * 物流包邮设置： LOGISTICS_FREESETTING_NONE 不设置包邮条件（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICSFREESETTING的内容）
         */
        public static final String LOGISTICS_FREESETTING_NONE = "LOGISTICS_FREESETTING_NONE";
        /**
         * 物流包邮设置： LOGISTICS_FREESETTING_PURCHASE_PRICE 按单次购买金额免费（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICSFREESETTING的内容）
         */
        public static final String LOGISTICS_FREESETTING_PURCHASE_PRICE = "LOGISTICS_FREESETTING_PURCHASE_PRICE";
        /**
         * 物流包邮设置： LOGISTICS_FREESETTING_PURCHASE_COUNT 按单次购买件数免费（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICSFREESETTING的内容）
         */
        public static final String LOGISTICS_FREESETTING_PURCHASE_COUNT = "LOGISTICS_FREESETTING_PURCHASE_COUNT";
        /**
         * 物流包邮设置： LOGISTICS_FREESETTING_PURCHASE_PRICE_AND_COUNT
         * 按单次购买金额和购买件数免费（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGISTICSFREESETTING的内容）
         */
        public static final String LOGISTICS_FREESETTING_PURCHASE_PRICE_AND_COUNT = "LOGISTICS_FREESETTING_PURCHASE_PRICE_AND_COUNT";

        /**
         * 门店/产品评论是否匿名评价：STOREEVALUATIONANONYMITYEVAL_YES 是(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONANONYMITYEVAL的内容)
         */
        public static final String STOREEVALUATIONANONYMITYEVAL_YES = "STOREEVALUATIONANONYMITYEVAL_YES";
        /**
         * 门店/产品评论是否匿名评价：STOREEVALUATIONANONYMITYEVAL_NO 否(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONANONYMITYEVAL的内容)
         */
        public static final String STOREEVALUATIONANONYMITYEVAL_NO = "STOREEVALUATIONANONYMITYEVAL_NO";
        /**
         * 门店/产品评论是否系统评价：STOREEVALUATIONSYSTEMEVAL_YES 是(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONSYSTEMEVAL的内容)
         */
        public static final String STOREEVALUATIONSYSTEMEVAL_YES = "STOREEVALUATIONSYSTEMEVAL_YES";
        /**
         * 门店/产品评论是否系统评价：STOREEVALUATIONANONYMITYEVAL_NO 否(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONSYSTEMEVAL的内容)
         */
        public static final String STOREEVALUATIONSYSTEMEVAL_NO = "STOREEVALUATIONSYSTEMEVAL_NO";
        /**
         * 门店/产品评论是否显示：STOREEVALUATIONSTATUS_YES 显示(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONSTATUS的内容)
         */
        public static final String STOREEVALUATIONSTATUS_YES = "STOREEVALUATIONSTATUS_YES";
        /**
         * 门店/产品评论是否显示：STOREEVALUATIONSTATUS_NO 取消显示(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREEVALUATIONSTATUS的内容)
         */
        public static final String STOREEVALUATIONSTATUS_NO = "STOREEVALUATIONSTATUS_NO";
        /**
         * 产品评论是否有上传图片：SALEPRODUCTEVALUATIONPHOTOFLAG_YES
         * 有(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTEVALUATIONPHOTOFLAG的内容)
         */
        public static final String SALEPRODUCTEVALUATIONPHOTOFLAG_YES = "SALEPRODUCTEVALUATIONPHOTOFLAG_YES";
        /**
         * 产品评论是否有上传图片：SALEPRODUCTEVALUATIONPHOTOFLAG_NO
         * 没有(对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTEVALUATIONPHOTOFLAG的内容)
         */
        public static final String SALEPRODUCTEVALUATIONPHOTOFLAG_NO = "SALEPRODUCTEVALUATIONPHOTOFLAG_NO";
        /**
         * 渠道类型： CHANNELTYPE_ALL 全渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_ALL = "CHANNELTYPE_ALL";
        /**
         * 渠道类型： CHANNELTYPE_WEB PC渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_WEB = "CHANNELTYPE_WEB";
        /**
         * 渠道类型： CHANNELTYPE_ANDROID Android渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_ANDROID = "CHANNELTYPE_ANDROID";
        /**
         * 渠道类型： CHANNELTYPE_IOS IOS渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_IOS = "CHANNELTYPE_IOS";
        /**
         * 渠道类型： CHANNELTYPE_WEIXIN 微信渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_WEIXIN = "CHANNELTYPE_WEIXIN";
        /**
         * 渠道类型： CHANNELTYPE_SCREEN 触屏渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_SCREEN = "CHANNELTYPE_SCREEN";
        /**
         * 渠道类型： CHANNELTYPE_HTML5 触屏渠道（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容）
         */
        public static final String CHANNELTYPE_HTML5 = "CHANNELTYPE_HTML5";
        /**
         * 店铺状态： STORESTATUS_OPEN 已开启（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
         */
        public static final String STORESTATUS_OPEN = "STORESTATUS_OPEN";
        /**
         * 店铺状态： STORESTATUS_CLOSED 已关闭（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
         */
        public static final String STORESTATUS_CLOSED = "STORESTATUS_CLOSED";

        /**
         * 小区是否显示状态： COMMUNITYDISPLAY_YES 是显示（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMUNITYDISPLAY的内容）
         */
        public static final String COMMUNITYDISPLAY_YES = "COMMUNITYDISPLAY_YES";
        /**
         * 小区是否显示状态： COMMUNITYDISPLAY_NO 不显示（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COMMUNITYDISPLAY的内容）
         */
        public static final String COMMUNITYDISPLAY_NO = "COMMUNITYDISPLAY_NO";

        /**
         * 店铺接单员是否有效： 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYSTATE的内容）
         */
        public static final String STOREDELIVERYSTATE_YES = "STOREDELIVERYSTATE_YES";

        /**
         * 店铺接单员是否有效： 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYSTATE的内容）
         */
        public static final String STOREDELIVERYSTATE_NO = "STOREDELIVERYSTATE_NO";

        /**
         * 店铺接单员处理步骤 接单，接单-发货，发货 Receive
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYORDERRECORDSTEP的内容）
         */
        public static final String STOREDELIVERYORDERRECORDSTEP_RECEIVE = "STOREDELIVERYORDERRECORDSTEP_RECEIVE";

        /**
         * 店铺接单员处理步骤 接单-发货
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYORDERRECORDSTEP的内容）
         */
        public static final String STOREDELIVERYORDERRECORDSTEP_RECEIVE_SEND = "STOREDELIVERYORDERRECORDSTEP_RECEIVE_SEND";

        /**
         * 店铺接单员处理步骤 发货
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYORDERRECORDSTEP的内容）
         */
        public static final String STOREDELIVERYORDERRECORDSTEP_SEND = "STOREDELIVERYORDERRECORDSTEP_SEND";

        /**
         * 店铺类型 ： 合作人
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
         */
        public static final String STORETYPE_PARTNER = "STORETYPE_PARTNER";
        /**
         * 店铺类型 ： 体验店
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
         */
        public static final String STORETYPE_EXPERIENCE_STORE = "STORETYPE_EXPERIENCE_STORE";
        /**
         * 店铺类型 ： 微仓
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
         */
        public static final String STORETYPE_MICROWAREHOUSE = "STORETYPE_MICROWAREHOUSE";

        /**
         * 用户是否下过单 : 是
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ISFIRSTORDERFORUSER的内容）
         */
        public static final String ISFIRSTORDERFORUSER_YES = "ISFIRSTORDERFORUSER_YES";
        /**
         * 用户是否下过单 : 否
         * 
         * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ISFIRSTORDERFORUSER的内容）
         */
        public static final String ISFIRSTORDERFORUSER_NO = "ISFIRSTORDERFORUSER_NO";

        /**
         * 登录类型： LOGINTYPE_CAPTCHA 验证码（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGINTYPE的内容）
         */
        public static final String LOGINTYPE_CAPTCHA = "LOGINTYPE_CAPTCHA";
        /**
         * 登录类型： LOGINTYPE_PASSWORD 密码（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=LOGINTYPE的内容）
         */
        public static final String LOGINTYPE_PASSWORD = "LOGINTYPE_PASSWORD";

        /**
         * 反馈类型: FEEDBACKTYPE_COMPLAIN 投诉商家（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_COMPLAIN = "FEEDBACKTYPE_COMPLAIN";

        /**
         * 反馈类型: FEEDBACKTYPE_QUALITY 商品质量（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_QUALITY = "FEEDBACKTYPE_QUALITY";

        /**
         * 反馈类型: FEEDBACKTYPE_DISPATCH 物流配送（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_DISPATCH = "FEEDBACKTYPE_DISPATCH";

        /**
         * 反馈类型: FEEDBACKTYPE_SOFTWARE 软件问题（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_SOFTWARE = "FEEDBACKTYPE_SOFTWARE";

        /**
         * 反馈类型: FEEDBACKTYPE_IDEA 意见和建议（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_IDEA = "FEEDBACKTYPE_IDEA";

        /**
         * 反馈类型: FEEDBACKTYPE_LEAGUE 加盟意向（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_LEAGUE = "FEEDBACKTYPE_LEAGUE";

        /**
         * 反馈类型: FEEDBACKTYPE_OTHER 其他（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKTYPE的内容）
         */
        public static final String FEEDBACKTYPE_OTHER = "FEEDBACKTYPE_OTHER";

        /**
         * 反馈状态: FEEDBACKSTATIS_YESDISPOSE 已处理（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKSTATIS的内容）
         */
        public static final String FEEDBACKSTATIS_YESDISPOSE = "FEEDBACKSTATIS_YESDISPOSE";
        /**
         * 反馈状态: FEEDBACKSTATIS_NODISPOSE 未处理（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FEEDBACKSTATIS的内容）
         */
        public static final String FEEDBACKSTATIS_NODISPOSE = "FEEDBACKSTATIS_NODISPOSE";
        /**
         * 第三方接入类型： CONNECTUSERCONNECTTYPE_WECHAT 微信APP接入（对应用户域系统字典S_SYETEM_DICT表的DICTTYPE=CONNECTUSERCONNECTTYPE的内容）
         */
        public static final String CONNECTUSERCONNECTTYPE_WECHATAPP = "CONNECTUSERCONNECTTYPE_WECHATAPP";
        /**
         * 第三方接入类型： CONNECTUSERCONNECTTYPE_WECHAT 微信HTML5接入（对应用户域系统字典S_SYETEM_DICT表的DICTTYPE=CONNECTUSERCONNECTTYPE的内容）
         */
        public static final String CONNECTUSERCONNECTTYPE_WECHATHTML5 = "CONNECTUSERCONNECTTYPE_WECHATHTML5";
        /**
         * 第三方接入类型： CONNECTUSERCONNECTTYPE_QQ QQ接入（对应用户域系统字典S_SYETEM_DICT表的DICTTYPE=CONNECTUSERCONNECTTYPE的内容）
         */
        public static final String CONNECTUSERCONNECTTYPE_QQ = "CONNECTUSERCONNECTTYPE_QQ";
        /**
         * 分享规则角色类型，SHARERULEROLETYPE_BUYER 买家 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEROLETYPE)
         */
        public static final String SHARERULEROLETYPE_BUYER = "SHARERULEROLETYPE_BUYER";
        /**
         * 分享规则状态，SHARERULESTATUS_ON 有效 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULESTATUS)
         */
        public static final String SHARERULESTATUS_ON = "SHARERULESTATUS_ON";
        /**
         * 分享规则状态，SHARERULESTATUS_OFF 无效 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULESTATUS)
         */
        public static final String SHARERULESTATUS_OFF = "SHARERULESTATUS_OFF";
        /**
         * 分享规则状态，SHARERULESTATUS_NORMAL 正常 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULESTATUS)
         */
        public static final String SHARERULESTATUS_NORMAL = "SHARERULESTATUS_NORMAL";
        /**
         * 分享规则邀请人限制条件，SHARERULEINVITERCONDITIONTYPE_LOGIN 用户登录
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITERCONDITIONTYPE)
         */
        public static final String SHARERULEINVITERCONDITIONTYPE_LOGIN = "SHARERULEINVITERCONDITIONTYPE_LOGIN";
        /**
         * 分享规则邀请人限制条件，SHARERULEINVITERCONDITIONTYPE_REGISTER 用户注册
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITERCONDITIONTYPE)
         */
        public static final String SHARERULEINVITERCONDITIONTYPE_REGISTER = "SHARERULEINVITERCONDITIONTYPE_REGISTER";
        /**
         * 分享规则邀请人限制条件，SHARERULEINVITERCONDITIONTYPE_ANYORDER 用户下任意订单
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITERCONDITIONTYPE)
         */
        public static final String SHARERULEINVITERCONDITIONTYPE_ANYORDER = "SHARERULEINVITERCONDITIONTYPE_ANYORDER";
        /**
         * 分享规则邀请人限制条件，SHARERULEINVITERCONDITIONTYPE_PRODUCT 用户购买特定商品
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITERCONDITIONTYPE)
         */
        public static final String SHARERULEINVITERCONDITIONTYPE_PRODUCT = "SHARERULEINVITERCONDITIONTYPE_PRODUCT";
        /**
         * 分享规则被邀请人限制条件，SHARERULEINVITEDCONDITIONTYPE_LOGIN 用户登录
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITEDCONDITIONTYPE)
         */
        public static final String SHARERULEINVITEDCONDITIONTYPE_LOGIN = "SHARERULEINVITEDCONDITIONTYPE_LOGIN";
        /**
         * 分享规则被邀请人限制条件，SHARERULEINVITEDCONDITIONTYPE_REGISTER 用户注册
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITEDCONDITIONTYPE)
         */
        public static final String SHARERULEINVITEDCONDITIONTYPE_REGISTER = "SHARERULEINVITEDCONDITIONTYPE_REGISTER";
        /**
         * 分享规则被邀请人限制条件，SHARERULEINVITEDCONDITIONTYPE_ANYORDER 用户下任意订单
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITEDCONDITIONTYPE)
         */
        public static final String SHARERULEINVITEDCONDITIONTYPE_ANYORDER = "SHARERULEINVITEDCONDITIONTYPE_ANYORDER";
        /**
         * 分享规则被邀请人限制条件，SHARERULEINVITEDCONDITIONTYPE_PRODUCT 用户购买特定商品
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEINVITEDCONDITIONTYPE)
         */
        public static final String SHARERULEINVITEDCONDITIONTYPE_PRODUCT = "SHARERULEINVITEDCONDITIONTYPE_PRODUCT";
        /**
         * 分享规则奖励设置，SHARERULEAWARDTYPE_CASH 现金 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEAWARDTYPE)
         */
        public static final String SHARERULEAWARDTYPE_CASH = "SHARERULEAWARDTYPE_CASH";
        /**
         * 分享规则奖励设置，SHARERULEAWARDTYPE_POINTS 积分 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEAWARDTYPE)
         */
        public static final String SHARERULEAWARDTYPE_POINTS = "SHARERULEAWARDTYPE_POINTS";
        /**
         * 分享规则奖励设置，SHARERULEAWARDTYPE_COUPON 优惠券 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SHARERULEAWARDTYPE)
         */
        public static final String SHARERULEAWARDTYPE_COUPON = "SHARERULEAWARDTYPE_COUPON";
        /**
         * 是否共享库存，STORESTOCKSHARE_YES 共享库存 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=STORESTOCKSHARE)
         */
        public static final String STORESTOCKSHARE_YES = "STORESTOCKSHARE_YES";
        /**
         * 是否共享库存，STORESTOCKSHARE_NO 不共享库存 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=STORESTOCKSHARE)
         */
        public static final String STORESTOCKSHARE_NO = "STORESTOCKSHARE_NO";
        /**
         * 修改批次编码，INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST
         * 第一次修改(对应用户域系统字典S_SYSTEM_DICT表的DICTTYPE=INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE)
         */
        public static final String INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST = "INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST";
        /**
         * 修改批次编码，INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_SECOND
         * 第二次修改(对应用户域系统字典S_SYSTEM_DICT表的DICTTYPE=INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE)
         */
        public static final String INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_SECOND = "INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_SECOND";
        /**
         * 修改批次编码，INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_THIRD
         * 第三次修改(对应用户域系统字典S_SYSTEM_DICT表的DICTTYPE=INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE)
         */
        public static final String INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_THIRD = "INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_THIRD";
        /**
         * 修改批次编码，INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FOURTH
         * 第四次修改(对应用户域系统字典S_SYSTEM_DICT表的DICTTYPE=INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE)
         */
        public static final String INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FOURTH = "INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FOURTH";
        /**
         * 用户性别，USERGENDER_FEMALE 女 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=USERGENDER)
         */
        public static final String USERGENDER_FEMALE = "USERGENDER_FEMALE";
        /**
         * 用户性别，USERGENDER_MALE 男 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=USERGENDER)
         */
        public static final String USERGENDER_MALE = "USERGENDER_MALE";
        /**
         * 结算规则设置历史操作类型,SETTLEMENTRULEHISTORYOPERTYPE_CREATE:创建(对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SETTLEMENTRULEHISTORYOPERTYPE)
         */
        public static final String SETTLEMENTRULEHISTORYOPERTYPE_CREATE = "SETTLEMENTRULEHISTORYOPERTYPE_CREATE";
        /**
         * 结算规则设置历史操作类型,SETTLEMENTRULEHISTORYOPERTYPE_UPDATE:修改(对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SETTLEMENTRULEHISTORYOPERTYPE)
         */
        public static final String SETTLEMENTRULEHISTORYOPERTYPE_UPDATE = "SETTLEMENTRULEHISTORYOPERTYPE_UPDATE";
    }

    public static final class OrderDomain {

        public static enum DictType {
            SALEORDERSTATUS("SALEORDERSTATUS", "订单记录状态"), COUPONSTYPE("COUPONSTYPE", "劵包类型"), COUPONSSTATE("COUPONSSTATE",
                    "优惠劵包状态"), SALEORDERDELIVERYMODE("SALEORDERDELIVERYMODE", "配送方式"), SALEORDERTYPE("SALEORDERTYPE", "订单类型"), SALEORDERPAYTYPE(
                    "SALEORDERPAYTYPE", "订单支付方式"), REFUNDAPPLYSTATUS("REFUNDAPPLYSTATUS", "退款申请记录状态"), REFUNDAPPLYOPERTYPE(
                    "REFUNDAPPLYOPERTYPE", "退款申请操作类型"), SALEORDERPAYPLATFORM("SALEORDERPAYPLATFORM", "订单支付平台"), USERFIRSTORDERSTATUS(
                    "USERFIRSTORDERSTATUS", "用户每日首单随机优惠使用状态"), SALEORDERBESTTIME("SALEORDERBESTTIME", "订单记录配送时间要求"), SALEORDERPAYSTATUS(
                    "SALEORDERPAYSTATUS", "订单付款状态"), SALEORDERITEMGIFTFLAG("SALEORDERITEMGIFTFLAG", "赠品标识"), SALEORDERCANCELTYPECODE(
                    "SALEORDERCANCELTYPECODE", "取消订单类型编码"), INVENTORYOPERTYPE("INVENTORYOPERTYPE", "商品库存变化操作类型"), FLITTINGORDERSTATUS(
                    "FLITTINGORDERSTATUS", "调拨单状态"), PURCHASEORDERSTATUS("PURCHASEORDERSTATUS", "采购单状态"), STOCKOUTORDERSTOCKOUTOPERTYPE(
                    "STOCKOUTORDERSTOCKOUTOPERTYPE", "出库单与出库记录关联操作类型"), STOCKOUTORDERSTATUS("STOCKOUTORDERSTATUS", "出库单状态"), STOCKOUTORDERTYPE(
                    "STOCKOUTORDERTYPE", "出库单类型"), PURCHASESTOCKINOPERTYPE("PURCHASESTOCKINOPERTYPE", "采购单与入库单关联操作类型"), INVENTORYSTORESTATUS(
                    "INVENTORYSTORESTATUS", "商品库存状态"), INVENTORYWARNINGFLAG("INVENTORYWARNINGFLAG", "商品库存预警标志"), PAYLOGTYPE(
                    "PAYLOGTYPE", "支付日志类型"), PAYLOGSTATUS("PAYLOGSTATUS", "支付日志状态"), PAYLOGOPERUSERTYPE(
                    "PAYLOGOPERUSERTYPE", "操作员类型"), ORDERPAYMENTPAYTYPE("ORDERPAYMENTPAYTYPE", "订单支付记录支付类型"), FIRSTORDERTYPE(
                    "FIRSTORDERTYPE", "首单类型"), ACTIVITYORDERCUSTOMERRESTATUS("ACTIVITYORDERCUSTOMERRESTATUS", "活动订单记录状态"), COUPONSUSERANGE(
                    "COUPONSUSERANGE", "优惠券使用范围"), PRODUCTLABEL("PRODUCTLABEL", "产品标示"), COUPONSGRANTRANGE(
                    "COUPONSGRANTRANGE", "优惠券发放范围"), COUPONSGRANTWAY("COUPONSGRANTWAY", "优惠券发放方式"), BUYERUSERTYPELABEL(
                    "BUYERUSERTYPELABEL", "买家用户类型标示"), USERCOUPONSSTATUS("USERCOUPONSSTATUS", "用户优惠券使用状态"), VOUPACKTYPETYPE(
                    "VOUPACKTYPETYPE", "抵用券包类型"), VOUCHERSTATE("VOUCHERSTATE", "抵用券包状态"), VOUCHERGRANTRANGE(
                    "VOUCHERGRANTRANGE", "抵用券发放范围"), VOUCHERGRANTWAY("VOUCHERGRANTWAY", "抵用券发放方式"), VOUCHERBUSINESSRULELIMIT(
                    "VOUCHERBUSINESSRULELIMIT", "抵用券业务规则限制"), USERVOUCHERSTATUS("USERVOUCHERSTATUS", "用户抵用劵使用状态"), COUPONVALIDTYPE(
                    "COUPONVALIDTYPE", "优惠券有效期类型"), APPRAISEFLAG("APPRAISEFLAG", "订单是否已评价"),ORDERGIFTSTATUS("ORDERGIFTSTATUS", "买赠活动发送状态"),
                    ORDERREFUNDSTATUS("ORDERREFUNDSTATUS", "订单退款状态"),ORDERREFUNDWAY("ORDERREFUNDWAY", "退款方式");

            private final String value;
            private final String text;

            private DictType(String value, String text) {
                this.value = value;
                this.text = text;
            }

            public String getValue() {
                return value;
            }

            public String getText() {
                return text;
            }

            public static DictType getEnum(String value) {
                if (value != null) {
                    DictType[] values = DictType.values();
                    for (DictType val : values) {
                        if (val.getValue().equals(value)) {
                            return val;
                        }
                    }
                }
                return null;
            }
        }

        /**
         * 订单记录状态： SALEORDERSTATUS_FORPAY 等待买家付款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_FORPAY = "SALEORDERSTATUS_FORPAY";
        /**
         * 订单记录状态： SALEORDERSTATUS_PAID 等待卖家接单（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_PAID = "SALEORDERSTATUS_PAID";
        /**
         * 订单记录状态： SALEORDERSTATUS_FORSEND 等待卖家发货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_FORSEND = "SALEORDERSTATUS_FORSEND";
        /**
         * 订单记录状态： SALEORDERSTATUS_FORRECEIVE 等待买家收货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_FORRECEIVE = "SALEORDERSTATUS_FORRECEIVE";
        /**
         * 订单记录状态： SALEORDERSTATUS_FINISHED 交易成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_FINISHED = "SALEORDERSTATUS_FINISHED";
        /**
         * 订单记录状态： SALEORDERSTATUS_APPRAISE 已评价（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_APPRAISE = "SALEORDERSTATUS_APPRAISE";
        /**
         * 订单记录状态： APPRAISEFLAG_YES 订单已评价（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=APPRAISEFLAG的内容）
         */
        public static final String APPRAISEFLAG_YES = "APPRAISEFLAG_YES";
        /**
         * 订单记录状态： APPRAISEFLAG_NO 订单未评价（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=APPRAISEFLAG的内容）
         */
        public static final String APPRAISEFLAG_NO = "APPRAISEFLAG_NO";
        /**
         * 订单记录状态： SALEORDERSTATUS_CANCEL 已取消（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_CANCEL = "SALEORDERSTATUS_CANCEL";
        /**
         * 订单记录状态： SALEORDERSTATUS_REFUND 退款中（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_REFUNDING = "SALEORDERSTATUS_REFUNDING";
        /**
         * 订单记录状态： SALEORDERSTATUS_REFUNDSUCCESS 退款成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_REFUNDSUCCESS = "SALEORDERSTATUS_REFUNDSUCCESS";
        /**
         * 订单记录状态： SALEORDERSTATUS_REFUNDFAILURE 退款失败（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEORDERSTATUS的内容）
         */
        public static final String SALEORDERSTATUS_REFUNDFAILURE = "SALEORDERSTATUS_REFUNDFAILURE";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_FORSELLERAUDIT 等待卖家审核（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_FORSELLERAUDIT = "REFUNDAPPLYSTATUS_FORSELLERAUDIT";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_SELLERREJECT 卖家已拒绝（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_SELLERREJECT = "REFUNDAPPLYSTATUS_SELLERREJECT";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_FORBUYERSEND 等待买家退货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_FORBUYERSEND = "REFUNDAPPLYSTATUS_FORBUYERSEND";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_FORBUYERSEND 等待卖家收货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_FORSELLERRECEIVE = "REFUNDAPPLYSTATUS_FORSELLERRECEIVE";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_REFUNDING 退款中（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_REFUNDING = "REFUNDAPPLYSTATUS_REFUNDING";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_SECCEED 退款成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_SECCEED = "REFUNDAPPLYSTATUS_SECCEED";
        /**
         * 退款申请记录状态： REFUNDAPPLYSTATUS_CANCEL 退款关闭（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYSTATUS的内容）
         */
        public static final String REFUNDAPPLYSTATUS_CANCEL = "REFUNDAPPLYSTATUS_CANCEL";

        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_APPLY 申请退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_APPLY = "REFUNDAPPLYOPERTYPE_APPLY";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_AUDIT 审核退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_AUDIT = "REFUNDAPPLYOPERTYPE_AUDIT";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_SEND 退款发货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_SEND = "REFUNDAPPLYOPERTYPE_SEND";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_RECEIVE 退款收货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_RECEIVE = "REFUNDAPPLYOPERTYPE_RECEIVE";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_MODIFY 修改退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_MODIFY = "REFUNDAPPLYOPERTYPE_MODIFY";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_CANCEL 取消退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_CANCEL = "REFUNDAPPLYOPERTYPE_CANCEL";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_EXTENDRECEIVE 延长收货时间（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_EXTENDRECEIVE = "REFUNDAPPLYOPERTYPE_EXTENDRECEIVE";
        /**
         * 退款申请操作类型： REFUNDAPPLYOPERTYPE_CLOSE 关闭退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=REFUNDAPPLYOPERTYPE的内容）
         */
        public static final String REFUNDAPPLYOPERTYPE_CLOSE = "REFUNDAPPLYOPERTYPE_CLOSE";

        /**
         * 优惠劵包状态：COUPONSSTATE_NOGRANT 未发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSSTATE)
         */
        public static final String COUPONSSTATE_NOGRANT = "COUPONSSTATE_NOGRANT";
        /**
         * 优惠劵包状态：COUPONSSTATE_GRANTED 已发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSSTATE)
         */
        public static final String COUPONSSTATE_GRANTED = "COUPONSSTATE_GRANTED";
        /**
         * 优惠劵包状态：COUPONSSTATE_DISABLE 已停用 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSSTATE)
         */
        public static final String COUPONSSTATE_DISABLE = "COUPONSSTATE_DISABLE";

        /**
         * 配送方式:SALEORDERDELIVERYMODE_DISTRIBUTION 配送上门 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERDELIVERYMODE)
         */
        public static final String SALEORDERDELIVERYMODE_DISTRIBUTION = "SALEORDERDELIVERYMODE_DISTRIBUTION";

        /**
         * 配送方式:SALEORDERDELIVERYMODE_PICKUP 门店自提 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERDELIVERYMODE)
         */
        public static final String SALEORDERDELIVERYMODE_PICKUP = "SALEORDERDELIVERYMODE_PICKUP";

        /**
         * 订单类型:SALEORDERTYPE_ORDINARY 普通订单 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERTYPE)
         */
        public static final String SALEORDERTYPE_ORDINARY = "SALEORDERTYPE_ORDINARY";

        /**
         * 订单类型:SALEORDERTYPE_VIP VIP订单 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERTYPE)
         */
        public static final String SALEORDERTYPE_VIP = "SALEORDERTYPE_VIP";

        /**
         * 订单类型:SALEORDERTYPE_SECKILL 秒杀订单 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERTYPE)
         */
        public static final String SALEORDERTYPE_SECKILL = "SALEORDERTYPE_SECKILL";

        /**
         * 订单支付方式:SALEORDERPAYTYPE_ONLINE 在线支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYTYPE)
         */
        public static final String SALEORDERPAYTYPE_ONLINE = "SALEORDERPAYTYPE_ONLINE";

        /**
         * 订单支付方式:SALEORDERPAYTYPE_CASH 货到付款 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYTYPE)
         */
        public static final String SALEORDERPAYTYPE_CASH = "SALEORDERPAYTYPE_CASH";

        /**
         * 订单支付平台编码，SALEORDERPAYPLATFORM_WEIXIN 微信支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYPLATFORM)
         */
        public static final String SALEORDERPAYPLATFORM_WEIXIN = "SALEORDERPAYPLATFORM_WEIXIN";
        /**
         * 订单支付平台编码，SALEORDERPAYPLATFORM_ALIPAY 支付宝支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYPLATFORM)
         */
        public static final String SALEORDERPAYPLATFORM_ALIPAY = "SALEORDERPAYPLATFORM_ALIPAY";
        /**
         * 订单支付平台编码，SALEORDERPAYPLATFORM_WEIXINPUBLIC 微信公众号支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYPLATFORM)
         */
        public static final String SALEORDERPAYPLATFORM_WEIXINPUBLIC = "SALEORDERPAYPLATFORM_WEIXINPUBLIC";

        /**
         * 用户每日订单随机优惠金额使用状态编码，USERFIRSTORDERSTATUS_NOUSE 未使用 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=USERFIRSTORDERSTATUS)
         */
        public static final String USERFIRSTORDERSTATUS_NOUSE = "USERFIRSTORDERSTATUS_NOUSE";
        /**
         * 用户每日订单随机优惠金额使用状态编码，USERFIRSTORDERSTATUS_USED 生成订单已使用 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=USERFIRSTORDERSTATUS)
         */
        public static final String USERFIRSTORDERSTATUS_USED = "USERFIRSTORDERSTATUS_USED";
        /**
         * 用户每日订单随机优惠金额使用状态编码，USERFIRSTORDERSTATUS_USERD_CANCEL 已使用取消 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=USERFIRSTORDERSTATUS)
         */
        public static final String USERFIRSTORDERSTATUS_USERD_CANCEL = "USERFIRSTORDERSTATUS_USERD_CANCEL";
        /**
         * 订单记录配送时间要求:SALEORDERBESTTIME_FASTESTTIME 一小时闪电送达(对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERBESTTIME)
         */
        public static final String SALEORDERBESTTIME_FASTESTTIME = "SALEORDERBESTTIME_FASTESTTIME";
        /**
         * 订单记录配送时间要求:SALEORDERBESTTIME_ANYTIME 任意时间 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERBESTTIME)
         */
        public static final String SALEORDERBESTTIME_ANYTIME = "SALEORDERBESTTIME_ANYTIME";
        /**
         * 订单记录配送时间要求:SALEORDERBESTTIME_WORKDAY 工作日配送 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERBESTTIME)
         */
        public static final String SALEORDERBESTTIME_WORKDAY = "SALEORDERBESTTIME_WORKDAY";
        /**
         * 订单记录配送时间要求:SALEORDERBESTTIME_WEEKEND 周末配送 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERBESTTIME)
         */
        public static final String SALEORDERBESTTIME_WEEKEND = "SALEORDERBESTTIME_WEEKEND";
        /**
         * 订单记录配送时间要求:SALEORDERBESTTIME_PICKUP 营业时间内想提就提 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERBESTTIME)
         */
        public static final String SALEORDERBESTTIME_PICKUP = "SALEORDERBESTTIME_PICKUP";
        /**
         * 订单付款状态:SALEORDERPAYSTATUS_NOTPAY 未付款 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYSTATUS)
         */
        public static final String SALEORDERPAYSTATUS_NOTPAY = "SALEORDERPAYSTATUS_NOTPAY";
        /**
         * 订单付款状态:SALEORDERPAYSTATUS_PAID 已付款 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERPAYSTATUS)
         */
        public static final String SALEORDERPAYSTATUS_PAID = "SALEORDERPAYSTATUS_PAID";
        /**
         * 赠品标识:SALEORDERITEMGIFTFLAG_NO 不是赠品 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERITEMGIFTFLAG)
         */
        public static final String SALEORDERITEMGIFTFLAG_NO = "SALEORDERITEMGIFTFLAG_NO";
        /**
         * 赠品标识:SALEORDERITEMGIFTFLAG_YES 是赠品 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERITEMGIFTFLAG)
         */
        public static final String SALEORDERITEMGIFTFLAG_YES = "SALEORDERITEMGIFTFLAG_YES";

        /**
         * 订单发货状态编码，SALEORDERSENDSTATUS_NOTSEND 未发货
         */
        public static final String SALEORDERSENDSTATUS_NOTSEND = "SALEORDERSENDSTATUS_NOTSEND";
        /**
         * 订单发货状态编码，SALEORDERSENDSTATUS_PARTSENT 部分发货
         */
        public static final String SALEORDERSENDSTATUS_PARTSENT = "SALEORDERSENDSTATUS_PARTSENT";
        /**
         * 订单发货状态编码，SALEORDERSENDSTATUS_SENT 已发货
         */
        public static final String SALEORDERSENDSTATUS_SENT = "SALEORDERSENDSTATUS_SENT";

        /**
         * 订单收货状态编码，SALEORDERTAKESTATUS_NOTRECEIVE 未收货
         */
        public static final String SALEORDERTAKESTATUS_NOTRECEIVE = "SALEORDERTAKESTATUS_NOTRECEIVE";
        /**
         * 订单收货状态编码，SALEORDERTAKESTATUS_RECEIVED 已收货
         */
        public static final String SALEORDERTAKESTATUS_RECEIVED = "SALEORDERTAKESTATUS_RECEIVED";

        /**
         * 取消订单类型编码:SALEORDERCANCELTYPECODE_SELLER 卖家取消 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERCANCELTYPECODE)
         */
        public static final String SALEORDERCANCELTYPECODE_SELLER = "SALEORDERCANCELTYPECODE_SELLER";
        /**
         * 取消订单类型编码:SALEORDERCANCELTYPECODE_BUYER 买家取消 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERCANCELTYPECODE)
         */
        public static final String SALEORDERCANCELTYPECODE_BUYER = "SALEORDERCANCELTYPECODE_BUYER";
        /**
         * 取消订单类型编码:SALEORDERCANCELTYPECODE_OPERATOR 运营后台取消 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERCANCELTYPECODE)
         */
        public static final String SALEORDERCANCELTYPECODE_OPERATOR = "SALEORDERCANCELTYPECODE_OPERATOR";
        /**
         * 取消订单类型编码:SALEORDERCANCELTYPECODE_SYSTEM_NO_PAID 系统自动取消(未付款)
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERCANCELTYPECODE)
         */
        public static final String SALEORDERCANCELTYPECODE_SYSTEM_NO_PAID = "SALEORDERCANCELTYPECODE_SYSTEM_NO_PAID";
        /**
         * 取消订单类型编码:SALEORDERCANCELTYPECODE_SYSTEM_NO_ACCEPTED 系统自动取消(未接单)
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=SALEORDERCANCELTYPECODE)
         */
        public static final String SALEORDERCANCELTYPECODE_SYSTEM_NO_ACCEPTED = "SALEORDERCANCELTYPECODE_SYSTEM_NO_ACCEPTED";
        /**
         * 入库记录类型，STOCKINTYPE_COMMON 普通入库
         */
        public static final String STOCKINTYPE_COMMON = "STOCKINTYPE_COMMON";
        /**
         * 入库记录类型，STOCKINTYPE_AFTERSALE 售后入库
         */
        public static final String STOCKINTYPE_AFTERSALE = "STOCKINTYPE_AFTERSALE";
        /**
         * 入库记录类型，STOCKINTYPE_FLITTING 调拨入库
         */
        public static final String STOCKINTYPE_FLITTING = "STOCKINTYPE_FLITTING";
        /**
         * 入库记录类型，STOCKINTYPE_PURCHASE 采购入库
         */
        public static final String STOCKINTYPE_PURCHASE = "STOCKINTYPE_PURCHASE";

        /**
         * 出库记录类型，STOCKOUTTYPE_COMMON 普通出库
         */
        public static final String STOCKOUTTYPE_COMMON = "STOCKOUTTYPE_COMMON";
        /**
         * 出库记录类型，STOCKOUTTYPE_SEND 发货出库
         */
        public static final String STOCKOUTTYPE_SEND = "STOCKOUTTYPE_SEND";
        /**
         * 出库记录类型，STOCKOUTTYPE_FLITTING 调拨出库
         */
        public static final String STOCKOUTTYPE_FLITTING = "STOCKOUTTYPE_FLITTING";
        /**
         * 出库记录类型，STOCKOUTTYPE_STOCKOUTORDER 出库单出库
         */
        public static final String STOCKOUTTYPE_STOCKOUTORDER = "STOCKOUTTYPE_STOCKOUTORDER";

        /**
         * 调拨单状态，FLITTINGORDERSTATUS_APPLY 调货单已提交
         */
        public static final String FLITTINGORDERSTATUS_APPLY = "FLITTINGORDERSTATUS_APPLY";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_ACCEPTED 微仓已审核
         */
        public static final String FLITTINGORDERSTATUS_ACCEPTED = "FLITTINGORDERSTATUS_ACCEPTED";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_ACCEPTREJECTED 微仓审核不通过
         */
        public static final String FLITTINGORDERSTATUS_ACCEPTREJECTED = "FLITTINGORDERSTATUS_ACCEPTREJECTED";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_SEND 微仓已发货
         */
        public static final String FLITTINGORDERSTATUS_SEND = "FLITTINGORDERSTATUS_SEND";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_CHECKING 验货中
         */
        public static final String FLITTINGORDERSTATUS_CHECKING = "FLITTINGORDERSTATUS_CHECKING";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_CHECKED 验货完毕
         */
        public static final String FLITTINGORDERSTATUS_CHECKED = "FLITTINGORDERSTATUS_CHECKED";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_FINISHED 调货完成
         */
        public static final String FLITTINGORDERSTATUS_FINISHED = "FLITTINGORDERSTATUS_FINISHED";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_FINISHREJECTED 调拨争议
         */
        public static final String FLITTINGORDERSTATUS_FINISHREJECTED = "FLITTINGORDERSTATUS_FINISHREJECTED";
        /**
         * 调拨单状态，FLITTINGORDERSTATUS_ARBITRATE 平台客服已介入
         */
        public static final String FLITTINGORDERSTATUS_ARBITRATE = "FLITTINGORDERSTATUS_ARBITRATE";

        /**
         * 调出店铺接收状态，FLITTINGORDERACCEPTSTATUS_APPLY 申请
         */
        public static final String FLITTINGORDERACCEPTSTATUS_APPLY = "FLITTINGORDERACCEPTSTATUS_APPLY";
        /**
         * 调出店铺接收状态，FLITTINGORDERACCEPTSTATUS_PASSED 接收
         */
        public static final String FLITTINGORDERACCEPTSTATUS_PASSED = "FLITTINGORDERACCEPTSTATUS_PASSED";
        /**
         * 调出店铺接收状态，FLITTINGORDERACCEPTSTATUS_REJECTED 拒绝
         */
        public static final String FLITTINGORDERACCEPTSTATUS_REJECTED = "FLITTINGORDERACCEPTSTATUS_REJECTED";

        /**
         * 调出店铺发货状态，FLITTINGORDERSENDSTATUS_NOTYET 未发货
         */
        public static final String FLITTINGORDERSENDSTATUS_NOTYET = "FLITTINGORDERSENDSTATUS_NOTYET";
        /**
         * 调出店铺发货状态，FLITTINGORDERSENDSTATUS_SENT 已发货
         */
        public static final String FLITTINGORDERSENDSTATUS_SENT = "FLITTINGORDERSENDSTATUS_SENT";

        /**
         * 调出店铺验货状态，FLITTINGORDERCHECKSTATUS_NOTYET 未验货
         */
        public static final String FLITTINGORDERCHECKSTATUS_NOTYET = "FLITTINGORDERCHECKSTATUS_NOTYET";
        /**
         * 调出店铺验货状态，FLITTINGORDERCHECKSTATUS_CHECKING 验货中
         */
        public static final String FLITTINGORDERCHECKSTATUS_CHECKING = "FLITTINGORDERCHECKSTATUS_CHECKING";
        /**
         * 调出店铺验货状态，FLITTINGORDERCHECKSTATUS_CHECKED 已验货
         */
        public static final String FLITTINGORDERCHECKSTATUS_CHECKED = "FLITTINGORDERCHECKSTATUS_CHECKED";

        /**
         * 调出店铺完成审核状态，FLITTINGORDERAUDITSTATUS_NOTYET 未审核
         */
        public static final String FLITTINGORDERAUDITSTATUS_NOTYET = "FLITTINGORDERAUDITSTATUS_NOTYET";
        /**
         * 调出店铺完成审核状态，FLITTINGORDERAUDITSTATUS_PASSED 审核完成
         */
        public static final String FLITTINGORDERAUDITSTATUS_PASSED = "FLITTINGORDERAUDITSTATUS_PASSED";
        /**
         * 调出店铺完成审核状态，FLITTINGORDERAUDITSTATUS_REJECTED 拒绝通过审核
         */
        public static final String FLITTINGORDERAUDITSTATUS_REJECTED = "FLITTINGORDERAUDITSTATUS_REJECTED";
        /**
         * 调出店铺完成审核状态，FLITTINGORDERAUDITSTATUS_ARBITRATE 仲裁
         */
        public static final String FLITTINGORDERAUDITSTATUS_ARBITRATE = "FLITTINGORDERAUDITSTATUS_ARBITRATE";

        /**
         * 调拨单与入库单关联操作类型，FLITTINGSTOCKINOPERTYPE_FLITTINGIN 调货入库
         */
        public static final String FLITTINGSTOCKINOPERTYPE_FLITTINGIN = "FLITTINGSTOCKINOPERTYPE_FLITTINGIN";
        /**
         * 调拨单与入库单关联操作类型，FLITTINGSTOCKINOPERTYPE_REJECTIN 退货入库
         */
        public static final String FLITTINGSTOCKINOPERTYPE_REJECTIN = "FLITTINGSTOCKINOPERTYPE_REJECTIN";

        /**
         * 调拨单与出库单关联操作类型，FLITTINGSTOCKOUTOPERTYPE_FLITTINGOUT 退货出库
         */
        public static final String FLITTINGSTOCKOUTOPERTYPE_FLITTINGOUT = "FLITTINGSTOCKOUTOPERTYPE_FLITTINGOUT";

        /**
         * 调拨数量变化操作类型，FLITTINGORDERHISOPERTYPE_CHECKED 验货调整
         */
        public static final String FLITTINGORDERHISOPERTYPE_CHECKED = "FLITTINGORDERHISOPERTYPE_CHECKED";
        /**
         * 调拨数量变化操作类型，FLITTINGORDERHISOPERTYPE_ADJUSTBYOPER 后台调整
         */
        public static final String FLITTINGORDERHISOPERTYPE_ADJUSTBYOPER = "FLITTINGORDERHISOPERTYPE_ADJUSTBYOPER";

        /**
         * 调拨明细数量变化操作类型，FLITTINGORDERITEMHISOPERTYPE_CHECKED 验货调整
         */
        public static final String FLITTINGORDERITEMHISOPERTYPE_CHECKED = "FLITTINGORDERITEMHISOPERTYPE_CHECKED";
        /**
         * 调拨明细数量变化操作类型，FLITTINGORDERITEMHISOPERTYPE_ADJUSTBYOPER 后台调整
         */
        public static final String FLITTINGORDERITEMHISOPERTYPE_ADJUSTBYOPER = "FLITTINGORDERITEMHISOPERTYPE_ADJUSTBYOPER";
        /**
         * 采购单状态，PURCHASEORDERSTATUS_UNAUDIT 未审核
         */
        public static final String PURCHASEORDERSTATUS_UNAUDIT = "PURCHASEORDERSTATUS_UNAUDIT";
        /**
         * 采购单状态，PURCHASEORDERSTATUS_AUDIT_NOTPASSED 审核未通过
         */
        public static final String PURCHASEORDERSTATUS_AUDIT_NOTPASSED = "PURCHASEORDERSTATUS_AUDIT_NOTPASSED";
        /**
         * 采购单状态，PURCHASEORDERSTATUS_AUDIT_PASSED 审核通过
         */
        public static final String PURCHASEORDERSTATUS_AUDIT_PASSED = "PURCHASEORDERSTATUS_AUDIT_PASSED";
        /**
         * 采购单与入库单关联操作类型，PURCHASESTOCKINOPERTYPE_PURCHASEIN 采购入库
         */
        public static final String PURCHASESTOCKINOPERTYPE_PURCHASEIN = "PURCHASESTOCKINOPERTYPE_PURCHASEIN";
        /**
         * 出库单状态，STOCKOUTORDERSTATUS_UNAUDIT 未审核
         */
        public static final String STOCKOUTORDERSTATUS_UNAUDIT = "STOCKOUTORDERSTATUS_UNAUDIT";
        /**
         * 出库单状态，STOCKOUTORDERSTATUS_AUDIT_NOTPASSED 审核未通过
         */
        public static final String STOCKOUTORDERSTATUS_AUDIT_NOTPASSED = "STOCKOUTORDERSTATUS_AUDIT_NOTPASSED";
        /**
         * 出库单状态，STOCKOUTORDERSTATUS_AUDIT_PASSED 审核通过
         */
        public static final String STOCKOUTORDERSTATUS_AUDIT_PASSED = "STOCKOUTORDERSTATUS_AUDIT_PASSED";
        /**
         * 出库单类型，STOCKOUTORDERTYPE_BREAKAGE 报损出库
         */
        public static final String STOCKOUTORDERTYPE_BREAKAGE = "STOCKOUTORDERTYPE_BREAKAGE";
        /**
         * 出库单类型，STOCKOUTORDERTYPE_MARKETING 营销出库
         */
        public static final String STOCKOUTORDERTYPE_MARKETING = "STOCKOUTORDERTYPE_MARKETING";
        /**
         * 出库单类型，STOCKOUTORDERTYPE_OTHERS 其它出库
         */
        public static final String STOCKOUTORDERTYPE_OTHERS = "STOCKOUTORDERTYPE_OTHERS";
        /**
         * 出库单与出库记录关联操作类型，STOCKOUTORDERSTOCKOUTOPERTYPE_STOCKOUT 出库单出库
         */
        public static final String STOCKOUTORDERSTOCKOUTOPERTYPE_STOCKOUT = "STOCKOUTORDERSTOCKOUTOPERTYPE_STOCKOUT";
        /**
         * 订单与入库单关联操作类型，SALESTOCKINOPERTYPE_AFTERSALE 退货入库
         */
        public static final String SALESTOCKINOPERTYPE_AFTERSALE = "SALESTOCKINOPERTYPE_AFTERSALE";
        /**
         * 订单与出库单关联操作类型，SALESTOCKOUTOPERTYPE_SEND 发货出库
         */
        public static final String SALESTOCKOUTOPERTYPE_SEND = "SALESTOCKOUTOPERTYPE_SEND";

        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_CREATE 库存创建（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_CREATE = "INVENTORYOPERTYPE_CREATE";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_INCOMMON 普通入库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_INCOMMON = "INVENTORYOPERTYPE_INCOMMON";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_INAFTERSALE 售后入库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_INAFTERSALE = "INVENTORYOPERTYPE_INAFTERSALE";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_OUTCOMMON 普通出库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_OUTCOMMON = "INVENTORYOPERTYPE_OUTCOMMON";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_CREATEORDER 订单创建（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_CREATEORDER = "INVENTORYOPERTYPE_CREATEORDER";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_ACCEPTORDER 订单接单（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_ACCEPTORDER = "INVENTORYOPERTYPE_ACCEPTORDER";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_SENDORDER 订单发货（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_SENDORDER = "INVENTORYOPERTYPE_SENDORDER";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_CANCELORDER 订单取消（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_CANCELORDER = "INVENTORYOPERTYPE_CANCELORDER";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_CREATEFLITTING 订单创建（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_CREATEFLITTING = "INVENTORYOPERTYPE_CREATEFLITTING";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_ACCEPTFLITTING 订单接单（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_ACCEPTFLITTING = "INVENTORYOPERTYPE_ACCEPTFLITTING";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_SENDFLITTING 订单发货（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_SENDFLITTING = "INVENTORYOPERTYPE_SENDFLITTING";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_FINISHFLITTING 订单取消（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_FINISHFLITTING = "INVENTORYOPERTYPE_FINISHFLITTING";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_CANCELFLITTING 订单取消（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_CANCELFLITTING = "INVENTORYOPERTYPE_CANCELFLITTING";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_FINISHPURCHASE 采购入库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_FINISHPURCHASE = "INVENTORYOPERTYPE_FINISHPURCHASE";
        /**
         * 商品库存变化操作类型:INVENTORYOPERTYPE_FINISHSTOCKOUT 出库单出库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)）
         */
        public static final String INVENTORYOPERTYPE_FINISHSTOCKOUT = "INVENTORYOPERTYPE_FINISHSTOCKOUT";
        /**
         * 商品库存状态:INVENTORYSTORESTATUS_ABUNDANT 库存充足（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYSTORESTATUS)）
         */
        public static final String INVENTORYSTORESTATUS_ABUNDANT = "INVENTORYSTORESTATUS_ABUNDANT";
        /**
         * 商品库存状态:INVENTORYSTORESTATUS_STABLE 库存稳定（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYSTORESTATUS)）
         */
        public static final String INVENTORYSTORESTATUS_STABLE = "INVENTORYSTORESTATUS_STABLE";
        /**
         * 商品库存状态:INVENTORYSTORESTATUS_TIGHT 库存紧张（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYSTORESTATUS)）
         */
        public static final String INVENTORYSTORESTATUS_TIGHT = "INVENTORYSTORESTATUS_TIGHT";
        /**
         * 商品库存预警标志:INVENTORYWARNINGFLAG_YES 预警（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYWARNINGFLAG)）
         */
        public static final String INVENTORYWARNINGFLAG_YES = "INVENTORYWARNINGFLAG_YES";
        /**
         * 商品库存预警标志:INVENTORYWARNINGFLAG_NO 不预警（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=INVENTORYWARNINGFLAG)）
         */
        public static final String INVENTORYWARNINGFLAG_NO = "INVENTORYWARNINGFLAG_NO";

        /**
         * 支付日志类型:PAYLOGTYPE_PAY 支付（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGTYPE)）
         */
        public static final String PAYLOGTYPE_PAY = "PAYLOGTYPE_PAY";
        /**
         * 支付日志类型:PAYLOGTYPE_REFUND 退款（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGTYPE)）
         */
        public static final String PAYLOGTYPE_REFUND = "PAYLOGTYPE_REFUND";

        /**
         * 支付日志状态:PAYLOGSTATUS_INIT 待支付（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)）
         */
        public static final String PAYLOGSTATUS_INIT = "PAYLOGSTATUS_INIT";
        /**
         * 支付日志状态:PAYLOGSTATUS_PAYSECCEED 支付成功（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)）
         */
        public static final String PAYLOGSTATUS_PAYSECCEED = "PAYLOGSTATUS_PAYSECCEED";
        /**
         * 支付日志状态:PAYLOGSTATUS_PAYFAILURE 支付失败（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)）
         */
        public static final String PAYLOGSTATUS_PAYFAILURE = "PAYLOGSTATUS_PAYFAILURE";
        /**
         * 支付日志状态:PAYLOGSTATUS_REFUND 退款（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)）
         */
        public static final String PAYLOGSTATUS_REFUND = "PAYLOGSTATUS_REFUND";
        /**
         * 支付日志状态:PAYLOGSTATUS_CLOSE 关闭（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)）
         */
        public static final String PAYLOGSTATUS_CLOSE = "PAYLOGSTATUS_CLOSE";

        /**
         * 操作员类型:PAYLOGOPERUSERTYPE_BUYER 买家（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGOPERUSERTYPE)）
         */
        public static final String PAYLOGOPERUSERTYPE_BUYER = "PAYLOGOPERUSERTYPE_BUYER";
        /**
         * 操作员类型:PAYLOGOPERUSERTYPE_SELLER 卖家（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGOPERUSERTYPE)）
         */
        public static final String PAYLOGOPERUSERTYPE_SELLER = "PAYLOGOPERUSERTYPE_SELLER";
        /**
         * 操作员类型:PAYLOGOPERUSERTYPE_OPERATOR 运营商（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PAYLOGOPERUSERTYPE)）
         */
        public static final String PAYLOGOPERUSERTYPE_OPERATOR = "PAYLOGOPERUSERTYPE_OPERATOR";

        /**
         * 订单支付记录支付类型，ORDERPAYMENTPAYTYPE_WXPAY 微信支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=ORDERPAYMENTPAYTYPE)
         */
        public static final String ORDERPAYMENTPAYTYPE_WXPAY = "ORDERPAYMENTPAYTYPE_WXPAY";
        /**
         * 订单支付记录支付类型，ORDERPAYMENTPAYTYPE_ALIPAY 支付宝支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=ORDERPAYMENTPAYTYPE)
         */
        public static final String ORDERPAYMENTPAYTYPE_ALIPAY = "ORDERPAYMENTPAYTYPE_ALIPAY";
        /**
         * 订单支付记录支付类型，ORDERPAYMENTPAYTYPE_WXPAYPUBLIC 微信公众号支付 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=ORDERPAYMENTPAYTYPE)
         */
        public static final String ORDERPAYMENTPAYTYPE_WXPAYPUBLIC = "ORDERPAYMENTPAYTYPE_WXPAYPUBLIC";
        /**
         * 首单类型，FIRSTORDERTYPE_VIPUPGRADE VIP升级首单 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=FIRSTORDERTYPE)
         */
        public static final String FIRSTORDERTYPE_VIPUPGRADE = "FIRSTORDERTYPE_VIPUPGRADE";
        /**
         * 首单类型，FIRSTORDERTYPE_PENNYPRODUCT 一分钱商品 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=FIRSTORDERTYPE)
         */
        public static final String FIRSTORDERTYPE_PENNYPRODUCT = "FIRSTORDERTYPE_PENNYPRODUCT";
        /**
         * 活动订单记录状态，ACTIVITYORDERCUSTOMERRESTATUS_NORMAL 正常,没有取消
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=ACTIVITYORDERCUSTOMERRESTATUS)
         */
        public static final String ACTIVITYORDERCUSTOMERRESTATUS_NORMAL = "ACTIVITYORDERCUSTOMERRESTATUS_NORMAL";
        /**
         * 活动订单记录状态，ACTIVITYORDERCUSTOMERRESTATUS_CANCEL 取消 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=ACTIVITYORDERCUSTOMERRESTATUS)
         */
        public static final String ACTIVITYORDERCUSTOMERRESTATUS_CANCEL = "ACTIVITYORDERCUSTOMERRESTATUS_CANCEL";

        /**
         * 优惠券使用范围，COUPONSUSERANGE_ALL 全场 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSUSERANGE)
         */
        public static final String COUPONSUSERANGE_ALL = "COUPONSUSERANGE_ALL";
        /**
         * 优惠券使用范围，COUPONSUSERANGE_PRODUCT_CLASS 产品品类 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSUSERANGE)
         */
        public static final String COUPONSUSERANGE_PRODUCT_CLASS = "COUPONSUSERANGE_PRODUCT_CLASS";
        /**
         * 优惠券使用范围，COUPONSUSERANGE_PRODUCT_LABEL 产品标示 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSUSERANGE)
         */
        public static final String COUPONSUSERANGE_PRODUCT_LABEL = "COUPONSUSERANGE_PRODUCT_LABEL";
        /**
         * 优惠券使用范围，COUPONSUSERANGE_SINGLE_PRODUCT 单个产品 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSUSERANGE)
         */
        public static final String COUPONSUSERANGE_SINGLE_PRODUCT = "COUPONSUSERANGE_SINGLE_PRODUCT";

        /**
         * 产品标示，PRODUCTLABEL_ALL 全部标示 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=PRODUCTLABEL)
         */
        public static final String PRODUCTLABEL_ALL = "PRODUCTLABEL_ALL";
        /**
         * 产品标示，PRODUCTLABEL_HOT_SALE 热卖商品 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=PRODUCTLABEL)
         */
        public static final String PRODUCTLABEL_HOT_SALE = "PRODUCTLABEL_HOT_SALE";
        /**
         * 产品标示，PRODUCTLABEL_NEW_ARRIVAL 新品上市 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=PRODUCTLABEL)
         */
        public static final String PRODUCTLABEL_NEW_ARRIVAL = "PRODUCTLABEL_NEW_ARRIVAL";
        /**
         * 产品标示，PRODUCTLABEL_POPULARITY 人气 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=PRODUCTLABEL)
         */
        public static final String PRODUCTLABEL_POPULARITY = "PRODUCTLABEL_POPULARITY";
        /**
         * 产品标示，PRODUCTLABEL_WELL_CHOSEN 精选 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=PRODUCTLABEL)
         */
        public static final String PRODUCTLABEL_WELL_CHOSEN = "PRODUCTLABEL_WELL_CHOSEN";

        /**
         * 优惠券发放范围，COUPONSGRANTRANGE_BATCH 批量发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTRANGE)
         */
        public static final String COUPONSGRANTRANGE_BATCH = "COUPONSGRANTRANGE_BATCH";
        /**
         * 优惠券发放范围，COUPONSGRANTRANGE_SINGLE 单独发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTRANGE)
         */
        public static final String COUPONSGRANTRANGE_SINGLE = "COUPONSGRANTRANGE_SINGLE";

        /**
         * 优惠券发放方式，COUPONSGRANTWAY_RED_ENVELOPE 抢红包 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTWAY)
         */
        public static final String COUPONSGRANTWAY_RED_ENVELOPE = "COUPONSGRANTWAY_RED_ENVELOPE";
        /**
         * 优惠券发放方式，COUPONSGRANTWAY_SHARE_GIFT 分享有礼 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTWAY)
         */
        public static final String COUPONSGRANTWAY_SHARE_GIFT = "COUPONSGRANTWAY_SHARE_GIFT";
        /**
         * 优惠券发放方式，COUPONSGRANTWAY_AUTO_RELEASE 系统自动发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTWAY)
         */
        public static final String COUPONSGRANTWAY_AUTO_RELEASE = "COUPONSGRANTWAY_AUTO_RELEASE";
        /**
         * 优惠券发放方式，COUPONSGRANTWAY_REGIST_GIFT 注册有礼 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTWAY)
         */
        public static final String COUPONSGRANTWAY_REGIST_GIFT = "COUPONSGRANTWAY_REGIST_GIFT";
        /**
         * 优惠券发放方式，COUPONSGRANTWAY_ACTIVITY_MANAGER 活动管理 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=COUPONSGRANTWAY)
         */
        public static final String COUPONSGRANTWAY_ACTIVITY_MANAGER = "COUPONSGRANTWAY_ACTIVITY_MANAGER";
        
        /**
         * 买家用户类型标示，BUYERUSERTYPELABEL_ALL 全部买家用户 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=BUYERUSERTYPELABEL)
         */
        public static final String BUYERUSERTYPELABEL_ALL = "BUYERUSERTYPELABEL_ALL";
        /**
         * 买家用户类型标示，BUYERUSERTYPELABEL_NEW_REGISTER 新注册用户 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=BUYERUSERTYPELABEL)
         */
        public static final String BUYERUSERTYPELABEL_NEW_REGISTER = "BUYERUSERTYPELABEL_NEW_REGISTER";

        /**
         * 用户优惠劵使用状态：USERCOUPONSSTATUS_RECEIVED 已领取 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERCOUPONSSTATUS的内容)
         */
        public static final String USERCOUPONSSTATUS_RECEIVED = "USERCOUPONSSTATUS_RECEIVED";
        /**
         * 用户优惠劵使用状态：USERCOUPONSSTATUS_USABLE 可用 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERCOUPONSSTATUS的内容)
         */
        public static final String USERCOUPONSSTATUS_USABLE = "USERCOUPONSSTATUS_USABLE";
        /**
         * 用户优惠劵使用状态：USERCOUPONSSTATUS_USED 已使用 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERCOUPONSSTATUS的内容)
         */
        public static final String USERCOUPONSSTATUS_USED = "USERCOUPONSSTATUS_USED";
        /**
         * 用户优惠劵使用状态：USERCOUPONSSTATUS_EXPIRED 已过期 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERCOUPONSSTATUS的内容)
         */
        public static final String USERCOUPONSSTATUS_EXPIRED = "USERCOUPONSSTATUS_EXPIRED";

        /**
         * 抵用券包类型：VOUPACKTYPETYPE_SINGLE_VOUCHER 单张抵用券 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=VOUPACKTYPETYPE的内容)
         */
        public static final String VOUPACKTYPETYPE_SINGLE_VOUCHER = "VOUPACKTYPETYPE_SINGLE_VOUCHER";
        /**
         * 抵用券包类型：VOUPACKTYPETYPE_MULTIPLE_VOUCHER 多张抵用券 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=VOUPACKTYPETYPE的内容)
         */
        public static final String VOUPACKTYPETYPE_MULTIPLE_VOUCHER = "VOUPACKTYPETYPE_MULTIPLE_VOUCHER";

        /**
         * 抵用券包状态：VOUCHERSTATE_NOGRANT 未发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERSTATE)
         */
        public static final String VOUCHERSTATE_NOGRANT = "VOUCHERSTATE_NOGRANT";
        /**
         * 抵用券包状态：VOUCHERSTATE_GRANTED 已发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERSTATE)
         */
        public static final String VOUCHERSTATE_GRANTED = "VOUCHERSTATE_GRANTED";
        /**
         * 抵用券包状态：VOUCHERSTATE_DISABLE 已停用 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERSTATE)
         */
        public static final String VOUCHERSTATE_DISABLE = "VOUCHERSTATE_DISABLE";

        /**
         * 抵用券发放范围，VOUCHERGRANTRANGE_BATCH 批量发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTRANGE)
         */
        public static final String VOUCHERGRANTRANGE_BATCH = "VOUCHERGRANTRANGE_BATCH";
        /**
         * 抵用券发放范围，VOUCHERGRANTRANGE_SINGLE 单独发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTRANGE)
         */
        public static final String VOUCHERGRANTRANGE_SINGLE = "VOUCHERGRANTRANGE_SINGLE";

        /**
         * 抵用券发放方式，VOUCHERGRANTWAY_RED_ENVELOPE 抢红包 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTWAY)
         */
        public static final String VOUCHERGRANTWAY_RED_ENVELOPE = "VOUCHERGRANTWAY_RED_ENVELOPE";
        /**
         * 抵用券发放方式，VOUCHERGRANTWAY_SHARE_GIFT 分享有礼 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTWAY)
         */
        public static final String VOUCHERGRANTWAY_SHARE_GIFT = "VOUCHERGRANTWAY_SHARE_GIFT";
        /**
         * 抵用券发放方式，VOUCHERGRANTWAY_AUTO_RELEASE 系统自动发放 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTWAY)
         */
        public static final String VOUCHERGRANTWAY_AUTO_RELEASE = "VOUCHERGRANTWAY_AUTO_RELEASE";
        /**
         * 抵用券发放方式，VOUCHERGRANTWAY_REGISTER_GIFT 注册有礼 (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERGRANTWAY)
         */
        public static final String VOUCHERGRANTWAY_REGISTER_GIFT = "VOUCHERGRANTWAY_REGISTER_GIFT";

        /**
         * 抵用券业务规则限制，VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE 补贴商品无法使用
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERBUSINESSRULELIMIT)
         */
        public static final String VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE = "VOUCHERBUSINESSRULELIMIT_SUBSIDIZED_PRODUCT_NO_USE";
        /**
         * 抵用券业务规则限制，VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE 活动商品无法使用
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERBUSINESSRULELIMIT)
         */
        public static final String VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE = "VOUCHERBUSINESSRULELIMIT_ACTIVITY_PRODUCT_NO_USE";
        /**
         * 抵用券业务规则限制，VOUCHERBUSINESSRULELIMIT_SPECIAL_PRODUCT_NO_USE 特殊商品无法使用
         * (对应系统域系统字典S_SYSTEM_DICT表的DICTTYPE=VOUCHERBUSINESSRULELIMIT)
         */
        public static final String VOUCHERBUSINESSRULELIMIT_SPECIAL_PRODUCT_NO_USE = "VOUCHERBUSINESSRULELIMIT_SPECIAL_PRODUCT_NO_USE";

        /**
         * 用户抵用劵使用状态：USERVOUCHERSTATUS_RECEIVED 已领取 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERVOUCHERSTATUS的内容)
         */
        public static final String USERVOUCHERSTATUS_RECEIVED = "USERVOUCHERSTATUS_RECEIVED";
        /**
         * 用户抵用劵使用状态：USERVOUCHERSTATUS_USABLE 可用 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERVOUCHERSTATUS的内容)
         */
        public static final String USERVOUCHERSTATUS_USABLE = "USERVOUCHERSTATUS_USABLE";
        /**
         * 用户抵用劵使用状态：USERVOUCHERSTATUS_USED 已使用 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERVOUCHERSTATUS的内容)
         */
        public static final String USERVOUCHERSTATUS_USED = "USERVOUCHERSTATUS_USED";
        /**
         * 用户抵用劵使用状态：USERVOUCHERSTATUS_EXPIRED 已过期 (对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERVOUCHERSTATUS的内容)
         */
        public static final String USERVOUCHERSTATUS_EXPIRED = "USERVOUCHERSTATUS_EXPIRED";
        /**
         * 优惠券有效期类型：COUPONVALIDTYPE_CUSTOMTYPE 自定义类型 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COUPONVALIDTYPE的内容）
         */
        public static final String COUPONVALIDTYPE_CUSTOMTYPE = "COUPONVALIDTYPE_CUSTOMTYPE";
        /**
         * 优惠券有效期类型：COUPONVALIDTYPE_SYSTEMTYPE 系统定义类型 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=COUPONVALIDTYPE的内容）
         */
        public static final String COUPONVALIDTYPE_SYSTEMTYPE = "COUPONVALIDTYPE_SYSTEMTYPE";
        /**
         * 赠品发送状态：ORDERGIFTSTATUS_SENDED 已发送 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERGIFTSTATUS的内容）
         */
        public static final String ORDERGIFTSTATUS_SENDED = "ORDERGIFTSTATUS_SENDED";
        /**
         * 赠品发送状态：ORDERGIFTSTATUS_UNSEND 未发送（未领取） （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERGIFTSTATUS的内容）
         */
        public static final String ORDERGIFTSTATUS_UNSEND = "ORDERGIFTSTATUS_UNSEND";
        /**
         * 订单退款状态：ORDERREFUNDSTATUS_APPLY 退款申请 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERREFUNDSTATUS的内容）
         */
        public static final String ORDERREFUNDSTATUS_APPLY = "ORDERREFUNDSTATUS_APPLY";
        /**
         * 订单退款状态：ORDERREFUNDSTATUS_REFUNDING 退款中 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERREFUNDSTATUS的内容）
         */
        public static final String ORDERREFUNDSTATUS_REFUNDING = "ORDERREFUNDSTATUS_REFUNDING";
        /**
         * 订单退款状态：ORDERREFUNDSTATUS_SUCCESS 退款成功 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERREFUNDSTATUS的内容）
         */
        public static final String ORDERREFUNDSTATUS_SUCCESS = "ORDERREFUNDSTATUS_SUCCESS";
        /**
         * 订单退款状态：ORDERREFUNDSTATUS_FAILURE 退款失败 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERREFUNDSTATUS的内容）
         */
        public static final String ORDERREFUNDSTATUS_FAILURE = "ORDERREFUNDSTATUS_FAILURE";
        /**
         * 订单退款方式：ORDERREFUNDWAY_WEEK 1-7个工作日 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ORDERREFUNDWAY的内容）
         */
        public static final String ORDERREFUNDWAY_WEEK = "ORDERREFUNDWAY_WEEK";
        
    }

    public static final class ProductDomain {

        public static enum DictType {
            PRODUCTCLASSTYPE("PRODUCTCLASSTYPE", "产品类别类型"), PRODUCTCLASSLEVEL("PRODUCTCLASSLEVEL", "产品类别级别"), PRODUCTMAINTAINSTOREFLAG(
                    "PRODUCTMAINTAINSTOREFLAG", "系统库存是否可以维护"), PRODUCTOWNER("PRODUCTOWNER", "产品归属"), HOTSALEFLAG(
                    "HOTSALEFLAG", "是否热卖"), PRODUCTSTATUS("PRODUCTSTATUS", "产品状态"), PRODUCTSALESTATUS("PRODUCTSALESTATUS",
                    "产品上下架状态"), PRODUCTCLASSSTATUS("PRODUCTCLASSSTATUS", "产品分类状态"), PRODUCTBRANDSTATUS("PRODUCTBRANDSTATUS",
                    "产品品牌状态"), PRODUCTMODELSTATUS("PRODUCTMODELSTATUS", "产品型号状态"), PRODUCTPROPSLEVEL("PRODUCTPROPSLEVEL",
                    "产品基础属性级别"), PRODUCTPRICEOPERTYPE("PRODUCTPRICEOPERTYPE", "产品价格操作类型"), PRODUCTPROPSSHOWFLAG(
                    "PRODUCTPROPSSHOWFLAG", "产品基础属性主显示标识"), PRICEOTHERNESSSTATUS("PRICEOTHERNESSSTATUS", "价格定向状态"), SALEPRODUCTAUDITSTATUS(
                    "SALEPRODUCTAUDITSTATUS", "供应商商品审核状态"), SALEPRODUCTSALESTATUS("SALEPRODUCTSALESTATUS", "供应商商品上下架状态"), SALEPRODUCTENABLEDFLAG(
                    "SALEPRODUCTENABLEDFLAG", "供应商商品是否有效标识"), SALEPRODUCTOPERTYPE("SALEPRODUCTOPERTYPE", "供应商商品操作类型"), SALEPRODUCTPRICEOPERTYPE(
                    "SALEPRODUCTPRICEOPERTYPE", "商品价格操作类型"), SALEPRODUCTIMAGEOPERTYPE("SALEPRODUCTIMAGEOPERTYPE", "商品图片操作类型"), SALEPRODUCTPROFILEOPERTYPE(
                    "SALEPRODUCTPROFILEOPERTYPE", "商品描述操作类型"), PRODUCTIMAGEMASTERFLAG("PRODUCTIMAGEMASTERFLAG", "商品图片主图标识"), SALEZONETYPE(
                    "SALEZONETYPE", "销售专区类型"), ADVERTISEMENTTYPE("ADVERTISEMENTTYPE", "系统广告类型"), ADVERTISEMENTLINKTYPE(
                    "ADVERTISEMENTLINKTYPE", "系统广告链接类型"), ADVERTISEMENTSTATUS("ADVERTISEMENTSTATUS", "系统广告状态"), SALEPRODUCTSOURCE(
                    "SALEPRODUCTSOURCE", "商品来源"), SALEZONELINKTYPE("SALEZONELINKTYPE", "销售专区链接类型"), PRODUCTCLASSDISPLAY(
                    "PRODUCTCLASSDISPLAY", "产品分类是否显示"), SECKILLSCENEREPEATTYPE("SECKILLSCENEREPEATTYPE", "场次重复类型"), SECKILLSCENESTATUSCODE(
                    "SECKILLSCENESTATUSCODE", "场次状态"), ACTIVITYTYPE("ACTIVITYTYPE", "活动类型"), SECKILLPRODUCTQUALIFYTYPE(
                    "SECKILLPRODUCTQUALIFYTYPE", "秒杀商品参与资格类型"), SECKILLSCENEPRODUTRELATIONSTATUSCODE(
                    "SECKILLSCENEPRODUTRELATIONSTATUSCODE", "场次秒杀商品状态"), SECKILLPRODUCTSTATUS("SECKILLPRODUCTSTATUS",
                    "秒杀商品状态"), THEMEBASECOLOR("THEMEBASECOLOR", "专题底色"), FLOORSTATUS("FLOORSTATUS", "楼层状态"), FLOORLINKTYPE(
                    "FLOORLINKTYPE", "楼层跳转链接类型"), H5PAGETYPE("H5PAGETYPE", "H5页面类型"), REDENVELOPEACTIVITYSTATUS(
                    "REDENVELOPEACTIVITYSTATUS", "抢红包活动状态"), REDENVELOPEREWARDTYPE("REDENVELOPEREWARDTYPE", "红包奖励类型"), REDENVELOPEREWARDSTATUS(
                    "REDENVELOPEREWARDSTATUS", "红包奖励状态"), AUDITPRODUCTSUBMITSTATUS("AUDITPRODUCTSUBMITSTATUS", "待审核产品提交审核状态"), AUDITPRODUCTAUDITSTATUS(
                    "AUDITPRODUCTAUDITSTATUS", "待审核产品审核状态"), AUDITPRODUCTDATARESOURCE("AUDITPRODUCTDATARESOURCE",
                    "待审核产品审核状态"),BUYREWARDACTIVITYSTATUSCODE("BUYREWARDACTIVITYSTATUSCODE", "买赠活动状态"),BUYREWARDACTIVITYVALUEMETHOD("BUYREWARDACTIVITYVALUEMETHOD", "买赠活动取值方式")
                    ,BUYREWARDACTIVITYGIFTTYPE("BUYREWARDACTIVITYGIFTTYPE", "赠品类型"),BUYREWARDACTIVITYAUDITSTATUS(
                            "BUYREWARDACTIVITYAUDITSTATUS", "买赠活动审核状态");

            private final String value;
            private final String text;

            private DictType(String value, String text) {
                this.value = value;
                this.text = text;
            }

            public String getValue() {
                return value;
            }

            public String getText() {
                return text;
            }

            public static DictType getEnum(String value) {
                if (value != null) {
                    DictType[] values = DictType.values();
                    for (DictType val : values) {
                        if (val.getValue().equals(value)) {
                            return val;
                        }
                    }
                }
                return null;
            }
        }

        /**
         * 产品类别类型： PRODUCTCLASSTYPE_BASIC 基础类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSTYPE)）
         */
        public static final String PRODUCTCLASSTYPE_BASIC = "PRODUCTCLASSTYPE_BASIC";
        /**
         * 产品类别类型： PRODUCTCLASSTYPE_BASIC 一级类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSTYPE)）
         */
        public static final String PRODUCTCLASSTYPE_FIRST = "PRODUCTCLASSTYPE_FIRST";
        /**
         * 产品类别级别： PRODUCTCLASSSLEVEL_TOP 顶级级别（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSLEVEL)）
         */
        public static final String PRODUCTCLASSSLEVEL_TOP = "PRODUCTCLASSSLEVEL_TOP";
        /**
         * 产品类别级别： PRODUCTCLASSSLEVEL_FIRST 一级级别（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSLEVEL)）
         */
        public static final String PRODUCTCLASSSLEVEL_FIRST = "PRODUCTCLASSSLEVEL_FIRST";
        /**
         * 产品类别级别： PRODUCTCLASSSLEVEL_SECOND 二级级别（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSLEVEL)）
         */
        public static final String PRODUCTCLASSSLEVEL_SECOND = "PRODUCTCLASSSLEVEL_SECOND";
        /**
         * 产品类别级别： PRODUCTCLASSSLEVEL_THIRD 三级级别（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSLEVEL)）
         */
        public static final String PRODUCTCLASSSLEVEL_THIRD = "PRODUCTCLASSSLEVEL_THIRD";
        /**
         * 系统库存是否可以维护： PRODUCTMAINTAINSTOREFLAG_YES
         * 可以维护（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTMAINTAINSTOREFLAG)）
         */
        public static final String PRODUCTMAINTAINSTOREFLAG_YES = "PRODUCTMAINTAINSTOREFLAG_YES";
        /**
         * 系统库存是否可以维护： PRODUCTMAINTAINSTOREFLAG_NO
         * 不可以维护（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTMAINTAINSTOREFLAG)）
         */
        public static final String PRODUCTMAINTAINSTOREFLAG_NO = "PRODUCTMAINTAINSTOREFLAG_NO";

        /**
         * 产品归属： PRODUCTOWNER_OTHER 非一里递产品（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTOWNER)）
         */
        public static final String PRODUCTOWNER_OTHER = "PRODUCTOWNER_OTHER";
        /**
         * 产品归属： PRODUCTOWNER_YILIDI 一里递产品（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTOWNER)）
         */
        public static final String PRODUCTOWNER_YILIDI = "PRODUCTOWNER_YILIDI";

        /**
         * 是否热卖： HOTSALEFLAG_NO 非热卖（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=HOTSALEFLAG)）
         */
        public static final String HOTSALEFLAG_NO = "HOTSALEFLAG_NO";
        /**
         * 是否热卖： HOTSALEFLAG_YES 热卖（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=HOTSALEFLAG)）
         */
        public static final String HOTSALEFLAG_YES = "HOTSALEFLAG_YES";

        /**
         * 产品状态： PRODUCTSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTSTATUS的内容）
         */
        public static final String PRODUCTSTATUS_ON = "PRODUCTSTATUS_ON";
        /**
         * 产品状态： PRODUCTSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTSTATUS的内容）
         */
        public static final String PRODUCTSTATUS_OFF = "PRODUCTSTATUS_OFF";

        /**
         * 产品上下架状态： PRODUCTSALESTATUS_INIT 未上架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTSALESTATUS的内容）
         */
        public static final String PRODUCTSALESTATUS_INIT = "PRODUCTSALESTATUS_INIT";
        /**
         * 产品上下架状态： PRODUCTSALESTATUS_ONSALE 已上架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTSALESTATUS的内容）
         */
        public static final String PRODUCTSALESTATUS_ONSALE = "PRODUCTSALESTATUS_ONSALE";
        /**
         * 产品上下架状态： PRODUCTSALESTATUS_OFFSALE 已下架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTSALESTATUS的内容）
         */
        public static final String PRODUCTSALESTATUS_OFFSALE = "PRODUCTSALESTATUS_OFFSALE";

        /**
         * 产品分类状态： PRODUCTCLASSSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTCLASSSTATUS的内容）
         */
        public static final String PRODUCTCLASSSTATUS_ON = "PRODUCTCLASSSTATUS_ON";
        /**
         * 产品分类状态： PRODUCTCLASSSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTCLASSSTATUS的内容）
         */
        public static final String PRODUCTCLASSSTATUS_OFF = "PRODUCTCLASSSTATUS_OFF";

        /**
         * 产品品牌状态： PRODUCTBRANDSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTBRANDSTATUS的内容）
         */
        public static final String PRODUCTBRANDSTATUS_ON = "PRODUCTBRANDSTATUS_ON";
        /**
         * 产品品牌状态： PRODUCTBRANDSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTBRANDSTATUS的内容）
         */
        public static final String PRODUCTBRANDSTATUS_OFF = "PRODUCTBRANDSTATUS_OFF";

        /**
         * 产品型号状态： PRODUCTMODELSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTMODELSTATUS的内容）
         */
        public static final String PRODUCTMODELSTATUS_ON = "PRODUCTMODELSTATUS_ON";
        /**
         * 产品型号状态： PRODUCTMODELSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTMODELSTATUS的内容）
         */
        public static final String PRODUCTMODELSTATUS_OFF = "PRODUCTMODELSTATUS_OFF";

        /**
         * 产品基础属性级别： PRODUCTPROPSLEVEL_CLASSES 属性类别（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPROPSLEVEL的内容）
         */
        public static final String PRODUCTPROPSLEVEL_CLASSES = "PRODUCTPROPSLEVEL_CLASSES";
        /**
         * 产品基础属性级别： PRODUCTPROPSLEVEL_PROPERTIES 属性（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPROPSLEVEL的内容）
         */
        public static final String PRODUCTPROPSLEVEL_PROPERTIES = "PRODUCTPROPSLEVEL_PROPERTIES";

        /**
         * 产品价格操作类型： PRODUCTPRICEOPERTYPE_CREATE 创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPRICEOPERTYPE的内容）
         */
        public static final String PRODUCTPRICEOPERTYPE_CREATE = "PRODUCTPRICEOPERTYPE_CREATE";
        /**
         * 产品价格操作类型： PRODUCTPRICEOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPRICEOPERTYPE的内容）
         */
        public static final String PRODUCTPRICEOPERTYPE_MODIFY = "PRODUCTPRICEOPERTYPE_MODIFY";

        /**
         * 产品基础属性主显示标识： PRODUCTPROPSSHOWFLAG_YES 是（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPROPSSHOWFLAG的内容）
         */
        public static final String PRODUCTPROPSSHOWFLAG_YES = "PRODUCTPROPSSHOWFLAG_YES";
        /**
         * 产品基础属性主显示标识： PRODUCTPROPSSHOWFLAG_NO 否（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTPROPSSHOWFLAG的内容）
         */
        public static final String PRODUCTPROPSSHOWFLAG_NO = "PRODUCTPROPSSHOWFLAG_NO";

        /**
         * 价格定向状态： PRICEOTHERNESSSTATUS_ON 有效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRICEOTHERNESSSTATUS的内容）
         */
        public static final String PRICEOTHERNESSSTATUS_ON = "PRICEOTHERNESSSTATUS_ON";
        /**
         * 价格定向状态： PRICEOTHERNESSSTATUS_OFF 无效（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRICEOTHERNESSSTATUS的内容）
         */
        public static final String PRICEOTHERNESSSTATUS_OFF = "PRICEOTHERNESSSTATUS_OFF";

        /**
         * 供应商商品审核状态： SALEPRODUCTAUDITSTATUS_NOT_YET 未审核（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTAUDITSTATUS的内容）
         */
        public static final String SALEPRODUCTAUDITSTATUS_NOT_YET = "SALEPRODUCTAUDITSTATUS_NOT_YET";
        /**
         * 供应商商品审核状态： SALEPRODUCTAUDITSTATUS_PASSED 审核通过（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTAUDITSTATUS的内容）
         */
        public static final String SALEPRODUCTAUDITSTATUS_PASSED = "SALEPRODUCTAUDITSTATUS_PASSED";
        /**
         * 供应商商品审核状态： SALEPRODUCTAUDITSTATUS_NOT_PASSED 审核不通过（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTAUDITSTATUS的内容）
         */
        public static final String SALEPRODUCTAUDITSTATUS_NOT_PASSED = "SALEPRODUCTAUDITSTATUS_NOT_PASSED";

        /**
         * 供应商商品上下架状态： SALEPRODUCTSALESTATUS_INIT 未上架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTSALESTATUS的内容）
         */
        public static final String SALEPRODUCTSALESTATUS_INIT = "SALEPRODUCTSALESTATUS_INIT";
        /**
         * 供应商商品上下架状态： SALEPRODUCTSALESTATUS_ONSALE 已上架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTSALESTATUS的内容）
         */
        public static final String SALEPRODUCTSALESTATUS_ONSALE = "SALEPRODUCTSALESTATUS_ONSALE";
        /**
         * 供应商商品上下架状态： SALEPRODUCTSALESTATUS_OFFSALE 已下架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTSALESTATUS的内容）
         */
        public static final String SALEPRODUCTSALESTATUS_OFFSALE = "SALEPRODUCTSALESTATUS_OFFSALE";

        /**
         * 供应商商品是否有效标识： SALEPRODUCTENABLEDFLAG_ON 启用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTENABLEDFLAG的内容）
         */
        public static final String SALEPRODUCTENABLEDFLAG_ON = "SALEPRODUCTENABLEDFLAG_ON";
        /**
         * 供应商商品是否有效标识： SALEPRODUCTENABLEDFLAG_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTENABLEDFLAG的内容）
         */
        public static final String SALEPRODUCTENABLEDFLAG_OFF = "SALEPRODUCTENABLEDFLAG_OFF";

        /**
         * 供应商商品操作类型： SALEPRODUCTOPERTYPE_CREATE 创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTOPERTYPE的内容）
         */
        public static final String SALEPRODUCTOPERTYPE_CREATE = "SALEPRODUCTOPERTYPE_CREATE";
        /**
         * 供应商商品操作类型： SALEPRODUCTOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTOPERTYPE的内容）
         */
        public static final String SALEPRODUCTOPERTYPE_MODIFY = "SALEPRODUCTOPERTYPE_MODIFY";
        /**
         * 供应商商品操作类型： SALEPRODUCTOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTOPERTYPE的内容）
         */
        public static final String SALEPRODUCTOPERTYPE_DELETE = "SALEPRODUCTOPERTYPE_DELETE";
        /**
         * 供应商商品操作类型： SALEPRODUCTOPERTYPE_AUDIT 审核（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTOPERTYPE的内容）
         */
        public static final String SALEPRODUCTOPERTYPE_AUDIT = "SALEPRODUCTOPERTYPE_AUDIT";
        /**
         * 供应商商品操作类型： SALEPRODUCTOPERTYPE_CHANGESALESTATUS 上下架（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTOPERTYPE的内容）
         */
        public static final String SALEPRODUCTOPERTYPE_CHANGESALESTATUS = "SALEPRODUCTOPERTYPE_CHANGESALESTATUS";

        /**
         * 商品价格操作类型：SALEPRODUCTPRICEOPERTYPE_CREATE 创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTPRICEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTPRICEOPERTYPE_CREATE = "SALEPRODUCTPRICEOPERTYPE_CREATE";
        /**
         * 商品价格操作类型：SALEPRODUCTPRICEOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTPRICEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTPRICEOPERTYPE_MODIFY = "SALEPRODUCTPRICEOPERTYPE_MODIFY";

        /**
         * 商品图片操作类型：SALEPRODUCTIMAGEOPERTYPE_CREATE 创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTIMAGEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTIMAGEOPERTYPE_CREATE = "SALEPRODUCTIMAGEOPERTYPE_CREATE";
        /**
         * 商品图片操作类型： SALEPRODUCTIMAGEOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTIMAGEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTIMAGEOPERTYPE_MODIFY = "SALEPRODUCTIMAGEOPERTYPE_MODIFY";
        /**
         * 商品图片操作类型： SALEPRODUCTIMAGEOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTIMAGEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTIMAGEOPERTYPE_DELETE = "SALEPRODUCTIMAGEOPERTYPE_DELETE";

        /**
         * 商品描述操作类型： SALEPRODUCTPROFILEOPERTYPE_CREATE 创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTPROFILEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTPROFILEOPERTYPE_CREATE = "SALEPRODUCTPROFILEOPERTYPE_CREATE";
        /**
         * 商品描述操作类型： SALEPRODUCTPROFILEOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTPROFILEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTPROFILEOPERTYPE_MODIFY = "SALEPRODUCTPROFILEOPERTYPE_MODIFY";
        /**
         * 商品描述操作类型： SALEPRODUCTPROFILEOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SALEPRODUCTPROFILEOPERTYPE的内容）
         */
        public static final String SALEPRODUCTPROFILEOPERTYPE_DELETE = "SALEPRODUCTPROFILEOPERTYPE_DELETE";

        /**
         * 商品图片主图标识： PRODUCTIMAGEMASTERFLAG_YES 主图（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTIMAGEMASTERFLAG的内容）
         */
        public static final String PRODUCTIMAGEMASTERFLAG_YES = "PRODUCTIMAGEMASTERFLAG_YES";
        /**
         * 商品图片主图标识： PRODUCTIMAGEMASTERFLAG_NO 非主图（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PRODUCTIMAGEMASTERFLAG的内容）
         */
        public static final String PRODUCTIMAGEMASTERFLAG_NO = "PRODUCTIMAGEMASTERFLAG_NO";
        /**
         * 销售专区类型:SALEZONETYPE_VIP 升级VIP专区
         */
        public static final String SALEZONETYPE_VIP = "SALEZONETYPE_VIP";

        /**
         * 销售专区类型:SALEZONETYPE_RECOMMEND 每周推荐专区
         */
        public static final String SALEZONETYPE_RECOMMEND = "SALEZONETYPE_RECOMMEND";
        /**
         * 销售专区类型:SALEZONETYPE_CLASS 商品分类
         */
        public static final String SALEZONETYPE_CLASS = "SALEZONETYPE_CLASS";

        /**
         * 系统广告类型： ADVERTISEMENTTYPE_HOMEBANNER 首页横幅广告（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTTYPE的内容）
         */
        public static final String ADVERTISEMENTTYPE_HOMEBANNER = "ADVERTISEMENTTYPE_HOMEBANNER";
        /**
         * 系统广告类型： ADVERTISEMENTTYPE_VIPUPGRADE 升级VIP专区的BANNER广告（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTTYPE的内容）
         */
        public static final String ADVERTISEMENTTYPE_VIPUPGRADE = "ADVERTISEMENTTYPE_VIPUPGRADE";
        /**
         * 系统广告类型： ADVERTISEMENTTYPE_WEEKRECOMMEND 每周推荐专区BANNER广告（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTTYPE的内容）
         */
        public static final String ADVERTISEMENTTYPE_WEEKRECOMMEND = "ADVERTISEMENTTYPE_WEEKRECOMMEND";
        /**
         * 系统广告类型： ADVERTISEMENTTYPE_PENNYRPODUCT 一分钱商品专区BANNER广告（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTTYPE的内容）
         */
        public static final String ADVERTISEMENTTYPE_PENNYRPODUCT = "ADVERTISEMENTTYPE_PENNYRPODUCT";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_NONE 没有链接（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_NONE = "ADVERTISEMENTLINKTYPE_NONE";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_PRODUCTCLASS 商品分类（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_PRODUCTCLASS = "ADVERTISEMENTLINKTYPE_PRODUCTCLASS";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_ZONE 专区页面和H5页面（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_ZONE = "ADVERTISEMENTLINKTYPE_ZONE";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_HOMECLASSZONE 首页分类专区（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_HOMECLASSZONE = "ADVERTISEMENTLINKTYPE_HOMECLASSZONE";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_THEME 专题（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_THEME = "ADVERTISEMENTLINKTYPE_THEME";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_ACTIVITY 活动（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_ACTIVITY = "ADVERTISEMENTLINKTYPE_ACTIVITY";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_H5PAGE H5页面（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_H5PAGE = "ADVERTISEMENTLINKTYPE_H5PAGE";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL 商品详情页（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL = "ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL";
        /**
         * 系统广告链接类型： ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT
         * 网站资讯、公告（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTLINKTYPE的内容）
         */
        public static final String ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT = "ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT";
        /**
         * 系统广告状态： ADVERTISEMENTSTATUS_PUBLISHED 显示（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTSTATUS的内容）
         */
        public static final String ADVERTISEMENTSTATUS_PUBLISHED = "ADVERTISEMENTSTATUS_PUBLISHED";
        /**
         * 系统广告状态： ADVERTISEMENTSTATUS_REVOKE 不显示（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ADVERTISEMENTSTATUS的内容）
         */
        public static final String ADVERTISEMENTSTATUS_REVOKE = "ADVERTISEMENTSTATUS_REVOKE";

        /**
         * 商品来源： SALEPRODUCTSOURCE_STANDARD 标准库（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTSOURCE)）
         */
        public static final String SALEPRODUCTSOURCE_STANDARD = "SALEPRODUCTSOURCE_STANDARD";
        /**
         * 商品来源： SALEPRODUCTSOURCE_STORE 店铺（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTSOURCE)）
         */
        public static final String SALEPRODUCTSOURCE_STORE = "SALEPRODUCTSOURCE_STORE";
        /**
         * 商品来源： SALEPRODUCTSOURCE_SYSTEM 系统（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTSOURCE)）
         */
        public static final String SALEPRODUCTSOURCE_SYSTEM = "SALEPRODUCTSOURCE_SYSTEM";
        /**
         * 销售专区链接类型： SALEZONELINKTYPE_SALEZONE 销售专区链接类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEZONELINKTYPE)）
         */
        public static final String SALEZONELINKTYPE_SALEZONE = "SALEZONELINKTYPE_SALEZONE";
        /**
         * 销售专区链接类型： SALEZONELINKTYPE_PRODUCTCLASS 产品分类链接类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEZONELINKTYPE)）
         */
        public static final String SALEZONELINKTYPE_PRODUCTCLASS = "SALEZONELINKTYPE_PRODUCTCLASS";
        /**
         * 产品分类是否显示： PRODUCTCLASSDISPLAY_YES 显示（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSDISPLAY)）
         */
        public static final String PRODUCTCLASSDISPLAY_YES = "PRODUCTCLASSDISPLAY_YES";
        /**
         * 产品分类是否显示： PRODUCTCLASSDISPLAY_NO 不显示（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PRODUCTCLASSDISPLAY)）
         */
        public static final String PRODUCTCLASSDISPLAY_NO = "PRODUCTCLASSDISPLAY_NO";
        /**
         * 场次重复类型： SECKILLSCENEREPEATTYPE_NOTREPEAT 不重复（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENEREPEATTYPE)）
         */
        public static final String SECKILLSCENEREPEATTYPE_NOTREPEAT = "SECKILLSCENEREPEATTYPE_NOTREPEAT";
        /**
         * 场次重复类型： SECKILLSCENEREPEATTYPE_REPEAT 重复（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENEREPEATTYPE)）
         */
        public static final String SECKILLSCENEREPEATTYPE_REPEAT = "SECKILLSCENEREPEATTYPE_REPEAT";
        /**
         * 场次状态： SECKILLSCENESTATUSCODE_NOTSTART 未开始（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENESTATUSCODE)）
         */
        public static final String SECKILLSCENESTATUSCODE_NOTSTART = "SECKILLSCENESTATUSCODE_NOTSTART";
        /**
         * 场次状态： SECKILLSCENESTATUSCODE_STARTING 疯抢中（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENESTATUSCODE)）
         */
        public static final String SECKILLSCENESTATUSCODE_STARTING = "SECKILLSCENESTATUSCODE_STARTING";
        /**
         * 场次状态： SECKILLSCENESTATUSCODE_STARTED 已开始（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENESTATUSCODE)）
         */
        public static final String SECKILLSCENESTATUSCODE_STARTED = "SECKILLSCENESTATUSCODE_STARTED";
        /**
         * 场次状态： SECKILLSCENESTATUSCODE_EXPIRED 已失效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENESTATUSCODE)）
         */
        public static final String SECKILLSCENESTATUSCODE_EXPIRED = "SECKILLSCENESTATUSCODE_EXPIRED";
        /**
         * 活动类型： ACTIVITYTYPE_SECKILL 秒杀活动（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=ACTIVITYTYPE)）
         */
        public static final String ACTIVITYTYPE_SECKILL = "ACTIVITYTYPE_SECKILL";
        /**
         * 活动类型： ACTIVITYTYPE_REDENVELOPE 抢红包活动（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=ACTIVITYTYPE)）
         */
        public static final String ACTIVITYTYPE_REDENVELOPE = "ACTIVITYTYPE_REDENVELOPE";
        /**
         * 活动类型： ACTIVITYTYPE_BUYERREWARD 买赠活动（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=ACTIVITYTYPE)）
         */
        public static final String ACTIVITYTYPE_BUYERREWARD = "ACTIVITYTYPE_BUYERREWARD";
        /**
         * 秒杀商品参与资格类型： SECKILLPRODUCTQUALIFYTYPE_ALL
         * 不限（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLPRODUCTQUALIFYTYPE)）
         */
        public static final String SECKILLPRODUCTQUALIFYTYPE_ALL = "SECKILLPRODUCTQUALIFYTYPE_ALL";
        /**
         * 场次秒杀商品状态： SECKILLSCENEPRODUTRELATIONSTATUSCODE_ON
         * 有效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENEPRODUTRELATIONSTATUSCODE)）
         */
        public static final String SECKILLSCENEPRODUTRELATIONSTATUSCODE_ON = "SECKILLSCENEPRODUTRELATIONSTATUSCODE_ON";
        /**
         * 场次秒杀商品状态： SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
         * 失效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLSCENEPRODUTRELATIONSTATUSCODE)）
         */
        public static final String SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF = "SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF";
        /**
         * 秒杀商品状态： SECKILLPRODUCTSTATUS_ON 有效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLPRODUCTSTATUS)）
         */
        public static final String SECKILLPRODUCTSTATUS_ON = "SECKILLPRODUCTSTATUS_ON";
        /**
         * 秒杀商品状态： SECKILLPRODUCTSTATUS_OFF 无效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SECKILLPRODUCTSTATUS)）
         */
        public static final String SECKILLPRODUCTSTATUS_OFF = "SECKILLPRODUCTSTATUS_OFF";
        /**
         * 专题底色： THEMEBASECOLOR_RED 红色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_RED = "THEMEBASECOLOR_RED";
        /**
         * 专题底色： THEMEBASECOLOR_YELLOW 黄色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_YELLOW = "THEMEBASECOLOR_YELLOW";
        /**
         * 专题底色： THEMEBASECOLOR_LIGHTBLUE 浅蓝色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_LIGHTBLUE = "THEMEBASECOLOR_LIGHTBLUE";
        /**
         * 专题底色： THEMEBASECOLOR_NAVYBLUE 深蓝色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_NAVYBLUE = "THEMEBASECOLOR_NAVYBLUE";
        /**
         * 专题底色： THEMEBASECOLOR_LAKEBLUE 碧蓝色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_LAKEBLUE = "THEMEBASECOLOR_LAKEBLUE";
        /**
         * 专题底色： THEMEBASECOLOR_GREEN 绿色（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLOR)）
         */
        public static final String THEMEBASECOLOR_GREEN = "THEMEBASECOLOR_GREEN";
        /**
         * 楼层状态： FLOORSTATUS_ENABLED 启用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FLOORSTATUS的内容）
         */
        public static final String FLOORSTATUS_ENABLED = "FLOORSTATUS_ENABLED";
        /**
         * 楼层状态： FLOORSTATUS_DISABLED 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=FLOORSTATUS的内容）
         */
        public static final String FLOORSTATUS_DISABLED = "FLOORSTATUS_DISABLED";
        /**
         * 楼层跳转链接类型： FLOORLINKTYPE_PRODUCT 楼层商品链接类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORLINKTYPE)）
         */
        public static final String FLOORLINKTYPE_PRODUCT = "FLOORLINKTYPE_PRODUCT";
        /**
         * 楼层跳转链接类型： FLOORLINKTYPE_PRODUCT_CLASS 商品分类链接类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORLINKTYPE)）
         */
        public static final String FLOORLINKTYPE_PRODUCT_CLASS = "FLOORLINKTYPE_PRODUCT_CLASS";
        /**
         * 楼层跳转链接类型： FLOORLINKTYPE_ZONE 专区页面链接类型（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORLINKTYPE)）
         */
        public static final String FLOORLINKTYPE_ZONE = "FLOORLINKTYPE_ZONE";
        /**
         * H5页面类型： H5PAGETYPE_ABOUT_US 关于我们（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_ABOUT_US = "H5PAGETYPE_ABOUT_US";
        /**
         * H5页面类型： H5PAGETYPE_COMMON_QUESTION 常见问题（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_COMMON_QUESTION = "H5PAGETYPE_COMMON_QUESTION";
        /**
         * H5页面类型： H5PAGETYPE_PARTNER_JOIN 合伙人加盟（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_PARTNER_JOIN = "H5PAGETYPE_PARTNER_JOIN";
        /**
         * H5页面类型： H5PAGETYPE_FRESHMAN_EXCLUSIVE 新人专享（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_FRESHMAN_EXCLUSIVE = "H5PAGETYPE_FRESHMAN_EXCLUSIVE";
        /**
         * H5页面类型： H5PAGETYPE_UPGRADE_VIP 升级VIP（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_UPGRADE_VIP = "H5PAGETYPE_UPGRADE_VIP";
        /**
         * H5页面类型： H5PAGETYPE_UPGRADE_VIP_NEW 新版升级VIP（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_UPGRADE_VIP_NEW = "H5PAGETYPE_UPGRADE_VIP_NEW";
        /**
         * H5页面类型： H5PAGETYPE_MILK_PROMOTION 牛奶促销（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_MILK_PROMOTION = "H5PAGETYPE_MILK_PROMOTION";
        /**
         * H5页面类型： H5PAGETYPE_REGISTER_GIFT 注册有礼（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_REGISTER_GIFT = "H5PAGETYPE_REGISTER_GIFT";
        /**
         * H5页面类型： H5PAGETYPE_SHARE_PAGE 分享有礼（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=H5PAGETYPE)）
         */
        public static final String H5PAGETYPE_SHARE_PAGE = "H5PAGETYPE_SHARE_PAGE";

        /**
         * 抢红包活动状态： REDENVELOPEACTIVITYSTATUS_NOT_START
         * 未开始（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEACTIVITYSTATUS)）
         */
        public static final String REDENVELOPEACTIVITYSTATUS_NOT_START = "REDENVELOPEACTIVITYSTATUS_NOT_START";
        /**
         * 抢红包活动状态： REDENVELOPEACTIVITYSTATUS_STARTING
         * 已开始（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEACTIVITYSTATUS)）
         */
        public static final String REDENVELOPEACTIVITYSTATUS_STARTING = "REDENVELOPEACTIVITYSTATUS_STARTING";
        /**
         * 抢红包活动状态： REDENVELOPEACTIVITYSTATUS_END
         * 已结束（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEACTIVITYSTATUS)）
         */
        public static final String REDENVELOPEACTIVITYSTATUS_END = "REDENVELOPEACTIVITYSTATUS_END";

        /**
         * 红包奖励类型： REDENVELOPEREWARDTYPE_COUPON 优惠券（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDTYPE)）
         */
        public static final String REDENVELOPEREWARDTYPE_COUPON = "REDENVELOPEREWARDTYPE_COUPON";
        /**
         * 红包奖励类型： REDENVELOPEREWARDTYPE_VOUCHER 抵用券（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDTYPE)）
         */
        public static final String REDENVELOPEREWARDTYPE_VOUCHER = "REDENVELOPEREWARDTYPE_VOUCHER";

        /**
         * 红包奖励状态： REDENVELOPEREWARDSTATUS_VALID 有效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDSTATUS)）
         */
        public static final String REDENVELOPEREWARDSTATUS_VALID = "REDENVELOPEREWARDSTATUS_VALID";
        /**
         * 红包奖励状态： REDENVELOPEREWARDSTATUS_INVALID 无效（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDSTATUS)）
         */
        public static final String REDENVELOPEREWARDSTATUS_INVALID = "REDENVELOPEREWARDSTATUS_INVALID";
        /**
         * 待审核产品提交审核状态： AUDITPRODUCTSUBMITSTATUS_NONE
         * 未提交审核（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTSUBMITSTATUS)）
         */
        public static final String AUDITPRODUCTSUBMITSTATUS_NONE = "AUDITPRODUCTSUBMITSTATUS_NONE";
        /**
         * 待审核产品提交审核状态： AUDITPRODUCTSUBMITSTATUS_PART
         * 部分提交审核（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTSUBMITSTATUS)）
         */
        public static final String AUDITPRODUCTSUBMITSTATUS_PART = "AUDITPRODUCTSUBMITSTATUS_PART";
        /**
         * 待审核产品提交审核状态： AUDITPRODUCTSUBMITSTATUS_ALL
         * 全部提交审核（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTSUBMITSTATUS)）
         */
        public static final String AUDITPRODUCTSUBMITSTATUS_ALL = "AUDITPRODUCTSUBMITSTATUS_ALL";

        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_FOR_AUDIT
         * 待审核（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_FOR_AUDIT = "AUDITPRODUCTAUDITSTATUS_FOR_AUDIT";
        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT
         * 待初审（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT = "AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT";
        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED
         * 初审驳回（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED = "AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED";
        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT
         * 待终审（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT = "AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT";
        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED
         * 终审驳回（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED = "AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED";
        /**
         * 待审核产品审核状态： AUDITPRODUCTAUDITSTATUS_FINISHED
         * 审核完毕（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTAUDITSTATUS)）
         */
        public static final String AUDITPRODUCTAUDITSTATUS_FINISHED = "AUDITPRODUCTAUDITSTATUS_FINISHED";
        /**
         * 待审核产品数据来源： AUDITPRODUCTDATARESOURCE_PACKET
         * 来源：数据包导入（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTDATARESOURCE)）
         */
        public static final String AUDITPRODUCTDATARESOURCE_PACKET = "AUDITPRODUCTDATARESOURCE_PACKET";
        /**
         * 待审核产品数据来源： AUDITPRODUCTDATARESOURCE_STANDARD
         * 来源：新建、修改（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=AUDITPRODUCTDATARESOURCE)）
         */
        public static final String AUDITPRODUCTDATARESOURCE_STANDARD = "AUDITPRODUCTDATARESOURCE_STANDARD";
        /**
         * 买赠活动状态：BUYREWARDACTIVITYSTATUSCODE_NOTSTART 未开始（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYSTATUSCODE)）
         */
        public static final String BUYREWARDACTIVITYSTATUSCODE_NOTSTART = "BUYREWARDACTIVITYSTATUSCODE_NOTSTART";
        /**
         * 买赠活动状态：BUYREWARDACTIVITYSTATUSCODE_STARTED 进行中（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYSTATUSCODE)）
         */
        public static final String BUYREWARDACTIVITYSTATUSCODE_STARTED = "BUYREWARDACTIVITYSTATUSCODE_STARTED";
        /**
         * 买赠活动状态： BUYREWARDACTIVITYSTATUSCODE_EXPIRED 已结束（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYSTATUSCODE)）
         */
        public static final String BUYREWARDACTIVITYSTATUSCODE_EXPIRED = "BUYREWARDACTIVITYSTATUSCODE_EXPIRED";
        /**
         * 买赠活动取值方式：BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE 倍数（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYVALUEMETHOD)）
         */
        public static final String BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE = "BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE";
        /**
         * 买赠活动取值方式： BUYREWARDACTIVITYVALUEMETHOD_INTERVAL 区间（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYVALUEMETHOD)）
         */
        public static final String BUYREWARDACTIVITYVALUEMETHOD_INTERVAL = "BUYREWARDACTIVITYVALUEMETHOD_INTERVAL";
        /**
         * 买赠活动赠品类型：BUYREWARDACTIVITYGIFTTYPE_PRODUCT 赠品（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYGIFTTYPE)）
         */
        public static final String BUYREWARDACTIVITYGIFTTYPE_PRODUCT = "BUYREWARDACTIVITYGIFTTYPE_PRODUCT";
        /**
         * 买赠活动赠品类型： BUYREWARDACTIVITYGIFTTYPE_COUPON 优惠券（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYGIFTTYPE)）
         */
        public static final String BUYREWARDACTIVITYGIFTTYPE_COUPON = "BUYREWARDACTIVITYGIFTTYPE_COUPON";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_FOR_AUDIT
         * 待审核（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_FOR_AUDIT = "BUYREWARDACTIVITYAUDITSTATUS_FOR_AUDIT";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_FOR_INIT_AUDIT
         * 待初审（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_FOR_INIT_AUDIT = "BUYREWARDACTIVITYAUDITSTATUS_FOR_INIT_AUDIT";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_INIT_AUDIT_REJECTED
         * 初审驳回（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_INIT_AUDIT_REJECTED = "BUYREWARDACTIVITYAUDITSTATUS_INIT_AUDIT_REJECTED";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT
         * 待终审（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT = "BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED
         * 终审驳回（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED = "BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED";
        /**
         * 买赠活动审核状态： BUYREWARDACTIVITYAUDITSTATUS_FINISHED
         * 审核完毕（关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYREWARDACTIVITYAUDITSTATUS)）
         */
        public static final String BUYREWARDACTIVITYAUDITSTATUS_FINISHED = "BUYREWARDACTIVITYAUDITSTATUS_FINISHED";
        
    }

    public static final class SystemDomain {

        public static enum DictType {
            PERMISSIONTYPE("PERMISSIONTYPE", "权限类型"), PERMISSIONSTATUS("PERMISSIONSTATUS", "权限状态"), PERMISSIONLEVEL(
                    "PERMISSIONLEVEL", "权限级别"), PERMISSIONOPERTYPE("PERMISSIONOPERTYPE", "权限操作类型"), ROLEOPERTYPE(
                    "ROLEOPERTYPE", "角色操作类型"), ROLEPERMISSIONOPERTYPE("ROLEPERMISSIONOPERTYPE", "角色权限操作类型"), USERROLEOPERTYPE(
                    "USERROLEOPERTYPE", "用户角色操作类型"), SYSDICTSTATUS("SYSDICTSTATUS", "系统字典状态"), SYSDICTOPERTYPE(
                    "SYSDICTOPERTYPE", "系统字典操作类型"), SYSPARAMSTATUS("SYSPARAMSTATUS", "系统参数状态"), SYSPARAMOPERTYPE(
                    "SYSPARAMOPERTYPE", "系统参数操作类型"), AREATYPE("AREATYPE", "区域类别"), NOTIFYMSGTYPE("NOTIFYMSGTYPE", "通知消息类型"), NOTIFYMSGSTATUS(
                    "NOTIFYMSGSTATUS", "通知消息状态"), NOTIFYMSGREPORTSTATUS("NOTIFYMSGREPORTSTATUS", "通知消息报告状态"), SMSNOTIFYMSGTYPE(
                    "SMSNOTIFYMSGTYPE", "短信消息类型"), SMSNOTIFYPROVIDETYPE("SMSNOTIFYPROVIDETYPE", "短信消息提供方类型"), PUSHNOTIFYMSGTYPE(
                    "PUSHNOTIFYMSGTYPE", "推送消息类型"), PUSHNOTIFYPROVIDETYPE("PUSHNOTIFYPROVIDETYPE", "推送消息提供方类型"), MESSAGESENDTYPE(
                    "MESSAGESENDTYPE", "消息发送方式"), EXCEPTIONMESSAGESOURCE("EXCEPTIONMESSAGESOURCE", "异常消息来源"),MESSAGETYPEGROUP(
                    "MESSAGETYPEGROUP","消息类型组"),SYSTEMMESSAGETYPE("SYSTEMMESSAGETYPE","系统消息类型"),USERMESSAGETYPE(
                    "USERMESSAGETYPE","用户消息类型"),MESSAGEPUBLISHOBJECT("MESSAGEPUBLISHOBJECT","消息发布对象"),MESSAGECHECKSTATUS(
                    "MESSAGECHECKSTATUS","消息审核状态"),MESSAGESKIPTYPE("MESSAGESKIPTYPE","消息跳转类型");

            private final String value;
            private final String text;

            private DictType(String value, String text) {
                this.value = value;
                this.text = text;
            }

            public String getValue() {
                return value;
            }

            public String getText() {
                return text;
            }

            public static DictType getEnum(String value) {
                if (value != null) {
                    DictType[] values = DictType.values();
                    for (DictType val : values) {
                        if (val.getValue().equals(value)) {
                            return val;
                        }
                    }
                }
                return null;
            }
        }

        /**
         * 权限类型： PERMISSIONTYPE_MENU 菜单 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONTYPE的内容）
         */
        public static final String PERMISSIONTYPE_MENU = "PERMISSIONTYPE_MENU";
        /**
         * 权限类型：PERMISSIONTYPE_FUNC 功能 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONTYPE的内容）
         */
        public static final String PERMISSIONTYPE_FUNC = "PERMISSIONTYPE_FUNC";

        /**
         * 权限状态： PERMISSIONSTATUS_ON 有效 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONSTATUS的内容）
         */
        public static final String PERMISSIONSTATUS_ON = "PERMISSIONSTATUS_ON";
        /**
         * 权限状态：PERMISSIONSTATUS_OFF 无效 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONSTATUS的内容）
         */
        public static final String PERMISSIONSTATUS_OFF = "PERMISSIONSTATUS_OFF";

        /**
         * 权限级别： PERMISSIONLEVEL_FIRST_MENU 一级菜单 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONLEVEL的内容）
         */
        public static final String PERMISSIONLEVEL_FIRST_MENU = "PERMISSIONLEVEL_FIRST_MENU";
        /**
         * 权限级别：PERMISSIONLEVEL_SECOND_MENU 二级菜单 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONLEVEL的内容）
         */
        public static final String PERMISSIONLEVEL_SECOND_MENU = "PERMISSIONLEVEL_SECOND_MENU";
        /**
         * 权限级别：PERMISSIONLEVEL_FUNCTION 功能（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONLEVEL的内容）
         */
        public static final String PERMISSIONLEVEL_FUNCTION = "PERMISSIONLEVEL_FUNCTION";

        /**
         * 权限操作类型： PERMISSIONOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONOPERTYPE的内容）
         */
        public static final String PERMISSIONOPERTYPE_CREATE = "PERMISSIONOPERTYPE_CREATE";
        /**
         * 权限操作类型：PERMISSIONOPERTYPE_MODIFY 修改 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONOPERTYPE的内容）
         */
        public static final String PERMISSIONOPERTYPE_MODIFY = "PERMISSIONOPERTYPE_MODIFY";
        /**
         * 权限操作类型：PERMISSIONOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PERMISSIONOPERTYPE的内容）
         */
        public static final String PERMISSIONOPERTYPE_DELETE = "PERMISSIONOPERTYPE_DELETE";

        /**
         * 角色操作类型： ROLEOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ROLEOPERTYPE的内容）
         */
        public static final String ROLEOPERTYPE_CREATE = "ROLEOPERTYPE_CREATE";
        /**
         * 角色操作类型：ROLEOPERTYPE_MODIFY 修改 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ROLEOPERTYPE的内容）
         */
        public static final String ROLEOPERTYPE_MODIFY = "ROLEOPERTYPE_MODIFY";
        /**
         * 角色操作类型：ROLEOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ROLEOPERTYPE的内容）
         */
        public static final String ROLEOPERTYPE_DELETE = "ROLEOPERTYPE_DELETE";

        /**
         * 角色权限操作类型： ROLEPERMISSIONOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ROLEPERMISSIONOPERTYPE的内容）
         */
        public static final String ROLEPERMISSIONOPERTYPE_CREATE = "ROLEPERMISSIONOPERTYPE_CREATE";
        /**
         * 角色权限操作类型：ROLEPERMISSIONOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=ROLEPERMISSIONOPERTYPE的内容）
         */
        public static final String ROLEPERMISSIONOPERTYPE_DELETE = "ROLEPERMISSIONOPERTYPE_DELETE";

        /**
         * 用户角色操作类型： USERROLEOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERROLEOPERTYPE的内容）
         */
        public static final String USERROLEOPERTYPE_CREATE = "USERROLEOPERTYPE_CREATE";
        /**
         * 用户角色操作类型：USERROLEOPERTYPE_DELETE 删除（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERROLEOPERTYPE的内容）
         */
        public static final String USERROLEOPERTYPE_DELETE = "USERROLEOPERTYPE_DELETE";

        /**
         * 系统字典状态： SYSDICTSTATUS_ON 启用 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTSTATUS的内容）
         */
        public static final String SYSDICTSTATUS_ON = "SYSDICTSTATUS_ON";
        /**
         * 系统字典状态：SYSDICTSTATUS_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTSTATUS的内容）
         */
        public static final String SYSDICTSTATUS_OFF = "SYSDICTSTATUS_OFF";

        /**
         * 系统字典操作类型： SYSDICTOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTOPERTYPE的内容）
         */
        public static final String SYSDICTOPERTYPE_CREATE = "SYSDICTOPERTYPE_CREATE";
        /**
         * 系统字典操作类型：SYSDICTOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTOPERTYPE的内容）
         */
        public static final String SYSDICTOPERTYPE_MODIFY = "SYSDICTOPERTYPE_MODIFY";
        /**
         * 系统字典操作类型： SYSDICTOPERTYPE_ON 启用 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTOPERTYPE的内容）
         */
        public static final String SYSDICTOPERTYPE_ON = "SYSDICTOPERTYPE_ON";
        /**
         * 系统字典操作类型：SYSDICTOPERTYPE_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSDICTOPERTYPE的内容）
         */
        public static final String SYSDICTOPERTYPE_OFF = "SYSDICTOPERTYPE_OFF";

        /**
         * 系统参数状态： SYSPARAMSTATUS_ON 启用 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMSTATUS的内容）
         */
        public static final String SYSPARAMSTATUS_ON = "SYSPARAMSTATUS_ON";
        /**
         * 系统参数状态：SYSPARAMSTATUS_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMSTATUS的内容）
         */
        public static final String SYSPARAMSTATUS_OFF = "SYSPARAMSTATUS_OFF";

        /**
         * 系统参数操作类型： SYSPARAMOPERTYPE_CREATE 创建 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMOPERTYPE的内容）
         */
        public static final String SYSPARAMOPERTYPE_CREATE = "SYSPARAMOPERTYPE_CREATE";
        /**
         * 系统参数操作类型：SYSPARAMOPERTYPE_MODIFY 修改（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMOPERTYPE的内容）
         */
        public static final String SYSPARAMOPERTYPE_MODIFY = "SYSPARAMOPERTYPE_MODIFY";
        /**
         * 系统参数操作类型： SYSPARAMOPERTYPE_ON 启用 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMOPERTYPE的内容）
         */
        public static final String SYSPARAMOPERTYPE_ON = "SYSPARAMOPERTYPE_ON";
        /**
         * 系统参数操作类型：SYSPARAMOPERTYPE_OFF 禁用（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSPARAMOPERTYPE的内容）
         */
        public static final String SYSPARAMOPERTYPE_OFF = "SYSPARAMOPERTYPE_OFF";

        /**
         * 区域类别： AREATYPE_NATION 国家 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_NATION = "AREATYPE_NATION";
        /**
         * 区域类别：AREATYPE_REGION 区域（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_REGION = "AREATYPE_REGION";
        /**
         * 区域类别： AREATYPE_PROVINCE 省份 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_PROVINCE = "AREATYPE_PROVINCE";
        /**
         * 区域类别：AREATYPE_CITY 地市（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_CITY = "AREATYPE_CITY";
        /**
         * 区域类别： AREATYPE_COUNTY 县区 （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_COUNTY = "AREATYPE_COUNTY";
        /**
         * 区域类别：AREATYPE_TOWN 乡镇（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=AREATYPE的内容）
         */
        public static final String AREATYPE_TOWN = "AREATYPE_TOWN";

        /**
         * 通知消息类型： NOTIFYMSGTYPE_SMS 短信（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGTYPE的内容）
         */
        public static final String NOTIFYMSGTYPE_SMS = "NOTIFYMSGTYPE_SMS";
        /**
         * 通知消息类型： NOTIFYMSGTYPE_EMAIL 电子邮件（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGTYPE的内容）
         */
        public static final String NOTIFYMSGTYPE_EMAIL = "NOTIFYMSGTYPE_EMAIL";

        /**
         * 通知消息状态： NOTIFYMSGSTATUS_INIT 未发送（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGSTATUS的内容）
         */
        public static final String NOTIFYMSGSTATUS_INIT = "NOTIFYMSGSTATUS_INIT";
        /**
         * 通知消息状态： NOTIFYMSGSTATUS_SUCCEED 发送成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGSTATUS的内容）
         */
        public static final String NOTIFYMSGSTATUS_SUCCEED = "NOTIFYMSGSTATUS_SUCCEED";
        /**
         * 通知消息状态： NOTIFYMSGSTATUS_FAILED 发送失败（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGSTATUS的内容）
         */
        public static final String NOTIFYMSGSTATUS_FAILED = "NOTIFYMSGSTATUS_FAILED";

        /**
         * 通知消息报告状态： NOTIFYMSGREPORTSTATUS_NOTYET 未返回回执（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGREPORTSTATUS的内容）
         */
        public static final String NOTIFYMSGREPORTSTATUS_NOTYET = "NOTIFYMSGREPORTSTATUS_NOTYET";
        /**
         * 通知消息报告状态： NOTIFYMSGREPORTSTATUS_SUCCEED 发送成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGREPORTSTATUS的内容）
         */
        public static final String NOTIFYMSGREPORTSTATUS_SUCCEED = "NOTIFYMSGREPORTSTATUS_SUCCEED";
        /**
         * 通知消息报告状态： NOTIFYMSGREPORTSTATUS_FAILED 发送失败（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=NOTIFYMSGREPORTSTATUS的内容）
         */
        public static final String NOTIFYMSGREPORTSTATUS_FAILED = "NOTIFYMSGREPORTSTATUS_FAILED";

        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_REGIST 注册（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_REGIST = "SMSNOTIFYMSGTYPE_REGIST";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_LOGIN 登录（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_LOGIN = "SMSNOTIFYMSGTYPE_LOGIN";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_RESETPWD 重置密码（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_RESETPWD = "SMSNOTIFYMSGTYPE_RESETPWD";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_UPDATEPWD 修改密码（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_UPDATEPWD = "SMSNOTIFYMSGTYPE_UPDATEPWD";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERCREATE 订单创建（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERCREATE = "SMSNOTIFYMSGTYPE_ORDERCREATE";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERPAID 订单付款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERPAID = "SMSNOTIFYMSGTYPE_ORDERPAID";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERACCEPT 订单接单（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERACCEPT = "SMSNOTIFYMSGTYPE_ORDERACCEPT";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERSEND 订单发货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERSEND = "SMSNOTIFYMSGTYPE_ORDERSEND";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERPREPARED 订单备货（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERPREPARED = "SMSNOTIFYMSGTYPE_ORDERPREPARED";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERREMINDERPAY 订单催付款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERREMINDERPAY = "SMSNOTIFYMSGTYPE_ORDERREMINDERPAY";

        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERREFUND 订单退款（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERREFUND = "SMSNOTIFYMSGTYPE_ORDERREFUND";
        /**
         * 短信消息类型： SMSNOTIFYMSGTYPE_ORDERPAYSUCCESS 订单付款成功（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYMSGTYPE的内容）
         */
        public static final String SMSNOTIFYMSGTYPE_ORDERPAYSUCCESS = "SMSNOTIFYMSGTYPE_ORDERPAYSUCCESS";

        /**
         * 短信消息提供方类型： SMSNOTIFYPROVIDETYPE_HUAXIN 创世华信（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SMSNOTIFYPROVIDETYPE的内容）
         */
        public static final String SMSNOTIFYPROVIDETYPE_HUAXIN = "SMSNOTIFYPROVIDETYPE_HUAXIN";

        /**
         * 推送消息类型： PUSHNOTIFYMSGTYPE_ORDERACCEPT 订单接单（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PUSHNOTIFYMSGTYPE的内容）
         */
        public static final String PUSHNOTIFYMSGTYPE_ORDERACCEPT = "PUSHNOTIFYMSGTYPE_ORDERACCEPT";
        
        /**
         * 推送消息类型： PUSHNOTIFYMSGTYPE_SYSTEMMESSAGE 订单接单（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PUSHNOTIFYMSGTYPE的内容）
         */
        public static final String PUSHNOTIFYMSGTYPE_SYSTEMMESSAGE = "PUSHNOTIFYMSGTYPE_SYSTEMMESSAGE";

        /**
         * 推送消息提供方类型： PUSHNOTIFYPROVIDETYPE_GETUI 个推（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=PUSHNOTIFYPROVIDETYPE的内容）
         */
        public static final String PUSHNOTIFYPROVIDETYPE_GETUI = "PUSHNOTIFYPROVIDETYPE_GETUI";

        /**
         * 消息发送方式： MESSAGESENDTYPE_AUTOMATIC 自动触发（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESENDTYPE的内容）
         */
        public static final String MESSAGESENDTYPE_AUTOMATIC = "MESSAGESENDTYPE_AUTOMATIC";

        /**
         * 消息发送方式： MESSAGESENDTYPE_MANUAL 人工触发（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESENDTYPE的内容）
         */
        public static final String MESSAGESENDTYPE_MANUAL = "MESSAGESENDTYPE_MANUAL";

        /**
         * 异常消息来源： EXCEPTIONMESSAGESOURCE_PRODUCER 消息生产者（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=EXCEPTIONMESSAGESOURCE的内容）
         */
        public static final String EXCEPTIONMESSAGESOURCE_PRODUCER = "EXCEPTIONMESSAGESOURCE_PRODUCER";

        /**
         * 异常消息来源： EXCEPTIONMESSAGESOURCE_CONSUMER 消息消费者（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=EXCEPTIONMESSAGESOURCE的内容）
         */
        public static final String EXCEPTIONMESSAGESOURCE_CONSUMER = "EXCEPTIONMESSAGESOURCE_CONSUMER";
        
        /**
         * 消息类型组： MESSAGETYPEGROUP_SYSTEMGROUP 系统组（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGETYPEGROUP的内容）
         */
        public static final String MESSAGETYPEGROUP_SYSTEMGROUP = "MESSAGETYPEGROUP_SYSTEMGROUP";
        /**
         * 消息类型组： MESSAGETYPEGROUP_USERGROUP 用户组（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGETYPEGROUP的内容）
         */
        public static final String MESSAGETYPEGROUP_USERGROUP = "MESSAGETYPEGROUP_USERGROUP";
        
        /**
         * 系统消息类型：SYSTEMMESSAGETYPE_ACTIVE_MESSAGE 系统活动消息（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=SYSTEMMESSAGETYPE的内容）
         */
        public static final String SYSTEMMESSAGETYPE_ACTIVE_MESSAGE = "SYSTEMMESSAGETYPE_ACTIVE_MESSAGE";
        
        /**
         * 用户消息类型：USERMESSAGETYPE_PREFERENCE_MESSAGE 用户优惠消息（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERMESSAGETYPE的内容）
         */
        public static final String USERMESSAGETYPE_PREFERENCE_MESSAGE = "USERMESSAGETYPE_PREFERENCE_MESSAGE";
        
        /**
         * 用户消息类型：USERMESSAGETYPE_REFUND_MESSAGE 用户退款消息（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=USERMESSAGETYPE的内容）
         */
        public static final String USERMESSAGETYPE_REFUND_MESSAGE = "USERMESSAGETYPE_REFUND_MESSAGE";
        
        /**
         * 消息发布对象：MESSAGEPUBLISHOBJECT_ALL 全部（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容）
         */
        public static final String MESSAGEPUBLISHOBJECT_ALL = "MESSAGEPUBLISHOBJECT_ALL";
        
        /**
         * 消息发布对象：MESSAGEPUBLISHOBJECT_BUYER_ALL 全部买家用户（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容）
         */
        public static final String MESSAGEPUBLISHOBJECT_BUYER_ALL = "MESSAGEPUBLISHOBJECT_BUYER_ALL";
       
        /**
         * 消息发布对象：MESSAGEPUBLISHOBJECT_BUYER_SPECIAL 特殊买家用户（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容）
         */
        public static final String MESSAGEPUBLISHOBJECT_BUYER_SPECIAL = "MESSAGEPUBLISHOBJECT_BUYER_SPECIAL";
        
        /**
         * 消息发布对象：MESSAGEPUBLISHOBJECT_SELLER_ALL 全部卖家用户（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容）
         */
        public static final String MESSAGEPUBLISHOBJECT_SELLER_ALL = "MESSAGEPUBLISHOBJECT_SELLER_ALL";
        
        /**
         * 消息发布对象：MESSAGEPUBLISHOBJECT_SELLER_SPECIAL 特殊卖家用户（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容）
         */
        public static final String MESSAGEPUBLISHOBJECT_SELLER_SPECIAL = "MESSAGEPUBLISHOBJECT_SELLER_SPECIAL";
        
        /**
         * 消息审核状态：MESSAGECHECKSTATUS_AWAIT 等待审核（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGECHECKSTATUS的内容）
         */
        public static final String MESSAGECHECKSTATUS_AWAIT = "MESSAGECHECKSTATUS_AWAIT";
        /**
         * 消息审核状态：MESSAGECHECKSTATUS_OK 审核通过（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGECHECKSTATUS的内容）
         */
        public static final String MESSAGECHECKSTATUS_OK = "MESSAGECHECKSTATUS_OK";
        
        /**
         * 消息审核状态：MESSAGECHECKSTATUS_NO 审核不通过（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGECHECKSTATUS的内容）
         */
        public static final String MESSAGECHECKSTATUS_NO = "MESSAGECHECKSTATUS_NO";
        
        /**
         * 消息跳转类型：MESSAGESKIPTYPE_COUPON 优惠券类型（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESKIPTYPE的内容）
         */
        public static final String MESSAGESKIPTYPE_COUPON = "MESSAGESKIPTYPE_COUPON";
        
        /**
         * 消息跳转类型：MESSAGESKIPTYPE_REFUND 退款类型（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESKIPTYPE的内容）
         */
        public static final String MESSAGESKIPTYPE_REFUND = "MESSAGESKIPTYPE_REFUND";
        
        /**
         * 消息跳转类型：MESSAGESKIPTYPE_THEME 专题类型（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESKIPTYPE的内容）
         */
        public static final String MESSAGESKIPTYPE_THEME = "MESSAGESKIPTYPE_THEME";
    }

    public static final class SystemParams {

        /**
         * 系统参数编码：Session最大不活跃时间间隔，单位：分钟 SESSION_MAX_INACTIVE_INTERVAL
         */
        public static final String SESSION_MAX_INACTIVE_INTERVAL = "SESSION_MAX_INACTIVE_INTERVAL";

        /**
         * 系统参数编码：缺省的消息最大的重试阈值 MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT
         */
        public static final String MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT = "MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT";

        /**
         * 系统参数编码：缺省的消息重发时间间隔，单位：秒 MESSAGE_INTERVAL_TIME_DEFAULT
         */
        public static final String MESSAGE_INTERVAL_TIME_DEFAULT = "MESSAGE_INTERVAL_TIME_DEFAULT";

        /**
         * 系统参数编码：运营系统域名 OPERATION_SYSTEM_DOMAIN
         */
        public static final String OPERATION_SYSTEM_DOMAIN = "OPERATION_SYSTEM_DOMAIN";

        /**
         * 系统参数编码：上传文件正式基础URL UPLOAD_FILE_URL
         */
        public static final String UPLOAD_FILE_URL = "UPLOAD_FILE_URL";

        /**
         * 系统参数编码：上传文件临时基础URL UPLOAD_FILE_TEMP_URL
         */
        public static final String UPLOAD_FILE_TEMP_URL = "UPLOAD_FILE_TEMP_URL";

        /**
         * 系统参数编码：下载文件正式基础URL DOWNLOAD_FILE_URL
         */
        public static final String DOWNLOAD_FILE_URL = "DOWNLOAD_FILE_URL";

        /**
         * 系统参数编码：下载文件临时基础URL DOWNLOAD_FILE_TEMP_URL
         */
        public static final String DOWNLOAD_FILE_TEMP_URL = "DOWNLOAD_FILE_TEMP_URL";

        /**
         * 系统参数编码：模板Template的HTML文件根目录 TEMPLATE_HTML_BASE_PATH
         */
        public static final String TEMPLATE_HTML_BASE_PATH = "TEMPLATE_HTML_BASE_PATH";

        /**
         * 系统参数编码：本地静态HTML文件根目录 LOCAL_STATIC_HTML_BASE_PATH
         */
        public static final String LOCAL_STATIC_HTML_BASE_PATH = "LOCAL_STATIC_HTML_BASE_PATH";

        /**
         * 系统参数编码：远程Web服务器Nginx存放静态HTML文件目录 REMOTE_WEB_SERVER_STATIC_HTML_PATH
         */
        public static final String REMOTE_WEB_SERVER_STATIC_HTML_PATH = "REMOTE_WEB_SERVER_STATIC_HTML_PATH";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点1的IP地址 REMOTE_WEB_SERVER_ONE_IP
         */
        public static final String REMOTE_WEB_SERVER_ONE_IP = "REMOTE_WEB_SERVER_ONE_IP";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点1的文件复制监听端口 REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT
         */
        public static final String REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT = "REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点1的文件删除监听端口 REMOTE_WEB_SERVER_ONE_DELETE_PORT
         */
        public static final String REMOTE_WEB_SERVER_ONE_DELETE_PORT = "REMOTE_WEB_SERVER_ONE_DELETE_PORT";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点2的IP地址 REMOTE_WEB_SERVER_TWO_IP
         */
        public static final String REMOTE_WEB_SERVER_TWO_IP = "REMOTE_WEB_SERVER_TWO_IP";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点2的文件复制监听端口 REMOTE_WEB_SERVER_TWO_DUPLICATE_PORT
         */
        public static final String REMOTE_WEB_SERVER_TWO_DUPLICATE_PORT = "REMOTE_WEB_SERVER_TWO_DUPLICATE_PORT";

        /**
         * 系统参数编码：远程Web服务器Nginx所在节点2的文件删除监听端口 REMOTE_WEB_SERVER_TWO_DELETE_PORT
         */
        public static final String REMOTE_WEB_SERVER_TWO_DELETE_PORT = "REMOTE_WEB_SERVER_TWO_DELETE_PORT";

        /**
         * 系统参数编码：上传文件（图片）后缀格式，用|号分割
         */
        public static final String UPLOAD_FILE_IMAGE_POSTFIX_FORMAT = "UPLOAD_FILE_IMAGE_POSTFIX_FORMAT";

        /**
         * 系统参数编码：上传文件（图片）大小的最大值，单位：字节
         */
        public static final String UPLOAD_FILE_IMAGE_MAX_SIZE = "UPLOAD_FILE_IMAGE_MAX_SIZE";

        /**
         * 系统参数编码：上传文件（Excel）后缀格式，用|号分割
         */
        public static final String UPLOAD_FILE_EXCEL_POSTFIX_FORMAT = "UPLOAD_FILE_EXCEL_POSTFIX_FORMAT";

        /**
         * 系统参数编码：上传文件（Excel）大小的最大值，单位：字节
         */
        public static final String UPLOAD_FILE_EXCEL_MAX_SIZE = "UPLOAD_FILE_EXCEL_MAX_SIZE";

        /**
         * 系统参数编码：上传文件（压缩数据包）后缀格式，用|号分割
         */
        public static final String UPLOAD_FILE_COMPRESSEDDATAPACKET_POSTFIX_FORMAT = "UPLOAD_FILE_COMPRESSEDDATAPACKET_POSTFIX_FORMAT";

        /**
         * 系统参数编码：上传文件（压缩数据包）大小的最大值，单位：字节
         */
        public static final String UPLOAD_FILE_COMPRESSEDDATAPACKET_MAX_SIZE = "UPLOAD_FILE_COMPRESSEDDATAPACKET_MAX_SIZE";

        /**
         * 系统参数编码：本地服务器存放上传文件的基础路径
         */
        public static final String LOCAL_UPLOAD_FILE_BASE_PATH = "LOCAL_UPLOAD_FILE_BASE_PATH";

        /**
         * 系统参数编码：远程Web服务器Nginx存放上传文件的正式基础路径
         */
        public static final String REMOTE_UPLOAD_FILE_PUBLISH_BASE_PATH = "REMOTE_UPLOAD_FILE_PUBLISH_BASE_PATH";

        /**
         * 系统参数编码：产品图片相对路径
         */
        public static final String PRODUCT_PIC_RELATIVE_PATH = "PRODUCT_PIC_RELATIVE_PATH";
        /**
         * 系统参数编码：产品图片相对路径
         */
        public static final String SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH = "SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH";
        /**
         * 系统参数编码：本地服务器存放下载文件的基础路径
         */
        public static final String LOCAL_DOWNLOAD_FILE_BASE_PATH = "LOCAL_DOWNLOAD_FILE_BASE_PATH";

        /**
         * 系统参数编码：远程Web服务器Nginx存放下载文件的正式基础路径
         */
        public static final String REMOTE_DOWNLOAD_FILE_PUBLISH_BASE_PATH = "REMOTE_DOWNLOAD_FILE_PUBLISH_BASE_PATH";

        /**
         * 系统参数编码：用户报表导入相对路径
         */
        public static final String USER_REPORT_IMPORT_RELATIVE_PATH = "USER_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 系统参数编码：从标准库导入店铺商品的商品报表导入相对路径
         */
        public static final String SALEPRODUCT_FROM_STANDARD_REPORT_IMPORT_RELATIVE_PATH = "SALEPRODUCT_FROM_STANDARD_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 系统参数编码：店铺导入其他商品的商品报表导入相对路径
         */
        public static final String SALEPRODUCT_FROM_OTHER_REPORT_IMPORT_RELATIVE_PATH = "SALEPRODUCT_FROM_OTHER_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 系统参数编码：店铺导入其他商品顺序报表导入相对路径
         */
        public static final String SALEPRODUCT_SORT_REPORT_IMPORT_RELATIVE_PATH = "SALEPRODUCT_SORT_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 系统参数编码：标准库批量导入产品报表导入相对路径
         */
        public static final String PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH = "PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 系统参数编码：商品搜索热词
         */
        public static final String P_HOT_SEARCH_KEYS = "P_HOT_SEARCH_KEYS";
        /**
         * 系统参数编码:销售专区
         */
        public static final String P_SALE_ZONE_TYPE_HOME = "P_SALE_ZONE_TYPE_HOME";
        /**
         * 系统参数编码:调用短信接口标识，用于配置系统是否调用第三方短信接口进行实际发送短信的标识。0：不调用；1：调用
         */
        public static final String S_CALL_SMS_INTERFACE_FLAG = "S_CALL_SMS_INTERFACE_FLAG";
        /**
         * 系统参数编码:每日每个用户发送非失败短信次数
         */
        public static final String S_DAILY_SEND_SMS_COUNT = "S_DAILY_SEND_SMS_COUNT";
        /**
         * 系统参数编码:发送短信验证码超时时间，单位“秒”，默认120秒
         */
        public static final String SEND_SMS_CAPTCHA_TIME_OUT = "SEND_SMS_CAPTCHA_TIME_OUT";
        /**
         * 系统参数编码:短信验证码超时时间，单位“秒”，默认300秒
         */
        public static final String SMS_CAPTCHA_TIME_OUT = "SMS_CAPTCHA_TIME_OUT";
        /**
         * 系统参数编码:同一IP或同一设备每日发送短信次数，默认20次
         */
        public static final String IP_OR_DEVICE_DAILY_SEND_SMS_COUNT = "IP_OR_DEVICE_DAILY_SEND_SMS_COUNT";
        /**
         * 买家系统域名
         */
        public static final String BUYER_SYSTEM_DOMAIN = "BUYER_SYSTEM_DOMAIN";
        /**
         * 卖家系统域名
         */
        public static final String SELLER_SYSTEM_DOMAIN = "SELLER_SYSTEM_DOMAIN";
        /**
         * 移动端系统域名
         */
        public static final String MOBILE_SYSTEM_DOMAIN = "MOBILE_SYSTEM_DOMAIN";
        /**
         * 系统参数编码:调货单生成的最小商品金额，单位为厘
         */
        public static final String T_FLITTING_ORDER_CREATE_MIN_AMOUNT = "T_FLITTING_ORDER_CREATE_MIN_AMOUNT";
        /**
         * 系统参数编码:调货单门店支持最大拥有商品金额，单位为厘
         */
        public static final String T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT = "T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT";
        /**
         * 系统参数编码:系统注册默认创建用户ID
         */
        public static final String U_REGIST_DEFAULT_CREATE_USER_ID = "U_REGIST_DEFAULT_CREATE_USER_ID";
        /**
         * 系统参数编码:登陆验证码有效时间，单位“分钟”，默认5分钟
         */
        public static final String LOGIN_CAPTCHA_VALID_TIME = "LOGIN_CAPTCHA_VALID_TIME";
        /**
         * 系统参数编码:注册验证码有效时间，单位“分钟”，默认5分钟
         */
        public static final String REGISTER_CAPTCHA_VALID_TIME = "REGISTER_CAPTCHA_VALID_TIME";
        /**
         * 系统参数编码:退款间隔工作日，单位“天”，默认3-5天
         */
        public static final String REFUND_INTERVAL_DAYS = "REFUND_INTERVAL_DAYS";
        /**
         * 系统参数编码:客服热线，默认4001-333-866
         */
        public static final String CUSTOMER_HOTLINE = "CUSTOMER_HOTLINE";
        /**
         * 系统参数编码:首页销售专区链接信息
         */
        public static final String P_SALE_ZONE_TYPE_HOME_LINKINFO = "P_SALE_ZONE_TYPE_HOME_LINKINFO";
        /**
         * 系统参数编码:注册自动升级会员有效时间(单位“月”，默认一个月)
         */
        public static final String U_REGISTERTO_VIP_EXPIRE_MONTH = "U_REGISTERTO_VIP_EXPIRE_MONTH";
        /**
         * 系统参数编码:购买VIP商品升级会员有效时间(单位“月”，默认12个月)
         */
        public static final String U_BUYERPRODUCTTO_VIP_EXPIRE_MONTH = "U_BUYERPRODUCTTO_VIP_EXPIRE_MONTH";
        /**
         * 系统参数编码:VIP产品ID配置
         */
        public static final String P_VIP_PRODUCT_ID = "P_VIP_PRODUCT_ID";
        /**
         * 一分钱活动商品
         */
        public static final String P_PENNY_PRODUCT_ID = "P_PENNY_PRODUCT_ID";
        /**
         * 每周推荐商品
         */
        public static final String P_WEEKRECOMMEND_PRODUCT_ID = "P_WEEKRECOMMEND_PRODUCT_ID";
        /**
         * 用户小区定位查找范围
         */
        public static final String U_COMMUNITY_LOCATION_DISTANCE_RANGE = "U_COMMUNITY_LOCATION_DISTANCE_RANGE";
        /**
         * 首页销售专区图片地址
         */
        public static final String P_SALE_ZONE_TYPE_IMGURL = "P_SALE_ZONE_TYPE_IMGURL";
        /**
         * 需要自动收货时间间隔，单位：“天”，默认3天
         */
        public static final String NEED_AUTO_RECEIVE_INTERVAL_TIME = "NEED_AUTO_RECEIVE_INTERVAL_TIME";
        /** VIP商品佣金计算基数,单位:厘 **/
        public static final String T_VIP_COMMISSION_BASE = "T_VIP_COMMISSION_BASE";
        /**
         * 店铺定位查找范围
         */
        public static final String U_STORE_LOCATION_DISTANCE_RANGE = "U_STORE_LOCATION_DISTANCE_RANGE";
        /**
         * 小区与门店之间距离范围
         */
        public static final String COMMUNITY_STORE_DISTANCE = "COMMUNITY_STORE_DISTANCE";
        /**
         * 门店与微仓之间距离范围
         */
        public static final String STORE_WAREHOUSE_DISTANCE = "STORE_WAREHOUSE_DISTANCE";
        /**
         * 秒杀场次活动间隔时间：单位:分钟,默认:30分钟
         */
        public static final String P_SECKILLSCENE_INTERVAL_TIME = "P_SECKILLSCENE_INTERVAL_TIME";
        /**
         * 专题图片相对路径
         */
        public static final String THEME_PIC_RELATIVE_PATH = "THEME_PIC_RELATIVE_PATH";
        /**
         * 专题slogan图片相对路径
         */
        public static final String THEME_SLOGAN_PIC_RELATIVE_PATH = "THEME_SLOGAN_PIC_RELATIVE_PATH";
        /**
         * 广告图片相对路径
         */
        public static final String ADVERTISEMENT_PIC_RELATIVE_PATH = "ADVERTISEMENT_PIC_RELATIVE_PATH";
        /**
         * 品牌logo图片相对路径
         */
        public static final String BRAND_PIC_RELATIVE_PATH = "BRAND_PIC_RELATIVE_PATH";
        /**
         * 楼层icon图片相对路径
         */
        public static final String FLOOR_PIC_RELATIVE_PATH = "FLOOR_PIC_RELATIVE_PATH";
        /**
         * 秒杀场次结束时间,单位:小时
         */
        public static final String SECKILLSCENE_ENDTIME = "SECKILLSCENE_ENDTIME";
        /**
         * 用户图片相对路径
         */
        public static final String USER_PIC_RELATIVE_PATH = "USER_PIC_RELATIVE_PATH";
        /**
         * 每日参与抢红包次数
         */
        public static final String GRAB_REDENVELOPE_TIMES_DAILY = "GRAB_REDENVELOPE_TIMES_DAILY";
        /**
         * 每场抢红包活动持续时间，单位：秒，默认20秒
         */
        public static final String GRAB_REDENVELOPE_DURATION_PER_GAME = "GRAB_REDENVELOPE_DURATION_PER_GAME";
        /**
         * 每场抢红包活动所允许抢到的最大红包数量
         */
        public static final String GRAB_REDENVELOPE_MAX_COUNT_PER_GAME = "GRAB_REDENVELOPE_MAX_COUNT_PER_GAME";
        /**
         * 奖券选择配置,0-多选,1-单选
         */
        public static final String P_TICKET_SELECT_CONFIG = "P_TICKET_SELECT_CONFIG";
        /**
         * 分享背景图片相对路径
         */
        public static final String P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH = "P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH";
        /**
         * 系统参数编码：数据包产品报表导入相对路径
         */
        public static final String PACKET_PRODUCT_REPORT_IMPORT_RELATIVE_PATH = "PACKET_PRODUCT_REPORT_IMPORT_RELATIVE_PATH";
        /**
         * 分享活动冠军奖励
         */
        public static final String USERSHARE_CHAMPION_AWARD = "USERSHARE_CHAMPION_AWARD";

        /**
         * 产品顶级分类Code
         */
        public static final String TOP_LEVEL_CLASS = "TOP_LEVEL_CLASS";
        /**
         * 应用首页图标地址
         */
        public static final String P_APP_HOMEICONS = "P_APP_HOMEICONS";
        /**
         * 优惠券获取消息设置(COUPON_GET_MESSAGE_SET_ON:有效;COUPON_GET_MESSAGE_SET_OFF：无效)
         */
        public static final String COUPON_GET_MESSAGE_SET = "COUPON_GET_MESSAGE_SET";
        /**
         * 优惠券过期消息设置(COUPON_EXPIRE_MESSAGE_SET_ON:有效;COUPON_EXPIRE_MESSAGE_SET_OFF：无效)
         */
        public static final String COUPON_EXPIRE_MESSAGE_SET = "COUPON_EXPIRE_MESSAGE_SET";
        /**
         * 用户退款消息设置(USER_REFUND_MESSAGE_SET_ON:有效;USER_REFUND_MESSAGE_SET_OFF：无效)
         */
        public static final String USER_REFUND_MESSAGE_SET = "USER_REFUND_MESSAGE_SET";
        /**
         * 消息图片相对路径
         */
        public static final String MESSAGE_PIC_RELATIVE_PATH = "MESSAGE_PIC_RELATIVE_PATH";
    }
}
