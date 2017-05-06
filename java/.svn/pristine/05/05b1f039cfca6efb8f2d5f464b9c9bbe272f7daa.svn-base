package com.yilidi.o2o.controller.mobile.seller.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.product.GetBrandTypeParam;
import com.yilidi.o2o.appparam.seller.product.ProductByBrandCodeParam;
import com.yilidi.o2o.appvo.seller.product.BrandVO;
import com.yilidi.o2o.appvo.seller.product.SaleProductDetailVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 商品品牌
 * 
 * @author: xiasl
 * @date: 2016年12月15日14:36:57
 */
@Controller("sellerBrandController")
@RequestMapping(value = "/interfaces/seller")
public class BrandController extends SellerBaseController {

	@Autowired
	private IProductBrandService productBrandService;
	@Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
    
    private static final int PRODUCT_SALE_STATUS_OFF = 0;

    private static final int PRODUCT_SALE_STATUS_ON = 1;
	
	/**
	 * 获取商品品牌列表
	 * 
	 * @Description 获取商品品牌列表
	 * @param req
	 *            request请求
	 * @param resp
	 *            response响应
	 * @return ResultParamModel
	 */
	@RequestMapping(value = "/brand/searchbrand")
	@ResponseBody
	public ResultParamModel getProductBrand(HttpServletRequest req, HttpServletResponse resp) {
		GetBrandTypeParam getBrandTypeParam = super.getEntityParam(req, GetBrandTypeParam.class);
		String type = getBrandTypeParam.getType(); // 是否热门
		List<ProductBrandDto> productBrandList = productBrandService.listProductBrandsByType(type,super.getStoreId(),null);
		List<BrandVO> brandVOList = new ArrayList<BrandVO>();
		if (!ObjectUtils.isNullOrEmpty(productBrandList)) {
			for (int i = 0, size = productBrandList.size(); i < size; i++) {
				ProductBrandDto productBrandDto = productBrandList.get(i);
				BrandVO brandVO = new BrandVO();
				brandVO.setBrandName(productBrandDto.getBrandName());
				brandVO.setBrandCode(productBrandDto.getBrandCode());
				brandVO.setBrandDesc(productBrandDto.getBrandDesc() == null ? "" : productBrandDto.getBrandDesc());
				brandVO.setBrandLogoImageUrl(StringUtils.toFullImageUrl(productBrandDto.getImageUrl()));
				brandVO.setBrandImageUrl("-");
				brandVOList.add(brandVO);
			}
		}
		return super.encapsulateParam(brandVOList, AppMsgBean.MsgCode.SUCCESS, "获取品牌列表成功");
	}

	/**
	 * 获取商品列表
	 * 
	 * @Description 获取商品品牌列表
	 * @param req
	 *            request请求
	 * @param resp
	 *            response响应
	 * @return ResultParamModel
	 */
	
	@RequestMapping(value = "/brand/searchproductbybrand")
	@ResponseBody
	public ResultParamModel getProductsByBrandCode(HttpServletRequest req, HttpServletResponse resp) {
		ProductByBrandCodeParam productByBrandCodeParam = super.getEntityParam(req, ProductByBrandCodeParam.class);
		Integer storeId = super.getStoreId();
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setBrandCode(productByBrandCodeParam.getBrandCode());
        saleProductQuery.setStoreId(storeId);
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
        String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
        String sort = CommonConstants.SORT_ORDER_ASC;
        saleProductQuery.setOrder(order);
        saleProductQuery.setSort(sort);
        saleProductQuery.setStart(productByBrandCodeParam.getPageNum());
        saleProductQuery.setPageSize(productByBrandCodeParam.getPageSize());
        if (null == productByBrandCodeParam.getEnabledFlag()
                || WebConstants.ENABLED_FLAG_ALL == productByBrandCodeParam.getEnabledFlag().intValue()) {
        		saleProductQuery.setSaleStatus(null);
        } else {
            if (WebConstants.ENABLED_FLAG_ON_SALE == productByBrandCodeParam.getEnabledFlag().intValue()) {
            	saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
            }
            if (WebConstants.ENABLED_FLAG_OFF_SALE == productByBrandCodeParam.getEnabledFlag().intValue()) {
            	saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
            }
        }
        
        YiLiDiPage<SaleProductAppDto> page = saleProductService.findSaleProducts(saleProductQuery);
        List<SaleProductAppDto> saleProductAppDtoList = page.getResultList();
        List<SaleProductDetailVO> saleProductDetailVOList = new ArrayList<SaleProductDetailVO>();
        if (!ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
            for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                SaleProductDetailVO saleProductDetailVO = new SaleProductDetailVO();
                saleProductDetailVO.setSaleProductId(saleProductAppDto.getId());
                saleProductDetailVO.setSaleProductName(saleProductAppDto.getSaleProductName());
                saleProductDetailVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductAppDto.getSaleProductImageUrl()));
                saleProductDetailVO.setBrandName(saleProductAppDto.getBrandName());
                saleProductDetailVO.setRetailPrice(saleProductAppDto.getRetailPrice());
                saleProductDetailVO.setPromotionalPrice(saleProductAppDto.getPromotionalPrice());
                saleProductDetailVO
                        .setSaleCount(null == saleProductAppDto.getSaleCount() ? 0 : saleProductAppDto.getSaleCount());
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE
                        .equals(saleProductAppDto.getSaleProductProfileDto().getSaleStatus())) {
                    saleProductDetailVO.setProductStatus(PRODUCT_SALE_STATUS_ON);
                }
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE
                        .equals(saleProductAppDto.getSaleProductProfileDto().getSaleStatus())) {
                    saleProductDetailVO.setProductStatus(PRODUCT_SALE_STATUS_OFF);
                }
                saleProductDetailVOList.add(saleProductDetailVO);
            }
            List<Integer> saleProductIds = new ArrayList<Integer>();
            for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                saleProductIds.add(saleProductAppDto.getId());
            }
            List<SaleProductInventoryDto> saleProductInventoryDtoList = saleProductInventoryService
                    .listByStoreIdAndSaleProductIds(null, saleProductIds);
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryDtoList)) {
                for (SaleProductDetailVO saleProductDetailVO : saleProductDetailVOList) {
                    boolean isFound = false;
                    for (SaleProductInventoryDto saleProductInventoryDto : saleProductInventoryDtoList) {
                        if (saleProductDetailVO.getSaleProductId().intValue() == saleProductInventoryDto.getSaleProductId()
                                .intValue()) {
                            isFound = true;
                            saleProductDetailVO.setRemainCount(saleProductInventoryDto.getRemainCount());
                        }
                    }
                    if (!isFound) {
                        saleProductDetailVO.setRemainCount(0);
                    }
                }
            } else {
                for (SaleProductDetailVO saleProductDetailVO : saleProductDetailVOList) {
                    saleProductDetailVO.setRemainCount(0);
                }
            }
        }
        return super.encapsulatePageParam(page, saleProductDetailVOList, AppMsgBean.MsgCode.SUCCESS,
                "根据品牌关键字查询店铺中商品信息列表成功");
    }
        
}
