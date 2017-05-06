package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.FlittingOrderItemMapper;
import com.yilidi.o2o.order.dao.FlittingOrderMapper;
import com.yilidi.o2o.order.dao.FlittingStockInRelationMapper;
import com.yilidi.o2o.order.dao.PurchaseOrderItemMapper;
import com.yilidi.o2o.order.dao.PurchaseOrderMapper;
import com.yilidi.o2o.order.dao.PurchaseStockInRelationMapper;
import com.yilidi.o2o.order.dao.SaleOrderItemMapper;
import com.yilidi.o2o.order.dao.SaleOrderMapper;
import com.yilidi.o2o.order.dao.SaleStockInRelationMapper;
import com.yilidi.o2o.order.dao.StockInItemMapper;
import com.yilidi.o2o.order.dao.StockInMapper;
import com.yilidi.o2o.order.model.FlittingOrder;
import com.yilidi.o2o.order.model.FlittingOrderItem;
import com.yilidi.o2o.order.model.FlittingStockInRelation;
import com.yilidi.o2o.order.model.PurchaseOrder;
import com.yilidi.o2o.order.model.PurchaseOrderItem;
import com.yilidi.o2o.order.model.PurchaseStockInRelation;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.SaleStockInRelation;
import com.yilidi.o2o.order.model.StockIn;
import com.yilidi.o2o.order.model.StockInItem;
import com.yilidi.o2o.order.service.IStockInService;
import com.yilidi.o2o.order.service.dto.StockInDto;
import com.yilidi.o2o.order.service.dto.query.StockInQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 入库服务实现类
 * 
 * @author simpson
 * 
 */
@Service("stockInService")
public class StockInServiceImpl extends BasicDataService implements IStockInService {

    @Autowired
    private StockInMapper stockInMapper;
    @Autowired
    private StockInItemMapper stockInItemMapper;
    @Autowired
    private SaleOrderMapper saleOrderMapper;
    @Autowired
    private SaleOrderItemMapper saleOrderItemMapper;
    @Autowired
    private FlittingOrderMapper flittingOrderMapper;
    @Autowired
    private FlittingOrderItemMapper flittingOrderItemMapper;
    @Autowired
    private PurchaseOrderMapper purchaseOrderMapper;
    @Autowired
    private PurchaseOrderItemMapper purchaseOrderItemMapper;
    @Autowired
    private SaleStockInRelationMapper saleStockInRelationMapper;
    @Autowired
    private FlittingStockInRelationMapper flittingStockInRelationMapper;
    @Autowired
    private PurchaseStockInRelationMapper purchaseStockInRelationMapper;

