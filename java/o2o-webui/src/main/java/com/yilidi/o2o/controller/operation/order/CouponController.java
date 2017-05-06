package com.yilidi.o2o.controller.operation.order;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.dto.CouponBasicInfoDto;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.query.CouponPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.CouponQueryDto;
import com.yilidi.o2o.order.service.dto.query.UserCouponQueryDto;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.system.service.IMessageService;

/**
 * 优惠劵管理Controller
 * 
 * @author: chenlian
 * @date: 2016年10月20日 上午11:25:53
 */
@Controller
@RequestMapping(value = "/operation")
public class CouponController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ICouponService couponService;

    @Autowired
    private IProductClassService productClassService;

    @Autowired
    private IProductService productService;
    
    @Autowired
    private IMessageService messageService;
    

    /**
     * 查询优惠劵包列表
     * 
     * @param couponPackageQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchCouponPackages")
    @ResponseBody
    public MsgBean searchCouponPackages(@RequestBody CouponPackageQueryDto couponPackageQueryDto) {
        try {
            if (!StringUtils.isEmpty(couponPackageQueryDto.getStartCreateTime())) {
                couponPackageQueryDto
                        .setStartCreateDate(DateUtils.getSpecificStartDate(couponPackageQueryDto.getStartCreateTime()));
            }
            if (!StringUtils.isEmpty(couponPackageQueryDto.getEndCreateTime())) {
                couponPackageQueryDto
                        .setEndCreateDate(DateUtils.getSpecificEndDate(couponPackageQueryDto.getEndCreateTime()));
            }
            YiLiDiPage<CouponPackageDto> yiLiDiPage = couponService.findCouponPackages(couponPackageQueryDto);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询优惠劵列表成功");
        } catch (Exception e) {
            logger.error("查询优惠劵包列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 查询优惠劵包详情
     * 
     * @param id
     *            优惠劵包ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/getCouponPackageDetail")
    @ResponseBody
    public MsgBean getCouponPackageDetail(@PathVariable Integer id) {
        try {
            CouponPackageDto couponPackageDto = couponService.loadCouponPackageById(id);
            return super.encapsulateMsgBean(couponPackageDto, MsgBean.MsgCode.SUCCESS, "获取优惠劵包详情信息成功");
        } catch (Exception e) {
            logger.error("获取优惠劵包详情失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改优惠劵包
     * 
     * @param couponPackageDto
     *            优惠劵包DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateCouponPackage")
    @ResponseBody
    public MsgBean updateCouponPackage(@RequestBody CouponPackageDto couponPackageDto) {
        try {
            if (couponPackageDto == null) {
                throw new IllegalArgumentException("无法获取需新增的优惠劵包DTO");
            }
            Integer couponPackageId = couponPackageDto.getId();
            if (null == couponPackageId) {
                throw new IllegalArgumentException("无法获取需修改的优惠劵包ID");
            }
            Param conName = new Param.Builder("劵包名称", Param.ParamType.STR_NORMAL.getType(), couponPackageDto.getConName(),
                    false).build();
            Param amount = new Param.Builder("优惠金额", Param.ParamType.STR_NORMAL.getType(), couponPackageDto.getAmount(),
                    false).build();
            Param useCondition = new Param.Builder("订单金额", Param.ParamType.STR_NORMAL.getType(),
                    couponPackageDto.getUseCondition(), false).build();
            super.validateParams(conName, amount, useCondition);
            couponService.updateCouponPackage(couponPackageDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改优惠劵包成功");
        } catch (Exception e) {
            logger.error("修改优惠劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增优惠劵包
     * 
     * @param couponPackageDto
     *            优惠劵包DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createCouponPackage")
    @ResponseBody
    public MsgBean createCouponPackage(@RequestBody CouponPackageDto couponPackageDto) {
        try {
            if (couponPackageDto == null) {
                throw new IllegalArgumentException("无法获取需新增的优惠劵包DTO");
            }
            Param conName = new Param.Builder("劵包名称", Param.ParamType.STR_NORMAL.getType(), couponPackageDto.getConName(),
                    false).build();
            Param amount = new Param.Builder("优惠金额", Param.ParamType.STR_NORMAL.getType(), couponPackageDto.getAmount(),
                    false).build();
            Param useCondition = new Param.Builder("订单金额", Param.ParamType.STR_NORMAL.getType(),
                    couponPackageDto.getUseCondition(), false).build();
            super.validateParams(conName, amount, useCondition);
            couponPackageDto.setState(SystemContext.OrderDomain.COUPONSSTATE_NOGRANT);
            couponPackageDto.setCreateTime(new Date());
            couponPackageDto.setCreateUserId(super.getUserId());
            couponService.saveCouponPackage(couponPackageDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增优惠劵包成功");
        } catch (Exception e) {
            logger.error("新增优惠劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 停用优惠劵包
     * 
     * @param id
     *            优惠劵包ID
     * @param state
     *            优惠劵包状态
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{state}/updateCouponPackageState")
    @ResponseBody
    public MsgBean updateCouponPackageState(@PathVariable("id") Integer id, @PathVariable("state") Integer state) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取需停用的优惠劵包ID");
            }
            if (!ObjectUtils.isNullOrEmpty(state) && state == 1) {
                couponService.updateCouponPackageStateById(id, SystemContext.OrderDomain.COUPONSSTATE_DISABLE,
                        super.getUserId(), DateUtils.getCurrentDateTime());
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "停用优惠劵包成功");
        } catch (Exception e) {
            logger.error("停用优惠劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 发放优惠劵
     * 
     * @param couponDto
     *            发放优惠劵
     * @return MsgBean
     */
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/grantCoupon")
    @ResponseBody
    public MsgBean grantCoupon(@RequestBody CouponDto couponDto) {
        try {
            if (couponDto == null) {
                throw new IllegalArgumentException("无法获取需发放的优惠劵DTO");
            }
            Integer conPackId = couponDto.getConPackId();
            if (ObjectUtils.isNullOrEmpty(conPackId)) {
                throw new IllegalArgumentException("无法获取需发放的优惠劵包ID");
            }
            couponDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            couponDto.setGrantUserId(super.getUserId());
            couponDto.setGrantTime(DateUtils.getCurrentDateTime());
            Map<String, Object> map = couponService.saveForGrantCoupons(couponDto);
            if(!ObjectUtils.isNullOrEmpty(map)){
            	if((boolean)map.get("flag")){
					//可以推送消息
	        		List<Integer> userIdList = (List<Integer>)map.get("userIdList");
	        		Integer couponNum = (Integer)map.get("couponNum");
	        		Long couponPrice = (Long)map.get("couponPrice")/1000;
	        		String messageTitle = "您获得"+ couponNum +"张"+ couponPrice +"元优惠券";
	        		String messageIntro = "亲爱的用户,恭喜您获得了"+ couponNum +"张"+ couponPrice +"元优惠券";
	        		String grantRange = map.get("grantRange").toString();
	        		String publishObject = "";
	        		if(grantRange.equals(SystemContext.OrderDomain.COUPONSGRANTRANGE_BATCH)){
	        			publishObject = (SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_ALL);
	        		}else if(grantRange.toString().equals(SystemContext.OrderDomain.COUPONSGRANTRANGE_SINGLE)){
	        			publishObject = (SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL);
	        		}
	        		messageService.sendPreferenceMessage(super.getUserId(), userIdList, messageTitle, messageIntro,publishObject);
         		}
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "发放优惠劵成功");
        } catch (Exception e) {
            logger.error("发放优惠劵失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 分页获取优惠劵发放记录列表
     * 
     * @param userCouponQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchGrantRecord")
    @ResponseBody
    public MsgBean searchGrantRecord(@RequestBody CouponQueryDto couponQueryDto){
    	try {
    		if(couponQueryDto.getConPackId() == null){
    			 throw new IllegalArgumentException("无法获取需发放的优惠劵包ID");
    		}
			if(!StringUtils.isEmpty(couponQueryDto.getStrBeginTime())){
				couponQueryDto.setBeginTime(DateUtils.getSpecificStartDate(couponQueryDto.getStrBeginTime()));
			}
			if(!StringUtils.isEmpty(couponQueryDto.getStrEndTime())){
				couponQueryDto.setEndTime(DateUtils.getSpecificEndDate(couponQueryDto.getStrEndTime()));
			}
			if(!StringUtils.isEmpty(couponQueryDto.getRule())){
				couponQueryDto.setRule(couponQueryDto.getRule().trim());
			}
			YiLiDiPage<CouponDto> page = couponService.searchGrantRecord(couponQueryDto);
			return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取优惠劵发放记录列表成功");
		} catch (ParseException e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分页获取优惠劵发放记录列表失败");
		}
    	
    }

    /**
     * 获取优惠券发放记录
     * 
     * @param vouPackId
     *            券包id
     * @param batchNo
     * 			  批次号
     * @return MsgBean
     */
    @RequestMapping(value = "/{conPackId}/{batchNo}/getCouponGrantRecord")
    @ResponseBody
    public MsgBean getCouponGrantRecord(@PathVariable("conPackId") Integer conPackId,@PathVariable("batchNo")String batchNo){
    	try {
			if(conPackId==null && StringUtils.isEmpty(batchNo)){
				throw new IllegalArgumentException("优惠券信息有误");
			}
			CouponDto couponDto = couponService.getCouponGrantRecord(conPackId,batchNo);
			return encapsulateMsgBean(couponDto,MsgBean.MsgCode.SUCCESS, "获取优惠券发放记录成功");
		} catch (Exception e) {
			e.printStackTrace();
			return encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "获取优惠券发放记录成功");
		}
    }

    /**
     * 分页获取用户优惠劵使用记录列表
     * 
     * @param userCouponQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchUserCoupons")
    @ResponseBody
    public MsgBean searchUserCoupons(@RequestBody UserCouponQueryDto userCouponQueryDto) {
        try {
        	if(userCouponQueryDto.getConPackId() == null || StringUtils.isEmpty(userCouponQueryDto.getBatchNo())){
        		throw new IllegalArgumentException("优惠劵包数据有误");
        	}
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrStartUseTime())) {
                userCouponQueryDto.setStartUseTime(DateUtils.getSpecificStartDate(userCouponQueryDto.getStrStartUseTime()));
            }
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrEndUseTime())) {
                userCouponQueryDto.setEndUseTime(DateUtils.getSpecificEndDate(userCouponQueryDto.getStrEndUseTime()));
            }
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrStartGrantTime())) {
                userCouponQueryDto
                        .setStartGrantTime(DateUtils.getSpecificStartDate(userCouponQueryDto.getStrStartGrantTime()));
            }
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrEndGrantTime())) {
                userCouponQueryDto.setEndGrantTime(DateUtils.getSpecificEndDate(userCouponQueryDto.getStrEndGrantTime()));
            }
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrStartValidTime())) {
                userCouponQueryDto
                        .setStartValidTime(DateUtils.getSpecificStartDate(userCouponQueryDto.getStrStartValidTime()));
            }
            if (!StringUtils.isEmpty(userCouponQueryDto.getStrEndValidTime())) {
                userCouponQueryDto.setEndValidTime(DateUtils.getSpecificEndDate(userCouponQueryDto.getStrEndValidTime()));
            }
            YiLiDiPage<UserCouponInfoDto> yiLiDiPage = couponService.findUserCoupons(userCouponQueryDto);
            if (!ObjectUtils.isNullOrEmpty(yiLiDiPage) && !ObjectUtils.isNullOrEmpty(yiLiDiPage.getResultList())) {
                List<UserCouponInfoDto> userCouponInfoDtoList = yiLiDiPage.getResultList();
                for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtoList) {
                    String useRange = userCouponInfoDto.getUseRange();
                    if (!StringUtils.isEmpty(useRange)) {
                        if (SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_CLASS
                                .equals(userCouponInfoDto.getUseRangeCode())) {
                            if (useRange.contains(",")) {
                                String useRangeName = "";
                                StringTokenizer st = new StringTokenizer(useRange, ",");
                                while (st.hasMoreTokens()) {
                                    String classCode = st.nextToken();
                                    ProductClassDto productClassDto = productClassService
                                            .loadProductClassByClassCode(classCode, null);
                                    if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                                        useRangeName += productClassDto.getClassName() + ",";
                                    }
                                }
                                if (useRangeName.endsWith(",")) {
                                    useRangeName = useRangeName.substring(0, useRangeName.length() - 1);
                                }
                                userCouponInfoDto.setUseRangeName(useRangeName);
                            } else {
                                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(useRange,
                                        null);
                                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                                    userCouponInfoDto.setUseRangeName(productClassDto.getClassName());
                                }
                            }
                        }
                        if (SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_LABEL
                                .equals(userCouponInfoDto.getUseRangeCode())) {
                            if (useRange.contains(",")) {
                                String useRangeName = "";
                                StringTokenizer st = new StringTokenizer(useRange, ",");
                                while (st.hasMoreTokens()) {
                                    String productLabel = st.nextToken();
                                    String systemDictName = systemBasicDataInfoUtils.getSystemDictName(
                                            SystemContext.OrderDomain.DictType.PRODUCTLABEL.getValue(), productLabel);
                                    if (!StringUtils.isEmpty(systemDictName)) {
                                        useRangeName += systemDictName + ",";
                                    }
                                }
                                if (useRangeName.endsWith(",")) {
                                    useRangeName = useRangeName.substring(0, useRangeName.length() - 1);
                                }
                                userCouponInfoDto.setUseRangeName(useRangeName);
                            } else {
                                String systemDictName = systemBasicDataInfoUtils.getSystemDictName(
                                        SystemContext.OrderDomain.DictType.PRODUCTLABEL.getValue(), useRange);
                                if (!StringUtils.isEmpty(systemDictName)) {
                                    userCouponInfoDto.setUseRangeName(systemDictName);
                                }
                            }
                        }
                        if (SystemContext.OrderDomain.COUPONSUSERANGE_SINGLE_PRODUCT
                                .equals(userCouponInfoDto.getUseRangeCode())) {
                            ProductDto productDto = productService
                                    .loadProductByProductIdAndChannelCode(Integer.parseInt(useRange), null);
                            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                                userCouponInfoDto.setUseRangeName(productDto.getProductName());
                            }
                        }
                    }
                }
            }
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "分页获取用户优惠劵使用记录列表成功");
        } catch (Exception e) {
            logger.error("分页获取用户优惠劵使用记录列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 获取分享活动优惠券列表
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/{conPackId}/listCouponForShareRule")
    @ResponseBody
    public MsgBean listCouponForShareRule(@PathVariable Integer conPackId) {
        try {
            if (conPackId == null) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "券包不能为空");
            }
            List<CouponBasicInfoDto> couponBasicInfoDtoList = couponService.listCouponsForShareRule(conPackId);
            return super.encapsulateMsgBean(couponBasicInfoDtoList, MsgBean.MsgCode.SUCCESS, "获取优惠券列表成功");
        } catch (Exception e) {
            logger.error("获取产品类别列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 优惠券券包列表
     * @return
     */
    @RequestMapping(value = "/{grantWay}/listAvailableCouponPackage")
    @ResponseBody
    public MsgBean listAvailableCouponPackage(@PathVariable("grantWay")String grantWay){
    	try {
			List<CouponPackageDto> couponPackageDtoList = couponService.listAvailableCouponPackage(grantWay);
			return super.encapsulateMsgBean(couponPackageDtoList,MsgBean.MsgCode.SUCCESS,"");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE,e.getMessage());
		}
    }
    
    /**
     * 根据发放方式获取优惠券
     */
    @RequestMapping(value = "/{grantWay}/getCouponByGrantWay")
    @ResponseBody
    public MsgBean getCouponByGrantWay(@PathVariable("grantWay")String grantWay,@RequestBody CouponQueryDto couponQueryDto){
    	if(!StringUtils.isEmpty(grantWay)){
    		couponQueryDto.setGrantWay(grantWay);
    	}
    	try {
			YiLiDiPage<CouponDto> page = couponService.getCouponByGrantWay(couponQueryDto);
			return super.encapsulateMsgBean(page,MsgBean.MsgCode.SUCCESS,"优惠券列表获取成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE,e.getMessage());
		}
    }
}
