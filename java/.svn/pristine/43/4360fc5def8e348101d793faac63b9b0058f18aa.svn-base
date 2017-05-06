package com.yilidi.o2o.controller.mobile.seller.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.product.EnabledFlagParam;
import com.yilidi.o2o.appparam.seller.product.SearchProductsForTransParam;
import com.yilidi.o2o.appparam.seller.product.SearchProductsParam;
import com.yilidi.o2o.appvo.seller.order.SaleProductAllotVO;
import com.yilidi.o2o.appvo.seller.product.SaleProductDetailVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ISaleProductInventoryService;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.query.SaleProductInventoryQueryDto;
import com.yilidi.o2o.product.service.ISaleProductProfileService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * @Description: TODO(商品Controller)
 * @author: chenlian
 * @date: 2016年6月1日 下午5:33:29
 */
@Controller("sellerSaleProductController")
@RequestMapping(value = "/interfaces/seller")
public class SaleProductController extends SellerBaseController {

    private static final int ENABLED_FLAG_ONSALE = 1;

    private static final int ENABLED_FLAG_OFFSALE = 2;

    private static final int PRODUCT_SALE_STATUS_OFF = 0;

    private static final int PRODUCT_SALE_STATUS_ON = 1;

    @Autowired
    private ISaleProductProfileService saleProductProfileService;

    @Autowired
    private ISaleProductService saleProductService;

    @Autowired
    private ISaleProductInventoryService saleProductInventoryService;

    @Autowired
    private IStoreWarehouseService storeWarehouseService;

    @Autowired
    private IStoreProfileService storeProfileService;

