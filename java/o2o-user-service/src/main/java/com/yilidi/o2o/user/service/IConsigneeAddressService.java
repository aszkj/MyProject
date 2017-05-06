package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.ConsigneeAddressDto;

/**
 * 功能描述：ConsigneeAddress服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IConsigneeAddressService {

    /**
     * 添加收货地址
     * 
     * @param consigneeAddressDto
     * @throws UserServiceException
     */
    public ConsigneeAddressDto save(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException;

    /**
     * 根据ID删除收货地址
     * 
     * @param id
     */
    public void deleteById(Integer id) throws UserServiceException;

    /**
     * 根据ID获取收货地址
     * 
     * @param id
     * @param status
     * @return ConsigneeAddressDto
     * @throws UserServiceException
     */
    public ConsigneeAddressDto loadById(Integer id, String status) throws UserServiceException;

    /**
     * 根据客户Id查询该客户所有的收货地址
     * 
     * @param customerId
     * @return List<ConsigneeAddressDto>
     */
    public List<ConsigneeAddressDto> listByCustomerId(Integer customerId) throws UserServiceException;

    /**
     * 根据Id修改收货地址
     * 
     * @param consigneeAddressDto
     * @throws UserServiceException
     */
    public void updateByIdSelective(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException;

    /**
     * 根据Id修改收货地址 传空值不修改
     * 
     * @param consigneeAddressDto
     * @throws UserServiceException
     */
    public ConsigneeAddressDto updateById(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException;

    /**
     * 修改收货地址状态（启用/禁用）
     * 
     * @param consigneeAddressDto
     * @throws UserServiceException
     */
    public void updateForStatus(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException;

    /**
     * 修改收货地址是否默认（默认/非默认）
     * 
     * @param consigneeAddressDto
     * @throws UserServiceException
     */
    public void updateForDefaultFlag(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException;

    /**
     * 根据小区ID获取最近修改的收货地址
     * 
     * @param communityId
     *            小区ID
     * @param customerId
     *            客户ID
     * @return 收货地址信息
     * @throws UserServiceException
     *             用户服务异常
     */
    public ConsigneeAddressDto loadLatelyUpdateByCommunityId(Integer communityId, Integer customerId)
            throws UserServiceException;
}
