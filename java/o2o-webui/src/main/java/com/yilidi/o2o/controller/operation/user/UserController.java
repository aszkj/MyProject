package com.yilidi.o2o.controller.operation.user;

import java.text.ParseException;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.payment.tencent.common.MD5;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.dto.SaleOrderProxyDto;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.report.export.user.BuyerUserReportExport;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * @Description:TODO(用户(买家)管理控制器)
 * @author: llp
 * @date: 2015年11月25日 下午11:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class UserController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private BuyerUserReportExport buyerUserReportExport;
    
    @Autowired
    private IOrderService orderService;

    /**
     * @Description TODO(查询买家用户管理列表)
     * @param query
     * @return Page<UserDto>
     */
    @RequestMapping(value = "/listBuyerUser")
    @ResponseBody
    public MsgBean listBuyerUser(@RequestBody UserQuery query) {
        try {
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            query.setOrder("A.CREATETIME");
            query.setSort(CommonConstants.SORT_ORDER_DESC);
            if (!StringUtils.isEmpty(query.getStartCreateTime())) {
                query.setStartCreateDate(DateUtils.getSpecificStartDate(query.getStartCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getEndCreateTime())) {
                query.setEndCreateDate(DateUtils.getSpecificEndDate(query.getEndCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getStartVipCreateTime())) {
                query.setStartVipCreateDate(DateUtils.getSpecificStartDate(query.getStartVipCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getEndVipCreateTime())) {
                query.setEndVipCreateDate(DateUtils.getSpecificEndDate(query.getEndVipCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getStartVipExpireTime())) {
                query.setStartVipExpireDate(DateUtils.getSpecificStartDate(query.getStartVipExpireTime()));
            }
            if (!StringUtils.isEmpty(query.getEndVipExpireTime())) {
                query.setEndVipExpireDate(DateUtils.getSpecificEndDate(query.getEndVipExpireTime()));
            }
            YiLiDiPage<UserDto> page = userService.findBuyerUsers(query);
            logger.info("YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询买家用户管理列表成功");
        } catch (Exception e) {
            logger.error("查询买家用户管理列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(修改用户状态(启用，停用)，修改操作)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{statusCode}/updateBuyerUserStatus")
    @ResponseBody
    public MsgBean updateBuyerUserStatus(@PathVariable("id") Integer id, @PathVariable("statusCode") String statusCode) {
        try {
            UserDto userDto = new UserDto();
            userDto.setId(id);
            userDto.setModifyUserId(super.getUserId());
            userDto.setModifyTime(new Date());
            userDto.setStatusCode(statusCode);
            customerService.updateCustomerForStatus(userDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改买家用户状态成功");
        } catch (Exception e) {
            logger.error("修改买家用户状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量禁用买家用户状态)
     * @param param
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/batchDisabledUserStatus")
    @ResponseBody
    public MsgBean batchDisabledUserStatus(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    UserDto userDto = new UserDto();
                    userDto.setId(Integer.valueOf(paramString));
                    userDto.setModifyUserId(super.getUserId());
                    userDto.setModifyTime(new Date());
                    userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_OFF);
                    customerService.updateCustomerForStatus(userDto);
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量禁用买家用户状态成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "批量禁用买家用户状态失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量启用买家用户状态)
     * @param param
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/batchEnabledUserStatus")
    @ResponseBody
    public MsgBean batchEnabledUserStatus(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    UserDto userDto = new UserDto();
                    userDto.setId(Integer.valueOf(paramString));
                    userDto.setModifyUserId(super.getUserId());
                    userDto.setModifyTime(new Date());
                    userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
                    customerService.updateCustomerForStatus(userDto);
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量启用买家用户状态成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "批量启用买家用户状态失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据用户ID查询买家用户详情信息)
     * @param query
     * @return UserDto
     */
    @RequestMapping(value = "/{id}/loadBuyerUserById")
    @ResponseBody
    public MsgBean loadBuyerUserById(@PathVariable("id") Integer id) {
        try {
            UserDto userDto = userService.loadBuyerUserById(id);
            logger.info("UserDto : " + JsonUtils.toJsonStringWithDateFormat(userDto));
            return super.encapsulateMsgBean(userDto, MsgBean.MsgCode.SUCCESS, "查询用户详细信息成功");
        } catch (Exception e) {
            logger.error("查询用户详细信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出买家用户数据列表)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/exportBuyerUser")
    @ResponseBody
    public MsgBean exportBuyerUser(@RequestBody UserQuery query) {
        try {
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            query.setOrder("A.CREATETIME");
            query.setSort(CommonConstants.SORT_ORDER_DESC);
            if (!StringUtils.isEmpty(query.getStartCreateTime())) {
                query.setStartCreateDate(DateUtils.getSpecificStartDate(query.getStartCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getEndCreateTime())) {
                query.setEndCreateDate(DateUtils.getSpecificEndDate(query.getEndCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getStartVipCreateTime())) {
                query.setStartVipCreateDate(DateUtils.getSpecificStartDate(query.getStartVipCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getEndVipCreateTime())) {
                query.setEndVipCreateDate(DateUtils.getSpecificEndDate(query.getEndVipCreateTime()));
            }
            if (!StringUtils.isEmpty(query.getStartVipExpireTime())) {
                query.setStartVipExpireDate(DateUtils.getSpecificStartDate(query.getStartVipExpireTime()));
            }
            if (!StringUtils.isEmpty(query.getEndVipExpireTime())) {
                query.setEndVipExpireDate(DateUtils.getSpecificEndDate(query.getEndVipExpireTime()));
            }
            ReportFileModel reportFileModel = buyerUserReportExport.exportExcel(query, "买家用户统计报表");
            logger.info("exportSellerAccount : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "买家用户统计报表导出成功");
        } catch (Exception e) {
            logger.error("买家用户统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /***接单员begin***/
    
    /**
     * 店鋪子賬號列表
     * 
     * @param storeCode
     * 				店鋪編號
     * @param storeName
     * 				店鋪名稱
     * @param status
     * 				店鋪狀態
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/childAccount/getChildAccountList")
    public MsgBean getChildAccountList(@RequestBody UserQuery userDtoQuery){
    	try {
			if(!StringUtils.isEmpty(userDtoQuery.getStoreCode())){
				userDtoQuery.setStoreCode(userDtoQuery.getStoreCode().trim());
			}
			if(!StringUtils.isEmpty(userDtoQuery.getStoreName())){
				userDtoQuery.setStoreName(userDtoQuery.getStoreName().trim());
			}
			if(!ObjectUtils.isNullOrEmpty(userDtoQuery.getStoreId())){
				userDtoQuery.setCustomerId(userDtoQuery.getStoreId());
			}
			YiLiDiPage<UserDto> page = userService.getChildAccountList(userDtoQuery);
			return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "获取子账号列表成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "获取子账号列表异常");
		}
    	
    }
    
    /**
     * 根据用户id获取子账号
     * 
     * @param id
     * 			用户id
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/{id}/childAccount/getChildAccountById")
    public MsgBean getChildAccountById(@PathVariable("id") Integer id){
    	try {
			if(ObjectUtils.isNullOrEmpty(id)){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请求有误");
			}
			UserDto userDto = userService.loadUserById(id);
			if(!ObjectUtils.isNullOrEmpty(userDto)){
				return super.encapsulateMsgBean(userDto, MsgBean.MsgCode.SUCCESS, "获取子账号列表成功");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "子账号数据有误");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "根据id获取子账号异常");
		}
    }
    
    /**
     * 添加子账号
     * 
     * @param customerId	
     * 				用户标识
     * @param realName
     * 				接单员姓名
     * @param phone
     * 				接单员手机号		
     * 		
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/childAccount/addChildAccount")
    public MsgBean addChildAccount(@RequestBody UserDto userDto){
    	try {
			if(ObjectUtils.isNullOrEmpty(userDto.getCustomerId())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择门店");
			}
			if(StringUtils.isEmpty(userDto.getRealName())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员姓名不能为空");
			}
			if(StringUtils.isEmpty(userDto.getPhone())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员手机号不能为空");
			}
			if(userService.checkUserNameIsExist(userDto.getPhone(), SystemContext.UserDomain.CUSTOMERTYPE_SELLER)){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员手机号已存在");
			}
			userDto.setUserName(userDto.getPhone());
			userDto.setPassword(EncryptUtils.md5Crypt("888888").toUpperCase());
			userDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_SUB);
			userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			userDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
			userDto.setRegisterPlatform(SystemContext.UserDomain.CHANNELTYPE_WEB);
			userDto.setCreateUserId(this.getUserId());
			userDto.setCreateTime(new Date());
			userDto.setAuditUserId(this.getUserId());
			userDto.setAuditTime(new Date());
			userDto.setModifyUserId(this.getUserId());
			userDto.setModifyTime(new Date());
			if(SystemContext.UserDomain.USERSTATUS_OFF.equals(userDto.getStatusCode())){
				userDto.setFreezeTime(new Date());
			}
			userService.saveUser(userDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "子账号创建成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "创建子账号异常");
		}
    }
    
    /**
     * 修改子账号
     * 
     * @param customerId	
     * 				用户标识
     * @param realName
     * 				接单员姓名
     * @param phone
     * 				接单员手机号		
     * 		
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/childAccount/updateChildAccount")
    public MsgBean updateChildAccount(@RequestBody UserDto userDto){
    	try {
    		if(ObjectUtils.isNullOrEmpty(userDto.getId())){
    			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误");
    		}
    		UserDto userDtoCheck = userService.loadUserById(userDto.getId());
			if(ObjectUtils.isNullOrEmpty(userDtoCheck)){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误,用户对象不存在");
			}
			if(ObjectUtils.isNullOrEmpty(userDto.getCustomerId())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请选择门店");
			}
			if(StringUtils.isEmpty(userDto.getRealName())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员姓名不能为空");
			}
			if(StringUtils.isEmpty(userDto.getPhone())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员手机号不能为空");
			}
			if(!userDto.getPhone().equals(userDtoCheck.getUserName())){
				if(userService.checkUserNameIsExist(userDto.getPhone(), SystemContext.UserDomain.CUSTOMERTYPE_SELLER)){
					return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "接单员手机号已存在");
				}
			}
			userDto.setUserName(userDto.getPhone());
			userDto.setModifyUserId(this.getUserId());
			userDto.setModifyTime(new Date());
			if(SystemContext.UserDomain.USERSTATUS_OFF.equals(userDto.getStatusCode())){
				userDto.setFreezeTime(new Date());
			}
			userService.updateUser(userDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "子账号修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "子账号修改异常");
		}
    }
    
    /**
     * 重置子账号密码
     * 
     * @param Id	
     * 			用户表id
     * @param realName
     * 				接单员姓名
     * @param phone
     * 				接单员手机号		
     * 		
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/{id}/childAccount/updateUserPassword")
    public MsgBean updateUserPassword(@PathVariable("id") Integer id){
    	try {
    		if(ObjectUtils.isNullOrEmpty(id)){
    			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误");
    		}
			userService.updateUserPassword(id);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "密码重置成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "密码重置异常");
		}
    }
    
    
    /**
     * 冻结子账号
     * 
     * @param Id	
     * 			用户表id
     * @param realName
     * 				接单员姓名
     * @param phone
     * 				接单员手机号		
     * 		
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/{id}/{statusCode}/childAccount/updateUserStatusCode")
    public MsgBean updateUserStatusCode(@PathVariable("id") Integer id,@PathVariable("statusCode")String statusCode){
    	try {
    		if(ObjectUtils.isNullOrEmpty(id)){
    			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误");
    		}
    		if(StringUtils.isEmpty(statusCode)){
    			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误");
    		}
    		UserDto userDto = new UserDto();
            userDto.setId(id);
            userDto.setModifyUserId(super.getUserId());
            userDto.setModifyTime(new Date());
            userDto.setStatusCode(statusCode);
            customerService.updateCustomerForStatus(userDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "操作失败");
		}
    }
    
    /**
     * 获取子账号订单列表
     * 
     * @param id	
     * 			子账号id
     * @param saleOrderNo
     * 				订单号
     * @param statusCode
     * 				订单状态		
     * @param beginTime
     * 				订单处理开始时间
     * @param endTime		
     * 				订单处理结束时间
     * @return 
     * 		MsgBean
     */
    @ResponseBody
    @RequestMapping(value="/{acceptUserId}/childAccount/getChildAccountOrder")
    public MsgBean getChildAccountOrder(@PathVariable("acceptUserId") Integer acceptUserId,@RequestBody SaleOrderQueryDto saleOrderQueryDto){
    	if(ObjectUtils.isNullOrEmpty(acceptUserId)){
    		return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "请求有误");
    	}
    	saleOrderQueryDto.setAcceptUserId(acceptUserId);
    	if(!StringUtils.isEmpty(saleOrderQueryDto.getSaleOrderNo())){
    		saleOrderQueryDto.setSaleOrderNo(saleOrderQueryDto.getSaleOrderNo().trim());
    	}
    	try {
			if(!StringUtils.isEmpty(saleOrderQueryDto.getStatusCode())){
				if(!StringUtils.isEmpty(saleOrderQueryDto.getStrBeginTime())){
					saleOrderQueryDto.setBeginTime(DateUtils.getSpecificStartDate(saleOrderQueryDto.getStrBeginTime()));
				}
				if(!StringUtils.isEmpty(saleOrderQueryDto.getStrEndTime())){
					saleOrderQueryDto.setEndTime(DateUtils.getSpecificEndDate(saleOrderQueryDto.getStrEndTime()));
				}
			}else{
				saleOrderQueryDto.setBeginTime(null);
				saleOrderQueryDto.setEndTime(null);
			}
			YiLiDiPage<SaleOrderDto> page = orderService.getChildAccountOrder(saleOrderQueryDto);
			return super.encapsulateMsgBean(page,MsgBean.MsgCode.SUCCESS, "获取子账号订单列表成功");
		} catch (ParseException e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "获取子账号订单列表失败");
		}
    }
    
    /***接单员end***/
}