    @Override
    public StockInDto saveStockInBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(saleOrderNo)) {
                throw new OrderServiceException("订单编号不能为空");
            }
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrder)) {
                throw new OrderServiceException("根据订单编号查询不到订单信息");
            }
            if (!(SystemContext.OrderDomain.SALEORDERSENDSTATUS_SENT.equals(saleOrder.getSendStatus())
                    && (SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL.equals(saleOrder.getStatusCode())
                            || SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING.equals(saleOrder.getStatusCode())))) {
                // 必须是已经发货，并且取消或者退款中的订单才能进行
                throw new OrderServiceException("订单不是已经发货，并且取消或者退款中的订单，非法操作");
            }
            List<SaleOrderItem> saleOrderItems = saleOrderItemMapper.listBySaleOrderNo(saleOrderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrderItems)) {
                throw new OrderServiceException("订单明细为空，数据异常");
            }

            // 保存入库单信息
            StockIn stockIn = new StockIn();
            stockIn.setStoreId(saleOrder.getStoreId());
            stockIn.setStockInType(SystemContext.OrderDomain.STOCKINTYPE_AFTERSALE);
            stockIn.setStockInCount(saleOrder.getOrderCount());
            stockIn.setCreateTime(saleOrder.getCancelTime());
            stockIn.setCreateUserId(saleOrder.getCancelUserId());
            stockIn.setNote("订单退货入库");
            stockInMapper.save(stockIn);

            // 保存入库单明细信息
            for (SaleOrderItem saleOrderItem : saleOrderItems) {
                StockInItem stockInItem = new StockInItem();
                stockInItem.setStockInId(stockIn.getId());
                stockInItem.setSaleProductId(saleOrderItem.getSaleProductId());
                stockInItem.setQuantity(saleOrderItem.getQuantity());
                stockInItemMapper.save(stockInItem);
            }

            // 保存关联信息
            SaleStockInRelation saleStockInRelation = new SaleStockInRelation();
            saleStockInRelation.setSaleOrderNo(saleOrderNo);
            saleStockInRelation.setStockInId(stockIn.getId());
            saleStockInRelation.setCreateTime(saleOrder.getCancelTime());
            saleStockInRelation.setCreateUserId(saleOrder.getCancelUserId());
            saleStockInRelation.setOperType(SystemContext.OrderDomain.SALESTOCKINOPERTYPE_AFTERSALE);
            saleStockInRelationMapper.save(saleStockInRelation);

            StockInDto stockInDto = new StockInDto();
            ObjectUtils.fastCopy(stockIn, stockInDto);
            return stockInDto;
        } catch (Exception e) {
            logger.error("saveStockInBySaleOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<StockInDto> saveStockInByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(flittingOrderNo)) {
                throw new OrderServiceException("调拨单编号不能为空");
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException("根据调拨单编号查询不到调拨单信息");
            }
            if (!SystemContext.OrderDomain.FLITTINGORDERAUDITSTATUS_PASSED.equals(flittingOrder.getAuditStatus())) {
                throw new OrderServiceException("调拨单不是审核完成的调拨单，非法操作");
            }
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrderItems)) {
                throw new OrderServiceException("调拨单明细为空，数据异常");
            }

            List<StockInDto> resultDtos = new ArrayList<StockInDto>();
            // 根据实际收货的数量，创建调入店铺的入库单和明细
            StockIn destStockIn = new StockIn();
            destStockIn.setStoreId(flittingOrder.getDestStoreId());
            destStockIn.setStockInType(SystemContext.OrderDomain.STOCKINTYPE_FLITTING);
            destStockIn.setStockInCount(flittingOrder.getRealFlittingCount());
            destStockIn.setCreateTime(flittingOrder.getUpdateTime());
            destStockIn.setCreateUserId(flittingOrder.getAuditUserId());
            destStockIn.setNote("调货入库");
            stockInMapper.save(destStockIn);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                StockInItem destStockInItem = new StockInItem();
                destStockInItem.setStockInId(destStockIn.getId());
                destStockInItem.setSaleProductId(flittingOrderItem.getDestSaleProductId());
                destStockInItem.setQuantity(flittingOrderItem.getReceiveQuantity());
                stockInItemMapper.save(destStockInItem);
            }
            // 保存关联信息
            FlittingStockInRelation destFlittingStockInRelation = new FlittingStockInRelation();
            destFlittingStockInRelation.setFlittingOrderNo(flittingOrderNo);
            destFlittingStockInRelation.setStockInId(destStockIn.getId());
            destFlittingStockInRelation.setCreateTime(flittingOrder.getUpdateTime());
            destFlittingStockInRelation.setCreateUserId(flittingOrder.getUpdateUserId());
            destFlittingStockInRelation.setFlittingOperType(SystemContext.OrderDomain.FLITTINGSTOCKINOPERTYPE_FLITTINGIN);
            flittingStockInRelationMapper.save(destFlittingStockInRelation);

            StockInDto destStockInDto = new StockInDto();
            ObjectUtils.fastCopy(destStockIn, destStockInDto);
            resultDtos.add(destStockInDto);

            Integer rejectCount = flittingOrder.getFlittingCount() - flittingOrder.getRealFlittingCount();
            if (rejectCount > 0) {
                // 根据拒收的数量，创建调出店铺的入库单和明细
                StockIn srcStockIn = new StockIn();
                srcStockIn.setStoreId(flittingOrder.getSrcStoreId());
                srcStockIn.setStockInType(SystemContext.OrderDomain.STOCKINTYPE_FLITTING);
                srcStockIn.setStockInCount(rejectCount);
                srcStockIn.setCreateTime(flittingOrder.getUpdateTime());
                srcStockIn.setCreateUserId(flittingOrder.getAuditUserId());
                srcStockIn.setNote("调货拒收入库");
                stockInMapper.save(srcStockIn);
                for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                    StockInItem srcStockInItem = new StockInItem();
                    srcStockInItem.setStockInId(srcStockIn.getId());
                    srcStockInItem.setSaleProductId(flittingOrderItem.getSrcSaleProductId());
                    srcStockInItem.setQuantity(flittingOrderItem.getRejectQuantity());
                    stockInItemMapper.save(srcStockInItem);
                }
                // 保存关联信息
                FlittingStockInRelation srcFlittingStockInRelation = new FlittingStockInRelation();
                srcFlittingStockInRelation.setFlittingOrderNo(flittingOrderNo);
                srcFlittingStockInRelation.setStockInId(srcStockIn.getId());
                srcFlittingStockInRelation.setCreateTime(flittingOrder.getUpdateTime());
                srcFlittingStockInRelation.setCreateUserId(flittingOrder.getUpdateUserId());
                srcFlittingStockInRelation.setFlittingOperType(SystemContext.OrderDomain.FLITTINGSTOCKINOPERTYPE_REJECTIN);
                flittingStockInRelationMapper.save(srcFlittingStockInRelation);

                StockInDto srcStockInDto = new StockInDto();
                ObjectUtils.fastCopy(srcStockIn, srcStockInDto);
                resultDtos.add(srcStockInDto);
            }

            return resultDtos;
        } catch (Exception e) {
            logger.error("saveStockInByFlittingOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public StockInDto loadByStockInId(Integer stockInId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockInId)) {
                throw new OrderServiceException("入库单ID不能为空");
            }

            StockIn stockIn = stockInMapper.loadById(stockInId);
            StockInDto stockInDto = new StockInDto();
            ObjectUtils.fastCopy(stockIn, stockInDto);

            return stockInDto;
        } catch (Exception e) {
            logger.error("loadByStockInId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<StockInDto> findStockIns(StockInQueryDto stockInQueryDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockInQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }

            PageHelper.startPage(stockInQueryDto.getStart(), stockInQueryDto.getPageSize());
            Page<StockIn> pageStockIns = stockInMapper.findStockIns(stockInQueryDto.getStoreId(),
                    stockInQueryDto.getStockInType(), stockInQueryDto.getStartDate(), stockInQueryDto.getEndDate());
            Page<StockInDto> pageDto = new Page<StockInDto>(stockInQueryDto.getStart(), stockInQueryDto.getPageSize());
            ObjectUtils.fastCopy(pageStockIns, pageDto);
            List<StockIn> stockIns = pageStockIns.getResult();
            if (!ObjectUtils.isNullOrEmpty(stockIns)) {
                for (StockIn stockIn : stockIns) {
                    StockInDto stockInDto = new StockInDto();
                    ObjectUtils.fastCopy(stockIn, stockInDto);
                    pageDto.add(stockInDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findStockIns异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public StockInDto saveStockInByPurchaseOrderNo(String purchaseOrderNo, Map<Integer, Integer> saleProductMap)
            throws OrderServiceException {
        try {
            if (StringUtils.isBlank(purchaseOrderNo)) {
                throw new OrderServiceException("采购单编号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(saleProductMap)) {
                throw new OrderServiceException("入库的商品不能为空");
            }
            PurchaseOrder purchaseOrder = purchaseOrderMapper.loadByPurchaseOrderNo(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrder)) {
                throw new OrderServiceException("根据采购单编号查询不到采购单信息");
            }
            if (!SystemContext.OrderDomain.PURCHASEORDERSTATUS_AUDIT_PASSED.equals(purchaseOrder.getOrderStatus())) {
                throw new OrderServiceException("采购单不是审核完成的采购单，非法操作");
            }
            List<PurchaseOrderItem> purchaseOrderItems = purchaseOrderItemMapper.listPurchaseOrderItems(purchaseOrderNo);
            if (ObjectUtils.isNullOrEmpty(purchaseOrderItems)) {
                throw new OrderServiceException("采购单明细为空，数据异常");
            }

            // 创建采购微仓的入库单和明细
            StockIn stockIn = new StockIn();
            stockIn.setStoreId(purchaseOrder.getStoreId());
            stockIn.setStockInType(SystemContext.OrderDomain.STOCKINTYPE_PURCHASE);
            stockIn.setStockInCount(purchaseOrder.getPurchaseCount());
            stockIn.setCreateTime(purchaseOrder.getAuditTime());
            stockIn.setCreateUserId(purchaseOrder.getAuditUserId());
            stockIn.setNote("采购入库");
            stockInMapper.save(stockIn);

            for (PurchaseOrderItem purchaseOrderItem : purchaseOrderItems) {
                StockInItem stockInItem = new StockInItem();
                stockInItem.setStockInId(stockIn.getId());
                Integer saleProductId = saleProductMap.get(purchaseOrderItem.getProductId());
                if (null == saleProductId) {
                    logger.error("没有找到入库的商品ID[" + purchaseOrderItem.getProductId() + "]");
                    throw new OrderServiceException("没有找到入库的商品");
                }
                stockInItem.setSaleProductId(saleProductId);
                stockInItem.setQuantity(purchaseOrderItem.getQuantity());
                stockInItemMapper.save(stockInItem);
            }

            // 保存关联信息
            PurchaseStockInRelation purchaseStockInRelation = new PurchaseStockInRelation();
            purchaseStockInRelation.setPurchaseOrderNo(purchaseOrderNo);
            purchaseStockInRelation.setStockInId(stockIn.getId());
            purchaseStockInRelation.setCreateTime(purchaseOrder.getAuditTime());
            purchaseStockInRelation.setCreateUserId(purchaseOrder.getUpdateUserId());
            purchaseStockInRelation.setPurchaseOperType(SystemContext.OrderDomain.PURCHASESTOCKINOPERTYPE_PURCHASEIN);
            purchaseStockInRelationMapper.save(purchaseStockInRelation);

            StockInDto destStockInDto = new StockInDto();
            ObjectUtils.fastCopy(stockIn, destStockInDto);
            return destStockInDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
