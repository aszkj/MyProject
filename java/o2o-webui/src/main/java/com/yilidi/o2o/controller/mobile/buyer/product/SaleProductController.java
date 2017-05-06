package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.ProductByBarCodeParam;
import com.yilidi.o2o.appparam.buyer.product.ProductDetailParam;
import com.yilidi.o2o.appparam.buyer.product.SearchProductsParam;
import com.yilidi.o2o.appvo.buyer.product.BuyRewardActivityListVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductDetailByBarCodeVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductDetailVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductImageListVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductSearchVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.query.SaleProductInventoryQueryDto;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.IProductFavoriteService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;
import com.yilidi.o2o.product.service.dto.ProductFavoriteDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 商品请求
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerSaleProductController")
@RequestMapping(value = "/interfaces/buyer")
public class SaleProductController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IProductFavoriteService productFavoriteService;
    @Autowired
    private IBuyRewardActivityAuditService buyRewardActivityAuditService;

    /**
     * 搜索小区内（按关键字或者类型）店铺商品列表接口
     * 
     * @Description 搜索小区内（按关键字或者类型）店铺商品列表接口
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/searchproducts")
    @ResponseBody
    public ResultParamModel searchProducts(HttpServletRequest req, HttpServletResponse resp) {
        SearchProductsParam searchProductsParam = super.getEntityParam(req, SearchProductsParam.class);
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setParentCode(searchProductsParam.getParentClassCode());
        saleProductQuery.setProductClassCode(searchProductsParam.getClassCode());
        saleProductQuery.setKeywords(searchProductsParam.getKeywords());
        saleProductQuery.setCommunityId(searchProductsParam.getCommunityId());
        saleProductQuery.setStoreId(searchProductsParam.getStoreId());
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);

        String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
        if (WebConstants.PRODUCT_SORT_TYPE_SALE == ArithUtils.converIntegerToInt(searchProductsParam.getOrderBy())) {
            order = DBTablesColumnsName.SaleDaily.SALECOUNT;
        }
        if (WebConstants.PRODUCT_SORT_TYPE_PRICE == ArithUtils.converIntegerToInt(searchProductsParam.getOrderBy())) {
            order = DBTablesColumnsName.SaleProductPrice.RETAILPRICE;
        }
        String sort = CommonConstants.SORT_ORDER_ASC;
        if (WebConstants.PRODUCT_SORT_HIGH_TO_LOW == ArithUtils.converIntegerToInt(searchProductsParam.getSortBy())) {
            sort = CommonConstants.SORT_ORDER_DESC;
        }
        saleProductQuery.setOrder(order);
        saleProductQuery.setSort(sort);
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProducts(saleProductQuery);
        SaleProductInventoryQueryDto saleProductInventoryQueryDto = new SaleProductInventoryQueryDto();
        saleProductInventoryQueryDto.setStart(searchProductsParam.getPageNum());
        saleProductInventoryQueryDto.setPageSize(searchProductsParam.getPageSize());
        List<Integer> saleProductIds = new ArrayList<Integer>();
        Map<Integer, SaleProductAppDto> map = new HashMap<Integer, SaleProductAppDto>();
        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
            for (SaleProductAppDto saleProductAppDto : saleProductDtoList) {
                saleProductIds.add(saleProductAppDto.getId());
                map.put(saleProductAppDto.getId(), saleProductAppDto);
            }
        }
        saleProductInventoryQueryDto.setSaleProductIds(saleProductIds);
        YiLiDiPage<SaleProductInventoryDto> page = saleProductInventoryService
                .findInventoriesBySaleProductIds(saleProductInventoryQueryDto);
        List<SaleProductInventoryDto> saleProductInventoryDtoList = page.getResultList();
        boolean isVip = isVip();
        List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
        if (!ObjectUtils.isNullOrEmpty(saleProductInventoryDtoList)) {
            for (SaleProductInventoryDto saleProductInventoryDto : saleProductInventoryDtoList) {
                if (map.containsKey(saleProductInventoryDto.getSaleProductId())) {
                    SaleProductAppDto saleProductDto = map.get(saleProductInventoryDto.getSaleProductId());
                    SaleProductSearchVO productSearchVO = new SaleProductSearchVO();
                    ObjectUtils.fastCopy(saleProductDto, productSearchVO);
                    productSearchVO.setOrderPrice(saleProductDto.getRetailPrice());
                    if (isVip) {
                        productSearchVO.setOrderPrice(saleProductDto.getPromotionalPrice());
                    }
                    productSearchVO.setSaleProductId(saleProductDto.getId());
                    productSearchVO.setStockNum(saleProductDto.getStockNum());
                    if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
                        productSearchVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                    }
                    productSearchVO
                            .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
                    productSearchVOList.add(productSearchVO);
                }
            }
        }
        return super.encapsulatePageParam(page, productSearchVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 商品详情
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/productdetail")
    @ResponseBody
    public ResultParamModel productDetail(HttpServletRequest req, HttpServletResponse resp) {
        ProductDetailParam productDetailParam = super.getEntityParam(req, ProductDetailParam.class);
        SaleProductAppDto saleProductDto = saleProductService.loadSaleProductById(productDetailParam.getSaleProductId(),
                null, null, null);
        if (saleProductDto == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "商品不存在");
        }
        SaleProductDetailVO productDetailVO = new SaleProductDetailVO();
        ObjectUtils.fastCopy(saleProductDto, productDetailVO);
        productDetailVO.setSaleProductId(saleProductDto.getId());
        productDetailVO.setStockNum(saleProductDto.getStockNum());
        if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
            productDetailVO.setProductDetail(saleProductDto.getSaleProductProfileDto().getContent());
        }
        productDetailVO.setOrderPrice(saleProductDto.getRetailPrice());
        if (isVip()) {
            productDetailVO.setOrderPrice(saleProductDto.getPromotionalPrice());
        }
        productDetailVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
        if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
            productDetailVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
        }
        List<String> notMasterSaleProductImageList = saleProductDto.getSaleProductImageUrlList();
        List<SaleProductImageListVO> saleProductImageList = new ArrayList<SaleProductImageListVO>();
        if (!ObjectUtils.isNullOrEmpty(notMasterSaleProductImageList)) {
            for (String imageUrl : notMasterSaleProductImageList) {
                if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                    SaleProductImageListVO saleProductImageListVO = new SaleProductImageListVO();
                    saleProductImageListVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(imageUrl));
                    saleProductImageList.add(saleProductImageListVO);
                }
            }
        }
        productDetailVO.setSaleProductImageList(saleProductImageList);

        List<BuyRewardActivityListVO> activityInfoList = new ArrayList<BuyRewardActivityListVO>();
        List<BuyRewardActivityAuditDto> startedBuyRewardActivitys = buyRewardActivityAuditService
                .getActivityInfoList(productDetailVO.getProductId());
        if (!ObjectUtils.isNullOrEmpty(startedBuyRewardActivitys)) {
            for (BuyRewardActivityAuditDto buyRewardActivityAuditDto : startedBuyRewardActivitys) {
                BuyRewardActivityListVO buyRewardActivityListVO = new BuyRewardActivityListVO();
                buyRewardActivityListVO.setActId(buyRewardActivityAuditDto.getId());
                buyRewardActivityListVO.setActName(buyRewardActivityAuditDto.getActivityName());
                buyRewardActivityListVO.setActType(WebConstants.ACTIVITY_TYPE_BUYREWARD);
                buyRewardActivityListVO.setActTypeName(WebConstants.ACTIVITY_TYPE_BUYREWARD_NAME);
                activityInfoList.add(buyRewardActivityListVO);
            }
        }
        productDetailVO.setActivityInfoList(activityInfoList);
        
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        if (ObjectUtils.isNullOrEmpty(userSession)) {
            productDetailVO.setIsCollected(WebConstants.PRODUCT_FAVORITE_NO);
        } else {
            ProductFavoriteDto productFavoriteDto = productFavoriteService
                    .loadProductFavoriteByUserIdAndProductId(userSession.getUserId(), productDetailVO.getProductId());
            if (!ObjectUtils.isNullOrEmpty(productFavoriteDto)) {
                productDetailVO.setIsCollected(WebConstants.PRODUCT_FAVORITE_YES);
            } else {
                productDetailVO.setIsCollected(WebConstants.PRODUCT_FAVORITE_NO);
            }
        }
        return super.encapsulateParam(productDetailVO, AppMsgBean.MsgCode.SUCCESS, "获取商品详情成功");
    }

    /**
     * 根据商品条形码商品详情
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/productbybarcode")
    @ResponseBody
    public ResultParamModel productByBarcode(HttpServletRequest req, HttpServletResponse resp) {
        ProductByBarCodeParam productByBarCodeParam = super.getEntityParam(req, ProductByBarCodeParam.class);
        if (ObjectUtils.isNullOrEmpty(productByBarCodeParam)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "商品信息为空");
        }
        Integer storeId = productByBarCodeParam.getStoreId();
        Integer communityId = productByBarCodeParam.getCommunityId();
        if (ObjectUtils.isNullOrEmpty(storeId)) {
            StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(communityId, null);
            if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                logger.info("根据小区ID[" + communityId + "]没有找到店铺信息");
                return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "操作成功");
            }
            storeId = storeProfileDto.getStoreId();
        }
        SaleProductAppDto saleProductDto = saleProductService.loadSaleProductByStoreIdAndBarCode(storeId,
                productByBarCodeParam.getBarCode(), null);
        if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "商品信息为空");
        }
        SaleProductDetailByBarCodeVO saleProductDetailByBarCodeVO = new SaleProductDetailByBarCodeVO();
        ObjectUtils.fastCopy(saleProductDto, saleProductDetailByBarCodeVO);
        saleProductDetailByBarCodeVO.setSaleProductId(saleProductDto.getId());
        saleProductDetailByBarCodeVO.setStockNum(saleProductDto.getStockNum());
        if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
            saleProductDetailByBarCodeVO.setProductDetail(saleProductDto.getSaleProductProfileDto().getContent());
        }
        saleProductDetailByBarCodeVO.setOrderPrice(saleProductDto.getRetailPrice());
        if (isVip()) {
            saleProductDetailByBarCodeVO.setOrderPrice(saleProductDto.getPromotionalPrice());
        }
        saleProductDetailByBarCodeVO
                .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductDto.getSaleProductImageUrl()));
        String saleStatus = null;
        if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductProfileDto())) {
            saleProductDetailByBarCodeVO.setSaleProductSpec(saleProductDto.getSaleProductProfileDto().getSaleProductSpec());
            saleStatus = saleProductDto.getSaleProductProfileDto().getSaleStatus();
        }
        saleProductDetailByBarCodeVO
                .setProductStatus(ConverterUtils.toClientProductSaleStatus(saleStatus, saleProductDto.getEnabledFlag()));

        return super.encapsulateParam(saleProductDetailByBarCodeVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }
}
