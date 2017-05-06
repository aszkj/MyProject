/**
 * 文件名称：UserProxyServiceImpl.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.user.proxy.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.ConsigneeAddressMapper;
import com.yilidi.o2o.user.dao.CustomerMapper;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.model.ConsigneeAddress;
import com.yilidi.o2o.user.model.Customer;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.ConsigneeAddressProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 功能描述：用户服务代理实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("userProxyService")
public class UserProxyService extends BasicDataService implements IUserProxyService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ConsigneeAddressMapper consigneeAddressMapper;
    @Autowired
    private IUserService userService;

    @Override
    public UserProxyDto getUserById(Integer userId) throws UserServiceException {

        try {
            User user = userMapper.loadById(userId);
            if (null == user) {
                return null;
            }
            UserProxyDto uDto = new UserProxyDto();
            ObjectUtils.fastCopy(user, uDto);
            Customer customer = customerMapper.loadById(user.getCustomerId());
            if (null != customer) {
                uDto.setBuyerLevelCode(customer.getBuyerLevelCode());
            }
            return uDto;
        } catch (Exception e) {
            logger.error("getUserById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<KeyValuePair<String, String>> getUserEmailAndNameByIds(List<Integer> ids) throws UserServiceException {
        List<KeyValuePair<String, String>> uList;
        try {
            if (ObjectUtils.isNullOrEmpty(ids)) {
                return null;
            }
            uList = new ArrayList<KeyValuePair<String, String>>();
            for (Integer uId : ids) {
                User u = userMapper.loadById(uId);
                if (null != u) {
                    KeyValuePair<String, String> kv = new KeyValuePair<String, String>();
                    kv.setKey(u.getUserName());
                    kv.setValue(u.getEmail());
                    uList.add(kv);
                } else {
                    return null;
                }
            }
            return uList;
        } catch (Exception e) {
            logger.info(e);
            throw new UserServiceException("用户数据查询异常:" + e.getMessage());
        }

    }

    @Override
    public List<KeyValuePair<String, String>> getUserPhoneAndNameByIds(List<Integer> ids) throws UserServiceException {
        return null;
    }

    @Override
    public ConsigneeAddressProxyDto loadConsigneeAddressById(Integer id) throws UserServiceException {
        ConsigneeAddressProxyDto proxyDto = new ConsigneeAddressProxyDto();

        ConsigneeAddress address = consigneeAddressMapper.loadById(id, null);
        if (ObjectUtils.isNullOrEmpty(address)) {
            logger.error("consigneeAddressMapper.loadById(" + id + "), 查询结果为null");
            throw new UserServiceException("获取收货地址为null，ID[" + id + "]");
        }
        ObjectUtils.fastCopy(address, proxyDto);
        return proxyDto;
    }

    /**
     * 
     * 根据客户类型查询userId列表
     * 
     * @param customerType
     * @return
     */
    public List<Integer> listUserIdsByCustomerType(String customerType) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(customerType)) {
            return new ArrayList<>();
        }
        return userMapper.listUserIdsByCustomerType(customerType);
    };

    /**
     * 
     * 根据用户账号列表查询userId列表
     * 
     * @param customerType
     * @return
     */
    public List<Integer> listUserIdsByUserNames(List<String> userNames) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(userNames)) {
            return new ArrayList<>();
        }
        return userMapper.listUserIdsByUserNames(userNames);
    };

    /**
     * 
     * 根据买家用户级别查询userId列表
     * 
     * @param buyerLevel
     * @return
     */
    public List<Integer> listUserIdsByBuyerLevel(String buyerLevel) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(buyerLevel)) {
            return new ArrayList<>();
        }
        return userMapper.listUserIdsByBuyerLevel(buyerLevel);
    }

    @Override
    public List<UserProxyDto> listUserByIds(List<Integer> ids) throws UserServiceException {
        try {
            List<UserProxyDto> userProxyDtoList = new ArrayList<UserProxyDto>();
            if (ObjectUtils.isNullOrEmpty(ids)) {
                return userProxyDtoList;
            }
            for (Integer userId : ids) {
                if (null == userId) {
                    continue;
                }
                User user = userMapper.loadById(userId);
                if (ObjectUtils.isNullOrEmpty(user)) {
                    continue;
                }
                UserProxyDto userProxyDto = new UserProxyDto();
                ObjectUtils.fastCopy(user, userProxyDto);
                userProxyDto.setUserId(user.getId());
                userProxyDtoList.add(userProxyDto);
            }
            return userProxyDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserAvatar(Integer userId, String userAvatarUrl) throws UserServiceException {
        try {
            userService.updateUserAvatar(userId, userAvatarUrl);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

	@Override
	public List<UserProxyDto> getPushUserByCustomerType(String customerType) throws UserServiceException{
		List<UserProxyDto> userProxyDtoList = null;
		UserProxyDto userProxyDto = null;
		List<UserDto> userDtoList = userService.getPushUserByCustomerType(customerType);
		if(!ObjectUtils.isNullOrEmpty(userDtoList)){
			userProxyDtoList = new ArrayList<>();
			for (UserDto userDto : userDtoList) {
				userProxyDto = new UserProxyDto();
				ObjectUtils.fastCopy(userDto, userProxyDto);
				userProxyDtoList.add(userProxyDto);
			}
		}
		return userProxyDtoList;
	}

	@Override
	public UserProxyDto getUserByCustomerId(Integer customerId) throws UserServiceException {
		UserProxyDto userProxyDto = null;
		UserDto userDto = userService.loadMainUser(customerId, SystemContext.UserDomain.USERMASTERFLAG_MAIN);
		if(!ObjectUtils.isNullOrEmpty(userDto)){
			userProxyDto = new UserProxyDto();
			ObjectUtils.fastCopy(userDto, userProxyDto);
		}
		return userProxyDto;
	}

}
