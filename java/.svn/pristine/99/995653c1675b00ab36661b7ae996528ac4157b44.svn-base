package com.yilidi.o2o.controller.warehouse.product;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.WarehouseBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISaleProductProfileService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.report.export.product.WarehouseSaleProductInventoryReportExport;

/**
 * 微仓商品管理
 * 
 * @author: chenb
 * @date: 2016年6月1日 下午5:33:29
 */
@Controller("warehouseSaleProductController")
@RequestMapping(value = "/warehouse")
public class SaleProductController extends WarehouseBaseController {
    private static final String APPCHANNELCODE = SystemContext.UserDomain.CHANNELTYPE_ALL;

    @Autowired
    private ISaleProductProfileService saleProductProfileService;

    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private WarehouseSaleProductInventoryReportExport warehouseSaleProductInventoryReportExport;

    /**
     * 查询商品列表
     * 
     * @param saleProductQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/saleproduct/list")
    @ResponseBody
    public MsgBean listSaleProduct(@RequestBody SaleProductQuery saleProductQuery) {
        try {
            saleProductQuery.setStoreId(super.getStoreId());
            YiLiDiPage<SaleProductAppDto> page = saleProductService.findSaleProducts(saleProductQuery);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店列表成功");
        } catch (Exception e) {
            logger.error("查询门店列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品上下架
     * 
     * @param param
     *            商品ID和上下架状态
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saleproduct/{param}/updatesalestatus")
    @ResponseBody
    public MsgBean updateSaleProductSaleStatus(@PathVariable String param) {
        try {
            logger.info("更新实体传递参数：商品信息" + param);
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (null == params || params.length != 2) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "参数不合法");
                }
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(params[1])) {
                    typeString = "下架";
                } else {
                    typeString = "上架";
                }
                saleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode(Integer.valueOf(params[0]),
                        params[1], APPCHANNELCODE, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品" + typeString + "成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品" + typeString + "失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品批量上架
     * 
     * @param param
     *            商品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saleproduct/{param}/updatebatchonsale")
    @ResponseBody
    public MsgBean updateSaleProductBatchOnSale(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, APPCHANNELCODE, super.getUserId(),
                            new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量上架成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量上架失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品批量下架架
     * 
     * @param param
     *            商品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saleproduct/{param}/updatebatchoffsale")
    @ResponseBody
    public MsgBean updateSaleProductBatchOffSale(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE, APPCHANNELCODE, super.getUserId(),
                            new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量下架成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量下架失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 修改商品顺序
     * 
     * @param saleProductId
     *            商品Id
     * @param saleProductProfileDto
     *            商品saleProductDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saleproduct/{saleProductId}/updatedisplayorder")
    @ResponseBody
    public MsgBean updateSaleProductDisplayOrder(@PathVariable Integer saleProductId,
            @RequestBody SaleProductProfileDto saleProductProfileDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto) && !ObjectUtils.isNullOrEmpty(saleProductId)) {
                saleProductProfileService.updateSaleProductDisplayOrder(saleProductId,
                        saleProductProfileDto.getDisplayOrder(), APPCHANNELCODE, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品顺序修改成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量修改商品分类传递参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出商品库存信息列表
     * 
     * @param saleProductQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping("/saleproduct/exportsearchinventory")
    @ResponseBody
    public MsgBean exportSearchSaleProductInventory(@RequestBody SaleProductQuery saleProductQuery) {
        try {
            saleProductQuery.setStoreId(getStoreId());
            ReportFileModel reportFileModel = warehouseSaleProductInventoryReportExport.exportExcel(saleProductQuery,
                    "商品库存报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商品报表导出成功");
        } catch (Exception e) {
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
