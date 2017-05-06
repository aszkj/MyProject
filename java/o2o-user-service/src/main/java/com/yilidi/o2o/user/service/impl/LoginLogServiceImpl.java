package com.yilidi.o2o.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.user.dao.LoginLogMapper;
import com.yilidi.o2o.user.model.LoginLog;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.LoginLogQuery;

/**
 * 功能描述：登录Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("loginLogService")
public class LoginLogServiceImpl extends BasicDataService implements ILoginLogService {

    @Autowired
    private LoginLogMapper loginLogMapper;
    @Autowired
    private IMessageProxyService messageProxyService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IStoreProfileService storeProfileService;

    @Override
    public void saveLoginLog(LoginLogDto loginLogDto) throws UserServiceException {
        try {
            LoginLog loginLog = new LoginLog();
            ObjectUtils.fastCopy(loginLogDto, loginLog);
            loginLogMapper.save(loginLog);
        } catch (Exception e) {
            logger.error("saveLoginLog异常", e);
            throw new UserServiceException("保存系统登录日志出现异常", e);
        }
    }

    @Override
    public LoginLogDto getLoginLogBySessionId(String sessionId) throws UserServiceException {
        try {
            LoginLogDto loginLogDto = null;
            LoginLog loginLog = loginLogMapper.getLoginLogBySessionId(sessionId);
            if (null != loginLog) {
                loginLogDto = new LoginLogDto();
                ObjectUtils.fastCopy(loginLog, loginLogDto);
            }
            return loginLogDto;
        } catch (Exception e) {
            logger.error("getLoginLogBySessionId异常", e);
            throw new UserServiceException("根据SessionID查找登录日志出现异常", e);
        }
    }

    @Override
    public void updateLogoutTimeBySessionId(String sessionId) throws UserServiceException {
        try {
            loginLogMapper.updateLogoutTimeBySessionId(sessionId);
        } catch (Exception e) {
            logger.error("updateLogoutTimeBySessionId异常", e);
            throw new UserServiceException("根据SessionID更新登出时间出现异常", e);
        }
    }

    @Override
    public YiLiDiPage<LoginLogDto> findLoginLogs(LoginLogQuery loginLogQuery) throws UserServiceException {
        try {
            if (null == loginLogQuery.getStart() || loginLogQuery.getStart() <= 0) {
                loginLogQuery.setStart(1);
            }
            if (null == loginLogQuery.getPageSize() || loginLogQuery.getPageSize() <= 0) {
                loginLogQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            String strStartTime = loginLogQuery.getStartLoginTime();
            String strEndTime = loginLogQuery.getEndLoginTime();
            if (!ObjectUtils.isNullOrEmpty(strStartTime)) {
                loginLogQuery.setStartLoginTime(strStartTime + StringUtils.STARTTIMESTRING);
            }
            if (!ObjectUtils.isNullOrEmpty(strEndTime)) {
                loginLogQuery.setEndLoginTime(strEndTime + StringUtils.ENDTIMESTRING);
            }
            PageHelper.startPage(loginLogQuery.getStart(), loginLogQuery.getPageSize());
            Page<LoginLog> page = loginLogMapper.findLoginLogs(loginLogQuery);
            Page<LoginLogDto> pageDto = new Page<LoginLogDto>(loginLogQuery.getStart(), loginLogQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<LoginLog> loginLogs = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(loginLogs)) {
                for (LoginLog loginLog : loginLogs) {
                    LoginLogDto loginLogDto = new LoginLogDto();
                    ObjectUtils.fastCopy(loginLog, loginLogDto);
                    if (SystemContext.UserDomain.CUSTOMERTYPE_SELLER.equals(loginLogDto.getCustomerType())) {
                        UserDto userDto = userService.loadUserById(loginLogDto.getUserId());
                        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(userDto.getCustomerId(),
                                null);
                        loginLogDto.setStoreType(storeProfileDto.getStoreType());
                    }
                    pageDto.add(loginLogDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findLoginLogs异常", e);
            throw new UserServiceException("查询系统登录日志信息出现异常", e);
        }
    }

    @Override
    public void sendLoginLogMessage(LoginLogDto loginLogDto) throws UserServiceException {
        try {
            LoginLogProxyDto loginLogProxyDto = new LoginLogProxyDto();
            ObjectUtils.fastCopy(loginLogDto, loginLogProxyDto);
            messageProxyService.sendLoginLogMessage(loginLogProxyDto);
        } catch (Exception e) {
            logger.error("发送登录日志消息错误", e);
            throw new UserServiceException(e);
        }
    }

}
