package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.DeleteProductFavoriteParam;
import com.yilidi.o2o.appparam.buyer.product.GetProductFavoriteParam;
import com.yilidi.o2o.appparam.buyer.product.SaveProductFavoriteParam;
import com.yilidi.o2o.appvo.buyer.product.ProductFavoriteVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductFavoriteService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductFavoriteDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.query.ProductFavoriteQueryDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * <p>
 * Company:Yilidi
 * </p>
 * <p>
 * Title:收藏商品
 * </p>
 * 
 * @author xiasl
 * @date 2017年2月14日
 */
@Controller("buyerProductFavoriteController")
@RequestMapping(value = "/interfaces/buyer")
public class ProductFavoriteController extends BuyerBaseController {

    @Autowired
    private IProductFavoriteService productFavoriteService;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private IProductService productService;
    @Autowired
    private IProductClassService productClassService;

    /**
     * 收藏商品
     * 
     * @Description 收藏商品
     * @param req
     *            request请求
     * @param resp
     *            response响应
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/product/collectsaleproduct")
    @ResponseBody
    public ResultParamModel collectSaleProduct(HttpServletRequest req, HttpServletResponse resp) {
        SaveProductFavoriteParam saveProductFavoriteParam = super.getEntityParam(req, SaveProductFavoriteParam.class);
        Integer productId = saveProductFavoriteParam.getProductId();// 商品Id
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        ProductFavoriteDto productFavoriteDto = new ProductFavoriteDto();
        productFavoriteDto.setProductId(productId);
        productFavoriteDto.setCreateTime(new Date());
        productFavoriteDto.setUserId(userSession.getUserId());
        productFavoriteService.saveProductFavorite(productFavoriteDto);
        return super.encapsulateParam(null, AppMsgBean.MsgCode.SUCCESS, "收藏产品执行成功");
    }

    /**
     * 取消收藏商品
     * 
     * @Description 取消收藏商品
     * @param req
     *            request请求
     * @param resp
     *            response响应
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/product/cancelwithcollected")
    @ResponseBody
    public ResultParamModel cancelWithCollected(HttpServletRequest req, HttpServletResponse resp) {
        DeleteProductFavoriteParam deleteProductFavoriteParam = super.getEntityParam(req, DeleteProductFavoriteParam.class);
        String productId = deleteProductFavoriteParam.getProductIds();// 产品Id
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        productFavoriteService.deleteProductFavoriteByProductIdAndUserId(productId, userSession.getUserId());
        return super.encapsulateParam(null, AppMsgBean.MsgCode.SUCCESS, "取消收藏产品执行成功");
    }

    /**
     * 查询用户收藏的商品列表
     * 
     * @Description 查询用户收藏的商品列表
     * @param req
     *            request请求
     * @param resp
     *            response响应
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/product/saleproductcollections")
    @ResponseBody
    public ResultParamModel getSaleProductsCollections(HttpServletRequest req, HttpServletResponse resp) {
        GetProductFavoriteParam getProductFavoriteParam = super.getEntityParam(req, GetProductFavoriteParam.class);
        Integer storeId = getProductFavoriteParam.getStoreId();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        ProductFavoriteQueryDto queryProductFavorite = new ProductFavoriteQueryDto();
        queryProductFavorite.setUserId(userSession.getUserId());
        queryProductFavorite.setPageSize(getProductFavoriteParam.getPageSize());
        queryProductFavorite.setStart(getProductFavoriteParam.getPageNum());
        queryProductFavorite.setOrder("F." + DBTablesColumnsName.ProductFavorite.CREATETIME);
        queryProductFavorite.setSort(CommonConstants.SORT_ORDER_DESC);
        YiLiDiPage<ProductFavoriteDto> page = productFavoriteService.findProductFavoriteInfos(queryProductFavorite);
        List<ProductFavoriteDto> productFavoriteDtos = page.getResultList();
        List<ProductFavoriteVO> productFavoriteVOList = new ArrayList<ProductFavoriteVO>();

        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setStoreId(storeId);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
        boolean isVip = isVip();
        if (!ObjectUtils.isNullOrEmpty(productFavoriteDtos)) {
            for (ProductFavoriteDto pfDto : productFavoriteDtos) {
                ProductFavoriteVO pfVO = new ProductFavoriteVO();
                ProductDto pDto = productService.loadProductByProductIdAndChannelCode(pfDto.getProductId(), null);
                SaleProductAppDto appDto = saleProductService.loadSaleProductByStoreIdAndBarCode(storeId, pDto.getBarCode(),
                        null);
                ProductClassDto classDto = productClassService.loadProductClassByClassCode(pDto.getProductClassCode(), null);
                if (!ObjectUtils.isNullOrEmpty(appDto)) {
                    if (SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_OFF.equals(appDto.getEnabledFlag())) {
                        pfVO.setProductStatus(WebConstants.ENABLEDFLAG_OFF);
                    } else if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE
                            .equals(appDto.getSaleProductProfileDto().getSaleStatus())) {
                        pfVO.setProductStatus(WebConstants.SALESTATUS_OFFSALE);
                    } else {
                        pfVO.setProductStatus(WebConstants.SALESTATUS_ONSALE);
                    }
                    pfVO.setSaleProductId(appDto.getId());
                    pfVO.setProductId(appDto.getProductId());
                    pfVO.setBrandName(appDto.getBrandName());
                    pfVO.setSaleProductName(appDto.getSaleProductName());
                    if (!StringUtils.isEmpty(appDto.getSaleProductImageUrl()))
                        pfVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(appDto.getSaleProductImageUrl()));
                    pfVO.setRetailPrice(appDto.getRetailPrice());
                    pfVO.setPromotionalPrice(appDto.getPromotionalPrice());
                    pfVO.setOrderPrice(appDto.getRetailPrice());
                    if (isVip) {
                        pfVO.setOrderPrice(appDto.getPromotionalPrice());
                    }
                    pfVO.setStockNum(appDto.getStockNum());
                    if (!ObjectUtils.isNullOrEmpty(appDto.getSaleProductProfileDto())) {
                        pfVO.setSaleProductSpec(appDto.getSaleProductProfileDto().getSaleProductSpec());
                    }
                } else {
                    pfVO.setProductStatus(WebConstants.EXIST_NO);
                    pfVO.setProductId(pDto.getId());
                    pfVO.setBrandName(pDto.getBrandName());
                    pfVO.setSaleProductName(pDto.getProductName());
                    if (!ObjectUtils.isNullOrEmpty(pDto.getProductImageDtos())) {
                        for (ProductImageDto piDto : pDto.getProductImageDtos()) {
                            if (SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES.equals(piDto.getMasterFlag())) {
                                pfVO.setSaleProductImageUrl(StringUtils.toFullImageUrl(piDto.getImageUrl()));
                            }
                        }

                    }
                    pfVO.setStockNum(0);
                    pfVO.setRetailPrice(pDto.getProductPriceDto().getRetailPrice());
                    pfVO.setPromotionalPrice(pDto.getProductPriceDto().getPromotionalPrice());
                    pfVO.setOrderPrice(pDto.getProductPriceDto().getRetailPrice());
                    if (isVip) {
                        pfVO.setOrderPrice(pDto.getProductPriceDto().getPromotionalPrice());
                    }
                    if (!ObjectUtils.isNullOrEmpty(pDto.getProductProfileDto())
                            && StringUtils.isEmpty(pDto.getProductProfileDto().getProductSpec())) {
                        pfVO.setSaleProductSpec(pDto.getProductProfileDto().getProductSpec());
                    }
                }
                if (SystemContext.ProductDomain.PRODUCTCLASSSTATUS_OFF.equals(classDto.getStatusCode())
                        || SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_NO.equals(classDto.getDisplay())) {
                    pfVO.setProductStatus(WebConstants.EXIST_NO);
                }
                productFavoriteVOList.add(pfVO);
            }
        }

        return super.encapsulatePageParam(page, productFavoriteVOList, AppMsgBean.MsgCode.SUCCESS, "获取用户收藏商品列表成功");
    }
}
