package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.GetBrandKeywordParam;
import com.yilidi.o2o.appparam.buyer.product.GetBrandTypeParam;
import com.yilidi.o2o.appparam.buyer.product.ProductByBrandCodeParam;
import com.yilidi.o2o.appvo.buyer.product.BrandAppVO;
import com.yilidi.o2o.appvo.buyer.product.BrandVO;
import com.yilidi.o2o.appvo.buyer.product.SaleProductSearchVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.query.SaleProductInventoryQueryDto;
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
@Controller("BrandController")
@RequestMapping(value = "/interfaces/buyer")
public class BrandController extends BuyerBaseController {

	@Autowired
	private IProductBrandService productBrandService;
	@Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;
	
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
		Integer storeId = getBrandTypeParam.getStoreId();//店铺Id
		String type = getBrandTypeParam.getType(); // 是否热门
		String  saleStatus = SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE;
		List<ProductBrandDto> productBrandList = productBrandService.listProductBrandsByType(type,storeId,saleStatus);
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
	 * 获取商品品牌列表
	 * 
	 * @Description 获取商品列表
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
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        saleProductQuery.setBrandCode(productByBrandCodeParam.getBrandCode());
        saleProductQuery.setStoreId(productByBrandCodeParam.getStoreId());
        saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
        String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
        String sort = CommonConstants.SORT_ORDER_ASC;
        saleProductQuery.setOrder(order);
        saleProductQuery.setSort(sort);
        
        List<SaleProductAppDto> saleProductDtoList = saleProductService.listSaleProducts(saleProductQuery);
        SaleProductInventoryQueryDto saleProductInventoryQueryDto = new SaleProductInventoryQueryDto();
        saleProductInventoryQueryDto.setStart(productByBrandCodeParam.getPageNum());
        saleProductInventoryQueryDto.setPageSize(productByBrandCodeParam.getPageSize());
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
        List<SaleProductSearchVO> productSearchVOList = new ArrayList<SaleProductSearchVO>();
        boolean isVip = isVip();
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
	 * 获取商品品牌列表
	 * 
	 * @Description 获取商品品牌列表
	 * @param req
	 *            request请求
	 * @param resp
	 *            response响应
	 * @return ResultParamModel
	 */
	@RequestMapping(value = "/brand/searchbykeywords")
	@ResponseBody
	public ResultParamModel getProductBrandByKeywords(HttpServletRequest req, HttpServletResponse resp) {
		GetBrandKeywordParam getBrandParam = super.getEntityParam(req, GetBrandKeywordParam.class);
		String keywords = getBrandParam.getKeywords(); // 品牌名称关键字
		Integer storeId = getBrandParam.getStoreId();
		Integer pageNum = getBrandParam.getPageNum();
		Integer pageSize = getBrandParam.getPageSize();
		 if (null == pageNum) {
			 pageNum = 1;
         }
         if (null == pageSize) {
             pageSize = CommonConstants.PAGE_SIZE;
         }
         YiLiDiPage<ProductBrandDto> page = productBrandService.listProductBrandsByKeywords(keywords,storeId,pageNum,pageSize);
         List<ProductBrandDto> productBrandList = page.getResultList();
         List<BrandAppVO> brandVOList = new ArrayList<BrandAppVO>();
		if (!ObjectUtils.isNullOrEmpty(productBrandList)) {
			for (int i = 0, size = productBrandList.size(); i < size; i++) {
				ProductBrandDto productBrandDto = productBrandList.get(i);
				BrandAppVO brandVO = new BrandAppVO();
				brandVO.setBrandName(productBrandDto.getBrandName());
				brandVO.setBrandCode(productBrandDto.getBrandCode());
				brandVO.setBrandDesc(productBrandDto.getBrandDesc() == null ? "" : productBrandDto.getBrandDesc());
				brandVO.setBrandLogoImageUrl(StringUtils.toFullImageUrl(productBrandDto.getImageUrl()));
				brandVO.setBrandImageUrl("-");
				brandVOList.add(brandVO);
			}
		}
		return super.encapsulatePageParam(page, brandVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
	}
}
