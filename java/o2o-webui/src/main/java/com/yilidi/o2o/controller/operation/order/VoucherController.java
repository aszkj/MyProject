package com.yilidi.o2o.controller.operation.order;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
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
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherPackageDto;
import com.yilidi.o2o.order.service.dto.query.UserVoucherQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherQueryDto;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;

/**
 * 抵用劵管理Controller
 * 
 * @author: chenlian
 * @date: 2016年10月20日 上午11:25:53
 */
@Controller
@RequestMapping(value = "/operation")
public class VoucherController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IVoucherService voucherService;

    @Autowired
    private IProductClassService productClassService;

    @Autowired
    private IProductService productService;

    /**
     * 查询抵用劵包列表
     * 
     * @param voucherPackageQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchVoucherPackages")
    @ResponseBody
    public MsgBean searchVoucherPackages(@RequestBody VoucherPackageQueryDto voucherPackageQueryDto) {
        try {
            if (!StringUtils.isEmpty(voucherPackageQueryDto.getStartCreateTime())) {
                voucherPackageQueryDto.setStartCreateDate(DateUtils.getSpecificStartDate(voucherPackageQueryDto
                        .getStartCreateTime()));
            }
            if (!StringUtils.isEmpty(voucherPackageQueryDto.getEndCreateTime())) {
                voucherPackageQueryDto.setEndCreateDate(DateUtils.getSpecificEndDate(voucherPackageQueryDto
                        .getEndCreateTime()));
            }
            YiLiDiPage<VoucherPackageDto> yiLiDiPage = voucherService.findVoucherPackages(voucherPackageQueryDto);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询抵用劵列表成功");
        } catch (Exception e) {
            logger.error("查询抵用劵包列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 查询抵用劵包详情
     * 
     * @param id
     *            抵用劵包ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/getVoucherPackageDetail")
    @ResponseBody
    public MsgBean getVoucherPackageDetail(@PathVariable Integer id) {
        try {
            VoucherPackageDto voucherPackageDto = voucherService.loadVoucherPackageById(id);
            return super.encapsulateMsgBean(voucherPackageDto, MsgBean.MsgCode.SUCCESS, "获取抵用劵包详情信息成功");
        } catch (Exception e) {
            logger.error("获取抵用劵包详情失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改抵用劵包
     * 
     * @param voucherPackageDto
     *            抵用劵包DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateVoucherPackage")
    @ResponseBody
    public MsgBean updateVoucherPackage(@RequestBody VoucherPackageDto voucherPackageDto) {
        try {
            if (voucherPackageDto == null) {
                throw new IllegalArgumentException("无法获取需新增的抵用劵包DTO");
            }
            Integer voucherPackageId = voucherPackageDto.getId();
            if (null == voucherPackageId) {
                throw new IllegalArgumentException("无法获取需修改的抵用劵包ID");
            }
            Param vouName = new Param.Builder("劵包名称", Param.ParamType.STR_NORMAL.getType(), voucherPackageDto.getVouName(),
                    false).build();
            Param amount = new Param.Builder("抵用金额", Param.ParamType.STR_NORMAL.getType(), voucherPackageDto.getAmount(),
                    false).build();
            Param vouPackType = new Param.Builder("抵用券包类型", Param.ParamType.STR_NORMAL.getType(),
                    voucherPackageDto.getVouPackType(), false).build();
            Param vouPackContent = new Param.Builder("抵用券包内容", Param.ParamType.STR_NORMAL.getType(),
                    voucherPackageDto.getVouPackContent(), false).build();
            super.validateParams(vouName, amount, vouPackType, vouPackContent);
            voucherService.updateVoucherPackage(voucherPackageDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改抵用劵包成功");
        } catch (Exception e) {
            logger.error("修改抵用劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增抵用劵包
     * 
     * @param voucherPackageDto
     *            抵用劵包DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createVoucherPackage")
    @ResponseBody
    public MsgBean createVoucherPackage(@RequestBody VoucherPackageDto voucherPackageDto) {
        try {
            if (voucherPackageDto == null) {
                throw new IllegalArgumentException("无法获取需新增的抵用劵包DTO");
            }
            Param vouName = new Param.Builder("劵包名称", Param.ParamType.STR_NORMAL.getType(), voucherPackageDto.getVouName(),
                    false).build();
            Param amount = new Param.Builder("抵用金额", Param.ParamType.STR_NORMAL.getType(), voucherPackageDto.getAmount(),
                    false).build();
            Param vouPackType = new Param.Builder("抵用券包类型", Param.ParamType.STR_NORMAL.getType(),
                    voucherPackageDto.getVouPackType(), false).build();
            Param vouPackContent = new Param.Builder("抵用券包内容", Param.ParamType.STR_NORMAL.getType(),
                    voucherPackageDto.getVouPackContent(), false).build();
            super.validateParams(vouName, amount, vouPackType, vouPackContent);
            voucherPackageDto.setState(SystemContext.OrderDomain.VOUCHERSTATE_NOGRANT);
            voucherPackageDto.setCreateTime(new Date());
            voucherPackageDto.setCreateUserId(super.getUserId());
            voucherService.saveVoucherPackage(voucherPackageDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增抵用劵包成功");
        } catch (Exception e) {
            logger.error("新增抵用劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 停用抵用劵包
     * 
     * @param id
     *            抵用劵包ID
     * @param state
     *            抵用劵包状态
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{state}/updateVoucherPackageState")
    @ResponseBody
    public MsgBean updateVoucherPackageState(@PathVariable("id") Integer id, @PathVariable("state") Integer state) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取需停用的抵用劵包ID");
            }
            if (!ObjectUtils.isNullOrEmpty(state) && state == 1) {
                voucherService.updateVoucherPackageStateById(id, SystemContext.OrderDomain.VOUCHERSTATE_DISABLE,
                        super.getUserId(), DateUtils.getCurrentDateTime());
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "停用抵用劵包成功");
        } catch (Exception e) {
            logger.error("停用抵用劵包失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 发放抵用劵
     * 
     * @param voucherDto
     *            发放抵用劵
     * @return MsgBean
     */
    @RequestMapping(value = "/grantVoucher")
    @ResponseBody
    public MsgBean grantVoucher(@RequestBody VoucherDto voucherDto) {
        try {
            if (voucherDto == null) {
                throw new IllegalArgumentException("无法获取需发放的抵用劵DTO");
            }
            Integer vouPackId = voucherDto.getVouPackId();
            if (ObjectUtils.isNullOrEmpty(vouPackId)) {
                throw new IllegalArgumentException("无法获取需发放的抵用劵包ID");
            }
            voucherDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            voucherDto.setGrantUserId(super.getUserId());
            voucherDto.setGrantTime(DateUtils.getCurrentDateTime());
            voucherService.saveForGrantVouchers(voucherDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "发放抵用劵成功");
        } catch (Exception e) {
            logger.error("发放抵用劵失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 分页查询抵用券发放记录
     * 
     * @param voucherDto
     *            发放抵用劵
     * @return MsgBean
     */
    @RequestMapping(value = "/searchVoucherRecord")
    @ResponseBody
    public MsgBean searchVoucherRecord(@RequestBody VoucherQueryDto voucherQueryDto){
    	try {
			if(voucherQueryDto.getVouPackId() == null){
				throw new IllegalArgumentException("无法获取需发放的抵用劵包ID");
			}
			if(!ObjectUtils.isNullOrEmpty(voucherQueryDto.getRule())){
				voucherQueryDto.setRule(voucherQueryDto.getRule().trim());	
			}
			if(!ObjectUtils.isNullOrEmpty(voucherQueryDto.getStrGranBeginTime())){
				voucherQueryDto.setGranBeginTime(DateUtils.getSpecificStartDate(voucherQueryDto.getStrGranBeginTime()));
			}
			if(!ObjectUtils.isNullOrEmpty(voucherQueryDto.getStrGranEndTime())){
				voucherQueryDto.setGranEndTime(DateUtils.getSpecificEndDate(voucherQueryDto.getStrGranEndTime()));
			}
			 YiLiDiPage<VoucherDto> page = voucherService.searchVoucherRecord(voucherQueryDto);
			 return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取抵用劵发放记录列表成功");
		} catch (ParseException e) {
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分页获取抵用劵发放记录列表失敗");
		}
    }

    /**
     * 分页获取用户抵用劵使用记录列表
     * 
     * @param userVoucherQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchUserVouchers")
    @ResponseBody
    public MsgBean searchUserVouchers(@RequestBody UserVoucherQueryDto userVoucherQueryDto) {
        try {
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrStartUseTime())) {
                userVoucherQueryDto
                        .setStartUseTime(DateUtils.getSpecificStartDate(userVoucherQueryDto.getStrStartUseTime()));
            }
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrEndUseTime())) {
                userVoucherQueryDto.setEndUseTime(DateUtils.getSpecificEndDate(userVoucherQueryDto.getStrEndUseTime()));
            }
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrStartGrantTime())) {
                userVoucherQueryDto.setStartGrantTime(DateUtils.getSpecificStartDate(userVoucherQueryDto
                        .getStrStartGrantTime()));
            }
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrEndGrantTime())) {
                userVoucherQueryDto.setEndGrantTime(DateUtils.getSpecificEndDate(userVoucherQueryDto.getStrEndGrantTime()));
            }
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrStartValidTime())) {
                userVoucherQueryDto.setStartValidTime(DateUtils.getSpecificStartDate(userVoucherQueryDto
                        .getStrStartValidTime()));
            }
            if (!StringUtils.isEmpty(userVoucherQueryDto.getStrEndValidTime())) {
                userVoucherQueryDto.setEndValidTime(DateUtils.getSpecificEndDate(userVoucherQueryDto.getStrEndValidTime()));
            }
            YiLiDiPage<UserVoucherInfoDto> yiLiDiPage = voucherService.findUserVouchers(userVoucherQueryDto);
            if (!ObjectUtils.isNullOrEmpty(yiLiDiPage) && !ObjectUtils.isNullOrEmpty(yiLiDiPage.getResultList())) {
                List<UserVoucherInfoDto> userVoucherInfoDtoList = yiLiDiPage.getResultList();
                for (UserVoucherInfoDto userVoucherInfoDto : userVoucherInfoDtoList) {
                    Long orderAmountLimit = userVoucherInfoDto.getOrderAmountLimit();
                    String productClassLimit = userVoucherInfoDto.getProductClassLimit();
                    String businessRuleLimit = userVoucherInfoDto.getBusinessRuleLimit();
                    String productLimit = userVoucherInfoDto.getProductLimit();
                    String limitRangeName = "";
                    String limitRangeDetails = "";
                    if (!ObjectUtils.isNullOrEmpty(orderAmountLimit) && orderAmountLimit.longValue() != 0L) {
                        limitRangeName += "订单金额限制" + "，";
                        limitRangeDetails += "订单金额限制：订单满" + ArithUtils.convertToYuanStr(orderAmountLimit) + "元使用" + "_";
                    }
                    if (!StringUtils.isEmpty(productClassLimit)) {
                        limitRangeName += "产品品类限制" + "，";
                        if (productClassLimit.contains(",")) {
                            String productClassLimitName = "";
                            StringTokenizer st = new StringTokenizer(productClassLimit, ",");
                            while (st.hasMoreTokens()) {
                                String classCode = st.nextToken();
                                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(classCode,
                                        null);
                                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                                    productClassLimitName += productClassDto.getClassName() + "，";
                                }
                            }
                            if (productClassLimitName.endsWith("，")) {
                                productClassLimitName = productClassLimitName.substring(0,
                                        productClassLimitName.length() - 1);
                            }
                            limitRangeDetails += "产品品类限制：" + productClassLimitName + "无法使用" + "_";
                        } else {
                            ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(
                                    productClassLimit, null);
                            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                                limitRangeDetails += "产品品类限制：" + productClassDto.getClassName() + "无法使用" + "_";
                            }
                        }
                    }
                    if (!StringUtils.isEmpty(businessRuleLimit)) {
                        limitRangeName += "业务规则限制" + "，";
                        if (businessRuleLimit.contains(",")) {
                            String businessRuleLimitName = "";
                            StringTokenizer st = new StringTokenizer(businessRuleLimit, ",");
                            while (st.hasMoreTokens()) {
                                String productLabel = st.nextToken();
                                String systemDictName = systemBasicDataInfoUtils.getSystemDictName(
                                        SystemContext.OrderDomain.DictType.PRODUCTLABEL.getValue(), productLabel);
                                if (!StringUtils.isEmpty(systemDictName)) {
                                    businessRuleLimitName += systemDictName + "，";
                                }
                            }
                            if (businessRuleLimitName.endsWith("，")) {
                                businessRuleLimitName = businessRuleLimitName.substring(0,
                                        businessRuleLimitName.length() - 1);
                            }
                            limitRangeDetails += "业务规则限制：" + businessRuleLimitName + "_";
                        } else {
                            String systemDictName = systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.OrderDomain.DictType.PRODUCTLABEL.getValue(), businessRuleLimit);
                            if (!StringUtils.isEmpty(systemDictName)) {
                                limitRangeDetails += "业务规则限制：" + systemDictName + "_";
                            }
                        }
                    }
                    if (!StringUtils.isEmpty(productLimit)) {
                        if (productLimit.contains(",")) {
                            String productLimitName = "";
                            StringTokenizer st = new StringTokenizer(productLimit, ",");
                            while (st.hasMoreTokens()) {
                                String strProductId = st.nextToken();
                                ProductDto productDto = productService.loadProductByProductIdAndChannelCode(
                                        Integer.parseInt(strProductId), null);
                                if (!ObjectUtils.isNullOrEmpty(productDto)) {
                                    productLimitName += productDto.getProductName() + "，";
                                }
                            }
                            if (productLimitName.endsWith("，")) {
                                productLimitName = productLimitName.substring(0, productLimitName.length() - 1);
                            }
                            limitRangeDetails += "特殊商品限制：" + productLimitName + "无法使用" + "_";
                        } else {
                            ProductDto productDto = productService.loadProductByProductIdAndChannelCode(
                                    Integer.parseInt(productLimit), null);
                            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                                limitRangeDetails += "特殊商品限制：" + productDto.getProductName() + "无法使用" + "_";
                            }
                        }
                    }
                    if (!StringUtils.isEmpty(limitRangeName)) {
                        limitRangeName = limitRangeName.substring(0, limitRangeName.length() - 1);
                        userVoucherInfoDto.setLimitRangeName(limitRangeName);
                    }
                    if (!StringUtils.isEmpty(limitRangeDetails)) {
                        limitRangeDetails = limitRangeDetails.substring(0, limitRangeDetails.length() - 1);
                        userVoucherInfoDto.setLimitRangeDetails(limitRangeDetails);
                    }
                }
            }
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "分页获取用户抵用劵使用记录列表成功");
        } catch (Exception e) {
            logger.error("分页获取用户抵用劵使用记录列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 获取抵用券发放记录
     * 
     * @param vouPackId
     *            券包id
     * @param batchNo
     * 			  批次号
     * @return MsgBean
     */
    @RequestMapping(value = "/{vouPackId}/{batchNo}/getVoucherGrantRecord")
    @ResponseBody
    public MsgBean getVoucherGrantRecord(@PathVariable("vouPackId") Integer vouPackId,@PathVariable("batchNo")String batchNo){
    	try {
			if(vouPackId==null && StringUtils.isEmpty(batchNo)){
				throw new IllegalArgumentException("抵用券信息有误");
			}
			VoucherDto voucherDto = voucherService.getVoucherGrantRecord(vouPackId,batchNo);
			return encapsulateMsgBean(voucherDto,MsgBean.MsgCode.SUCCESS, "获取抵用券发放记录成功");
		} catch (Exception e) {
			e.printStackTrace();
			return encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "获取抵用券发放记录成功");
		}
    }
    
    /**
     * 抵用券券包
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listAvailableVoucherPackage")
    @ResponseBody
    public MsgBean listAvailableVoucherPackage(){
    	try {
			List<VoucherPackageDto> voucherPackageDtoList = voucherService.listAvailableVoucherPackage();
			return encapsulateMsgBean(voucherPackageDtoList,MsgBean.MsgCode.SUCCESS, "");
		} catch (Exception e) {
			e.printStackTrace();
			return encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "获取抵用券券包失败");
		}
    }

}
