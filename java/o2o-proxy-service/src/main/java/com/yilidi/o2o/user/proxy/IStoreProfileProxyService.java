/**
 * 文件名称：IUserProxyServcieDemo.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.proxy;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 功能描述：门店服务代理接口类定义 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IStoreProfileProxyService {

    /**
     * 根据小区ID查询门店信息
     * 
     * @param communityId
     *            小区ID
     * @param storeStatus
     *            门店状态
     * @return StoreProfileProxyDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileProxyDto loadByCommunityId(Integer communityId, String storeStatus) throws UserServiceException;

    /**
     * 根据店铺ID查找店铺信息
     * 
     * @param storeId
     *            店铺ID
     * @return 店铺信息
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileProxyDto loadByStoreId(Integer storeId) throws UserServiceException;

    /**
     * 根据
     * 
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @return StoreProfileProxyDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileProxyDto loadNearestStoreProfileByLngAndLat(String longitude, String latitude)
            throws UserServiceException;

    /**
     * 根据商品编码和商品名称查询店铺列表信息
     * 
     * @param storeCode
     *            商品编码
     * @param storeName
     *            商品名称
     * @return 店铺信息列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<StoreProfileProxyDto> listByStoreCodeAndStoreName(String storeCode, String storeName)
            throws UserServiceException;
}
