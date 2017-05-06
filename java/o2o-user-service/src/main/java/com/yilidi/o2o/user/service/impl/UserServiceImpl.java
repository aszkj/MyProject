package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;
import com.yilidi.o2o.user.dao.CustomerMapper;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.dao.UserProfileMapper;
import com.yilidi.o2o.user.model.Customer;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.model.UserProfile;
import com.yilidi.o2o.user.model.combination.AdminUserInfo;
import com.yilidi.o2o.user.model.combination.RoleBindingUserInfo;
import com.yilidi.o2o.user.model.combination.UserInfo;
import com.yilidi.o2o.user.model.combination.UserNameAndTypeInfo;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IRecommendCustomerStoreService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.AdminUserInfoDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.RoleBindingUserInfoDto;
import com.yilidi.o2o.user.service.dto.SynUserInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserNameAndTypeInfoDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * 功能描述：用户Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("userService")
public class UserServiceImpl extends BasicDataService implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserProfileMapper userProfileMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private ISystemDictProxyService systemDictProxyService;

    @Autowired
    private IRecommendCustomerStoreService recommendCustomerStoreService;

    @Autowired
    private IMessageProxyService messageProxyService;

    @Override
    public Boolean checkUserNameIsExist(String userName, String customerType) throws UserServiceException {
        try {
            User user = this.userMapper.loadByNameAndType(userName, customerType);
            return user != null;
        } catch (Exception e) {
            logger.error("checkUserNameIsExist异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUser(UserDto uDto) throws UserServiceException {
        try {
            User user = new User();
            ObjectUtils.fastCopy(uDto, user);
            this.userMapper.save(user);
            UserProfile userProfile = new UserProfile();
            UserProfileDto upDto = uDto.getUserProfileDto();
            upDto.setUserId(user.getId());
            ObjectUtils.fastCopy(upDto, userProfile);
            this.userProfileMapper.save(userProfile);
        } catch (Exception e) {
            logger.error("saveUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserDto> listUsers() throws UserServiceException {
        try {
            UserQuery query = new UserQuery();
            List<User> users = this.userMapper.findUsers(query);
            List<UserDto> uDtos = new ArrayList<UserDto>();
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (User u : users) {
                    UserDto uo = new UserDto();
                    uo.setId(u.getId());
                    uo.setEmail(u.getEmail());
                    uo.setUserName(u.getUserName());
                    uo.setPassword(u.getPassword());
                    uDtos.add(uo);
                }
            }
            return uDtos;
        } catch (Exception e) {
            logger.error("listUsers异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserDto viewUserDetail(Integer id) throws UserServiceException {
        try {
            User u = userMapper.loadById(id);
            UserDto uDto = null;
            if (null != u) {
                uDto = new UserDto();
                ObjectUtils.fastCopy(u, uDto);
                Integer userId = u.getId();
                UserProfile up = userProfileMapper.loadByUserId(userId);
                if (null != up) {
                    UserProfileDto upDto = new UserProfileDto();
                    ObjectUtils.fastCopy(up, upDto);
                    uDto.setUserProfileDto(upDto);
                }
            }
            return uDto;
        } catch (Exception e) {
            logger.error("viewUserDetail异常", e);
            throw new UserServiceException("viewUserDetail异常");
        }
    }

    @Override
    public YiLiDiPage<UserDto> findUsers(UserQuery userQuery) throws UserServiceException {
        try {
            if (null == userQuery.getStart() || userQuery.getStart() <= 0) {
                userQuery.setStart(1);
            }
            if (null == userQuery.getPageSize() || userQuery.getPageSize() <= 0) {
                userQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(userQuery.getStart(), userQuery.getPageSize());
            Page<User> page = userMapper.findUsers(userQuery);
            Page<UserDto> pageDto = new Page<UserDto>(userQuery.getStart(), userQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<User> users = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (User u : users) {
                    UserDto uDto = new UserDto();
                    ObjectUtils.fastCopy(u, uDto);
                    pageDto.add(uDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findUsers异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUser(UserDto uDto) throws UserServiceException {
        try {
            User user = new User();
            ObjectUtils.fastCopy(uDto, user);
            this.userMapper.updateByIdSelective(user);
            UserProfile userProfile = new UserProfile();
            userProfile.setUserId(uDto.getId());
            ObjectUtils.fastCopy(uDto.getUserProfileDto(), userProfile);
            this.userProfileMapper.updateByUserIdSelective(userProfile);
        } catch (Exception e) {
            logger.error("updateUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserForAudit(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setAuditStatusCode(uDto.getAuditStatusCode());
            user.setAuditUserId(uDto.getAuditUserId());
            user.setAuditTime(uDto.getAuditTime());
            user.setAuditNote(uDto.getAuditNote());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateUserForAudit异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserForStatus(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setStatusCode(uDto.getStatusCode());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateUserForStatus异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserForPassword(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setPassword(uDto.getPassword());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateUserForPassword异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserDto loadUserById(Integer id) throws UserServiceException {
        try {
            User u = userMapper.loadById(id);
            UserDto uDto = null;
            if (null != u) {
                uDto = new UserDto();
                ObjectUtils.fastCopy(u, uDto);
                Customer customer = customerMapper.loadById(u.getCustomerId());
                if (!ObjectUtils.isNullOrEmpty(customer)) {
                    uDto.setBuyerLevelCode(customer.getBuyerLevelCode());
                    uDto.setVipExpireDate(customer.getVipExpireDate());
                    uDto.setInvitationCode(customer.getInvitationCode());
                }
                UserProfile userProfile = userProfileMapper.loadByUserId(id);
                if (!ObjectUtils.isNullOrEmpty(userProfile)) {
                    UserProfileDto userProfileDto = new UserProfileDto();
                    ObjectUtils.fastCopy(userProfile, userProfileDto);
                    uDto.setUserProfileDto(userProfileDto);
                }
            }
            return uDto;
        } catch (Exception e) {
            logger.error("loadUserById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserDto loadUserByNameAndType(String userName, String customerType) throws UserServiceException {
        try {
            User u = userMapper.loadByNameAndType(userName, customerType);
            UserDto uDto = null;
            if (null != u) {
                uDto = new UserDto();
                ObjectUtils.fastCopy(u, uDto);
                CustomerDto customerDto = customerService.loadCustomerById(u.getCustomerId());
                if (null != customerDto) {
                    uDto.setVipExpireDate(customerDto.getVipExpireDate());
                    uDto.setBuyerLevelCode(customerDto.getBuyerLevelCode());
                }
                UserProfile userProfile = userProfileMapper.loadByUserId(u.getId());
                if (userProfile != null) {
                    UserProfileDto userProfileDto = new UserProfileDto();
                    ObjectUtils.fastCopy(userProfile, userProfileDto);
                    uDto.setUserProfileDto(userProfileDto);
                }
            }
            return uDto;
        } catch (Exception e) {
            logger.error("loadUserByNameAndType异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserDto loginValidate(String userName, String customerType, String loginType, String password)
            throws UserServiceException {
        UserDto userDto = null;
        String message = null;
        try {
            if (StringUtils.isEmpty(userName)) {
                message = "用户名不能为空";
                throw new UserServiceException(message);
            }
            if (SystemContext.UserDomain.LOGINTYPE_PASSWORD.equals(loginType)) {
                if (StringUtils.isEmpty(password)) {
                    message = "密码不能为空";
                    throw new UserServiceException(message);
                }
            }
            userDto = this.loadUserByNameAndType(userName, customerType);
            if (null == userDto) {
                message = "用户不存在";
                throw new UserServiceException(message);
            }
            CustomerDto customerDto = customerService.loadCustomerById(userDto.getCustomerId());
            if (null == customerDto) {
                message = "用户不存在";
                throw new UserServiceException(message);
            }
            if (SystemContext.UserDomain.LOGINTYPE_PASSWORD.equals(loginType)) {
                if (!userDto.getPassword().equalsIgnoreCase(password)) {
                    message = "密码不正确";
                    throw new UserServiceException(message);
                }
            }
            if (userDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_OFF)) {
                message = "用户已被禁用";
                throw new UserServiceException(message);
            }
            if (userDto.getAuditStatusCode().equals(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET)) {
                message = "用户未被审核";
                throw new UserServiceException(message);
            }
            if (userDto.getAuditStatusCode().equals(SystemContext.UserDomain.USERAUDITSTATUS_NOT_PASSED)) {
                message = "用户审核未通过";
                throw new UserServiceException(message);
            }
            if (userDto.getMasterFlag().equals(SystemContext.UserDomain.USERMASTERFLAG_SUB)
                    && null != customerDto.getMasterUserId()) {
                UserDto mainUserDto = this.loadUserById(customerDto.getMasterUserId());
                if (mainUserDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_OFF)
                        || customerDto.getStatusCode().equals(SystemContext.UserDomain.CUSTOMERSTATUS_OFF)) {
                    message = "父用户已被禁用";
                    throw new UserServiceException(message);
                }
                if (mainUserDto.getAuditStatusCode().equals(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET)) {
                    message = "父用户未被审核";
                    throw new UserServiceException(message);
                }
                if (mainUserDto.getAuditStatusCode().equals(SystemContext.UserDomain.USERAUDITSTATUS_NOT_PASSED)) {
                    message = "父用户审核未通过";
                    throw new UserServiceException(message);
                }
            }
            userDto.setCustomerId(customerDto.getId());
            userDto.setMasterUserId(customerDto.getMasterUserId());
            userDto.setBuyerLevelCode(customerDto.getBuyerLevelCode());
            userDto.setVipExpireDate(customerDto.getVipExpireDate());
            return userDto;
        } catch (Exception e) {
            if (SystemContext.UserDomain.CUSTOMERTYPE_BUYER.equals(customerType)
                    || SystemContext.UserDomain.CUSTOMERTYPE_SELLER.equals(customerType)) {
                message = "手机号码或验证码输入错误，请重新输入";
                if (SystemContext.UserDomain.LOGINTYPE_PASSWORD.equals(loginType)) {
                    message = "手机号码或密码输入错误，请重新输入";
                }
            } else {
                message = null == e.getMessage() ? "登录验证出现系统异常" : e.getMessage();
            }
            logger.error(null == e.getMessage() ? "登录验证出现系统异常" : e.getMessage(), e);
            throw new UserServiceException(message);
        }
    }

    @Override
    public void saveSubUser(UserDto uDto, Integer customerId) throws UserServiceException {
        try {
            User user = new User();
            ObjectUtils.fastCopy(uDto, user);
            this.userMapper.save(user);
            UserProfile userProfile = new UserProfile();
            UserProfileDto upDto = uDto.getUserProfileDto();
            upDto.setUserId(user.getId());
            ObjectUtils.fastCopy(upDto, userProfile);
            Customer customer = this.customerMapper.loadById(customerId);
            userProfile.setProvinceCode(customer.getProvinceCode());
            userProfile.setCityCode(customer.getCityCode());
            userProfile.setCountyCode(customer.getCountyCode());
            userProfile.setTownCode(customer.getTownCode());
            this.userProfileMapper.save(userProfile);
        } catch (Exception e) {
            logger.error("saveSubUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubUser(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setRealName(uDto.getRealName());
            user.setEmail(uDto.getEmail());
            user.setPhone(uDto.getPhone());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            user.setNote(uDto.getNote());
            this.userMapper.updateByIdSelective(user);
            UserProfile userProfile = this.userProfileMapper.loadByUserId(uDto.getId());
            this.userProfileMapper.updateByUserIdSelective(userProfile);
        } catch (Exception e) {
            logger.error("updateSubUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Page<UserDto> findSubUsers(UserQuery userQuery) throws UserServiceException {
        try {
            if (null == userQuery.getStart() || userQuery.getStart() <= 0) {
                userQuery.setStart(1);
            }
            if (null == userQuery.getPageSize() || userQuery.getPageSize() <= 0) {
                userQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(userQuery.getStart(), userQuery.getPageSize());
            Page<User> page = userMapper.findSubUsers(userQuery);
            Page<UserDto> pageDto = new Page<UserDto>(userQuery.getStart(), userQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<User> users = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (User u : users) {
                    UserDto uDto = new UserDto();
                    ObjectUtils.fastCopy(u, uDto);
                    pageDto.add(uDto);
                }
            }
            return pageDto;
        } catch (Exception e) {
            logger.error("findSubUsers异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubUserForAudit(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setAuditStatusCode(uDto.getAuditStatusCode());
            user.setAuditUserId(uDto.getAuditUserId());
            user.setAuditTime(uDto.getAuditTime());
            user.setAuditNote(uDto.getAuditNote());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
            UserDto dto = new UserDto();
            dto.setAuditNote("QQQQQ");
            this.saveUser(dto);
        } catch (Exception e) {
            logger.error("updateSubUserForAudit异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubUserForStatus(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setStatusCode(uDto.getStatusCode());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateSubUserForStatus异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<UserDto> findBuyerUsers(UserQuery query) throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<UserInfo> page = userMapper.findBuyerUsers(query);
            Page<UserDto> pageDto = new Page<UserDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<UserInfo> users = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (UserInfo u : users) {
                    UserDto uDto = new UserDto();
                    ObjectUtils.fastCopy(u, uDto);
                    // 用户注册渠道类型名称：Android，IOS等
                    String registerPlatformName = super.getSystemDictName(
                            SystemContext.UserDomain.DictType.CHANNELTYPE.getValue(), u.getRegisterPlatform());
                    if (!StringUtils.isEmpty(registerPlatformName)) {
                        uDto.setRegisterPlatform(registerPlatformName);
                    } else {
                        SystemDictProxyDto systemDictProxyDto = systemDictProxyService
                                .loadByDictCode(u.getRegisterPlatform());
                        if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
                            uDto.setRegisterPlatform(systemDictProxyDto.getDictName());
                        }
                    }
                    // 获取用户级别的名称：普通会员、VIP会员等
                    String buyerLevelName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.UserDomain.DictType.BUYERLEVEL.getValue(), uDto.getBuyerLevelCode());
                    if (!StringUtils.isEmpty(buyerLevelName)) {
                        uDto.setBuyerLevelName(buyerLevelName);
                    } else {
                        SystemDictProxyDto systemDictProxyDto = systemDictProxyService
                                .loadByDictCode(uDto.getBuyerLevelCode());
                        if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
                            uDto.setBuyerLevelName(systemDictProxyDto.getDictName());
                        }
                    }
                    pageDto.add(uDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findBuyerUsers异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserDto loadBuyerUserById(Integer id) throws UserServiceException {
        try {
            UserInfo u = userMapper.loadBuyerUserById(id);
            UserDto uDto = null;
            if (null != u) {
                uDto = new UserDto();
                ObjectUtils.fastCopy(u, uDto);
                UserProfile userProfile = userProfileMapper.loadByUserId(u.getId());
                if (userProfile != null) {
                    UserProfileDto userProfileDto = new UserProfileDto();
                    ObjectUtils.fastCopy(userProfile, userProfileDto);
                    uDto.setUserProfileDto(userProfileDto);
                }
            }
            return uDto;
        } catch (Exception e) {
            logger.error("loadBuyerUserById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AdminUserInfoDto> findAdminUsers(UserQuery query) throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<AdminUserInfo> page = userMapper.findAdminUsers(query);
            Page<AdminUserInfoDto> pageDto = new Page<AdminUserInfoDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<AdminUserInfo> adminUsers = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(adminUsers)) {
                for (AdminUserInfo u : adminUsers) {
                    AdminUserInfoDto uDto = new AdminUserInfoDto();
                    ObjectUtils.fastCopy(u, uDto);
                    String departmentName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.UserDomain.DictType.OPERATORDEPARTMENTTYPE.getValue(), u.getDepartment());
                    if (!StringUtils.isEmpty(departmentName)) {
                        uDto.setDepartmentName(departmentName);
                    } else {
                        SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(u.getDepartment());
                        if (null == systemDictProxyDto) {
                            uDto.setDepartmentName(null);
                        } else {
                            uDto.setDepartmentName(systemDictProxyDto.getDictName());
                        }
                    }
                    Integer recommendStoreId = recommendCustomerStoreService
                            .loadStoreIdByRecommendCustomerId(uDto.getCustomerId());
                    uDto.setRecommendStoreId(recommendStoreId);
                    pageDto.add(uDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("查询运营平台用户出现系统异常", e);
            throw new UserServiceException("查询运营平台用户出现系统异常", e);
        }
    }

    @Override
    public void saveAdminUser(UserDto userDto) throws UserServiceException {
        try {
            User userModel = this.userMapper.loadByNameAndType(userDto.getUserName(), userDto.getCustomerType());
            if (null != userModel) {
                throw new IllegalArgumentException("登录账号已经存在");
            }
            Customer customer = new Customer();
            customer.setCustomerName(userDto.getUserName());
            customer.setCustomerType(userDto.getCustomerType());
            customer.setCreateUserId(userDto.getCreateUserId());
            customer.setCreateTime(userDto.getCreateTime());
            if (userDto.getStatusCode().equals(SystemContext.UserDomain.USERSTATUS_ON)) {
                customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_ON);
            } else {
                customer.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_OFF);
            }
            customer.setStatusCode(userDto.getStatusCode());
            customer.setNote(userDto.getNote());
            customer.setInvitationCode(userDto.getInvitationCode());
            customer.setTelPhone(userDto.getPhone());
            this.customerMapper.saveSelective(customer);
            User user = new User();
            ObjectUtils.fastCopy(userDto, user);
            user.setCustomerId(customer.getId());
            // 系统用户，默认系统审核
            user.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
            user.setAuditUserId(userDto.getCreateUserId());
            user.setAuditTime(new Date());
            user.setAuditNote("系统自动审核通过");
            user.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            this.userMapper.save(user);
            UserProfile userProfile = new UserProfile();
            userProfile.setUserId(user.getId());
            this.userProfileMapper.save(userProfile);
            customer.setMasterUserId(user.getId());
            this.customerMapper.updateByIdSelective(customer);
            // 同步用户信息
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
            sendSaveSynUserInfoMessage(synUserInfoDto);
        } catch (Exception e) {
            String msg = "";
            if (!StringUtils.isEmpty(e.getMessage())) {
                msg = e.getMessage();
            } else {
                msg = "创建运营平台用户出现系统异常";
            }
            logger.error(msg, e);
            throw new UserServiceException(msg, e);
        }
    }

    @Override
    public void updateSubUserForPassword(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setPassword(uDto.getPassword());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateSubUserForPassword异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserBatch(List<UserDto> userDtoList) throws UserServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(userDtoList)) {
                List<User> userList = new ArrayList<User>();
                for (UserDto uDto : userDtoList) {
                    User user = new User();
                    ObjectUtils.fastCopy(uDto, user);
                    userList.add(user);
                }
                this.userMapper.batchSave(userList);
            }
        } catch (Exception e) {
            logger.error("批量保存用户出现系统异常", e);
            throw new UserServiceException("批量保存用户出现系统异常", e);
        }
    }

    @Override
    public List<UserDto> listDataForExportUser(UserDto userDto, Long startLineNum, Integer pageSize)
            throws UserServiceException {
        try {
            User user = new User();
            ObjectUtils.fastCopy(userDto, user);
            List<User> users = this.userMapper.listDataForExportUser(user, startLineNum, pageSize);
            List<UserDto> uDtos = new ArrayList<UserDto>();
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (User u : users) {
                    UserDto uDto = new UserDto();
                    ObjectUtils.fastCopy(u, uDto);
                    uDtos.add(uDto);
                }
            }
            return uDtos;
        } catch (Exception e) {
            logger.error("listDataForExportUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportUser(UserDto userDto) throws UserServiceException {
        try {
            User user = new User();
            ObjectUtils.fastCopy(userDto, user);
            Long counts = this.userMapper.getCountsForExportUser(user);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportBuyerUser(UserQuery userQuery) {
        try {
            return this.userMapper.getCountsForExportBuyerUser(userQuery);
        } catch (Exception e) {
            logger.error("getCountsForExportBuyerUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserDto> listDataForExportBuyerUser(UserQuery query, Long startLineNum, Integer pageSize) {
        try {
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            List<UserInfo> userInfos = this.userMapper.listDataForExportBuyerUser(query, startLineNum, pageSize);
            List<UserDto> uDtos = new ArrayList<UserDto>();
            if (!ObjectUtils.isNullOrEmpty(userInfos)) {
                for (UserInfo u : userInfos) {
                    UserDto uDto = new UserDto();
                    ObjectUtils.fastCopy(u, uDto);
                    uDtos.add(uDto);
                }
            }
            return uDtos;
        } catch (Exception e) {
            logger.error("listDataForExportBuyerUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<RoleBindingUserInfoDto> findRoleBindingUsers(List<Integer> userIdList, UserQuery query)
            throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userIds", userIdList);
            map.put("userQuery", query);
            Page<RoleBindingUserInfo> page = userMapper.findRoleBindingUsers(map);
            Page<RoleBindingUserInfoDto> pageDto = new Page<RoleBindingUserInfoDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<RoleBindingUserInfo> roleBindingUsers = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(roleBindingUsers)) {
                for (RoleBindingUserInfo u : roleBindingUsers) {
                    RoleBindingUserInfoDto uDto = new RoleBindingUserInfoDto();
                    ObjectUtils.fastCopy(u, uDto);
                    String departmentName = super.getSystemDictName(
                            SystemContext.UserDomain.DictType.OPERATORDEPARTMENTTYPE.getValue(), u.getDepartment());
                    uDto.setDepartmentName(departmentName);
                    String statusName = super.getSystemDictName(SystemContext.UserDomain.DictType.USERSTATUS.getValue(),
                            u.getStatusCode());
                    uDto.setStatusName(statusName);
                    pageDto.add(uDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("分页获取角色绑定的用户列表信息出现系统异常", e);
            throw new UserServiceException("分页获取角色绑定的用户列表信息出现系统异常");
        }
    }

    @Override
    public Set<UserNameAndTypeInfoDto> getUserNameAndTypeInfos() throws UserServiceException {
        try {
            List<UserNameAndTypeInfo> userNameAndTypeInfos = this.userMapper.listUserNameAndTypeInfo();
            Set<UserNameAndTypeInfoDto> uDtos = new HashSet<UserNameAndTypeInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(userNameAndTypeInfos)) {
                for (UserNameAndTypeInfo u : userNameAndTypeInfos) {
                    UserNameAndTypeInfoDto uDto = new UserNameAndTypeInfoDto();
                    ObjectUtils.fastCopy(u, uDto);
                    uDtos.add(uDto);
                }
            }
            return uDtos;
        } catch (Exception e) {
            logger.error("获取用户名与客户类型的用户相关信息列表出现系统异常", e);
            throw new UserServiceException("获取用户名与客户类型的用户相关信息列表出现系统异常");
        }
    }

    @Override
    public UserDto loadMainUser(Integer customerId, String masterFlag) throws UserServiceException {
        try {
            User u = userMapper.loadMainUser(customerId, masterFlag);
            UserDto uDto = null;
            if (null != u) {
                uDto = new UserDto();
                ObjectUtils.fastCopy(u, uDto);
            }
            return uDto;
        } catch (Exception e) {
            logger.error("loadMainUser异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserForUserName(UserDto uDto) throws UserServiceException {
        try {
            User user = this.userMapper.loadById(uDto.getId());
            user.setUserName(uDto.getUserName());
            user.setCustomerType(uDto.getCustomerType());
            user.setModifyUserId(uDto.getModifyUserId());
            user.setModifyTime(uDto.getModifyTime());
            this.userMapper.updateByIdSelective(user);
        } catch (Exception e) {
            logger.error("updateUserForUserName异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void sendSaveSynUserInfoMessage(SynUserInfoDto synUserInfoDto) throws UserServiceException {
        try {
            SmallTableUserInfoProxyDto smallTableUserInfoProxyDto = new SmallTableUserInfoProxyDto();
            ObjectUtils.fastCopy(synUserInfoDto, smallTableUserInfoProxyDto);
            messageProxyService.sendSaveSynUserInfoMessage(smallTableUserInfoProxyDto);
        } catch (Exception e) {
            logger.error("发送保存同步用户信息消息错误", e);
            throw new UserServiceException(e);
        }
    }

    @Override
    public void sendUpdateSynUserInfoMessage(SynUserInfoDto synUserInfoDto) throws UserServiceException {
        try {
            SmallTableUserInfoProxyDto smallTableUserInfoProxyDto = new SmallTableUserInfoProxyDto();
            ObjectUtils.fastCopy(synUserInfoDto, smallTableUserInfoProxyDto);
            messageProxyService.sendUpdateSynUserInfoMessage(smallTableUserInfoProxyDto);
        } catch (Exception e) {
            logger.error("发送更新同步用户信息消息错误", e);
            throw new UserServiceException(e);
        }
    }

    @Override
    public void updateUserAvatar(Integer userId, String userAvatarUrl) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new UserServiceException("param[userId] can not be null");
            }
            if (ObjectUtils.isNullOrEmpty(userAvatarUrl)) {
                return;
            }
            userAvatarUrl = userAvatarUrl.replaceAll("\\\\", CommonConstants.BACKSLASH);
            if (userAvatarUrl.startsWith("http") || userAvatarUrl.startsWith("https")) {
                FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
                userAvatarUrl = fileUploadUtils.uploadFromUrl(userAvatarUrl, null, getSystemFileRelativePath());
                fileUploadUtils.uploadPublishFile(userAvatarUrl);
            }
            userProfileMapper.updateUserAvatarByUserId(userId, userAvatarUrl);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void sendUpdatUserAvatarMessage(Integer userId, String userAvatarUrl) throws UserServiceException {
        try {
            messageProxyService.sendUpdatUserAvatarMessage(userId, userAvatarUrl);
        } catch (Exception e) {
            logger.error("发送修改用户头像日志消息错误", e);
            throw new UserServiceException(e);
        }
    }

    @Override
    public void updateUserImgUrl(Integer userId, String userImgUrl) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId) || ObjectUtils.isNullOrEmpty(userImgUrl)) {
                return;
            }
            userImgUrl = StringUtils.getUrlPathName(userImgUrl);
            UserProfile userProfile = new UserProfile();
            userProfile.setUserId(userId);
            userProfile.setUserImageUrl(userImgUrl);
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            userProfileMapper.updateByUserIdSelective(userProfile);
            fileUploadUtils.uploadPublishFile(userImgUrl);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    private String getSystemFileRelativePath() {
        String systemUserPicRelativePath = super.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH);
        if (ObjectUtils.isNullOrEmpty(systemUserPicRelativePath)) {
            return CommonConstants.USER_PIC_RELATIVE_PATH_DEFAULT;
        }
        return systemUserPicRelativePath;
    }

    @Override
    public List<UserDto> listBuyerUsersByUserName(String userName) throws UserServiceException {
        List<UserDto> userDtos = new ArrayList<UserDto>();
        if (!StringUtils.isEmpty(userName)) {
            List<User> users = userMapper.listBuyerUsersByUserName(userName);
            if (!ObjectUtils.isNullOrEmpty(users)) {
                for (User user : users) {
                    UserDto userDto = new UserDto();
                    ObjectUtils.fastCopy(user, userDto);
                    userDtos.add(userDto);
                }

            }
        }
        return userDtos;
    }

    @Override
    public void updateBindMobile(Integer userId, String mobile) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new UserServiceException("userId cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(mobile)) {
                throw new UserServiceException("mobile cant not be null");
            }
            User user = userMapper.loadByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            if (!ObjectUtils.isNullOrEmpty(user)) {
                throw new UserServiceException("该手机号已绑定其他账户");
            }
            
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

	@Override
	public YiLiDiPage<UserDto> getChildAccountList(UserQuery userDtoQuery) throws UserServiceException {
		if (null == userDtoQuery.getStart() || userDtoQuery.getStart() <= 0) {
			userDtoQuery.setStart(1);
        }
        if (null == userDtoQuery.getPageSize() || userDtoQuery.getPageSize() <= 0) {
        	userDtoQuery.setPageSize(CommonConstants.PAGE_SIZE);
        }
        PageHelper.startPage(userDtoQuery.getStart(), userDtoQuery.getPageSize());
        Page<User> page = userMapper.findChildAccountList(userDtoQuery);
        Page<UserDto> pageDto = new Page<UserDto>(userDtoQuery.getStart(), userDtoQuery.getPageSize());
        ObjectUtils.fastCopy(page, pageDto);
        UserDto userDto = null;
        if(!ObjectUtils.isNullOrEmpty(page)){
			if(!ObjectUtils.isNullOrEmpty(page.getResult())){
				for (User user : page.getResult()) {
					userDto = new UserDto();
					ObjectUtils.fastCopy(user, userDto);
					pageDto.add(userDto);
				}
			}
		}
        return YiLiDiPageUtils.encapsulatePageResult(pageDto);
	}

	@Override
	public void updateUserPassword(Integer id) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("password", EncryptUtils.md5Crypt("888888").toUpperCase());
		userMapper.updateUserPassword(map);
	}

	@Override
	public void updateUserStatusCode(Integer id, String statusCode,Date freezeTime) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("statusCode", statusCode);
		map.put("freezeTime", freezeTime);
		userMapper.updateUserStatusCode(map);
	}

	@Override
	public List<Integer> getAcceptOrderUserId(Integer customerId) {
		return userMapper.getAcceptOrderUserId(customerId);
	}

	@Override
	public List<UserDto> getPushUserByCustomerType(String customerType) {
		List<UserDto> userDtoList = null;
		UserDto userDto = null;
		List<User> userList = userMapper.getPushUserByCustomerType(customerType);
		if(!ObjectUtils.isNullOrEmpty(userList)){
			userDtoList = new ArrayList<>();
			for (User user : userList) {
				userDto = new UserDto();
				ObjectUtils.fastCopy(user, userDto);
				userDtoList.add(userDto);
			}
		}
		return userDtoList;
	}
}
