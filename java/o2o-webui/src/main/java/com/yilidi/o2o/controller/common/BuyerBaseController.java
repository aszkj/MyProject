package com.yilidi.o2o.controller.common;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.dto.CustomerDto;

/**
 * 
 * 买家（终端用户）的Controller基类
 * 
 * @author: chenlian
 * @date: 2015年11月7日 上午9:35:06
 * 
 */
public class BuyerBaseController extends AppBaseController {
    @Autowired
    private ICustomerService customerService;

    /**
     * 获取用户是否是会员
     */
    protected boolean isVip() {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        if (null != userSessionModel) {
            CustomerDto customerDto = customerService.loadCustomerById(userSessionModel.getCustomerId());
            if (null != customerDto && SystemContext.UserDomain.BUYERLEVEL_B.equals(customerDto.getBuyerLevelCode())) {
                return true;
            }
        }
        return false;
    }

    protected String getBuyerSystemDomain() {
        String result = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.BUYER_SYSTEM_DOMAIN);
        if (null == result) {
            result = "";
        }
        return result;
    }
}
