package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.FloorProductsParam;
import com.yilidi.o2o.appparam.buyer.product.HomeClassZoneSaleProductParam;
import com.yilidi.o2o.appparam.buyer.product.ProductHomeFloorsParam;
import com.yilidi.o2o.appparam.buyer.product.ProductHomeZonesParam;
import com.yilidi.o2o.appparam.buyer.product.ThemeInfoParam;
import com.yilidi.o2o.appparam.buyer.product.ZoneProductParam;
import com.yilidi.o2o.appvo.buyer.product.AdvertisementVO;
import com.yilidi.o2o.appvo.buyer.product.AppIconsVO;
import com.yilidi.o2o.appvo.buyer.product.FloorVO;
import com.yilidi.o2o.appvo.buyer.product.HomeClassZoneSaleProductVO;
import com.yilidi.o2o.appvo.buyer.product.ProductHomeFloorVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductSearchVO;
import com.yilidi.o2o.appvo.buyer.product.SaleZoneHomeVO;
import com.yilidi.o2o.appvo.buyer.product.SaleZoneMoreVO;
import com.yilidi.o2o.appvo.buyer.product.ThemeInfoVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IAdvertisementService;
import com.yilidi.o2o.product.service.IFloorAdvertisementTypeService;
import com.yilidi.o2o.product.service.IFloorProductService;
import com.yilidi.o2o.product.service.IFloorService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.IThemeService;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.FloorDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.ThemeDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 销售专区
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerSaleZoneController")
@RequestMapping(value = "/interfaces/buyer")
public class SaleZoneController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private IAdvertisementService advertisementService;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IFloorService floorService;
    @Autowired
    private IFloorProductService floorProductService;
    @Autowired
    private IFloorAdvertisementTypeService floorAdvertisementTypeService;
    @Autowired
    private IThemeService themeService;

    /** VIP升级专区 **/
    private static final int ZONE_TYPE_VIP = 1;
    /** 注册有礼:1分钱商品活动专区 **/
    private static final int ZONE_TYPE_PENNY = 2;
    /** 每周推荐 **/
    private static final int ZONE_TYPE_WEEKRECOMMEND = 3;
    /** 首页专区商品显示数量 **/
    private static final int HOME_PRODUCT_PAGESIZE = 4;

    /**
     * 获取首页专区列表
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/homezones")
    @ResponseBody
    public ResultParamModel homeZones(HttpServletRequest req, HttpServletResponse resp) {
        ProductHomeZonesParam productHomeZonesParam = super.getEntityParam(req, ProductHomeZonesParam.class);
        List<SaleZoneHomeVO> saleZoneHomeVOList = new ArrayList<SaleZoneHomeVO>();
        if (ObjectUtils.isNullOrEmpty(productHomeZonesParam)) {
            return super.encapsulateParam(saleZoneHomeVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        Integer communityId = productHomeZonesParam.getCommunityId();
        Integer storeId = productHomeZonesParam.getStoreId();
        String homeSaleZoneType = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.P_SALE_ZONE_TYPE_HOME);
        if (StringUtils.isNotEmpty(homeSaleZoneType)) {
            String[] homeSaleZoneTypeArr = homeSaleZoneType.split(CommonConstants.DELIMITER_COMMA);
            for (int i = 0; i < homeSaleZoneTypeArr.length; i++) {
                SaleZoneHomeVO saleZoneHomeVO = new SaleZoneHomeVO();
                saleZoneHomeVO.setSaleZoneId(homeSaleZoneTypeArr[i]);
                saleZoneHomeVO.setSaleZoneName(systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SALEZONETYPE.getValue(), homeSaleZoneTypeArr[i]));

                // 广告信息
                saleZoneHomeVO.setSaleZoneAdvInfo(getAdvertismentVoBySaleZoneTypeCode(homeSaleZoneTypeArr[i]));

                // 设置更多信息
                SaleZoneMoreVO saleZoneMoreVO = getSaleZoneMoreListBySaleZoneCode(homeSaleZoneTypeArr[i]);
                saleZoneHomeVO.setSaleZoneMoreInfo(saleZoneMoreVO);

                // 设置产品列表信息
                SaleProductQuery saleProductQuery = new SaleProductQuery();
                // saleProductQuery.setStart(1);
                // saleProductQuery.setPageSize(HOME_PRODUCT_PAGESIZE);
                // saleProductQuery.setChannelCode(ConverterUtils.toServerChannelCode(super.getIntfCallChannel(req)));
                saleProductQuery.setTypeCode(homeSaleZoneTypeArr[i]);
                saleProductQuery.setCommunityId(communityId);
                saleProductQuery.setStoreId(storeId);
                saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
                saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
                List<SaleProductAppDto> saleProductDtoList = saleProductService
                        .findSaleProductsBySaleZoneType(saleProductQuery);
                List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
                boolean isVip = isVip();
                int count = 0;
                if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
                    for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                        if (++count > HOME_PRODUCT_PAGESIZE) {
                            break;
                        }
                        SaleProductSearchVO saleProductSearchVO = new SaleProductSearchVO();
                        ObjectUtils.fastCopy(saleProductDto, saleProductSearchVO);
                        saleProductSearchVO.setSaleProductId(saleProductDto.getId());
                        saleProductSearchVO.setStockNum(saleProductDto.getStockNum());
                        saleProductSearchVO
                                .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
                        Long orderPrice = saleProductDto.getRetailPrice();
                        if (isVip) {
                            orderPrice = saleProductDto.getPromotionalPrice();
                        }
                        saleProductSearchVO.setOrderPrice(orderPrice);
                        if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {

                            saleProductSearchVO
                                    .setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                        }
                        productSearchVOList.add(saleProductSearchVO);
                    }
                }
                saleZoneHomeVO.setSaleZoneProductList(productSearchVOList);
                saleZoneHomeVOList.add(saleZoneHomeVO);
            }
        }
        return super.encapsulateParam(saleZoneHomeVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 获取首页楼层列表
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/homefloors")
    @ResponseBody
    public ResultParamModel homeFloors(HttpServletRequest req, HttpServletResponse resp) {
        ProductHomeFloorsParam productHomeFloorsParam = super.getEntityParam(req, ProductHomeFloorsParam.class);
        List<ProductHomeFloorVO> productHomeFloorVOList = new ArrayList<ProductHomeFloorVO>();
        if (ObjectUtils.isNullOrEmpty(productHomeFloorsParam)) {
            return super.encapsulateParam(productHomeFloorVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        Integer communityId = productHomeFloorsParam.getCommunityId();
        Integer storeId = productHomeFloorsParam.getStoreId();
        List<FloorDto> floorDtoList = floorService.listFloors();
        if (ObjectUtils.isNullOrEmpty(floorDtoList)) {
            return super.encapsulateParam(productHomeFloorVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        for (FloorDto floorDto : floorDtoList) {
            if (SystemContext.ProductDomain.FLOORSTATUS_ENABLED.equals(floorDto.getStatusCode())) {
                ProductHomeFloorVO productHomeFloorVO = new ProductHomeFloorVO();
                FloorVO floorVO = new FloorVO();
                floorVO.setFloorId(floorDto.getId());
                floorVO.setFloorName(floorDto.getFloorName());
                floorVO.setFloorImageUrl(floorDto.getFloorImageFullUrl());
                floorVO.setLinkType(ConverterUtils.toClientFloorLinkType(floorDto.getLinkType()));
                floorVO.setLinkData(floorDto.getLinkData());
                setFloorSaleProductList(communityId, storeId, floorDto.getId(), floorVO);
                productHomeFloorVO.setFloorInfo(floorVO);
                AdvertisementVO advertisementVO = getAdvertisementVO(floorDto.getId());
                productHomeFloorVO.setAdvertisementInfo(advertisementVO);
                productHomeFloorVOList.add(productHomeFloorVO);
            }
            if (SystemContext.ProductDomain.FLOORSTATUS_DISABLED.equals(floorDto.getStatusCode())) {
                ProductHomeFloorVO productHomeFloorVO = new ProductHomeFloorVO();
                AdvertisementVO advertisementVO = getAdvertisementVO(floorDto.getId());
                if (!ObjectUtils.isNullOrEmpty(advertisementVO)) {
                    productHomeFloorVO.setAdvertisementInfo(advertisementVO);
                    productHomeFloorVOList.add(productHomeFloorVO);
                }

            }
        }
        return super.encapsulateParam(productHomeFloorVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private AdvertisementVO getAdvertisementVO(Integer floorId) {
        AdvertisementVO advertisementVO = null;
        String advertisementTypeCode = floorAdvertisementTypeService.loadAdvertisementTypeCodeByFloorId(floorId);
        if (StringUtils.isNotEmpty(advertisementTypeCode)) {
            List<AdvertisementDto> advertisementDtoList = advertisementService.listByTypeCode(advertisementTypeCode);
            if (!ObjectUtils.isNullOrEmpty(advertisementDtoList)) {
                AdvertisementDto aDto = null;
                for (AdvertisementDto advertisementDto : advertisementDtoList) {
                    if (SystemContext.ProductDomain.ADVERTISEMENTSTATUS_PUBLISHED.equals(advertisementDto.getStatusCode())
                            && DateUtils.getCurrentDateTime().before(advertisementDto.getEndTime())
                            && DateUtils.getCurrentDateTime().after(advertisementDto.getStartTime())) {
                        aDto = advertisementDto;
                        break;
                    }
                }
                if (!ObjectUtils.isNullOrEmpty(aDto)) {
                    advertisementVO = new AdvertisementVO();
                    advertisementVO.setTitleName(aDto.getAdvertisementName());
                    advertisementVO.setImageUrl(aDto.getImageFullUrl());
                    advertisementVO.setLinkType(ConverterUtils.toClienLinkType(aDto.getLinkType()));
                    advertisementVO.setLinkData(aDto.getLinkData());
                }
            }
        }
        return advertisementVO;
    }

    private void setFloorSaleProductList(Integer communityId, Integer storeId, Integer floorId, FloorVO floorVO) {
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setFloorId(floorId);
        saleProductQuery.setCommunityId(communityId);
        saleProductQuery.setStoreId(storeId);
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProductsByFloorId(saleProductQuery);
        List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
        boolean isVip = isVip();
        int count = 0;
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                if (++count > HOME_PRODUCT_PAGESIZE) {
                    break;
                }
                SaleProductSearchVO saleProductSearchVO = new SaleProductSearchVO();
                ObjectUtils.fastCopy(saleProductDto, saleProductSearchVO);
                saleProductSearchVO.setSaleProductId(saleProductDto.getId());
                saleProductSearchVO.setStockNum(saleProductDto.getStockNum());
                saleProductSearchVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
                Long orderPrice = saleProductDto.getRetailPrice();
                if (isVip) {
                    orderPrice = saleProductDto.getPromotionalPrice();
                }
                saleProductSearchVO.setOrderPrice(orderPrice);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {

                    saleProductSearchVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                productSearchVOList.add(saleProductSearchVO);
            }
        }
        floorVO.setFloorProductList(productSearchVOList);
    }

    /**
     * 获取专区商品信息列表
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/zoneproduct")
    @ResponseBody
    public ResultParamModel listSaleZooProduct(HttpServletRequest req, HttpServletResponse resp) {
        ZoneProductParam zooProductParam = super.getEntityParam(req, ZoneProductParam.class);
        List<SaleProductSearchVO> saleProductSearchVOList = new ArrayList<SaleProductSearchVO>();
        if (ObjectUtils.isNullOrEmpty(zooProductParam)) {
            return super.encapsulateParam(saleProductSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        Integer zoneType = zooProductParam.getZoneType();
        Integer communityId = zooProductParam.getCommunityId();
        Integer storeId = zooProductParam.getStoreId();

        String productIdSystemParam = null;
        if (ZONE_TYPE_VIP == zoneType) { // VIP专区
            productIdSystemParam = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.P_VIP_PRODUCT_ID);
        }
        if (ZONE_TYPE_PENNY == zoneType) { // 1分钱活动
            productIdSystemParam = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.P_PENNY_PRODUCT_ID);
        }
        if (ZONE_TYPE_WEEKRECOMMEND == zoneType) { // 每周推荐
            productIdSystemParam = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.P_WEEKRECOMMEND_PRODUCT_ID);
        }
        if (ObjectUtils.isNullOrEmpty(productIdSystemParam)) {
            return super.encapsulateParam(saleProductSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        List<Integer> productIds = new ArrayList<Integer>();
        String[] productIdArr = productIdSystemParam.split(CommonConstants.DELIMITER_COMMA);
        for (String vipProductId : productIdArr) {
            Integer productId = ArithUtils.converStringToInt(vipProductId);
            if (productId <= 0) {
                continue;
            }
            productIds.add(productId);
        }
        if (ObjectUtils.isNullOrEmpty(productIds)) {
            return super.encapsulateParam(saleProductSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
            if (null == storeProfileDto) {
                logger.info("根据小区ID[" + communityId + "]找不到店铺信息");
                return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "执行成功");
            }
            storeId = storeProfileDto.getStoreId();
        }
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProductByProductIdsAndStoreIdAndChannelCode(
                productIds, SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, storeId, null);
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            boolean isVip = isVip();
            for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                SaleProductSearchVO saleProductSearchVO = new SaleProductSearchVO();
                ObjectUtils.fastCopy(saleProductDto, saleProductSearchVO);
                saleProductSearchVO.setSaleProductId(saleProductDto.getId());
                Long orderPrice = saleProductDto.getRetailPrice();
                if (isVip) {
                    orderPrice = saleProductDto.getPromotionalPrice();
                }
                saleProductSearchVO.setOrderPrice(orderPrice);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
                    saleProductSearchVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                saleProductSearchVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductSearchVO.getSaleProductImageUrl()));
                saleProductSearchVOList.add(saleProductSearchVO);
            }
        }
        return super.encapsulateParam(saleProductSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 根据销售专区编码获取商品列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/homeclasszoneproducts")
    @ResponseBody
    public ResultParamModel listHomeClassZoneProducts(HttpServletRequest req, HttpServletResponse resp) {
        HomeClassZoneSaleProductParam zooProductParam = super.getEntityParam(req, HomeClassZoneSaleProductParam.class);
        List<HomeClassZoneSaleProductVO> homeClassZoneSaleProductVOList = new ArrayList<HomeClassZoneSaleProductVO>();
        if (ObjectUtils.isNullOrEmpty(zooProductParam)) {
            return super.encapsulateParam(homeClassZoneSaleProductVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        String zoneCode = zooProductParam.getZoneCode();
        Integer storeId = zooProductParam.getStoreId();
        // 设置产品列表信息
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setTypeCode(zoneCode);
        saleProductQuery.setStoreId(storeId);
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        List<SaleProductAppDto> saleProductDtoList = saleProductService.findSaleProductsBySaleZoneType(saleProductQuery);
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            boolean isVip = isVip();
            for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                HomeClassZoneSaleProductVO homeClassZoneSaleProductVO = new HomeClassZoneSaleProductVO();
                ObjectUtils.fastCopy(saleProductDto, homeClassZoneSaleProductVO);
                homeClassZoneSaleProductVO.setSaleProductId(saleProductDto.getId());
                Long orderPrice = saleProductDto.getRetailPrice();
                if (isVip) {
                    orderPrice = saleProductDto.getPromotionalPrice();
                }
                homeClassZoneSaleProductVO.setOrderPrice(orderPrice);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
                    homeClassZoneSaleProductVO
                            .setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                homeClassZoneSaleProductVO.setSaleProductImageUrl(
                        StringUtils.toFullImageUrl(homeClassZoneSaleProductVO.getSaleProductImageUrl()));
                homeClassZoneSaleProductVOList.add(homeClassZoneSaleProductVO);
            }
        }
        return super.encapsulateParam(homeClassZoneSaleProductVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private AdvertisementVO getAdvertismentVoBySaleZoneTypeCode(String code) {
        String typeCode = getAdvertismentTypeBySaleZoneCode(code);
        if (StringUtils.isEmpty(typeCode)) {
            return null;
        }
        AdvertisementQuery query = new AdvertisementQuery();
        query.setTypeCode(typeCode);
        query.setStatusCode(SystemContext.ProductDomain.ADVERTISEMENTSTATUS_PUBLISHED);
        List<AdvertisementDto> advertisementDtoList = advertisementService.list(query);
        if (!ObjectUtils.isNullOrEmpty(advertisementDtoList)) {
            AdvertisementDto advertisementDto = advertisementDtoList.get(0);
            AdvertisementVO advertisementVO = new AdvertisementVO();
            advertisementVO.setLinkType(ConverterUtils.toClienLinkType(advertisementDto.getLinkType()));
            advertisementVO.setLinkData(advertisementDto.getLinkData());
            advertisementVO.setTitleName("");
            advertisementVO.setImageUrl(StringUtils.toFullImageUrl(advertisementDto.getImageUrl()));
            return advertisementVO;
        }
        return null;
    }

    private String getAdvertismentTypeBySaleZoneCode(String code) {
        List<String> typeList = getAdvertismentTypeListBySaleZoneCode(code);
        if (!ObjectUtils.isNullOrEmpty(typeList)) {
            return typeList.get(0);
        }
        return null;
    }

    private List<String> getAdvertismentTypeListBySaleZoneCode(String code) {
        if (StringUtils.isEmpty(code)) {
            return null;
        }
        String[] codeArr = code.split(CommonConstants.DELIMITER_UNDERLINE);
        if (codeArr.length != 2) {
            return null;
        }
        List<String> advertismentTypeCodeList = null;
        List<Map<String, String>> advertisementList = systemBasicDataInfoUtils
                .getSystemDictInfoList(SystemContext.ProductDomain.DictType.ADVERTISEMENTTYPE.getValue());
        if (!ObjectUtils.isNullOrEmpty(advertisementList)) {
            advertismentTypeCodeList = new ArrayList<String>();
            for (int i = 0, size = advertisementList.size(); i < size; i++) {
                Map<String, String> map = advertisementList.get(i);
                String typeCode = map.get(CommonConstants.APPOINTED_KEY_ID);
                String[] typeCodeArr = typeCode.split(CommonConstants.DELIMITER_UNDERLINE);
                if (typeCodeArr.length != 2) {
                    continue;
                }
                if (typeCodeArr[1].equals(codeArr[1])) {
                    advertismentTypeCodeList.add(typeCode);
                }
            }
        }
        return advertismentTypeCodeList;
    }

    private SaleZoneMoreVO getSaleZoneMoreListBySaleZoneCode(String code) {
        if (StringUtils.isEmpty(code)) {
            return null;
        }
        String[] codeArr = code.split(CommonConstants.DELIMITER_UNDERLINE);
        if (codeArr.length != 2) {
            return null;
        }
        String saleZoneLinkTypeInfoParam = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.P_SALE_ZONE_TYPE_HOME_LINKINFO);
        if (ObjectUtils.isNullOrEmpty(saleZoneLinkTypeInfoParam)) {
            return null;
        }
        String[] saleZoneLinkTypeInfoParamArr = saleZoneLinkTypeInfoParam.split(CommonConstants.DELIMITER_COMMA);
        if (ObjectUtils.isNullOrEmpty(saleZoneLinkTypeInfoParamArr)) {
            return null;
        }
        SaleZoneMoreVO saleZoneMoreVO = null;
        for (String saleZoneLinkTypeInfo : saleZoneLinkTypeInfoParamArr) {
            String[] saleZoneLinkTypeInfoArr = saleZoneLinkTypeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
            if (saleZoneLinkTypeInfoArr.length != 3) {
                continue;
            }
            if (saleZoneLinkTypeInfoArr[0].equals(codeArr[1])) {
                saleZoneMoreVO = new SaleZoneMoreVO();
                saleZoneMoreVO.setMoreType(getSaleZoneMoreLinkTypeInt(saleZoneLinkTypeInfoArr[1]));
                saleZoneMoreVO.setMoreData(saleZoneLinkTypeInfoArr[2]);
                break;
            }
        }
        if (ObjectUtils.isNullOrEmpty(saleZoneMoreVO)) {
            return null;
        }
        String saleZoneTypeImgParam = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.P_SALE_ZONE_TYPE_IMGURL);
        String[] saleZoneTypeImgParamArr = null;
        if (!ObjectUtils.isNullOrEmpty(saleZoneTypeImgParam)) {
            saleZoneTypeImgParamArr = saleZoneTypeImgParam.split(CommonConstants.DELIMITER_COMMA);
        }
        if (ObjectUtils.isNullOrEmpty(saleZoneTypeImgParamArr)) {
            saleZoneMoreVO.setMoreImgUrl("");
            return saleZoneMoreVO;
        }
        for (String saleZoneTypeImg : saleZoneTypeImgParamArr) {
            String[] saleZoneTypeImgArr = saleZoneTypeImg.split(CommonConstants.DELIMITER_UNDERLINE);
            if (saleZoneTypeImgArr.length != 2) {
                continue;
            }
            if (saleZoneTypeImgArr[0].equals(codeArr[1])) {
                saleZoneMoreVO.setMoreImgUrl(StringUtils.toFullImageUrl(saleZoneTypeImgArr[1]));
            }
        }
        return saleZoneMoreVO;
    }

    private int getSaleZoneMoreLinkTypeInt(String linkTypeSuffix) {
        String linkType = getSaleZoneMoreLinkType(linkTypeSuffix);
        if (SystemContext.ProductDomain.SALEZONELINKTYPE_PRODUCTCLASS.equals(linkType)) {
            return WebConstants.MORE_TYPE_PRODUCT_CLASS;
        }
        return WebConstants.MORE_TYPE_SALEZONE;
    }

    private String getSaleZoneMoreLinkType(String linkTypeSuffix) {
        if (ObjectUtils.isNullOrEmpty(linkTypeSuffix)) {
            return null;
        }
        List<Map<String, String>> saleZoneLinkTypeList = systemBasicDataInfoUtils
                .getSystemDictInfoList(SystemContext.ProductDomain.DictType.SALEZONELINKTYPE.getValue());
        if (!ObjectUtils.isNullOrEmpty(saleZoneLinkTypeList)) {
            for (Map<String, String> map : saleZoneLinkTypeList) {
                String typeCode = map.get(CommonConstants.APPOINTED_KEY_ID);
                String[] typeCodeArr = typeCode.split(CommonConstants.DELIMITER_UNDERLINE);
                if (typeCodeArr.length != 2) {
                    continue;
                }
                if (typeCodeArr[1].equals(linkTypeSuffix)) {
                    return typeCode;
                }
            }
        }
        return null;
    }

    /**
     * 查询专题信息数据
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/themeinfo")
    @ResponseBody
    public ResultParamModel themeinfo(HttpServletRequest req, HttpServletResponse resp) {
        ThemeInfoParam themeInfoParam = super.getEntityParam(req, ThemeInfoParam.class);
        ThemeInfoVO themeInfoVO = new ThemeInfoVO();
        if (ObjectUtils.isNullOrEmpty(themeInfoParam)) {
            return super.encapsulateParam(themeInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        String typeCode = themeInfoParam.getTypeCode();
        Integer storeId = themeInfoParam.getStoreId();
        ThemeDto themeDto = themeService.loadByTypeCode(typeCode);
        if (ObjectUtils.isNullOrEmpty(themeDto)) {
            return super.encapsulateParam(themeInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        themeInfoVO.setTypeCode(typeCode);
        themeInfoVO.setThemeName(themeDto.getThemeName());
        themeInfoVO.setThemeImageUrl(themeDto.getThemeImageFullUrl());
        themeInfoVO.setSloganImageUrl(themeDto.getSloganImageFullUrl());
        themeInfoVO.setBaseColor(ConverterUtils.toBaseColor(themeDto.getBaseColor()));
        themeInfoVO.setBaseColor(themeDto.getBaseColor());
        setThemeSaleProductList(storeId, typeCode, themeInfoVO);
        return super.encapsulateParam(themeInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private void setThemeSaleProductList(Integer storeId, String typeCode, ThemeInfoVO themeInfoVO) {
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setTypeCode(typeCode);
        saleProductQuery.setStoreId(storeId);
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProductsByTypeCode(saleProductQuery);
        List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
        boolean isVip = isVip();
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                SaleProductSearchVO saleProductSearchVO = new SaleProductSearchVO();
                ObjectUtils.fastCopy(saleProductDto, saleProductSearchVO);
                saleProductSearchVO.setSaleProductId(saleProductDto.getId());
                saleProductSearchVO.setStockNum(saleProductDto.getStockNum());
                saleProductSearchVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
                Long orderPrice = saleProductDto.getRetailPrice();
                if (isVip) {
                    orderPrice = saleProductDto.getPromotionalPrice();
                }
                saleProductSearchVO.setOrderPrice(orderPrice);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {

                    saleProductSearchVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                productSearchVOList.add(saleProductSearchVO);
            }
        }
        themeInfoVO.setSaleProducts(productSearchVOList);
    }

    /**
     * 根据楼层ID查询楼层商品列表
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/floorproducts")
    @ResponseBody
    public ResultParamModel floorproducts(HttpServletRequest req, HttpServletResponse resp) {
        FloorProductsParam floorProductsParam = super.getEntityParam(req, FloorProductsParam.class);
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setFloorId(floorProductsParam.getFloorId());
        saleProductQuery.setStoreId(floorProductsParam.getStoreId());
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProductsByFloorId(saleProductQuery);
        List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
        boolean isVip = isVip();
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            for (SaleProductAppDto saleProductDto : saleProductDtoList) {
                SaleProductSearchVO saleProductSearchVO = new SaleProductSearchVO();
                ObjectUtils.fastCopy(saleProductDto, saleProductSearchVO);
                saleProductSearchVO.setSaleProductId(saleProductDto.getId());
                saleProductSearchVO.setStockNum(saleProductDto.getStockNum());
                saleProductSearchVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
                Long orderPrice = saleProductDto.getRetailPrice();
                if (isVip) {
                    orderPrice = saleProductDto.getPromotionalPrice();
                }
                saleProductSearchVO.setOrderPrice(orderPrice);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {

                    saleProductSearchVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                productSearchVOList.add(saleProductSearchVO);
            }
        }
        return super.encapsulateParam(productSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 3.78应用首页图标数据列表接口
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/home/appicons")
    @ResponseBody
    public ResultParamModel homeAppIcons(HttpServletRequest req, HttpServletResponse resp) {
        List<AppIconsVO> appIconsList = new ArrayList<AppIconsVO>();
        String appIcon = StringUtils
                .trim(systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.P_APP_HOMEICONS));
        if (!ObjectUtils.isNullOrEmpty(appIcon)) {
            String[] appIconArr = appIcon.split(CommonConstants.DELIMITER_COMMA);
            for (String appIconItem : appIconArr) {
                if (!ObjectUtils.isNullOrEmpty(appIconItem.trim())) {
                    AppIconsVO appIconsVO = new AppIconsVO();
                    appIconsVO.setImageUrl(StringUtils.toFullImageUrl(appIconItem.trim()));
                    appIconsList.add(appIconsVO);
                }
            }
        }
        return super.encapsulateParam(appIconsList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }
}
