/**
 * 文件名称：UserProxyService.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.user.proxy;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;

/**
 * 功能描述：登录日志代理服务接口定义 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ILoginLogProxyService {

    /**
     * 保存登录日志信息
     * 
     * @param loginLogProxyDto
     * @throws UserServiceException
     */
    public void save(LoginLogProxyDto loginLogProxyDto) throws UserServiceException;

    /**
     * 根据SessionId更新登出时间
     * 
     * @param sessionId
     * @throws UserServiceException
     */
    public void updateLogoutTimeBySessionId(String sessionId) throws UserServiceException;
}
