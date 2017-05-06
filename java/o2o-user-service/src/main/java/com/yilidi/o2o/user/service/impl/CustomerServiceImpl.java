package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.user.dao.CustomerMapper;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.dao.UserProfileMapper;
import com.yilidi.o2o.user.model.Customer;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.model.UserProfile;
import com.yilidi.o2o.user.model.combination.CustomerRelatedInfo;
import com.yilidi.o2o.user.model.combination.VipUserStatisticInfo;
import com.yilidi.o2o.user.model.query.InvitedUserQuery;
import com.yilidi.o2o.user.model.query.VipUserStatisticDetailQuery;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.InvitationUserDto;
import com.yilidi.o2o.user.service.dto.SynUserInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;
import com.yilidi.o2o.user.service.dto.VipUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.query.CustomerQuery;
import com.yilidi.o2o.user.service.dto.query.InvitedUserQueryDto;
import com.yilidi.o2o.user.service.dto.query.VipUserStatisticDetailQueryDto;

/**
 * 功能描述：客户Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("customerService")
public class CustomerServiceImpl extends BasicDataService implements ICustomerService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserProfileMapper userProfileMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private IAreaDictProxyService areaDictProxyService;

    @Autowired
    private IAccountService accountService;
    
    @Autowired
    private IUserService userService;
    
    @Autowired
    private IUserShareService userShareService;
    
    /** 注册自动升级会员有效时间(单位“天”，默认一个月) **/
    private static final int REGISTER_VIP_EXPIRE_MONTH = 1;

    @Override
    public CustomerDto viewCustomerDetail(Integer id) throws UserServiceException {
        try {
            CustomerRelatedInfo customerRelatedInfo = customerMapper.loadCustomerRelatedInfoById(id);
            CustomerDto customerDto = null;
            if (null != customerRelatedInfo) {
                customerDto = new CustomerDto();
                ObjectUtils.fastCopy(customerRelatedInfo, customerDto);
                customerDto.setCustomerAreaAddressInfo(areaDictProxyService.encapsulateAreaNameByCodes(
                        customerDto.getProvinceCode(), customerDto.getCityCode(), customerDto.getCountyCode(),
                        customerDto.getTownCode(), customerDto.getAddressDetail()));
                encapsulateCustomerInfo(customerRelatedInfo, customerDto);
            }
            return customerDto;
        } catch (Exception e) {
            logger.error("viewCustomerDetail异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public CustomerDto viewEnterprise(Integer id) throws UserServiceException {
        try {
            Customer customer = customerMapper.loadById(id);
            CustomerDto customerDto = null;
            if (null != customer) {
                customerDto = new CustomerDto();
                ObjectUtils.fastCopy(customer, customerDto);
            }
            return customerDto;
        } catch (Exception e) {
            logger.error("viewEnterprise异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public CustomerDto loadCustomerById(Integer id) throws UserServiceException {
        try {
            Customer customer = customerMapper.loadById(id);
            CustomerDto customerDto = null;
            if (null != customer) {
                customerDto = new CustomerDto();
                ObjectUtils.fastCopy(customer, customerDto);
            }
            return customerDto;
        } catch (Exception e) {
            logger.error("loadCustomerById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public CustomerDto loadCustomerByName(String customerName) throws UserServiceException {
        try {
            Customer customer = customerMapper.loadByCustomerName(customerName);
            CustomerDto customerDto = null;
            if (null != customer) {
                customerDto = new CustomerDto();
                ObjectUtils.fastCopy(customer, customerDto);
            }
            return customerDto;
        } catch (Exception e) {
            logger.error("loadCustomerByName异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Boolean checkCustomerNameIsExist(String customerName) throws UserServiceException {
        try {
            Customer customer = customerMapper.loadByCustomerName(customerName);
            return customer != null;
        } catch (Exception e) {
            logger.error("checkCustomerNameIsExist异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer saveCustomer(CustomerDto customerDto) throws UserServiceException {
        try {
            Date nowDate = new Date();
            Customer customer = new Customer();
            ObjectUtils.fastCopy(customerDto, customer);
            Date vipExpireDate = DateUtils.addMonths(nowDate, ArithUtils.converStringToInt(
                    super.getSystemParamValue(SystemContext.SystemParams.U_REGISTERTO_VIP_EXPIRE_MONTH),
                    REGISTER_VIP_EXPIRE_MONTH));
            customer.setCreateTime(nowDate);
            customer.setVipExpireDate(vipExpireDate);
            customer.setBuyerLevelCode(SystemContext.UserDomain.BUYERLEVEL_B);
            this.customerMapper.saveSelective(customer);
            User user = new User();
            ObjectUtils.fastCopy(customerDto.getMasterUserDto(), user);
            user.setCreateTime(nowDate);
            user.setCustomerId(customer.getId());
            this.userMapper.save(user);
            UserProfile userProfile = new UserProfile();
            UserProfileDto upDto = customerDto.getMasterUserDto().getUserProfileDto();
            upDto.setUserId(user.getId());
            ObjectUtils.fastCopy(upDto, userProfile);
            this.userProfileMapper.save(userProfile);
            customer.setMasterUserId(user.getId());
            this.customerMapper.updateByIdSelective(customer);

            // 创建4个账本：运营商不需要创建账本，买家只有现金账本，门店用户4个账本
            AccountDto accountDto = new AccountDto();
            if (!ObjectUtils.isNullOrEmpty(customer.getCustomerType())
                    && !customer.getCustomerType().equals(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR)) {
                accountDto.setCustomerId(customer.getId());
                accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
                accountDto.setCurrentBalance(0L);
                accountDto.setFreezeAmount(0L);
                accountDto.setCreateUserId(customerDto.getCreateUserId());
                accountDto.setCreateTime(customerDto.getCreateTime());
                accountService.save(accountDto);
            }
            if (!ObjectUtils.isNullOrEmpty(customer.getCustomerType())
                    && customer.getCustomerType().equals(SystemContext.UserDomain.CUSTOMERTYPE_SELLER)) {
                accountDto = new AccountDto();
                accountDto.setCustomerId(customer.getId());
                accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_PRODCUTPRICESUBSIDY);
                accountDto.setCurrentBalance(0L);
                accountDto.setFreezeAmount(0L);
                accountDto.setCreateUserId(customerDto.getCreateUserId());
                accountDto.setCreateTime(customerDto.getCreateTime());
                accountService.save(accountDto);

                accountDto = new AccountDto();
                accountDto.setCustomerId(customer.getId());
                accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_COUPONSUBSIDY);
                accountDto.setCurrentBalance(0L);
                accountDto.setFreezeAmount(0L);
                accountDto.setCreateUserId(customerDto.getCreateUserId());
                accountDto.setCreateTime(customerDto.getCreateTime());
                accountService.save(accountDto);

                accountDto = new AccountDto();
                accountDto.setCustomerId(customer.getId());
                accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_LOGISTICSSUBSIDY);
                accountDto.setCurrentBalance(0L);
                accountDto.setFreezeAmount(0L);
                accountDto.setCreateUserId(customerDto.getCreateUserId());
                accountDto.setCreateTime(customerDto.getCreateTime());
                accountService.save(accountDto);
            }
            //同步用户信息
            SynUserInfoDto synUserInfoDto = new SynUserInfoDto();
            synUserInfoDto.setUserId(user.getId());
            synUserInfoDto.setCustomerId(customer.getId());
            synUserInfoDto.setUserName(user.getUserName());
            synUserInfoDto.setCustomerName(customer.getCustomerName());
            synUserInfoDto.setUserMobile(user.getPhone());
            synUserInfoDto.setCustomerMobile(customer.getTelPhone());
            synUserInfoDto.setRealName(user.getRealName());
            synUserInfoDto.setRegisterTime(user.getCreateTime());
            synUserInfoDto.setInvitationCode(customer.getInvitationCode());
            userService.sendSaveSynUserInfoMessage(synUserInfoDto);
            return customer.getId();
        } catch (Exception e) {
            logger.error("saveCustomer异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CustomerDto> findCustomers(CustomerQuery customerQuery) throws UserServiceException {
        try {
            if (null == customerQuery.getStart() || customerQuery.getStart() <= 0) {
                customerQuery.setStart(1);
            }
            if (null == customerQuery.getPageSize() || customerQuery.getPageSize() <= 0) {
                customerQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(customerQuery.getStart(), customerQuery.getPageSize());
            Page<CustomerRelatedInfo> page = customerMapper.findCustomers(customerQuery);
            Page<CustomerDto> pageDto = new Page<CustomerDto>(customerQuery.getStart(), customerQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<CustomerRelatedInfo> customerRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(customerRelatedInfos)) {
                for (CustomerRelatedInfo cri : customerRelatedInfos) {
                    CustomerDto cDto = new CustomerDto();
                    ObjectUtils.fastCopy(cri, cDto);
                    cDto.setCustomerAreaAddressInfo(areaDictProxyService.encapsulateAreaNameByCodes(cDto.getProvinceCode(),
                            cDto.getCityCode(), cDto.getCountyCode(), cDto.getTownCode(), cDto.getAddressDetail()));
                    encapsulateCustomerInfo(cri, cDto);
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCustomers异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    private void encapsulateCustomerInfo(CustomerRelatedInfo customerRelatedInfo, CustomerDto customerDto)
            throws SystemServiceException {
        UserDto userDto = new UserDto();
        UserProfileDto userProfileDto = new UserProfileDto();
        userDto.setId(customerRelatedInfo.getUserId());
        userDto.setUserName(customerRelatedInfo.getUserName());
        userDto.setPhone(customerRelatedInfo.getPhone());
        userDto.setMasterFlag(customerRelatedInfo.getMasterFlag());
        if (customerRelatedInfo.getUserStatusCode().equals(SystemContext.UserDomain.USERSTATUS_OFF)) {
            userDto.setStatusCode(customerRelatedInfo.getUserStatusCode());
        } else {
            if (customerRelatedInfo.getMasterFlag().equals(SystemContext.UserDomain.USERMASTERFLAG_MAIN)) {
                userDto.setStatusCode(customerRelatedInfo.getUserStatusCode());
            } else {
                if (customerRelatedInfo.getCustomerStatusCode().equals(SystemContext.UserDomain.CUSTOMERSTATUS_ON)) {
                    userDto.setStatusCode(customerRelatedInfo.getUserStatusCode());
                } else {
                    userDto.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_OFF);
                }
            }
        }
        userDto.setAuditStatusCode(customerRelatedInfo.getAuditStatusCode());
        userDto.setEmail(customerRelatedInfo.getEmail());
        userDto.setAuditTime(customerRelatedInfo.getAuditTime());
        userDto.setAuditUserId(customerRelatedInfo.getAuditUserId());
        userDto.setAuditUserName(customerRelatedInfo.getAuditUserName());
        userDto.setAuditNote(customerRelatedInfo.getAuditNote());
        userProfileDto.setId(customerRelatedInfo.getUserProfileId());
        userProfileDto.setUserId(customerRelatedInfo.getUserId());
        userProfileDto.setProvinceCode(customerRelatedInfo.getUserProvinceCode());
        userProfileDto.setCityCode(customerRelatedInfo.getUserCityCode());
        userProfileDto.setCountyCode(customerRelatedInfo.getUserCountyCode());
        userProfileDto.setTownCode(customerRelatedInfo.getUserTownCode());
        userProfileDto.setUserAreaAddressInfo(areaDictProxyService.encapsulateAreaNameByCodes(
                customerRelatedInfo.getUserProvinceCode(), customerRelatedInfo.getUserCityCode(),
                customerRelatedInfo.getUserCountyCode(), customerRelatedInfo.getUserTownCode(),
                customerRelatedInfo.getAddressDetail()));
        userDto.setUserProfileDto(userProfileDto);
        customerDto.setStatusCode(customerRelatedInfo.getCustomerStatusCode());
        customerDto.setUserDto(userDto);
        if (customerRelatedInfo.getMasterFlag().equals(SystemContext.UserDomain.USERMASTERFLAG_MAIN)) {
            UserDto masterUserDto = new UserDto();
            ObjectUtils.fastCopy(userDto, masterUserDto);
            customerDto.setMasterUserDto(masterUserDto);
        }
    }

    @Override
    public void updateCustomer(CustomerDto customerDto) throws UserServiceException {
        try {
            Customer customer = this.customerMapper.loadById(customerDto.getId());
            ObjectUtils.fastCopy(customerDto, customer);
            this.customerMapper.updateByIdSelective(customer);
            User user = this.userMapper.loadById(customerDto.getMasterUserDto().getId());
            ObjectUtils.fastCopy(customerDto.getMasterUserDto(), user);
            this.userMapper.updateByIdSelective(user);
            UserProfile userProfile = this.userProfileMapper.loadByUserId(customerDto.getMasterUserDto().getUserProfileDto()
                    .getUserId());
            ObjectUtils.fastCopy(customerDto.getMasterUserDto().getUserProfileDto(), userProfile);
            this.userProfileMapper.updateByUserIdSelective(userProfile);
        } catch (Exception e) {
            logger.error("updateCustomer异常", e);
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
            if (ObjectUtils.isNullOrEmpty(buyerLevelCode)) {
                throw new UserServiceException("终端用户级别编码");
            }
            if (ObjectUtils.isNullOrEmpty(operationUserId)) {
                throw new UserServiceException("操作用户ID");
            }
            if (ObjectUtils.isNullOrEmpty(operationDate)) {
                operationDate = new Date();
            }
            Integer effectCount = customerMapper.updateBuyerLevelById(customerId, buyerLevelCode, vipExpireDate,
                    vipCreateTime, operationUserId, operationDate);
            if (1 != effectCount) {
                throw new UserServiceException("更新用户会员信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAdminUser(UserDto userDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(userDto.getId());
            user.setUserName(userDto.getUserName());
            user.setRealName(userDto.getRealName());
            user.setPhone(userDto.getPhone());
            user.setEmail(userDto.getEmail());
            user.setDepartment(userDto.getDepartment());
            user.setStatusCode(userDto.getStatusCode());
            user.setNote(userDto.getNote());
            user.setModifyTime(userDto.getModifyTime());
            user.setModifyUserId(userDto.getMasterUserId());
            user.setCustomerType(userDto.getCustomerType());
            this.userMapper.update(user);
            Customer customer = this.customerMapper.loadById(user.getCustomerId());
            if (null != customer) {
                String masterFlag = user.getMasterFlag();
                if (SystemContext.UserDomain.USERMASTERFLAG_MAIN.equals(masterFlag)) {
                    if (userDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_ON)) {
                        customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_ON);
                    } else {
                        customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_OFF);
                    }
                    customer.setModifyUserId(userDto.getModifyUserId());
                    customer.setModifyTime(userDto.getModifyTime());
                    customer.setInvitationCode(userDto.getInvitationCode());
                    this.customerMapper.updateAdminCustomer(customer);
                }
                //同步用户信息
                SynUserInfoDto synUserInfoDto = new SynUserInfoDto();
                synUserInfoDto.setUserName(user.getUserName());
                synUserInfoDto.setCustomerName(customer.getCustomerName());
                synUserInfoDto.setUserMobile(user.getPhone());
                synUserInfoDto.setCustomerMobile(customer.getTelPhone());
                synUserInfoDto.setRealName(user.getRealName());
                synUserInfoDto.setInvitationCode(userDto.getInvitationCode());
                synUserInfoDto.setUserId(user.getId());
                userService.sendUpdateSynUserInfoMessage(synUserInfoDto);
            }
        } catch (Exception e) {
            logger.error("更新运营平台用户出现系统异常", e);
            throw new UserServiceException("更新运营平台用户出现系统异常", e);
        }
    }

    @Override
    public void updateCustomerForAudit(CustomerDto customerDto) throws UserServiceException {
        try {
            Customer customer = this.customerMapper.loadById(customerDto.getId());
            Integer masterUserId = customer.getMasterUserId();
            if (null != masterUserId) {
                User user = this.userMapper.loadById(masterUserId);
                user.setAuditStatusCode(customerDto.getMasterUserDto().getAuditStatusCode());
                user.setAuditUserId(customerDto.getMasterUserDto().getAuditUserId());
                user.setAuditTime(customerDto.getMasterUserDto().getAuditTime());
                user.setAuditNote(customerDto.getMasterUserDto().getAuditNote());
                user.setModifyUserId(customerDto.getMasterUserDto().getModifyUserId());
                user.setModifyTime(customerDto.getMasterUserDto().getModifyTime());
                this.userMapper.updateByIdSelective(user);
                customer.setModifyUserId(customerDto.getModifyUserId());
                customer.setModifyTime(customerDto.getModifyTime());
                this.customerMapper.updateByIdSelective(customer);
            }
        } catch (Exception e) {
            logger.error("updateCustomerForAudit异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateCustomerForStatus(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            Customer customer = this.customerMapper.loadById(user.getCustomerId());
            //当前账号下子账号列表
            List<User> userChildList = null;
            if (user.getMasterFlag().equals(SystemContext.UserDomain.USERMASTERFLAG_MAIN)) {
                if (uDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_ON)) {
                    customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_ON);
                } else {
                    customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_OFF);
                    uDto.setFreezeTime(new Date());
                    userChildList = this.userMapper.getChildBycustom(user.getCustomerId());
                }
                customer.setModifyUserId(uDto.getModifyUserId());
                customer.setModifyTime(uDto.getModifyTime());
                this.customerMapper.updateByIdSelective(customer);
                user.setStatusCode(uDto.getStatusCode());
                user.setModifyUserId(uDto.getModifyUserId());
                user.setModifyTime(uDto.getModifyTime());
                user.setFreezeTime(uDto.getFreezeTime());
                this.userMapper.updateByIdSelective(user);
                if (uDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_OFF)) {
                	if(!ObjectUtils.isNullOrEmpty(userChildList)){
                		for (User userChild : userChildList) {
                			this.userService.updateUserStatusCode(userChild.getId(), uDto.getStatusCode(), uDto.getFreezeTime());;
						}
                	}
                } 
            } else {
            	user.setStatusCode(uDto.getStatusCode());
                user.setModifyUserId(uDto.getModifyUserId());
                user.setModifyTime(uDto.getModifyTime());
                if (uDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_ON)) {
                    if (customer.getStatusCode().equals(SystemContext.UserDomain.CUSTOMERSTATUS_OFF)) {
                        throw new UserServiceException("主账号已被禁用，无法启用该子账号！");
                    }
                } else {
                    user.setFreezeTime(new Date());
                    
                }
                this.userMapper.updateByIdSelective(user);
                
            }
        } catch (Exception e) {
            logger.error("更新用户状态出现系统异常", e);
            throw new UserServiceException("更新用户状态出现系统异常", e);
        }
    }

    @Override
    public void updateCustomerForPassword(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setPassword(uDto.getPassword());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
            if (user.getMasterFlag().equals(SystemContext.UserDomain.USERMASTERFLAG_MAIN)) {
                Integer customerId = user.getCustomerId();
                Customer customer = this.customerMapper.loadById(customerId);
                customer.setModifyUserId(uDto.getModifyUserId());
                customer.setModifyTime(uDto.getModifyTime());
                this.customerMapper.updateByIdSelective(customer);
            }
        } catch (Exception e) {
            logger.error("更新用户密码出现系统异常", e);
            throw new UserServiceException("更新用户密码出现系统异常", e);
        }
    }

    @Override
    public Long getInviteCount(Integer inviteCustomerId, Date startCreateTime, Date endCreateTime)
            throws UserServiceException {
        try {
            return this.customerMapper.getInviteCount(inviteCustomerId, SystemContext.UserDomain.CUSTOMERSTATUS_ON,
                    startCreateTime, endCreateTime);
        } catch (Exception e) {
            String msg = "获取邀请注册用户数出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public Long getVipUserCount(Integer inviteCustomerId, Date startCreateTime, Date endCreateTime)
            throws UserServiceException {
        try {
            return this.customerMapper.getVipUserCount(inviteCustomerId, SystemContext.UserDomain.CUSTOMERSTATUS_ON,
                    SystemContext.UserDomain.BUYERLEVEL_B, startCreateTime, endCreateTime);
        } catch (Exception e) {
            String msg = "获取卖家所邀请的VIP用户数出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<InvitationUserDto> findInvitedUsers(InvitedUserQueryDto invitedUserQueryDto)
            throws UserServiceException {
        try {
            if (null == invitedUserQueryDto.getStart() || invitedUserQueryDto.getStart() <= 0) {
                invitedUserQueryDto.setStart(1);
            }
            if (null == invitedUserQueryDto.getPageSize() || invitedUserQueryDto.getPageSize() <= 0) {
                invitedUserQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            InvitedUserQuery invitedUserQuery = new InvitedUserQuery();
            ObjectUtils.fastCopy(invitedUserQueryDto, invitedUserQuery);
            PageHelper.startPage(invitedUserQuery.getStart(), invitedUserQuery.getPageSize());

            Page<Customer> page = customerMapper.findInvitedCustomers(invitedUserQuery);
            Page<InvitationUserDto> pageDto = new Page<InvitationUserDto>(invitedUserQueryDto.getStart(),
                    invitedUserQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<Customer> customers = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(customers)) {
                for (Customer customer : customers) {
                    InvitationUserDto invitationUserDto = new InvitationUserDto();
                    String buyerLevelCode = customer.getBuyerLevelCode();
                    if (!StringUtils.isEmpty(buyerLevelCode)) {
                        if (SystemContext.UserDomain.BUYERLEVEL_A.equals(buyerLevelCode)) {
                            invitationUserDto.setVipFlag(0);
                        }
                        if (SystemContext.UserDomain.BUYERLEVEL_B.equals(buyerLevelCode)) {
                            if (null != customer.getVipCreateTime()) {
                                invitationUserDto.setVipFlag(1);
                            } else {
                                invitationUserDto.setVipFlag(2);
                            }
                        }
                    }
                    Integer masterUserId = customer.getMasterUserId();
                    if (null != masterUserId) {
                        User user = this.userMapper.loadById(masterUserId);
                        if (null != user) {
                            invitationUserDto.setUserName(user.getUserName());
                            String phone = user.getPhone();
                            if (!StringUtils.isEmpty(phone)) {
                                invitationUserDto.setUserMaskMobile(phone.substring(0,
                                        phone.length() - (phone.substring(3)).length())
                                        + "****" + phone.substring(7));
                            }
                        }
                    }
                    pageDto.add(invitationUserDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "分页获取邀请注册客户信息列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public Integer getVipUserCountByTimes(Integer inviteCustomerId, Date beginDate, Date endDate)
            throws UserServiceException {
        try {
            return this.customerMapper.getVipUserCountByTimes(inviteCustomerId, SystemContext.UserDomain.CUSTOMERSTATUS_ON,
                    SystemContext.UserDomain.BUYERLEVEL_B, beginDate, endDate);
        } catch (Exception e) {
            String msg = "获取卖家某一时间段内所邀请的VIP用户数出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<VipUserStatisticInfoDto> findVipUserStatisticInfos(
            VipUserStatisticDetailQueryDto vipUserStatisticDetailQueryDto) throws UserServiceException {
        try {
            if (null == vipUserStatisticDetailQueryDto.getStart() || vipUserStatisticDetailQueryDto.getStart() <= 0) {
                vipUserStatisticDetailQueryDto.setStart(1);
            }
            if (null == vipUserStatisticDetailQueryDto.getPageSize() || vipUserStatisticDetailQueryDto.getPageSize() <= 0) {
                vipUserStatisticDetailQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            VipUserStatisticDetailQuery vipUserStatisticDetailQuery = new VipUserStatisticDetailQuery();
            ObjectUtils.fastCopy(vipUserStatisticDetailQueryDto, vipUserStatisticDetailQuery);
            PageHelper.startPage(vipUserStatisticDetailQuery.getStart(), vipUserStatisticDetailQuery.getPageSize());
            Page<VipUserStatisticInfo> page = customerMapper.findVipUserStatisticInfos(vipUserStatisticDetailQuery);
            Page<VipUserStatisticInfoDto> pageDto = new Page<VipUserStatisticInfoDto>(
                    vipUserStatisticDetailQueryDto.getStart(), vipUserStatisticDetailQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<VipUserStatisticInfo> vipUserStatisticInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(vipUserStatisticInfos)) {
                for (VipUserStatisticInfo vipUserStatisticInfo : vipUserStatisticInfos) {
                    VipUserStatisticInfoDto vipUserStatisticInfoDto = new VipUserStatisticInfoDto();
                    ObjectUtils.fastCopy(vipUserStatisticInfo, vipUserStatisticInfoDto);
                    pageDto.add(vipUserStatisticInfoDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "分页获取铂金会员统计详细信息出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<CustomerDto> listByCustomerTypeAndBuyerLevelCode(String customerType, String buyerLevelCode)
            throws UserServiceException {
        try {
            List<CustomerDto> customerDtoList = new ArrayList<CustomerDto>();
            List<Customer> customerList = customerMapper.listByCustomerTypeAndBuyerLevelCode(customerType, buyerLevelCode);
            if (!ObjectUtils.isNullOrEmpty(customerList)) {
                for (Customer customer : customerList) {
                    CustomerDto customerDto = new CustomerDto();
                    ObjectUtils.fastCopy(customer, customerDto);
                    customerDtoList.add(customerDto);
                }
            }
            return customerDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public CustomerDto loadByInvitationCode(String invitationCode) throws UserServiceException {
        Customer customer = customerMapper.loadByInvitationCode(invitationCode);
        CustomerDto customerDto = null;
        if (null != customer) {
            customerDto = new CustomerDto();
            ObjectUtils.fastCopy(customer, customerDto);
        }
        return customerDto;
    }

}
