package com.yilidi.o2o.controller.operation.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductImageService;
import com.yilidi.o2o.product.service.ISaleProductPriceService;
import com.yilidi.o2o.product.service.ISaleProductProfileService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.ISaleProductTempService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductOtherBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductSortBatchSaveDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.report.export.product.SaleProductInventoryReportExport;
import com.yilidi.o2o.report.export.product.SaleProductReportExport;
import com.yilidi.o2o.report.imports.product.SaleProductOtherReportImport;
import com.yilidi.o2o.report.imports.product.SaleProductReportImport;
import com.yilidi.o2o.report.imports.product.SaleProductSortReportImport;

/**
 * 功能描述：商品控制器 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/operation")
public class SaleProductController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    private static final String APPCHANNELCODE = SystemContext.UserDomain.CHANNELTYPE_ALL;

    @Autowired
    private ISaleProductService saleProductService;

    @Autowired
    private ISaleProductTempService saleProductTempService;

    @Autowired
    private IProductService productService;

    @Autowired
    private IProductClassService productClassService;

    @Autowired
    private ISaleProductProfileService saleProductProfileService;

    @Autowired
    private ISaleProductImageService saleProductImageService;

    @Autowired
    private ISaleProductPriceService saleProductPriceService;

    @Autowired
    private SaleProductReportExport saleProductReportExport;

    @Autowired
    private SaleProductInventoryReportExport saleProductInventoryReportExport;

    @Autowired
    private SaleProductReportImport saleProductReportImport;

    @Autowired
    private SaleProductSortReportImport saleProductSortReportImport;

    @Autowired
    private SaleProductOtherReportImport saleProductOtherReportImport;

    //
    // /**
    // * 新增单个商品
    // *
    // * @param saleProductDto
    // * 商品保存实体
    // * @return MsgBean
    // * @throws SaleProductServiceException
    // */
    // @RequestMapping(value = "/saveSaleProduct")
    // @ResponseBody
    // public MsgBean saveSaleProduct(@RequestBody SaleProductDto saleProductDto) {
    // try {
    // if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
    // saleProductService.saveSaleProduct(saleProductDto, APPCHANNELCODE);
    //
    // return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品保存成功");
    // } else {
    // return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品保存失败");
    //
    // }
    // } catch (Exception e) {
    // logger.error(e.getMessage());
    // logger.info("保存失败：商品保存失败" + e.getMessage());
    // return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品保存失败");
    // }
    // }

    /**
     * 批量新增商品（批量添加）
     * 
     * @param param
     *            所保存的商品id
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    @RequestMapping(value = "/{param}/batchSaveSaleProduct")
    @ResponseBody
    public MsgBean batchSaveSaleProduct(@PathVariable String param) {
        try {
            List<SaleProductDto> listSaleProductDto = null;
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                Integer storeId = Integer.valueOf(arrParam[arrParam.length - 2]);
                String storeType = arrParam[arrParam.length - 1];

                listSaleProductDto = new ArrayList<SaleProductDto>();
                for (int i = 0; i < arrParam.length - 2; i++) {
                    // 根据产品id和渠道编码获取到产品
                    Integer productId = null;
                    Integer perOperCount = null;
                    if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeType)) {
                        String[] arrIdAndPerOperCount = arrParam[i].split("_");
                        productId = Integer.valueOf(arrIdAndPerOperCount[0]);
                        perOperCount = Integer.valueOf(arrIdAndPerOperCount[1]);
                    } else {
                        productId = Integer.valueOf(arrParam[i]);
                    }
                    ProductDto productDto = productService.loadProductByProductIdAndChannelCode(productId, APPCHANNELCODE);
                    SaleProductDto saleProductDto = pakageToSaleProductDto(productDto, storeId, super.getUserId(),
                            DateUtils.getCurrentDateTime());
                    if (null != perOperCount) {
                        saleProductDto.setPerOperCount(perOperCount);
                    }
                    listSaleProductDto.add(saleProductDto);
                }
                List<String> errorString = null;
                if (!ObjectUtils.isNullOrEmpty(listSaleProductDto)) {
                    errorString = saleProductService.saveSaleProducts(listSaleProductDto, storeType, APPCHANNELCODE);
                }
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    errorString.add(0, "商品批量保存成功，但以下产品未被成功添加：");
                    return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "商品批量保存成功");
                } else {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量保存成功");
                }
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品批量保存前台参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("批量保存失败：商品批量保存失败" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将产品Dto封装成商品Dto（批量添加）
     * 
     * @param productDto
     *            产品品Dto
     * @param storeId
     *            商店Id
     * @param loginId
     *            用户loginId
     * @param createTime
     *            商品createTime
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageToSaleProductDto(ProductDto productDto, Integer storeId, Integer loginId, Date createTime) {
        SaleProductDto saleProductDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                saleProductDto = new SaleProductDto();
                saleProductDto.setStoreId(storeId);
                saleProductDto.setProductId(productDto.getId());
                saleProductDto.setProductClassCode(productDto.getProductClassCode());
                saleProductDto.setBrandCode(productDto.getBrandCode());
                saleProductDto.setSaleProductName(productDto.getProductName());
                saleProductDto.setBarCode(productDto.getBarCode());
                saleProductDto.setPerOperCount(productDto.getPerOperCount());
                // 默认为审核通过状态
                saleProductDto.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
                // 默认为启用状态
                saleProductDto.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
                saleProductDto.setAuditTime(createTime);
                saleProductDto.setAuditUserId(loginId);
                saleProductDto.setCreateTime(createTime);
                saleProductDto.setCreateUserId(loginId);
                saleProductDto.setModifyTime(createTime);
                saleProductDto.setModifyUserId(loginId);
                // 封装商品的价格信息
                SaleProductPriceDto saleProductPriceDto = null;
                ProductPriceDto productPriceDto = productDto.getProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                    saleProductPriceDto = new SaleProductPriceDto();
                    saleProductPriceDto.setPromotionalPrice(productPriceDto.getPromotionalPrice());
                    saleProductPriceDto.setRetailPrice(productPriceDto.getRetailPrice());
                    saleProductPriceDto.setCommissionPrice(productPriceDto.getCommissionPrice());
                    saleProductPriceDto.setCostPrice(productPriceDto.getCostPrice());
                    saleProductPriceDto.setVipCommissionPrice(productPriceDto.getVipCommissionPrice());
                    saleProductPriceDto.setCreateTime(createTime);
                    saleProductPriceDto.setCreateUserId(loginId);
                    saleProductPriceDto.setModifyTime(createTime);
                    saleProductPriceDto.setModifyUserId(loginId);
                    saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
                }
                // 封装商品的附属信息
                SaleProductProfileDto saleProductProfileDto = null;
                ProductProfileDto productProfileDto = productDto.getProductProfileDto();
                if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                    saleProductProfileDto = new SaleProductProfileDto();
                    saleProductProfileDto.setContent(productProfileDto.getContent());
                    saleProductProfileDto.setDisplayOrder(productProfileDto.getDisplayOrder());
                    saleProductProfileDto.setHotSaleFlag(productProfileDto.getHotSaleFlag());
                    saleProductProfileDto.setProductOwner(productProfileDto.getProductOwner());
                    if (productProfileDto.getSaleStatus().equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_INIT)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_INIT);
                    } else if (productProfileDto.getSaleStatus().equals(
                            SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                    } else if (productProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
                    }
                    saleProductProfileDto.setSaleProductSpec(productProfileDto.getProductSpec());
                    saleProductProfileDto.setSellPoint(productProfileDto.getSellPoint());
                    // 此处来源是从标准库导入的
                    saleProductProfileDto.setSaleProductSource(SystemContext.ProductDomain.SALEPRODUCTSOURCE_STANDARD);
                    saleProductProfileDto.setCreateTime(createTime);
                    saleProductProfileDto.setCreateUserId(loginId);
                    saleProductProfileDto.setModifyTime(createTime);
                    saleProductProfileDto.setModifyUserId(loginId);
                    saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
                }
                // 封装商品的图片信息
                List<ProductImageDto> productImageDtoList = productDto.getProductImageDtos();
                List<SaleProductImageDto> saleProductImageDtoList = null;
                if (!ObjectUtils.isNullOrEmpty(productImageDtoList)) {
                    saleProductImageDtoList = new ArrayList<SaleProductImageDto>();
                    for (ProductImageDto productImageDto : productImageDtoList) {
                        SaleProductImageDto saleProductImageDto = null;
                        if (!ObjectUtils.isNullOrEmpty(productImageDto)) {
                            saleProductImageDto = new SaleProductImageDto();
                            saleProductImageDto.setImageUrl(productImageDto.getImageUrl());
                            saleProductImageDto.setMasterFlag(productImageDto.getMasterFlag());
                            saleProductImageDto.setImageOrder(productImageDto.getImageOrder());
                            saleProductImageDto.setCreateTime(createTime);
                            saleProductImageDto.setCreateUserId(loginId);
                            saleProductImageDto.setModifyTime(createTime);
                            saleProductImageDto.setModifyUserId(loginId);
                            saleProductImageDtoList.add(saleProductImageDto);
                        }
                    }
                    saleProductDto.setSaleProductImageDtos(saleProductImageDtoList);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将产品Dto封装成商品Dto" + e.getMessage());
            throw new ProductServiceException("异常：将产品Dto封装成商品Dto");
        }
        return saleProductDto;
    }

    /**
     * 查询商品显示信息列表
     * 
     * @param querySaleProduct
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{storeType}/listSaleProductRelativeInfos")
    @ResponseBody
    public MsgBean listSaleProductRelativeInfos(@PathVariable String storeType,
            @RequestBody SaleProductQuery querySaleProduct) {
        try {
            querySaleProduct.setChannelCode(APPCHANNELCODE);
            querySaleProduct.setStoreType(storeType);
            YiLiDiPage<SaleProductDto> page = saleProductService.findSaleProductRelativeInfos(querySaleProduct);
            if (!ObjectUtils.isNullOrEmpty(page)) {
                return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "商品显示信息列表查询成功");
            } else {
                logger.info("查询失败：商品显示信息列表不存在");
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品显示信息列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取商品
     * 
     * @param saleProductId
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{saleProductId}/loadSaleProduct")
    @ResponseBody
    public MsgBean loadSaleProduct(@PathVariable Integer saleProductId) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductId)) {
                SaleProductDto saleProductDto = saleProductService.loadSaleProductByIdAndChannelCode(saleProductId, null,
                        null, APPCHANNELCODE);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                    return super.encapsulateMsgBean(saleProductDto, MsgBean.MsgCode.SUCCESS, "商品查询成功");
                } else {
                    logger.info("查询失败：商品信息不存在");
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品不存在");
                }
            } else {
                logger.info("失败：查询参数商品编码为空");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "查询参数商品编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 更新商品
     * 
     * @param saleProductDto
     *            更新实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/updateSaleProduct")
    @ResponseBody
    public MsgBean updateSaleProduct(@RequestBody SaleProductDto saleProductDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                saleProductDto.setModifyUserId(super.getUserId());
                saleProductDto.setModifyTime(new Date());
                saleProductService.updateSaleProduct(saleProductDto, APPCHANNELCODE);
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品信息更新成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "需要更新商品参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：商品更新失败" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品禁用和启用
     * 
     * @param param
     *            商品ID和有效状态
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateEnabledFlag")
    @ResponseBody
    public MsgBean updateEnabledFlag(@PathVariable String param) {
        try {
            logger.info("商品禁用和启用的参数" + param);
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON)) {
                    typeString = "启用";
                } else {
                    typeString = "禁用";
                }
                saleProductService.updateEnabledFlag(Integer.valueOf(params[0]), params[1], super.getUserId(), new Date());
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
     * 商品批量启用
     * 
     * @param param
     *            商品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/batchEnabledSaleProduct")
    @ResponseBody
    public MsgBean batchEnabledSaleProduct(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductService.updateEnabledFlag(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON, super.getUserId(), new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量启用成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量启用失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品批量禁用
     * 
     * @param param
     *            商品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/batchDisabledSaleProduct")
    @ResponseBody
    public MsgBean batchDisabledSaleProduct(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductService.updateEnabledFlag(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_OFF, super.getUserId(), new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量禁用成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量禁用失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
    @RequestMapping(value = "/{param}/updateSaleProductSaleStatus")
    @ResponseBody
    public MsgBean updateSaleProductSaleStatus(@PathVariable String param) {
        try {
            logger.info("更新实体传递参数：商品信息" + param);
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE)) {
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
    @RequestMapping(value = "/{param}/updateSaleProductBatchOnSale")
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
    @RequestMapping(value = "/{param}/updateSaleProductBatchOffSale")
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
     * 商品热卖和非热卖
     * 
     * @param param
     *            商品ID和热卖标示
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateSaleProductHotSaleFlag")
    @ResponseBody
    public MsgBean updateSaleProductHotSaleFlag(@PathVariable String param) {
        try {
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.HOTSALEFLAG_YES)) {
                    typeString = "热卖";
                } else {
                    typeString = "取消热卖";
                }
                saleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode(Integer.valueOf(params[0]),
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
     * 商品批量非热卖
     * 
     * @param param
     *            商品Id组
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateSaleProductBatchNoHot")
    @ResponseBody
    public MsgBean updateSaleProductBatchNoHot(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.HOTSALEFLAG_NO, APPCHANNELCODE, super.getUserId(), new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量非热卖成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量非热卖失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品批量热卖
     * 
     * @param param
     *            商品Id组
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateSaleProductBatchHot")
    @ResponseBody
    public MsgBean updateSaleProductBatchHot(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    saleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.HOTSALEFLAG_YES, APPCHANNELCODE, super.getUserId(), new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量热卖成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量热卖失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 商品批量修改商品分类
     * 
     * @param param
     *            商品Id组
     * @param productDto
     *            商品productDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateSaleProductClassForBatch")
    @ResponseBody
    public MsgBean updateSaleProductClassForBatch(@PathVariable String param, @RequestBody ProductDto productDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String idString : arrParam) {
                    saleProductService.updateProductClass(Integer.valueOf(idString), productDto.getProductClassCode(),
                            super.getUserId(), new Date());
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量修改商品分类成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品批量修改商品分类传递参数为空");
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
    @RequestMapping(value = "/{saleProductId}/updateSaleProductDisplayOrder")
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
     * 添加到标准库
     * 
     * @param id
     *            商品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{id}/addToStandard")
    @ResponseBody
    public MsgBean addToStandard(@PathVariable Integer id) {
        try {
            if (!ObjectUtils.isNullOrEmpty(id)) {
                // 根据产品id和渠道编码获取到产品
                SaleProductDto saleProductDto = saleProductService.loadSaleProductByIdAndChannelCode(id, null, null,
                        APPCHANNELCODE);
                String errorString = saleProductService.addToStandard(saleProductDto, APPCHANNELCODE, super.getUserId(),
                        new Date());
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品添加到标准库保存失败：<br>" + errorString);
                } else {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "添加到标准库成功");
                }
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品添加到标准库传递参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出商品显示信息列表
     * 
     * @param querySaleProduct
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/exportSearchSaleProduct")
    @ResponseBody
    public MsgBean exportSearchSaleProduct(@RequestBody SaleProductQuery querySaleProduct) {
        try {
            ReportFileModel reportFileModel = saleProductReportExport.exportExcel(querySaleProduct, "商品报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商品报表导出成功");
        } catch (Exception e) {
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导入商品（标准库）报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForSaleProduct")
    @ResponseBody
    public MsgBean uploadToTempForSaleProduct(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.SALEPRODUCT_FROM_STANDARD_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            String storeId = req.getParameter("storeId");
            String storeType = req.getParameter("storeType");
            // 导入标准库商品
            SaleProductBatchSaveDto saleProductBatchSaveDto = new SaleProductBatchSaveDto(Integer.valueOf(storeId),
                    super.getUserId(), new Date(), APPCHANNELCODE, storeType);
            List<String> validateTipsList = saleProductReportImport.importExcel(filePathSub, saleProductBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "导入商品（标准库）报表失败");
            } else {
                logger.info("导入商品（标准库）报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入商品（标准库）报表成功");
            }
        } catch (Exception e) {
            logger.error("导入商品（标准库）报表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导入商品顺序报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForSaleProductSort")
    @ResponseBody
    public MsgBean uploadToTempForSaleProductSort(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.SALEPRODUCT_SORT_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            String storeId = req.getParameter("storeId");
            // 导入商品顺序报表
            SaleProductSortBatchSaveDto saleProductSortBatchSaveDto = new SaleProductSortBatchSaveDto(
                    Integer.valueOf(storeId), super.getUserId(), new Date(), APPCHANNELCODE);
            List<String> validateTipsList = saleProductSortReportImport
                    .importExcel(filePathSub, saleProductSortBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "导入商品顺序报表失败");
            } else {
                logger.info("导入商品顺序报表成功");
                // 删除临时生成的报表文件
                fileUploadUtils.deleteTempFile(filePathSub);
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入商品顺序报表成功");
            }
        } catch (Exception e) {
            logger.error("导入商品顺序报表异常：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导入其他商品（非标准库）报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForSaleProductOther")
    @ResponseBody
    public MsgBean uploadToTempForSaleProductOther(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.SALEPRODUCT_FROM_OTHER_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            String storeId = req.getParameter("storeId");
            String storeType = req.getParameter("storeType");
            // 导入其他商品报表
            SaleProductOtherBatchSaveDto saleProductOtherBatchSaveDto = new SaleProductOtherBatchSaveDto(
                    Integer.valueOf(storeId), super.getUserId(), new Date(), APPCHANNELCODE, storeType);
            List<String> validateTipsList = saleProductOtherReportImport.importExcel(filePathSub,
                    saleProductOtherBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "导入商品报表失败");
            } else {
                logger.info("导入其他商品（非标准库）报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入其他商品（非标准库）报表成功");
            }
        } catch (Exception e) {
            logger.error("导入其他商品（非标准库）报表异常：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取临时商品
     * 
     * @param saleProductId
     *            参数saleProductId
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{saleProductId}/loadSaleProductTemp")
    @ResponseBody
    public MsgBean loadSaleProductTemp(@PathVariable Integer saleProductId) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductId)) {
                SaleProductDto saleProductDto = saleProductTempService.loadSaleProductTempByIdAndChannelCode(saleProductId,
                        APPCHANNELCODE);
                if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                    return super.encapsulateMsgBean(saleProductDto, MsgBean.MsgCode.SUCCESS, "临时商品查询成功");
                } else {
                    logger.info("查询失败：临时商品信息不存在");
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "临时商品不存在");
                }
            } else {
                logger.info("失败：查询参数临时商品id为空");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "查询参数临时商品id为空");
            }
        } catch (Exception e) {
            logger.error("失败：查询临时商品异常：" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 审核临时商品
     * 
     * @param auditSaleProductDto
     *            参数auditSaleProductDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/auditSaleProductTemp")
    @ResponseBody
    public MsgBean auditSaleProductTemp(@RequestBody SaleProductDto auditSaleProductDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(auditSaleProductDto)) {
                String errorString = saleProductTempService.auditSaleProductTemp(auditSaleProductDto, APPCHANNELCODE,
                        super.getUserId(), new Date());
                return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "审核商品商品成功");
                // if(ObjectUtils.isNullOrEmpty(errorString)){
                // return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "审核商品商品成功");
                // }else{
                // return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "审核商品商品成功");
                // }
            } else {
                logger.info("失败：审核商品商品id为空");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "审核商品商品id为空");
            }
        } catch (Exception e) {
            logger.error("失败：审核商品商品异常：" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存临时商品（卖家修改商品后调用此方法先保存到临时表，审核之后再保存到正式商品库）
     * 
     * @param saveSaleProductDto
     *            参数saveSaleProductDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saveSaleProductTemp")
    @ResponseBody
    public MsgBean saveSaleProductTemp(@RequestBody SaleProductDto saveSaleProductDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saveSaleProductDto)) {
                saleProductTempService
                        .saveSaleProductTemp(saveSaleProductDto, APPCHANNELCODE, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存临时商品成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "保存参数临时商品为空");
            }
        } catch (Exception e) {
            logger.error("失败：查询临时商品异常：" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询指定店铺类型下的商品基本类别列表
     * 
     * @param storeType
     *            参数店铺类型
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "{storeType}/listProductClassByStoreType")
    @ResponseBody
    public MsgBean listProductClassByStoreType(@PathVariable String storeType) {
        try {
            List<HashMap<String, String>> productClassList = productClassService.listProductClassByStoreType(storeType,
                    SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            if (!ObjectUtils.isNullOrEmpty(productClassList)) {
                return super.encapsulateMsgBean(productClassList, MsgBean.MsgCode.SUCCESS, "指定店铺类型下的商品基本类别列表查询成功");
            } else {
                logger.info("查询失败：指定店铺类型下的商品基本类别列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "指定店铺类型下的商品基本类别列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询商品库存列表
     * 
     * @param saleProductQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listSaleProductInventory")
    @ResponseBody
    public MsgBean listSaleProductInventory(@RequestBody SaleProductQuery saleProductQuery) {
        try {
            YiLiDiPage<SaleProductAppDto> page = saleProductService.findSaleProductInventorys(saleProductQuery);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店列表成功");
        } catch (Exception e) {
            logger.error("查询门店列表失败：" + e.getMessage(), e);
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
    @RequestMapping("/exportSearchSaleProductInventory")
    @ResponseBody
    public MsgBean exportSearchSaleProductInventory(@RequestBody SaleProductQuery saleProductQuery) {
        try {
            ReportFileModel reportFileModel = saleProductInventoryReportExport.exportExcel(saleProductQuery, "商品库存报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商品报表导出成功");
        } catch (Exception e) {
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 修改最小起订数量
     * 
     * @param saleProductId
     *            商品Id
     * @param saleProductDto
     *            商品saleProductDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{saleProductId}/updateSaleProductPerOperCount")
    @ResponseBody
    public MsgBean updateSaleProductPerOperCount(@PathVariable Integer saleProductId,
            @RequestBody SaleProductDto saleProductDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto) && !ObjectUtils.isNullOrEmpty(saleProductId)) {
                SaleProductDto spDto = saleProductService.loadSaleProductBasicInfoById(saleProductId, null);
                saleProductDto.setId(saleProductId);
                saleProductDto.setSaleProductName(spDto.getSaleProductName());
                saleProductDto.setProductClassCode(spDto.getProductClassCode());
                saleProductDto.setModifyUserId(super.getUserId());
                saleProductDto.setModifyTime(DateUtils.getCurrentDateTime());
                saleProductService.updateSaleProductBasicInfo(saleProductDto);
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "商品最小起订数量修改成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "商品最小起订数量传递参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}