    /**
     * 
     * 根据类型或关键字查询店铺中商品信息列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/product/searchproducts")
    @ResponseBody
    public ResultParamModel searchProducts(HttpServletRequest req, HttpServletResponse resp) {
        SearchProductsParam searchProductsParam = super.getEntityParam(req, SearchProductsParam.class);
        SaleProductQuery salesProductQuery = new SaleProductQuery();
        salesProductQuery.setStart(searchProductsParam.getPageNum());
        salesProductQuery.setPageSize(searchProductsParam.getPageSize());
        salesProductQuery.setParentCode(searchProductsParam.getParentClassCode());
        salesProductQuery.setProductClassCode(searchProductsParam.getClassCode());
        salesProductQuery.setKeywords(searchProductsParam.getKeyword());
        salesProductQuery.setStoreId(super.getStoreId());
        salesProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        salesProductQuery.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
        if (null == searchProductsParam.getEnabledFlag()
                || WebConstants.ENABLED_FLAG_ALL == searchProductsParam.getEnabledFlag().intValue()) {
            salesProductQuery.setSaleStatus(null);
        } else {
            if (WebConstants.ENABLED_FLAG_ON_SALE == searchProductsParam.getEnabledFlag().intValue()) {
                salesProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
            }
            if (WebConstants.ENABLED_FLAG_OFF_SALE == searchProductsParam.getEnabledFlag().intValue()) {
                salesProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
            }
        }
        String order = "PS." + DBTablesColumnsName.SaleProduct.MODIFYTIME;
        if (WebConstants.PRODUCT_SORT_TYPE_SALE == ArithUtils.converIntegerToInt(searchProductsParam.getOrderBy())) {
            order = DBTablesColumnsName.SaleDaily.SALECOUNT;
        }
        if (WebConstants.PRODUCT_SORT_TYPE_REMAINCOUNT == ArithUtils.converIntegerToInt(searchProductsParam.getOrderBy())) {
            order = DBTablesColumnsName.SaleProduct.REMAINCOUNT;
        }
        String sort = CommonConstants.SORT_ORDER_ASC;
        if (WebConstants.PRODUCT_SORT_HIGH_TO_LOW == ArithUtils.converIntegerToInt(searchProductsParam.getSortBy())) {
            sort = CommonConstants.SORT_ORDER_DESC;
        }
        if (order.equals(DBTablesColumnsName.SaleProduct.MODIFYTIME)) {
            sort = CommonConstants.SORT_ORDER_DESC;
        }
        salesProductQuery.setOrder(order);
        salesProductQuery.setSort(sort);
        YiLiDiPage<SaleProductAppDto> page = saleProductService.findSaleProducts(salesProductQuery);
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
                "根据类型或关键字查询店铺中商品信息列表成功");
    }

    /**
     * 
     * 根据类型查询调货商品信息列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/product/searchproductsfortrans")
    @ResponseBody
    public ResultParamModel searchProductsFortrans(HttpServletRequest req, HttpServletResponse resp) {
        SearchProductsForTransParam param = super.getEntityParam(req, SearchProductsForTransParam.class);
        SaleProductDto spDto = new SaleProductDto();
        spDto.setParentCode(param.getParentClassCode());
        spDto.setProductClassCode(param.getClassCode());
        Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(super.getStoreId());
        if (null == warehouseId) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺还没有所属的微仓");
        }
        StoreProfileDto warehouseDto = storeProfileService.loadBasicStoreInfo(warehouseId, null);
        if (null == warehouseDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺所属的微仓不存在");
        }
        spDto.setStoreId(warehouseId);
        spDto.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        spDto.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
        spDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
        List<SaleProductAppDto> spaDtoList = saleProductService.listSaleProductsForSellerFlitting(spDto);
        SaleProductInventoryQueryDto saleProductInventoryQueryDto = new SaleProductInventoryQueryDto();
        saleProductInventoryQueryDto.setStart(param.getPageNum());
        saleProductInventoryQueryDto.setPageSize(param.getPageSize());
        List<Integer> saleProductIds = new ArrayList<Integer>();
        Map<Integer, SaleProductAppDto> map = new HashMap<Integer, SaleProductAppDto>();
        if (!ObjectUtils.isNullOrEmpty(spaDtoList)) {
            for (SaleProductAppDto saleProductAppDto : spaDtoList) {
                saleProductIds.add(saleProductAppDto.getId());
                map.put(saleProductAppDto.getId(), saleProductAppDto);
            }
        }
        saleProductInventoryQueryDto.setSaleProductIds(saleProductIds);
        YiLiDiPage<SaleProductInventoryDto> page = saleProductInventoryService
                .findInventoriesBySaleProductIds(saleProductInventoryQueryDto);
        List<SaleProductInventoryDto> saleProductInventoryDtoList = page.getResultList();
        List<SaleProductAllotVO> saleProductAllotVOList = new ArrayList<SaleProductAllotVO>();
        List<String> barCodeList = null;
        if (!ObjectUtils.isNullOrEmpty(saleProductInventoryDtoList)) {
            barCodeList = new ArrayList<String>();
            for (SaleProductInventoryDto saleProductInventoryDto : saleProductInventoryDtoList) {
                if (map.containsKey(saleProductInventoryDto.getSaleProductId())) {
                    SaleProductAppDto saleProductAppDto = map.get(saleProductInventoryDto.getSaleProductId());
                    SaleProductAllotVO saleProductAllotVO = new SaleProductAllotVO();
                    saleProductAllotVO.setSaleProductId(saleProductAppDto.getId());
                    saleProductAllotVO.setSaleProductName(saleProductAppDto.getSaleProductName());
                    saleProductAllotVO
                            .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductAppDto.getSaleProductImageUrl()));
                    saleProductAllotVO.setBrandName(saleProductAppDto.getBrandName());
                    saleProductAllotVO.setBasePrice(saleProductAppDto.getPromotionalPrice());
                    saleProductAllotVO.setPerAllotCount(saleProductAppDto.getPerOperCount());
                    saleProductAllotVO.setWarehouseCount(saleProductAppDto.getStockNum());
                    saleProductAllotVO.setProductId(saleProductAppDto.getProductId());
                    barCodeList.add(saleProductAppDto.getBarCode());
                    saleProductAllotVOList.add(saleProductAllotVO);
                }
            }
        }
        if (!ObjectUtils.isNullOrEmpty(barCodeList)) {
            List<SaleProductDto> saleProductDtoList = saleProductService
                    .listSaleProductsByStoreIdAndBarCodes(super.getStoreId(), barCodeList);
            if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
                List<Integer> spIds = new ArrayList<Integer>();
                for (SaleProductDto saleProductDto : saleProductDtoList) {
                    spIds.add(saleProductDto.getId());
                }
                List<SaleProductInventoryDto> spiDtoList = saleProductInventoryService
                        .listByStoreIdAndSaleProductIds(super.getStoreId(), spIds);
                if (!ObjectUtils.isNullOrEmpty(spiDtoList)) {
                    for (SaleProductAllotVO saleProductAllotVO : saleProductAllotVOList) {
                        boolean isFound = false;
                        for (SaleProductInventoryDto saleProductInventoryDto : spiDtoList) {
                            SaleProductDto saleProductDto = saleProductService
                                    .loadSaleProductBasicInfoById(saleProductInventoryDto.getSaleProductId(), null);
                            if (saleProductAllotVO.getProductId().intValue() == saleProductDto.getProductId().intValue()) {
                                isFound = true;
                                saleProductAllotVO.setRemainCount(saleProductInventoryDto.getRemainCount());
                            }
                        }
                        if (!isFound) {
                            saleProductAllotVO.setRemainCount(0);
                        }
                    }
                } else {
                    for (SaleProductAllotVO saleProductAllotVO : saleProductAllotVOList) {
                        saleProductAllotVO.setRemainCount(0);
                    }
                }
            } else {
                for (SaleProductAllotVO saleProductAllotVO : saleProductAllotVOList) {
                    saleProductAllotVO.setRemainCount(0);
                }
            }
        }
        return super.encapsulatePageParam(page, saleProductAllotVOList, AppMsgBean.MsgCode.SUCCESS, "根据类型查询调货商品信息列表成功");
    }

    /**
     * 
     * 批量设置商品上下架
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/product/enabledflag")
    @ResponseBody
    public ResultParamModel enabledFlag(HttpServletRequest req, HttpServletResponse resp) {
        EnabledFlagParam enabledFlagParam = super.getEntityParam(req, EnabledFlagParam.class);
        String saleProductIds = enabledFlagParam.getSaleProductIds();
        Integer enabledFlag = enabledFlagParam.getEnabledFlag();
        StringTokenizer st = new StringTokenizer(saleProductIds, ",");
        List<Integer> saleProductIdList = new ArrayList<Integer>();
        while (st.hasMoreTokens()) {
            saleProductIdList.add(Integer.parseInt(st.nextToken()));
        }
        String saleStatus = null;
        if (ENABLED_FLAG_ONSALE == enabledFlag.intValue()) {
            saleStatus = SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE;
        }
        if (ENABLED_FLAG_OFFSALE == enabledFlag.intValue()) {
            saleStatus = SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE;
        }
        Integer modifyUserId = super.getUserId();
        Date modifyTime = DateUtils.getCurrentDateTime();
        String channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺不存在");
        }
        if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())
                && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileDto.getStockShare())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "共享库存不能上下架操作");
        }
        saleProductProfileService.updateSaleStatusBatchBySeller(saleProductIdList, saleStatus, channelCode, modifyUserId,
                modifyTime);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "批量设置商品上下架成功");
    }
}
