package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.query.LoginLogQuery;

/**
 * 功能描述：Login服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ILoginLogService {

    /**
     * 添加登陆日志信息
     * 
     * @param loginLogDto
     * @throws UserServiceException
     */
    public void saveLoginLog(LoginLogDto loginLogDto) throws UserServiceException;

    /**
     * 根据SessionId更新登出时间
     * 
     * @param sessionId
     * @throws UserServiceException
     */
    public void updateLogoutTimeBySessionId(String sessionId) throws UserServiceException;

    /**
     * 
     * @Description TODO(根据SessionID获取登录日志)
     * @param sessionId
     * @return LoginLogDto
     * @throws UserServiceException
     */
    public LoginLogDto getLoginLogBySessionId(String sessionId) throws UserServiceException;

    /**
     * 根据查询条件分页查询用户登录日志信息
     * 
     * @param loginLogQuery
     *            查询条件
     * @return YiLiDiPage
     * @throws UserServiceException
     *             用户域异常
     */
    public YiLiDiPage<LoginLogDto> findLoginLogs(LoginLogQuery loginLogQuery) throws UserServiceException;

    /**
     * 登录日志消息
     * 
     * @param loginLogDto
     *            登录日志代理对象
     * @throws UserServiceException
     *             系统域服务异常
     */
    public void sendLoginLogMessage(LoginLogDto loginLogDto) throws UserServiceException;

}
