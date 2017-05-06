package com.yilidi.o2o.controller.operation.user;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.query.LoginLogQuery;

/**
 * 
 * 用户登录日志
 * 
 * @author: heyong
 * @date: 2015年12月1日 上午10:50:14
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class LoginLogController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ILoginLogService loginLogService;

    /**
     * 
     * 用户登录日志
     * 
     * @param loginLogQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listLoginLog")
    @ResponseBody
    public MsgBean listLoginLog(@RequestBody LoginLogQuery loginLogQuery) {
        try {
            loginLogQuery.setOrder(DBTablesColumnsName.LoginLog.LOGINTIME);
            loginLogQuery.setSort(CommonConstants.SORT_ORDER_DESC);
            YiLiDiPage<LoginLogDto> yiLiDiPage = loginLogService.findLoginLogs(loginLogQuery);
            logger.info("listLoginLog->yiLiDiPage:" + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询用户登录日志列表成功");
        } catch (Exception e) {
            logger.error("查询用户登录日志列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
