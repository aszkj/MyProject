package com.yilidi.o2o.controller.mobile.seller.order;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.order.AllotInfoParam;
import com.yilidi.o2o.appparam.seller.order.CheckAllotParam;
import com.yilidi.o2o.appparam.seller.order.ConfirmAllotParam;
import com.yilidi.o2o.appparam.seller.order.ConfirmCheckAllotParam;
import com.yilidi.o2o.appparam.seller.order.CreateAllotParam;
import com.yilidi.o2o.appparam.seller.order.ListAllotParam;
import com.yilidi.o2o.appparam.seller.order.ShowAllotDetailParam;
import com.yilidi.o2o.appvo.seller.order.AllotCheckStatusVO;
import com.yilidi.o2o.appvo.seller.order.AllotOrderBaseVO;
import com.yilidi.o2o.appvo.seller.order.AllotOrderConfirmVO;
import com.yilidi.o2o.appvo.seller.order.AllotOrderDetailVO;
import com.yilidi.o2o.appvo.seller.order.AllotStatusVO;
import com.yilidi.o2o.appvo.seller.order.SaleProductAllotVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IFlittingOrderItemService;
import com.yilidi.o2o.order.service.IFlittingOrderService;
import com.yilidi.o2o.order.service.dto.FlittingOrderDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderSaveDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderSaveItemDto;
import com.yilidi.o2o.order.service.dto.query.FlittingOrderQueryDto;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * @Description: TODO(调货Controller)
 * @author: chenlian
 * @date: 2016年6月1日 下午6:13:56
 */
@Controller("sellerAllotController")
@RequestMapping(value = "/interfaces/seller")
public class AllotController extends SellerBaseController {

    private static final int PRODUCT_SALE_STATUS_OFF = 0;

    private static final int PRODUCT_SALE_STATUS_ON = 1;

    private static final String ALLOT_ORDER_NO_KEY = "allotOrderNo";

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IFlittingOrderService flittingOrderService;

    @Autowired
    private IFlittingOrderItemService flittingOrderItemService;

    @Autowired
    private ISaleProductService saleProductService;

    @Autowired
    private IStoreWarehouseService storeWarehouseService;

