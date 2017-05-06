/**
 * 文件名称：IUserProxyServcieDemo.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.proxy;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.proxy.dto.CustomerProxyDto;
import com.yilidi.o2o.user.proxy.dto.StoreProxyDto;

/**
 * 功能描述：客户服务代理接口类定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICustomerProxyService {

    /**
     * 根据客户id获取客户信息
     * 
     * @param customerId
     *            客户id
     * @return 客户dto代理对象
     * @throws UserServiceException
     *             用户层服务异常
     */
    public CustomerProxyDto loadCustomerInfoById(Integer customerId) throws UserServiceException;

    /**
     * 根据用户userId获取客户信息
     * 
     * @param userId
     *            用户id
     * @return 客户dto代理对象
     * @throws UserServiceException
     *             用户层服务异常
     */
    public CustomerProxyDto loadCustomerInfoByUserId(Integer userId) throws UserServiceException;

    /**
     * @Description TODO(根据店铺ID,店铺编码，店铺名称，获得店铺信息)
     * @param storeProxyDto
     * @return
     * @throws UserServiceException
     */
    public List<StoreProxyDto> listStoreInfoByQuery(StoreProxyDto storeProxyDto) throws UserServiceException;

    /**
     * 更新买家用户会员级别信息
     * 
     * @param customerId
     *            客户ID
     * @param buyerLevelCode
     *            用户级别
     * @param vipExpireDate
     *            会员过期时间
     * @param vipCreateTime
     *            会员开通时间
     * @param operationUserId
     *            操作用户ID
     * @param operationDate
     *            操作时间
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateBuyerLevelCodeById(Integer customerId, String buyerLevelCode, Date vipExpireDate, Date vipCreateTime,
            Integer operationUserId, Date operationDate) throws UserServiceException;
}
