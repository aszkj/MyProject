package com.yilidi.o2o.order.service.impl;

import java.util.List;

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
import com.yilidi.o2o.order.dao.FlittingStockOutRelationMapper;
import com.yilidi.o2o.order.dao.SaleOrderItemMapper;
import com.yilidi.o2o.order.dao.SaleOrderMapper;
import com.yilidi.o2o.order.dao.SaleStockOutRelationMapper;
import com.yilidi.o2o.order.dao.StockOutItemMapper;
import com.yilidi.o2o.order.dao.StockOutMapper;
import com.yilidi.o2o.order.dao.StockOutOrderItemMapper;
import com.yilidi.o2o.order.dao.StockOutOrderMapper;
import com.yilidi.o2o.order.dao.StockOutOrderStockOutRelationMapper;
import com.yilidi.o2o.order.model.FlittingOrder;
import com.yilidi.o2o.order.model.FlittingOrderItem;
import com.yilidi.o2o.order.model.FlittingStockOutRelation;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.SaleStockOutRelation;
import com.yilidi.o2o.order.model.StockOut;
import com.yilidi.o2o.order.model.StockOutItem;
import com.yilidi.o2o.order.model.StockOutOrder;
import com.yilidi.o2o.order.model.StockOutOrderItem;
import com.yilidi.o2o.order.model.StockOutOrderStockOutRelation;
import com.yilidi.o2o.order.service.IStockOutService;
import com.yilidi.o2o.order.service.dto.StockOutDto;
import com.yilidi.o2o.order.service.dto.query.StockOutQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 出库单服务实现类
 * 
 * @author chenb
 * 
 */
@Service("stockOutService")
public class StockOutServiceImpl extends BasicDataService implements IStockOutService {

    @Autowired
    private StockOutMapper stockOutMapper;
    @Autowired
    private StockOutItemMapper stockOutItemMapper;
    @Autowired
    private SaleOrderMapper saleOrderMapper;
    @Autowired
    private SaleOrderItemMapper saleOrderItemMapper;
    @Autowired
    private FlittingOrderMapper flittingOrderMapper;
    @Autowired
    private FlittingOrderItemMapper flittingOrderItemMapper;
    @Autowired
    private SaleStockOutRelationMapper saleStockOutRelationMapper;
    @Autowired
    private FlittingStockOutRelationMapper flittingStockOutRelationMapper;
    @Autowired
    private StockOutOrderStockOutRelationMapper stockOutOrderStockOutRelationMapper;
    @Autowired
    private StockOutOrderMapper stockOutOrderMapper;
    @Autowired
    private StockOutOrderItemMapper stockOutOrderItemMapper;

