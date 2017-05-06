/**
 * 文件名称：CustomerProxyServiceImpl.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.proxy.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.AccountMapper;
import com.yilidi.o2o.user.dao.CommissionSettingMapper;
import com.yilidi.o2o.user.dao.CustomerMapper;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.model.Account;
import com.yilidi.o2o.user.model.CommissionSetting;
import com.yilidi.o2o.user.model.Customer;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.model.combination.StoreInfo;
import com.yilidi.o2o.user.proxy.ICustomerProxyService;
import com.yilidi.o2o.user.proxy.dto.CustomerProxyDto;
import com.yilidi.o2o.user.proxy.dto.StoreProxyDto;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;
import com.yilidi.o2o.user.service.dto.query.StoreQuery;

/**
 * 功能描述：客户服务代理类实现 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("customerProxyService")
public class CustomerProxyService extends BasicDataService implements ICustomerProxyService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommissionSettingMapper commissionSettingMapper;

    @Override
    public CustomerProxyDto loadCustomerInfoById(Integer customerId) throws UserServiceException {
        logger.debug("CustomerProxyServiceImpl.getCustomerInfoById => 参数[customerId :" + customerId + "]");
        if (ObjectUtils.isNullOrEmpty(customerId)) {
            logger.error("CustomerProxyServiceImpl.getCustomerInfoById => 参数【customerId】为null");
            throw new UserServiceException("CustomerProxyServiceImpl.getCustomerInfoById => 参数为null");
        }

        Customer customer = customerMapper.loadById(customerId);
        if (!ObjectUtils.isNullOrEmpty(customer)) {
            CustomerProxyDto proxyDto = new CustomerProxyDto();

            logger.debug("CustomerProxyDto => " + proxyDto);

            User user = userMapper.loadById(customer.getMasterUserId());
            if (ObjectUtils.isNullOrEmpty(user)) {
                String msg = "客户[" + customer.getCustomerName() + "]的主用户id[" + customer.getMasterUserId() + "]不存在";
                logger.error(msg);
                throw new UserServiceException(msg);
            }

            /*
             * 获取客户的佣金设置
             */
            CommissionSetting setting = commissionSettingMapper.loadByStoreId(customerId);
            if (!ObjectUtils.isNullOrEmpty(setting)) {
                proxyDto.setRate(setting.getRate());
            }

            proxyDto.setCustomerId(customerId);
            proxyDto.setCustomerName(customer.getCustomerName());
            proxyDto.setCustomerType(customer.getCustomerType());
            proxyDto.setMasterName(customer.getMasterName());
            proxyDto.setMasterUserId(customer.getMasterUserId());
            proxyDto.setMasterUserName(user.getUserName());
            proxyDto.setProvinceCode(customer.getProvinceCode());
            proxyDto.setCityCode(customer.getCityCode());
            proxyDto.setCountyCode(customer.getCountyCode());
            proxyDto.setVipExpireDate(customer.getVipExpireDate());
            proxyDto.setVipCreateTime(customer.getVipCreateTime());
            proxyDto.setInvitationCode(customer.getInvitationCode());
            proxyDto.setInviteCustomerId(customer.getInviteCustomerId());
            proxyDto.setRecommendCustomerId(customer.getRecommendCustomerId());

            /*
             * 获取余额账户
             */
            Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(customerId, AccountTypeInfoDto.Type.YE);
            if (!ObjectUtils.isNullOrEmpty(account)) {
                proxyDto.setAccountBalance(account.getCurrentBalance());
            }

            return proxyDto;
        }
        return null;
    }

    @Override
    public CustomerProxyDto loadCustomerInfoByUserId(Integer userId) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(userId)) {
            logger.error("CustomerProxyServiceImpl.loadCustomerInfoByUserId => 参数【userId】为null");
            throw new UserServiceException("CustomerProxyServiceImpl.loadCustomerInfoByUserId => 参数为null");
        }
        User user = userMapper.loadById(userId);
        if (ObjectUtils.isNullOrEmpty(user)) {
            return null;
        }
        Customer customer = customerMapper.loadById(user.getCustomerId());
        if (ObjectUtils.isNullOrEmpty(customer)) {
            return null;
        }
        CustomerProxyDto proxyDto = new CustomerProxyDto();
        /*
         * 获取客户的佣金设置
         */
        CommissionSetting setting = commissionSettingMapper.loadByStoreId(customer.getId());
        if (!ObjectUtils.isNullOrEmpty(setting)) {
            proxyDto.setRate(setting.getRate());
        }
        ObjectUtils.fastCopy(customer, proxyDto);
        proxyDto.setCustomerId(customer.getId());
        proxyDto.setCustomerType(customer.getCustomerType());
        proxyDto.setMasterUserName(user.getUserName());
        /*
         * 获取余额账户
         */
        Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(customer.getId(), AccountTypeInfoDto.Type.YE);
        if (!ObjectUtils.isNullOrEmpty(account)) {
            proxyDto.setAccountBalance(account.getCurrentBalance());
        }

        return proxyDto;
    }

    @Override
    public List<StoreProxyDto> listStoreInfoByQuery(StoreProxyDto storeProxyDto) throws UserServiceException {
        try {
            StoreQuery query = new StoreQuery();
            if (!ObjectUtils.isNullOrEmpty(storeProxyDto)) {
                query.setStoreId(storeProxyDto.getId());
                query.setStoreCode(storeProxyDto.getStoreCode());
                query.setStoreName(storeProxyDto.getStoreName());
            }
            List<StoreInfo> storeInfos = customerMapper.listStoreInfoByQuery(query);
            List<StoreProxyDto> storeProxyDtos = null;
            if (!ObjectUtils.isNullOrEmpty(storeInfos)) {
                storeProxyDtos = new ArrayList<StoreProxyDto>();
                for (StoreInfo storeInfo : storeInfos) {
                    StoreProxyDto storeProxyDtoTemp = new StoreProxyDto();
                    ObjectUtils.fastCopy(storeInfo, storeProxyDtoTemp);
                    storeProxyDtos.add(storeProxyDtoTemp);
                }
            }
            return storeProxyDtos;
        } catch (Exception e) {
            logger.error("listStoreInfoByQuery异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateBuyerLevelCodeById(Integer customerId, String buyerLevelCode, Date vipExpireDate, Date vipCreateTime,
            Integer operationUserId, Date operationDate) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(customerId)) {
                throw new UserServiceException("客户ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(operationUserId)) {
                throw new UserServiceException("用户ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(buyerLevelCode)) {
                throw new UserServiceException("客户级别编码不能为空");
            }
            Integer result = customerMapper.updateBuyerLevelById(customerId, buyerLevelCode, vipExpireDate, vipCreateTime,
                    operationUserId, operationDate);
            if (1 != result) {
                throw new UserServiceException("更新用户会员信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }
}
