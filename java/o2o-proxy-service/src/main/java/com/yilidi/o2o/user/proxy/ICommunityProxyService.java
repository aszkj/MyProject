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
import com.yilidi.o2o.system.proxy.dto.CommunityProxyDto;

/**
 * 功能描述：小区代理服务接口定义 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICommunityProxyService {

    /**
     * 根据小区ID查找小区信息
     * 
     * @param id
     *            小区ID
     * @return CommunityProxyDto
     * @throws UserServiceException
     *             用户服务域异常
     */
    public CommunityProxyDto loadById(Integer id) throws UserServiceException;
}
