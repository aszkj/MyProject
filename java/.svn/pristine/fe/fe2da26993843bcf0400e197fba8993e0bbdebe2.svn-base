package com.yilidi.o2o.controller.mobile.buyer.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appparam.buyer.user.AddUpdateAddressParam;
import com.yilidi.o2o.appparam.buyer.user.AddressDeleteParam;
import com.yilidi.o2o.appparam.buyer.user.AddressDetailParam;
import com.yilidi.o2o.appvo.buyer.user.AddressDetailVO;
import com.yilidi.o2o.appvo.buyer.user.AddressListVO;
import com.yilidi.o2o.appvo.buyer.user.AddressSaveOrUpdateVO;
import com.yilidi.o2o.appvo.buyer.user.CommunitySearchVO;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IConsigneeAddressService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.ConsigneeAddressDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 收货地址接口
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午9:47:59
 */
@Controller
@RequestMapping(value = "/interfaces/buyer")
public class ConsigneeAddressController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IConsigneeAddressService consigneeAddressService;
    @Autowired
    private IStoreProfileService storeProfileService;

    /**
     * 
     * 收货地址列表信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/useraddress/addresslist")
    @ResponseBody
    public ResultParamModel addressList(HttpServletRequest req, HttpServletResponse resp) {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        List<ConsigneeAddressDto> consigneeAddressDtoList = consigneeAddressService
                .listByCustomerId(userSessionModel.getCustomerId());
        List<AddressListVO> addressListVOList = null;
        if (ObjectUtils.isNullOrEmpty(consigneeAddressDtoList)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "收货地址列表信息为空");
        }
        addressListVOList = new ArrayList<AddressListVO>();
        for (int i = 0, size = consigneeAddressDtoList.size(); i < size; i++) {
            ConsigneeAddressDto consigneeAddressDto = consigneeAddressDtoList.get(i);
            AddressListVO addressListVO = new AddressListVO();
            ObjectUtils.fastCopy(consigneeAddressDto, addressListVO);
            CommunitySearchVO communityVo = new CommunitySearchVO();
            ObjectUtils.fastCopy(consigneeAddressDto, communityVo);
            communityVo.setCityName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getCityCode()));
            communityVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getProvinceCode()));
            communityVo.setCountyName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getCountyCode()));
            // 店铺信息
            StoreInfoVO storeInfoVo = null;
            if (null != consigneeAddressDto.getStoreProfileDto()) {
                storeInfoVo = new StoreInfoVO();
                ObjectUtils.fastCopy(consigneeAddressDto.getStoreProfileDto(), storeInfoVo);
                storeInfoVo.setDeduceTransCostAmount(consigneeAddressDto.getStoreProfileDto().getStartSendingPrice());
                storeInfoVo.setTransCostAmount(consigneeAddressDto.getStoreProfileDto().getAddSendingPrice());
                storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
                if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                    storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
                }
                if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                    storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
                }
                if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                    storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
                }
            }
            communityVo.setStoreInfo(storeInfoVo);
            addressListVO.setCommunity(communityVo);
            addressListVOList.add(addressListVO);
        }
        return super.encapsulateParam(addressListVOList, AppMsgBean.MsgCode.SUCCESS, "收货地址列表信息接口成功");
    }

    /**
     * 
     * 收货地址详细信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/useraddress/addressdetail")
    @ResponseBody
    public ResultParamModel addressDetail(HttpServletRequest req, HttpServletResponse resp) {
        AddressDetailParam addressDetailParam = super.getEntityParam(req, AddressDetailParam.class);
        Integer addressId = addressDetailParam.getAddressId(); // 地址信息ID
        logger.info("=======addressId : " + addressId);
        ConsigneeAddressDto consigneeAddressDto = consigneeAddressService.loadById(addressId,
                SystemContext.UserDomain.CONSADDRSTATUS_ON);
        if (ObjectUtils.isNullOrEmpty(consigneeAddressDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "收货地址详细信息不存在");
        }

        AddressDetailVO addressDetailVO = new AddressDetailVO();
        ObjectUtils.fastCopy(consigneeAddressDto, addressDetailVO);
        CommunitySearchVO communityVo = new CommunitySearchVO();
        ObjectUtils.fastCopy(consigneeAddressDto, communityVo);
        communityVo.setCityName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getCityCode()));
        communityVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getProvinceCode()));
        communityVo.setCountyName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDto.getCountyCode()));
        StoreInfoVO storeInfoVo = null;
        if (null != consigneeAddressDto.getStoreProfileDto()) {
            storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(consigneeAddressDto.getStoreProfileDto(), storeInfoVo);
            storeInfoVo.setDeduceTransCostAmount(consigneeAddressDto.getStoreProfileDto().getStartSendingPrice());
            storeInfoVo.setTransCostAmount(consigneeAddressDto.getStoreProfileDto().getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
            }
        }
        communityVo.setStoreInfo(storeInfoVo);
        addressDetailVO.setCommunity(communityVo);
        return super.encapsulateParam(addressDetailVO, AppMsgBean.MsgCode.SUCCESS, "收货地址详细信息接口成功");
    }

    /**
     * 
     * 新增/修改地址信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/useraddress/addupdateuseraddress")
    @ResponseBody
    public ResultParamModel addOrUpdateAddress(HttpServletRequest req, HttpServletResponse resp) {
        AddUpdateAddressParam addUpdateAddressParam = super.getEntityParam(req, AddUpdateAddressParam.class);
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        ConsigneeAddressDto consigneeAddressDto = JsonUtils.parseObject(addUpdateAddressParam.toString(),
                ConsigneeAddressDto.class);
        ConsigneeAddressDto consigneeAddressDtotemp = null;
        Date operationDate = new Date();
        if (ObjectUtils.isNullOrEmpty(consigneeAddressDto.getAddressId())) { // 有值则代表修改、无值则代表新增

            consigneeAddressDto.setCustomerId(userSessionModel.getCustomerId());
            consigneeAddressDto.setStatus(SystemContext.UserDomain.CONSADDRSTATUS_ON);
            consigneeAddressDto.setCreateUserId(userSessionModel.getUserId());
            consigneeAddressDto.setModifyTime(operationDate);
            consigneeAddressDto.setCreateTime(operationDate);
            consigneeAddressDto.setModifyUserId(userSessionModel.getUserId());
            logger.info("=====================新增地址:" + consigneeAddressDto);
            consigneeAddressDtotemp = consigneeAddressService.save(consigneeAddressDto);
        } else {
            consigneeAddressDto.setModifyUserId(userSessionModel.getCustomerId());
            consigneeAddressDto.setModifyTime(operationDate);
            logger.info("=====================修改地址:" + consigneeAddressDto);
            consigneeAddressDtotemp = consigneeAddressService.updateById(consigneeAddressDto);
        }
        AddressSaveOrUpdateVO addressSaveOrUpdateVO = new AddressSaveOrUpdateVO();
        ObjectUtils.fastCopy(consigneeAddressDtotemp, addressSaveOrUpdateVO);
        StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(consigneeAddressDtotemp.getCommunityId(),
                null);
        if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该小区没有服务的店,不能设为收货地址");
        }
        CommunitySearchVO communityVo = new CommunitySearchVO();
        ObjectUtils.fastCopy(consigneeAddressDto, communityVo);
        communityVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDtotemp.getProvinceCode()));
        communityVo.setCityName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDtotemp.getCityCode()));
        communityVo.setCountyName(systemBasicDataInfoUtils.getAreaName(consigneeAddressDtotemp.getCountyCode()));
        communityVo.setAddressDetail(consigneeAddressDto.getAddressDetail());

        StoreInfoVO storeInfoVo = null;
        if (null != storeProfileDto) {
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCommunityDto())) {
                communityVo.setCommunityName(storeProfileDto.getCommunityDto().getName());
            }
            storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(storeProfileDto, storeInfoVo);
            storeInfoVo.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            storeInfoVo.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
            }
        }
        communityVo.setStoreInfo(storeInfoVo);
        addressSaveOrUpdateVO.setCommunity(communityVo);
        return super.encapsulateParam(addressSaveOrUpdateVO, AppMsgBean.MsgCode.SUCCESS, "新增/修改地址信息接口成功");
    }

    /**
     * 
     * 修改默认收货地址接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/address/updatedefaultaddress")
    @ResponseBody
    public ResultParamModel updateDefaultAddress(HttpServletRequest req, HttpServletResponse resp) {
        AppParamModel param = super.getParameter(req);
        JSONObject entity = param.getEntity();
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        ConsigneeAddressDto consigneeAddressDto = JsonUtils.parseObject(entity, ConsigneeAddressDto.class);
        Param addressIdValidate = new Param.Builder("收货地址", Param.ParamType.STR_INTEGER.getType(),
                consigneeAddressDto.getAddressId(), false).build();
        super.validateParams(addressIdValidate);

        consigneeAddressDto.setCustomerId(userSessionModel.getCustomerId());
        consigneeAddressDto.setModifyUserId(userSessionModel.getUserId());
        consigneeAddressDto.setModifyTime(new Date());
        consigneeAddressService.updateForDefaultFlag(consigneeAddressDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "修改默认收货地址接口成功");
    }

    /**
     * 
     * 失效收货地址接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/useraddress/invaliduseraddress")
    @ResponseBody
    public ResultParamModel delteAddress(HttpServletRequest req, HttpServletResponse resp) {
        AddressDeleteParam addressDeleteParam = super.getEntityParam(req, AddressDeleteParam.class);
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
        consigneeAddressDto.setAddressId(addressDeleteParam.getAddressId());
        consigneeAddressDto.setCustomerId(userSessionModel.getCustomerId());
        consigneeAddressDto.setModifyUserId(userSessionModel.getUserId());
        consigneeAddressDto.setModifyTime(new Date());
        consigneeAddressDto.setStatus(SystemContext.UserDomain.CONSADDRSTATUS_OFF);
        consigneeAddressService.updateForStatus(consigneeAddressDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "删除收货地址接口成功");
    }

}