    @Override
    public StockOutDto saveStockOutBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(saleOrderNo)) {
                throw new OrderServiceException("订单编号不能为空");
            }
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrder)) {
                throw new OrderServiceException("根据订单编号查询不到订单信息");
            }
            if (!(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(saleOrder.getStatusCode()))) {
                // 必须是待收货订单才能进行
                throw new OrderServiceException("订单不是待收货订单，非法操作");
            }
            List<SaleOrderItem> saleOrderItems = saleOrderItemMapper.listBySaleOrderNo(saleOrderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrderItems)) {
                throw new OrderServiceException("订单明细为空，数据异常");
            }

            StockOut stockOut = new StockOut();
            stockOut.setStoreId(saleOrder.getStoreId());
            stockOut.setStockOutType(SystemContext.OrderDomain.STOCKOUTTYPE_SEND);
            stockOut.setStockOutCount(saleOrder.getOrderCount());
            stockOut.setCreateTime(saleOrder.getSendTime());
            stockOut.setCreateUserId(saleOrder.getSendUserId());
            stockOut.setNote("订单发货出库");
            stockOutMapper.save(stockOut);

            for (SaleOrderItem saleOrderItem : saleOrderItems) {
                StockOutItem stockOutItem = new StockOutItem();
                stockOutItem.setStockOutId(stockOut.getId());
                stockOutItem.setSaleProductId(saleOrderItem.getSaleProductId());
                stockOutItem.setQuantity(saleOrderItem.getQuantity());
                stockOutItemMapper.save(stockOutItem);
            }

            // 保存关联信息
            SaleStockOutRelation saleStockOutRelation = new SaleStockOutRelation();
            saleStockOutRelation.setSaleOrderNo(saleOrderNo);
            saleStockOutRelation.setStockOutId(stockOut.getId());
            saleStockOutRelation.setCreateTime(saleOrder.getSendTime());
            saleStockOutRelation.setCreateUserId(saleOrder.getSendUserId());
            saleStockOutRelation.setOperType(SystemContext.OrderDomain.SALESTOCKOUTOPERTYPE_SEND);
            saleStockOutRelationMapper.save(saleStockOutRelation);

            StockOutDto stockOutDto = new StockOutDto();
            ObjectUtils.fastCopy(stockOut, stockOutDto);
            return stockOutDto;
        } catch (Exception e) {
            logger.error("saveStockOutBySaleOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public StockOutDto saveStockOutByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(flittingOrderNo)) {
                throw new OrderServiceException("调拨单编号不能为空");
            }
            FlittingOrder flittingOrder = flittingOrderMapper.loadByFlittingOrderNo(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrder)) {
                throw new OrderServiceException("根据调拨单编号查询不到调拨单信息");
            }
            if (!SystemContext.OrderDomain.FLITTINGORDERSTATUS_SEND.equals(flittingOrder.getOrderStatus())) {
                throw new OrderServiceException("调拨单不是已发货的调拨单，非法操作");
            }
            List<FlittingOrderItem> flittingOrderItems = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(flittingOrderItems)) {
                throw new OrderServiceException("调拨单明细为空，数据异常");
            }

            // 根据实际收货的数量，创建调入店铺的入库单和明细
            StockOut stockOut = new StockOut();
            stockOut.setStoreId(flittingOrder.getSrcStoreId());
            stockOut.setStockOutType(SystemContext.OrderDomain.STOCKOUTTYPE_FLITTING);
            stockOut.setStockOutCount(flittingOrder.getFlittingCount());
            stockOut.setCreateTime(flittingOrder.getSendTime());
            stockOut.setCreateUserId(flittingOrder.getSendUserId());
            stockOut.setNote("调货出库");
            stockOutMapper.save(stockOut);
            for (FlittingOrderItem flittingOrderItem : flittingOrderItems) {
                StockOutItem stockOutItem = new StockOutItem();
                stockOutItem.setStockOutId(stockOut.getId());
                stockOutItem.setSaleProductId(flittingOrderItem.getSrcSaleProductId());
                stockOutItem.setQuantity(flittingOrderItem.getQuantity());
                stockOutItemMapper.save(stockOutItem);
            }

            // 保存关联信息
            FlittingStockOutRelation flittingStockOutRelation = new FlittingStockOutRelation();
            flittingStockOutRelation.setFlittingOrderNo(flittingOrderNo);
            flittingStockOutRelation.setStockOutId(stockOut.getId());
            flittingStockOutRelation.setCreateTime(flittingOrder.getSendTime());
            flittingStockOutRelation.setCreateUserId(flittingOrder.getSendUserId());
            flittingStockOutRelation.setFlittingOperType(SystemContext.OrderDomain.FLITTINGSTOCKOUTOPERTYPE_FLITTINGOUT);
            flittingStockOutRelationMapper.save(flittingStockOutRelation);

            StockOutDto stockOutDto = new StockOutDto();
            ObjectUtils.fastCopy(stockOut, stockOutDto);
            return stockOutDto;
        } catch (Exception e) {
            logger.error("saveStockOutByFlittingOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public StockOutDto loadByStockOutId(Integer stockOutId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutId)) {
                throw new OrderServiceException("出库单ID不能为空");
            }

            StockOut stockOut = stockOutMapper.loadById(stockOutId);
            StockOutDto stockOutDto = new StockOutDto();
            ObjectUtils.fastCopy(stockOut, stockOutDto);

            return stockOutDto;
        } catch (Exception e) {
            logger.error("loadByStockOutId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<StockOutDto> findStockOuts(StockOutQueryDto stockOutQueryDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(stockOutQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }

            PageHelper.startPage(stockOutQueryDto.getStart(), stockOutQueryDto.getPageSize());
            Page<StockOut> pageStockOuts = stockOutMapper.findStockOuts(stockOutQueryDto.getStoreId(),
                    stockOutQueryDto.getStockOutType(), stockOutQueryDto.getStartDate(), stockOutQueryDto.getEndDate());
            Page<StockOutDto> pageDto = new Page<StockOutDto>(stockOutQueryDto.getStart(), stockOutQueryDto.getPageSize());
            ObjectUtils.fastCopy(pageStockOuts, pageDto);
            List<StockOut> stockOuts = pageStockOuts.getResult();
            if (!ObjectUtils.isNullOrEmpty(stockOuts)) {
                for (StockOut stockOut : stockOuts) {
                    StockOutDto stockOutDto = new StockOutDto();
                    ObjectUtils.fastCopy(stockOut, stockOutDto);
                    pageDto.add(stockOutDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findStockOuts异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public StockOutDto saveStockOutByStockOutOrderNo(String stockOutOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(stockOutOrderNo)) {
                throw new OrderServiceException("出库单编号不能为空");
            }
            StockOutOrder stockOutOrder = stockOutOrderMapper.loadByStockOutOrderNo(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrder)) {
                throw new OrderServiceException("根据出库单编号查询不到出库单信息");
            }
            if (!SystemContext.OrderDomain.STOCKOUTORDERSTATUS_AUDIT_PASSED.equals(stockOutOrder.getOrderStatus())) {
                throw new OrderServiceException("出库单不是审核通过的出库单，非法操作");
            }
            List<StockOutOrderItem> stockOutOrderItems = stockOutOrderItemMapper.listStockOutOrderItems(stockOutOrderNo);
            if (ObjectUtils.isNullOrEmpty(stockOutOrderItems)) {
                throw new OrderServiceException("出库单明细为空，数据异常");
            }

            // 根据实际收货的数量，创建调入店铺的入库单和明细
            StockOut stockOut = new StockOut();
            stockOut.setStoreId(stockOutOrder.getStoreId());
            stockOut.setStockOutType(SystemContext.OrderDomain.STOCKOUTTYPE_STOCKOUTORDER);
            stockOut.setStockOutCount(stockOutOrder.getStockOutCount());
            stockOut.setCreateTime(stockOutOrder.getAuditTime());
            stockOut.setCreateUserId(stockOutOrder.getAuditUserId());
            stockOut.setNote("出库单出库");
            stockOutMapper.save(stockOut);
            for (StockOutOrderItem stockOutOrderItem : stockOutOrderItems) {
                StockOutItem stockOutItem = new StockOutItem();
                stockOutItem.setStockOutId(stockOut.getId());
                stockOutItem.setSaleProductId(stockOutOrderItem.getSaleProductId());
                stockOutItem.setQuantity(stockOutOrderItem.getQuantity());
                stockOutItemMapper.save(stockOutItem);
            }

            // 保存关联信息
            StockOutOrderStockOutRelation stockOutOrderStockOutRelation = new StockOutOrderStockOutRelation();
            stockOutOrderStockOutRelation.setStockOutOrderNo(stockOutOrderNo);
            stockOutOrderStockOutRelation.setStockOutId(stockOut.getId());
            stockOutOrderStockOutRelation.setCreateTime(stockOutOrder.getAuditTime());
            stockOutOrderStockOutRelation.setCreateUserId(stockOutOrder.getAuditUserId());
            stockOutOrderStockOutRelation
                    .setStockOutOperType(SystemContext.OrderDomain.STOCKOUTORDERSTOCKOUTOPERTYPE_STOCKOUT);
            stockOutOrderStockOutRelationMapper.save(stockOutOrderStockOutRelation);

            StockOutDto stockOutDto = new StockOutDto();
            ObjectUtils.fastCopy(stockOut, stockOutDto);
            return stockOutDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