    /**
     * 
     * 确认调货单
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/confirmallot")
    @ResponseBody
    public ResultParamModel confirmAllot(HttpServletRequest req, HttpServletResponse resp) {
        ConfirmAllotParam confirmAllotParam = super.getEntityParam(req, ConfirmAllotParam.class);
        StoreProfileDto spDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == spDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该店铺不存在");
        }
        AllotOrderConfirmVO allotOrderConfirmVO = new AllotOrderConfirmVO();
        allotOrderConfirmVO.setStoreId(super.getStoreId());
        allotOrderConfirmVO.setStoreName(spDto.getStoreName());
        allotOrderConfirmVO.setStoreAddress(systemBasicDataInfoUtils.getAddressPrefix(spDto.getProvinceCode(),
                spDto.getCityCode(), spDto.getCountyCode()) + spDto.getAddressDetail());
        Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(super.getStoreId());
        if (null == warehouseId) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺还没有所属的微仓");
        }
        StoreProfileDto warehouseDto = storeProfileService.loadBasicStoreInfo(warehouseId, null);
        if (null == warehouseDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺所属的微仓不存在");
        }
        allotOrderConfirmVO.setWarehouseName(warehouseDto.getStoreName());
        allotOrderConfirmVO.setMinAllotAmount(getMinCreateFlittingOrderAmount());
        allotOrderConfirmVO.setMaxAllotAmount(getMaxFlittingOrderPromotionAmount());
        List<AllotInfoParam> allotInfo = confirmAllotParam.getAllotInfo();
        List<Integer> productIds = new ArrayList<Integer>();
        Map<Integer, Integer> allotInfoMap = new HashMap<Integer, Integer>();
        for (AllotInfoParam allotInfoParam : allotInfo) {
            productIds.add(allotInfoParam.getSaleProductId());
            allotInfoMap.put(allotInfoParam.getSaleProductId(), allotInfoParam.getAllotNum());
        }
        List<SaleProductAppDto> saleProductAppDtoList = saleProductService
                .listSaleProductByIdsAndStoreIdAndChannelCode(productIds, warehouseId, null, null, null);
        List<SaleProductAllotVO> saleProductAllotVOList = new ArrayList<SaleProductAllotVO>();
        if (!ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
            for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                SaleProductAllotVO saleProductAllotVO = new SaleProductAllotVO();
                saleProductAllotVO.setSaleProductId(saleProductAppDto.getId());
                saleProductAllotVO.setSaleProductName(saleProductAppDto.getSaleProductName());
                saleProductAllotVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(saleProductAppDto.getSaleProductImageUrl()));
                saleProductAllotVO.setSaleProductSpec(saleProductAppDto.getSaleProductProfileDto().getSaleProductSpec());
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE
                        .equals(saleProductAppDto.getSaleProductProfileDto().getSaleStatus())) {
                    saleProductAllotVO.setProductStatus(PRODUCT_SALE_STATUS_ON);
                }
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE
                        .equals(saleProductAppDto.getSaleProductProfileDto().getSaleStatus())) {
                    saleProductAllotVO.setProductStatus(PRODUCT_SALE_STATUS_OFF);
                }
                saleProductAllotVO.setBrandName(saleProductAppDto.getBrandName());
                saleProductAllotVO.setBasePrice(saleProductAppDto.getPromotionalPrice());
                saleProductAllotVO.setWarehouseCount(saleProductAppDto.getStockNum());
                saleProductAllotVO.setAllotCount(allotInfoMap.get(saleProductAppDto.getId()));
                saleProductAllotVO.setPerAllotCount(saleProductAppDto.getPerOperCount());
                saleProductAllotVOList.add(saleProductAllotVO);
            }
            Integer allotTotalCount = 0;
            Long allotTotalAmount = 0L;
            for (SaleProductAllotVO saleProductAllotVO : saleProductAllotVOList) {
                allotTotalCount += saleProductAllotVO.getAllotCount();
                allotTotalAmount += saleProductAllotVO.getBasePrice();
            }
            allotOrderConfirmVO.setAllotTotalCount(allotTotalCount);
            allotOrderConfirmVO.setAllotTotalAmount(allotTotalAmount);
        } else {
            allotOrderConfirmVO.setAllotTotalCount(0);
            allotOrderConfirmVO.setAllotTotalAmount(0L);
        }
        allotOrderConfirmVO.setSaleProductList(saleProductAllotVOList);
        return super.encapsulateParam(allotOrderConfirmVO, AppMsgBean.MsgCode.SUCCESS, "确认调货单成功");
    }

    private Long getMinCreateFlittingOrderAmount() {
        String paramValue = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.T_FLITTING_ORDER_CREATE_MIN_AMOUNT);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return 0L;
        }
        try {
            return Long.parseLong(paramValue);
        } catch (Exception e) {
            logger.error("转换T_FLITTING_ORDER_CREATE_MIN_AMOUNT参数值异常", e);
            return 0L;
        }
    }

    private Long getMaxFlittingOrderPromotionAmount() {
        String paramValue = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return 0L;
        }
        try {
            return Long.parseLong(paramValue);
        } catch (Exception e) {
            logger.error("转换T_FLITTING_ORDER_MAX_PROMOTIONPRICE_AMOUNT参数值异常", e);
            return 0L;
        }
    }

    /**
     * 
     * 生成调货单
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws InterruptedException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/createallot")
    @ResponseBody
    public ResultParamModel createAllot(HttpServletRequest req, HttpServletResponse resp) throws InterruptedException {
        CreateAllotParam createAllotParam = super.getEntityParam(req, CreateAllotParam.class);
        List<AllotInfoParam> allotInfo = createAllotParam.getAllotInfo();
        String allotNote = createAllotParam.getAllotNote();
        FlittingOrderSaveDto flittingOrderSaveDto = new FlittingOrderSaveDto();
        Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(super.getStoreId());
        if (null == warehouseId) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺还没有所属的微仓");
        }
        StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺不存在");
        }
        if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())
                && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileDto.getStockShare())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "共享库存不能上下架操作");
        }
        StoreProfileDto warehouseDto = storeProfileService.loadBasicStoreInfo(warehouseId, null);
        if (null == warehouseDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺所属的微仓不存在");
        }
        flittingOrderSaveDto.setSrcStoreId(warehouseId);
        flittingOrderSaveDto.setDestStoreId(super.getStoreId());
        flittingOrderSaveDto.setOperateUserId(super.getUserId());
        List<FlittingOrderSaveItemDto> flittingProductList = new ArrayList<FlittingOrderSaveItemDto>();
        for (AllotInfoParam allotInfoParam : allotInfo) {
            FlittingOrderSaveItemDto flittingOrderSaveItemDto = new FlittingOrderSaveItemDto();
            flittingOrderSaveItemDto.setSrcSaleProductId(allotInfoParam.getSaleProductId());
            flittingOrderSaveItemDto.setFlittingCount(allotInfoParam.getAllotNum());
            flittingProductList.add(flittingOrderSaveItemDto);
        }
        flittingOrderSaveDto.setFlittingProductList(flittingProductList);
        flittingOrderSaveDto.setFlittingNote(allotNote);
        String flittingOrderNo = flittingOrderService.saveOrder(flittingOrderSaveDto);
        FlittingOrderDto flittingOrderDto = flittingOrderService.loadByFlittingOrderNo(flittingOrderNo);
        AllotOrderBaseVO allotOrderBaseVO = new AllotOrderBaseVO();
        allotOrderBaseVO.setAllotOrderId(flittingOrderDto.getId());
        allotOrderBaseVO.setAllotOrderNo(flittingOrderNo);
        allotOrderBaseVO.setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderDto.getOrderStatus()));
        allotOrderBaseVO.setAllotTotalCount(flittingOrderDto.getFlittingCount());
        allotOrderBaseVO.setAllotTotalAmount(flittingOrderDto.getFlittingAmount());
        allotOrderBaseVO.setAllotFromStoreName(flittingOrderDto.getSrcStoreName());
        allotOrderBaseVO.setCreateTime(DateUtils.formatDateLong(flittingOrderDto.getCreateTime()));
        return super.encapsulateParam(allotOrderBaseVO, AppMsgBean.MsgCode.SUCCESS, "生成调货单成功");
    }

    /**
     * 
     * 获取调货单列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/orderlist")
    @ResponseBody
    public ResultParamModel orderList(HttpServletRequest req, HttpServletResponse resp) {
        ListAllotParam listAllotParam = super.getEntityParam(req, ListAllotParam.class);
        FlittingOrderQueryDto flittingOrderQueryDto = new FlittingOrderQueryDto();
        if (WebConstants.FLITTING_ORDER_STATUS_QUERY_NO_FINISHED == listAllotParam.getWhetherComplete().intValue()) {
            flittingOrderQueryDto.setOrderStatusList(Arrays.asList(SystemContext.OrderDomain.FLITTINGORDERSTATUS_APPLY,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTED,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_SEND,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKING,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKED,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED,
                    SystemContext.OrderDomain.FLITTINGORDERSTATUS_ARBITRATE));
        }
        if (WebConstants.FLITTING_ORDER_STATUS_QUERY_FINISHED == listAllotParam.getWhetherComplete().intValue()) {
            flittingOrderQueryDto
                    .setOrderStatusList(Arrays.asList(SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTREJECTED,
                            SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED));
        }
        flittingOrderQueryDto.setDestStoreId(super.getStoreId());
        flittingOrderQueryDto.setStart(listAllotParam.getPageNum());
        flittingOrderQueryDto.setPageSize(listAllotParam.getPageSize());
        YiLiDiPage<FlittingOrderDto> flittingOrderDtoPageInfos = flittingOrderService
                .findFlittingOrders(flittingOrderQueryDto);
        List<FlittingOrderDto> flittingOrderDtoList = flittingOrderDtoPageInfos.getResultList();
        List<AllotOrderBaseVO> allotOrderBaseVOList = new ArrayList<AllotOrderBaseVO>();
        if (!ObjectUtils.isNullOrEmpty(flittingOrderDtoList)) {
            for (FlittingOrderDto flittingOrderDto : flittingOrderDtoList) {
                AllotOrderBaseVO allotOrderBaseVO = new AllotOrderBaseVO();
                allotOrderBaseVO.setAllotOrderNo(flittingOrderDto.getFlittingOrderNo());
                allotOrderBaseVO.setCreateTime(DateUtils.formatDateLong(flittingOrderDto.getCreateTime()));
                allotOrderBaseVO.setConsignee(flittingOrderDto.getFlittingOrderAddressDto().getUserName());
                allotOrderBaseVO.setConsMobile(flittingOrderDto.getFlittingOrderAddressDto().getPhoneNo());
                allotOrderBaseVO
                        .setConsAddress(systemBasicDataInfoUtils.getAddressPrefix(flittingOrderDto.getDestProvinceCode(),
                                flittingOrderDto.getDestCityCode(), flittingOrderDto.getDestCountyCode())
                                + flittingOrderDto.getFlittingOrderAddressDto().getAddressDetail());
                allotOrderBaseVO.setAllotTotalCount(flittingOrderDto.getFlittingCount());
                allotOrderBaseVO.setAllotTotalAmount(flittingOrderDto.getFlittingAmount());
                allotOrderBaseVO.setRealAllotTotalCount(flittingOrderDto.getRealFlittingCount());
                allotOrderBaseVO.setRealAllotTotalAmount(flittingOrderDto.getRealFlittingAmount());
                allotOrderBaseVO.setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderDto.getOrderStatus()));
                allotOrderBaseVO.setStatusCodeName(systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.OrderDomain.DictType.FLITTINGORDERSTATUS.getValue(),
                        flittingOrderDto.getOrderStatus()));
                allotOrderBaseVOList.add(allotOrderBaseVO);
            }
        }
        return super.encapsulatePageParam(flittingOrderDtoPageInfos, allotOrderBaseVOList, AppMsgBean.MsgCode.SUCCESS,
                "获取调货单列表成功");
    }

    /**
     * 
     * 获取调货单详情
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/orderdetails")
    @ResponseBody
    public ResultParamModel orderDetails(HttpServletRequest req, HttpServletResponse resp) {
        ShowAllotDetailParam showAllotDetailParam = super.getEntityParam(req, ShowAllotDetailParam.class);
        FlittingOrderDto flittingOrderDto = flittingOrderService
                .loadByFlittingOrderNo(showAllotDetailParam.getAllotOrderNo());
        AllotOrderDetailVO allotOrderDetailVO = new AllotOrderDetailVO();
        allotOrderDetailVO.setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderDto.getOrderStatus()));
        allotOrderDetailVO.setStatusCodeName(systemBasicDataInfoUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.FLITTINGORDERSTATUS.getValue(), flittingOrderDto.getOrderStatus()));
        allotOrderDetailVO.setAllotOrderId(flittingOrderDto.getId());
        allotOrderDetailVO.setAllotOrderNo(flittingOrderDto.getFlittingOrderNo());
        allotOrderDetailVO.setCreateTime(DateUtils.formatDateLong(flittingOrderDto.getCreateTime()));
        allotOrderDetailVO.setNote(flittingOrderDto.getApplyNote());
        allotOrderDetailVO.setAllotFromStoreName(flittingOrderDto.getSrcStoreName());
        allotOrderDetailVO.setAllotToStoreName(flittingOrderDto.getDestStoreName());
        allotOrderDetailVO.setAllotTotalCount(flittingOrderDto.getFlittingCount());
        allotOrderDetailVO.setAllotTotalAmount(flittingOrderDto.getFlittingAmount());
        allotOrderDetailVO.setRealAllotTotalCount(flittingOrderDto.getRealFlittingCount());
        allotOrderDetailVO.setRealAllotTotalAmount(flittingOrderDto.getRealFlittingAmount());
        List<FlittingOrderItemDto> itemDtos = flittingOrderItemService
                .listFlittingOrderItems(flittingOrderDto.getFlittingOrderNo());
        List<SaleProductAllotVO> allotOrderItemList = new ArrayList<SaleProductAllotVO>();
        if (!ObjectUtils.isNullOrEmpty(itemDtos)) {
            for (FlittingOrderItemDto flittingOrderItemDto : itemDtos) {
                SaleProductAllotVO saleProductAllotVO = new SaleProductAllotVO();
                saleProductAllotVO.setSaleProductId(flittingOrderItemDto.getSrcSaleProductId());
                saleProductAllotVO.setSaleProductName(flittingOrderItemDto.getProductName());
                saleProductAllotVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(flittingOrderItemDto.getProductImageUrl3()));
                saleProductAllotVO.setBrandName(flittingOrderItemDto.getBrandName());
                saleProductAllotVO.setAllotCount(flittingOrderItemDto.getQuantity());
                saleProductAllotVO.setRealAllotCount(flittingOrderItemDto.getReceiveQuantity());
                allotOrderItemList.add(saleProductAllotVO);
            }
        }
        allotOrderDetailVO.setAllotOrderItemList(allotOrderItemList);
        List<FlittingOrderHistoryDto> historyDtos = flittingOrderService
                .listFlittingOrderHistorys(flittingOrderDto.getFlittingOrderNo());
        List<AllotStatusVO> allotStatusList = new ArrayList<AllotStatusVO>();
        if (!ObjectUtils.isNullOrEmpty(historyDtos)) {
            for (FlittingOrderHistoryDto flittingOrderHistoryDto : historyDtos) {
                AllotStatusVO allotStatusVO = new AllotStatusVO();
                allotStatusVO
                        .setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderHistoryDto.getFlittingStatus()));
                allotStatusVO.setStatusCodeName(systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.OrderDomain.DictType.FLITTINGORDERSTATUS.getValue(),
                        flittingOrderHistoryDto.getFlittingStatus()));
                allotStatusVO.setStatusTime(DateUtils.formatDateLong(flittingOrderHistoryDto.getOperateTime()));
                allotStatusVO.setStatusNote(flittingOrderHistoryDto.getOperationDesc());
                allotStatusList.add(allotStatusVO);
            }
        }
        allotOrderDetailVO.setAllotStatusList(allotStatusList);
        return super.encapsulateParam(allotOrderDetailVO, AppMsgBean.MsgCode.SUCCESS, "获取调货单详情成功");
    }

    /**
     * 
     * 调货单开始验货
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/checkallot")
    @ResponseBody
    public ResultParamModel checkAllot(HttpServletRequest req, HttpServletResponse resp) {
        CheckAllotParam checkAllotParam = super.getEntityParam(req, CheckAllotParam.class);
        flittingOrderService.updateForChecking(checkAllotParam.getAllotOrderNo(), super.getUserId());
        FlittingOrderDto flittingOrderDto = flittingOrderService.loadByFlittingOrderNo(checkAllotParam.getAllotOrderNo());
        AllotCheckStatusVO allotCheckStatusVO = new AllotCheckStatusVO();
        allotCheckStatusVO.setAllotOrderId(flittingOrderDto.getId());
        allotCheckStatusVO.setAllotOrderNo(checkAllotParam.getAllotOrderNo());
        allotCheckStatusVO.setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderDto.getOrderStatus()));
        allotCheckStatusVO.setStatusTime(DateUtils.formatDateLong(flittingOrderDto.getUpdateTime()));
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        session.setAttribute(ALLOT_ORDER_NO_KEY, checkAllotParam.getAllotOrderNo());
        return super.encapsulateParam(allotCheckStatusVO, AppMsgBean.MsgCode.SUCCESS, "调货单开始验货成功");
    }

    /**
     * 
     * 确认调货单验货
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/allot/confirmcheckallot")
    @ResponseBody
    public ResultParamModel confirmCheckAllot(HttpServletRequest req, HttpServletResponse resp) {
        ConfirmCheckAllotParam confirmCheckAllotParam = super.getEntityParam(req, ConfirmCheckAllotParam.class);
        List<AllotInfoParam> allotInfo = confirmCheckAllotParam.getAllotInfo();
        String flittingOrderNo = confirmCheckAllotParam.getAllotOrderNo();
        List<FlittingOrderItemDto> flittingOrderItemDtos = flittingOrderItemService.listFlittingOrderItems(flittingOrderNo);
        if (ObjectUtils.isNullOrEmpty(flittingOrderItemDtos)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "没有需调货的产品");
        }
        Map<Integer, Integer> allotInfoMap = new HashMap<Integer, Integer>();
        for (AllotInfoParam allotInfoParam : allotInfo) {
            allotInfoMap.put(allotInfoParam.getSaleProductId(), allotInfoParam.getAllotNum());
        }
        for (FlittingOrderItemDto flittingOrderItemDto : flittingOrderItemDtos) {
            Integer rejectQuantity = flittingOrderItemDto.getQuantity()
                    - allotInfoMap.get(flittingOrderItemDto.getSrcSaleProductId());
            if (rejectQuantity < 0) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "拒绝商品的数量不能大于该商品在调拨单里申请的数量");
            }
            flittingOrderItemDto.setRejectQuantity(rejectQuantity);
            flittingOrderItemDto.setReceiveQuantity(allotInfoMap.get(flittingOrderItemDto.getSrcSaleProductId()));
            flittingOrderItemDto.setUpdateTime(DateUtils.getCurrentDateTime());
            flittingOrderItemDto.setUpdateUserId(super.getUserId());
        }
        flittingOrderService.updateForChecked(flittingOrderNo, flittingOrderItemDtos, super.getUserId());
        FlittingOrderDto flittingOrderDto = flittingOrderService.loadByFlittingOrderNo(flittingOrderNo);
        AllotCheckStatusVO allotCheckStatusVO = new AllotCheckStatusVO();
        allotCheckStatusVO.setAllotOrderId(flittingOrderDto.getId());
        allotCheckStatusVO.setAllotOrderNo(flittingOrderNo);
        allotCheckStatusVO.setStatusCode(ConverterUtils.toFlittingOrderStatus(flittingOrderDto.getOrderStatus()));
        allotCheckStatusVO.setStatusTime(DateUtils.formatDateLong(flittingOrderDto.getUpdateTime()));
        return super.encapsulateParam(allotCheckStatusVO, AppMsgBean.MsgCode.SUCCESS, "确认调货单验货成功");
    }
}
