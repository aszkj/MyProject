package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.ILoginLogProxyService;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.dto.LoginLogDto;

/**
 * 功能描述：登录地址Service服务实现类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("loginLogProxyService")
public class LoginLogProxyServiceImpl extends BasicDataService implements ILoginLogProxyService {

    @Autowired
    private ILoginLogService loginLogService;

    @Override
    public void save(LoginLogProxyDto loginLogProxyDto) throws UserServiceException {
        try {
            logger.info("loginLogProxyDto:[" + loginLogProxyDto.toString() + "]");
            LoginLogDto loginLogDto = new LoginLogDto();
            ObjectUtils.fastCopy(loginLogProxyDto, loginLogDto);
            loginLogService.saveLoginLog(loginLogDto);
            logger.info("登录日志保存成功");
        } catch (Exception e) {
            logger.error("登录日志保存失败", e);
            throw new UserServiceException("登录日志保存异常");
        }
    }

    @Override
    public void updateLogoutTimeBySessionId(String sessionId) throws UserServiceException {
        try {
            logger.info("sessionId:[" + sessionId + "]");
            loginLogService.updateLogoutTimeBySessionId(sessionId);
            logger.info("退出登录更新日志成功");
        } catch (Exception e) {
            logger.error("退出登录更新日志失败", e);
            throw new UserServiceException("退出登录更新日志异常");
        }
    }

}
