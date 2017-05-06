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
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductProfileService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.IProductTempService;
import com.yilidi.o2o.product.service.dto.AuditProductDto;
import com.yilidi.o2o.product.service.dto.AuditProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductTempBatchSaveDto;
import com.yilidi.o2o.product.service.dto.ProductTempDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;
import com.yilidi.o2o.product.service.dto.query.ProductTempQuery;
import com.yilidi.o2o.report.export.product.ProductReportExport;
import com.yilidi.o2o.report.imports.product.ProductReportImport;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 功能描述：产品控制器 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/operation")
public class ProductController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    private static final String APPCHANNELCODE = SystemContext.UserDomain.CHANNELTYPE_ALL;

    @Autowired
    private IProductService productService;

    @Autowired
    private IProductTempService productTempService;

    @Autowired
    private IProductProfileService productProfileService;

    @Autowired
    private ProductReportExport productReport;

    @Autowired
    private ProductReportImport productReportImport;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IProductClassService productClassService;

    /**
     * 新增产品
     * 
     * @param productDto
     *            保存实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saveProduct")
    @ResponseBody
    public MsgBean saveProduct(@RequestBody ProductDto productDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                productDto.setCreateUserId(super.getUserId());
                productDto.setCreateTime(new Date());
                productService.saveProduct(productDto, APPCHANNELCODE);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品信息保存成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要保存产品参数为空");
            }
        } catch (Exception e) {
            logger.info("保存失败：产品保存失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 更新产品
     * 
     * @param productDto
     *            更新实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/updateProduct")
    @ResponseBody
    public MsgBean updateProduct(@RequestBody ProductDto productDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                productDto.setModifyUserId(super.getUserId());
                productDto.setModifyTime(new Date());
                productService.updateProduct(productDto, APPCHANNELCODE);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品信息更新成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要更新产品参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：产品更新失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 冻结产品
     * 
     * @param id
     *            冻结产品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{id}/freezeProduct")
    @ResponseBody
    public MsgBean freezeProduct(@PathVariable Integer id) {
        try {
            if (!ObjectUtils.isNullOrEmpty(id)) {
                boolean isFreeze = productService.updateProductStatusById(id, SystemContext.ProductDomain.PRODUCTSTATUS_OFF,
                        new Date(), 1);
                return super.encapsulateMsgBean(isFreeze, MsgBean.MsgCode.SUCCESS, "冻结产品成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要冻结产品参数id为空");
            }
        } catch (Exception e) {
            logger.info("冻结失败：冻结产品失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 启用产品
     * 
     * @param id
     *            启用产品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{id}/enableProduct")
    @ResponseBody
    public MsgBean enableProduct(@PathVariable Integer id) {
        try {
            if (!ObjectUtils.isNullOrEmpty(id)) {
                boolean isFreeze = productService.updateProductStatusById(id, SystemContext.ProductDomain.PRODUCTSTATUS_ON,
                        new Date(), 1);
                return super.encapsulateMsgBean(isFreeze, MsgBean.MsgCode.SUCCESS, "启用产品成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要启用产品参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：启用产品失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取产品
     * 
     * @param productId
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{productId}/loadProduct")
    @ResponseBody
    public MsgBean loadProduct(@PathVariable Integer productId) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productId)) {
                ProductDto productDto = productService.loadProductByProductIdAndChannelCode(productId, APPCHANNELCODE);
                AuditProductDto auditProductDto = new AuditProductDto();
                auditProductDto.setBrandName(productDto.getBrandName());
                auditProductDto.setProductClassCode(productDto.getProductClassCode());
                auditProductDto.setProductName(productDto.getProductName());
                auditProductDto.setBarCode(productDto.getBarCode());
                auditProductDto.setChannelCode(productDto.getProductProfileDto().getChannelCode());
                auditProductDto.setDisplayOrder(productDto.getProductProfileDto().getDisplayOrder());
                auditProductDto.setContent(productDto.getProductProfileDto().getContent());
                auditProductDto.setProductSpec(productDto.getProductProfileDto().getProductSpec());
                auditProductDto.setCostPrice(productDto.getProductPriceDto().getCostPrice());
                auditProductDto.setCommissionPrice(productDto.getProductPriceDto().getCommissionPrice());
                auditProductDto.setVipCommissionPrice(productDto.getProductPriceDto().getVipCommissionPrice());
                auditProductDto.setPromotionalPrice(productDto.getProductPriceDto().getPromotionalPrice());
                auditProductDto.setRetailPrice(productDto.getProductPriceDto().getRetailPrice());
                List<AuditProductImageDto> imageList = new ArrayList<AuditProductImageDto>();
                if(!ObjectUtils.isNullOrEmpty(productDto.getProductImageDtos())){
                	for(ProductImageDto ImageDto:productDto.getProductImageDtos()){
                		AuditProductImageDto auditProductImageDto = new AuditProductImageDto();
                		ObjectUtils.fastCopy(ImageDto, auditProductImageDto);
                		imageList.add(auditProductImageDto);
                	}
                	auditProductDto.setProductImageDtos(imageList);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto)) {
                    return super.encapsulateMsgBean(auditProductDto, MsgBean.MsgCode.SUCCESS, "产品查询成功");
                } else {
                    logger.info("查询失败：产品信息不存在");
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品不存在");
                }
            } else {
                logger.info("失败：查询参数产品编码为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "查询参数产品编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    /**
     * 获取产品
     * 
     * @param productId
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{productId}/loadProductForView")
    @ResponseBody
    public MsgBean loadProductForView(@PathVariable Integer productId) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productId)) {
                ProductDto productDto = productService.loadProductByProductIdAndChannelCode(productId, APPCHANNELCODE);
                if (!ObjectUtils.isNullOrEmpty(productDto)) {
                    return super.encapsulateMsgBean(productDto, MsgBean.MsgCode.SUCCESS, "产品查询成功");
                } else {
                    logger.info("查询失败：产品信息不存在");
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品不存在");
                }
            } else {
                logger.info("失败：查询参数产品编码为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "查询参数产品编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }


    /**
     * 查询产品显示信息列表
     * 
     * @param queryProduct
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/listProductRelativeInfos")
    @ResponseBody
    public MsgBean listProductRelativeInfos(@RequestBody ProductQuery queryProduct) {
        try {
            // queryProduct.setChannelCode(APPCHANNELCODE);
            queryProduct.setOrder("CREATETIME");
            queryProduct.setSort("DESC");
            YiLiDiPage<ProductDto> page = productService.findProductRelativeInfos(queryProduct);
            if (!ObjectUtils.isNullOrEmpty(page)) {
                return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "产品显示信息列表查询成功");
            } else {
                logger.info("查询失败：产品显示信息列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品显示信息列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品上下架
     * 
     * @param param
     *            产品ID和上下架状态
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateSaleStatus")
    @ResponseBody
    public MsgBean updateSaleStatus(@PathVariable String param) {
        try {
            logger.info("更新实体传递参数：产品信息" + param);
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE)) {
                    typeString = "下架";
                } else {
                    typeString = "上架";
                }
                productProfileService.updateSaleStatusByProductIdAndChannelCode(Integer.valueOf(params[0]), params[1],
                        APPCHANNELCODE, 1, new Date());
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品" + typeString + "成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品" + typeString + "失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品批量上架
     * 
     * @param param
     *            产品Id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductBatchOnSale")
    @ResponseBody
    public MsgBean updateProductBatchOnSale(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    productProfileService.updateSaleStatusByProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE, APPCHANNELCODE, 1, new Date());
                }
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量上架成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量上架失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品批量下架
     * 
     * @param param
     *            查询参数
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductBatchOffSale")
    @ResponseBody
    public MsgBean updateProductBatchOffSale(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    productProfileService.updateSaleStatusByProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE, APPCHANNELCODE, 1, new Date());
                }
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量上架成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量上架失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品热卖和非热卖
     * 
     * @param param
     *            产品ID和热卖标示
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductHotSaleFlag")
    @ResponseBody
    public MsgBean updateProductHotSaleFlag(@PathVariable String param) {
        try {
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.HOTSALEFLAG_YES)) {
                    typeString = "热卖";
                } else {
                    typeString = "取消热卖";
                }
                productProfileService.updateHotSaleFlagByProductIdAndChannelCode(Integer.valueOf(params[0]), params[1],
                        APPCHANNELCODE, 1, new Date());
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品" + typeString + "成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品" + typeString + "失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品批量非热卖
     * 
     * @param param
     *            产品Id组
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductBatchNoHot")
    @ResponseBody
    public MsgBean updateProductBatchNoHot(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    productProfileService.updateHotSaleFlagByProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.HOTSALEFLAG_NO, APPCHANNELCODE, 1, new Date());
                }
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量非热卖成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量非热卖失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品批量热卖
     * 
     * @param param
     *            产品Id组
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductBatchHot")
    @ResponseBody
    public MsgBean updateProductBatchHot(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    productProfileService.updateHotSaleFlagByProductIdAndChannelCode(Integer.valueOf(paramString),
                            SystemContext.ProductDomain.HOTSALEFLAG_YES, APPCHANNELCODE, 1, new Date());
                }
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量热卖成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量热卖失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品批量修改产品分类
     * 
     * @param param
     *            产品Id组
     * @param productDto
     *            产品productDto
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductClassForBatch")
    @ResponseBody
    public MsgBean updateProductClassForBatch(@PathVariable String param, @RequestBody ProductDto productDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param) && !ObjectUtils.isNullOrEmpty(productDto)) {
                String[] arrParam = param.split(",");
                for (String idString : arrParam) {
                    productService.updateProductClass(Integer.valueOf(idString), productDto.getProductClassCode(), 1,
                            new Date());
                }
                if (ObjectUtils.isNullOrEmpty(productDto.getProductClassCode())) {
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "请选择产品分类");
                } else {
                    if (!ObjectUtils.isNullOrEmpty(productClassService
                            .getAllNextProductClassByUpCode(new ProductClassQuery(productDto.getProductClassCode())))) {
                        return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "请选择最后一级产品分类");
                    }
                }
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量修改产品分类成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品批量修改产品分类传递参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出产品显示信息列表
     * 
     * @param queryProduct
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/exportSearchProduct")
    @ResponseBody
    public MsgBean exportSearchProduct(@RequestBody ProductQuery queryProduct) {
        try {
            ReportFileModel reportFileModel = productReport.exportExcel(queryProduct, "产品信息报表");
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "产品报表导出成功");
        } catch (Exception e) {
            e.printStackTrace();
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品导入报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForProduct")
    @ResponseBody
    public MsgBean uploadToTempForProduct(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            // 导入临时产品报表
            ProductTempBatchSaveDto productTempBatchSaveDto = new ProductTempBatchSaveDto(APPCHANNELCODE);
            List<String> validateTipsList = productReportImport.importExcel(filePathSub, productTempBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "产品导入报表失败");
            } else {
                logger.info("产品导入报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "产品导入报表成功");
            }
        } catch (Exception e) {
            logger.error("产品导入报表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询临时产品显示信息列表
     * 
     * @param productTempQuery
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/listProductTemps")
    @ResponseBody
    public MsgBean listProductTemps(@RequestBody ProductTempQuery productTempQuery) {
        try {
            productTempQuery.setChannelCode(APPCHANNELCODE);
            productTempQuery.setOrder("TEMPID");
            productTempQuery.setSort("DESC");
            YiLiDiPage<ProductTempDto> page = productTempService.findProductTemps(productTempQuery);
            if (!ObjectUtils.isNullOrEmpty(page)) {
                return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "临时产品显示信息列表查询成功");
            } else {
                logger.info("查询失败：临时产品显示信息列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "临时产品显示信息列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将所有的导入的临时产品添加到标准库
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/addAllTempProductToStandard")
    @ResponseBody
    public MsgBean addAllTempProductToStandard() {
        try {
            List<String> error = productTempService.addAllTempProductToStandard(null, APPCHANNELCODE, super.getUserId(),
                    new Date());
            return super.encapsulateMsgBean(error, MsgBean.MsgCode.SUCCESS, "添加到标准库成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将批量导入的产品上传图片后上传到标准库，然后删掉临时产品表里的信息
     * 
     * @param id
     *            临时产品id
     * @param productDto
     *            图片以及详情实体信息
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "{id}/updateProductTemp")
    @ResponseBody
    public MsgBean updateProductTemp(@PathVariable Integer id, @RequestBody ProductDto productDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(id) && !ObjectUtils.isNullOrEmpty(productDto)) {
                // 根据产品id和渠道编码获取到产品
                List<String> errorString = productService.saveProductTempToStandard(productDto, id, APPCHANNELCODE,
                        super.getUserId(), new Date());
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "产品添加到标准库保存成功:" + errorString);
                } else {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "产品添加到标准库成功");
                }
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "产品添加到标准库传递参数为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将产品批量加入多个店铺
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/saveProductToStores")
    @ResponseBody
    public MsgBean saveProductToStores(HttpServletRequest req) {
        try {
            String storeCodes = req.getParameter("storeCodes");
            String barCodes = req.getParameter("barCodes");
            if (!ObjectUtils.isNullOrEmpty(storeCodes) && !ObjectUtils.isNullOrEmpty(barCodes)) {
                List<String> errorString = productService.saveProductToStores(this.listCommunityStoresInfo(storeCodes),
                        this.getProductBarCodeInfo(barCodes), APPCHANNELCODE, super.getUserId(), new Date());
                if (ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "将产品批量加入店铺成功");
                } else {
                    errorString.add(0, "产品批量同步成功，但以下产品未被成功同步：");
                    return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "将产品批量加入店铺成功");
                }
            } else {
                logger.info("添加的产品或者商店id为空");
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "添加的产品或者商店id为空");
            }
        } catch (Exception e) {
            logger.error("将产品批量加入店铺异常：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    // 获取店铺信息
    private List<HashMap<String, Object>> listCommunityStoresInfo(String storeCodes) {
        List<HashMap<String, Object>> storeInfo = null;
        try {
            if ("allStore".equals(storeCodes)) {
                List<StoreProfileDto> listStoreProfileDto = storeProfileService.listStoreProfile(null);
                if (!ObjectUtils.isNullOrEmpty(listStoreProfileDto)) {
                    storeInfo = new ArrayList<HashMap<String, Object>>();
                    for (StoreProfileDto storeProfileDto : listStoreProfileDto) {
                        if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                            pakageStoresInfoMap(storeInfo, storeProfileDto);
                        }
                    }
                }
            } else {
                if (!ObjectUtils.isNullOrEmpty(storeCodes)) {
                    storeInfo = new ArrayList<HashMap<String, Object>>();
                    String[] storeCodesArrayStrings = null;
                    if (storeCodes.contains(",")) {
                        storeCodesArrayStrings = storeCodes.split(",");
                        for (String storeCodeString : storeCodesArrayStrings) {
                            if (!ObjectUtils.isNullOrEmpty(storeCodeString)) {
                                StoreProfileDto storeProfileDto = storeProfileService.loadByStoreCode(storeCodeString);
                                if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                                    pakageStoresInfoMap(storeInfo, storeProfileDto);
                                }
                            }
                        }
                    } else {
                        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreCode(storeCodes);
                        if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                            pakageStoresInfoMap(storeInfo, storeProfileDto);
                        }
                    }

                }
            }
        } catch (Exception e) {
            logger.error("获取店铺信息异常：" + e.getMessage(), e);
        }
        return storeInfo;
    }

    // 封装店铺必要信息
    private List<HashMap<String, Object>> pakageStoresInfoMap(List<HashMap<String, Object>> storeInfo,
            StoreProfileDto storeProfileDto) {
        try {
            HashMap<String, Object> storeInfoMap = null;
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                storeInfoMap = new HashMap<String, Object>();
                storeInfoMap.put("storeId", storeProfileDto.getStoreId());
                storeInfoMap.put("storeCode", storeProfileDto.getStoreCode());
                storeInfoMap.put("storeName", storeProfileDto.getStoreName());
                storeInfoMap.put("storeType", storeProfileDto.getStoreType());
                storeInfo.add(storeInfoMap);
            }
        } catch (Exception e) {
            logger.error("封装店铺必要信息异常：" + e.getMessage(), e);
        }
        return storeInfo;
    }

    // 获取产品条形码信息列表
    private List<String> getProductBarCodeInfo(String barCodes) {
        List<String> barCodeList = null;
        try {
            if ("allProduct".equals(barCodes)) {
                List<ProductDto> listProductDto = productService.getProductBasicInfos();
                barCodeList = new ArrayList<String>();
                for (ProductDto productDto : listProductDto) {
                    if (!ObjectUtils.isNullOrEmpty(productDto)) {
                        barCodeList.add(productDto.getBarCode());
                    }
                }
            } else {
                if (!ObjectUtils.isNullOrEmpty(barCodes)) {
                    barCodeList = new ArrayList<String>();
                    String[] barCodeArrayStrings = null;
                    if (barCodes.contains(",")) {
                        barCodeArrayStrings = barCodes.split(",");
                        for (String barCodeString : barCodeArrayStrings) {
                            if (!ObjectUtils.isNullOrEmpty(barCodeString)) {
                                barCodeList.add(barCodeString);
                            }
                        }
                    } else {
                        barCodeList.add(barCodes);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("获取产品条形码信息列表异常：" + e.getMessage(), e);
        }
        return barCodeList;
    }

    /**
     * 依据店铺类型查询产品显示信息列表
     * 
     * @param storeType
     *            店铺类型
     * @param queryProduct
     *            查询实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "{storeId}-{storeType}/listProductRelativeInfosByStoreType")
    @ResponseBody
    public MsgBean listProductRelativeInfosByStoreType(@PathVariable Integer storeId, @PathVariable String storeType,
            @RequestBody ProductQuery queryProduct) {
        try {
            queryProduct.setChannelCode(APPCHANNELCODE);
            queryProduct.setOrder("DISPLAYORDER");
            queryProduct.setSort("ASC");
            YiLiDiPage<ProductDto> page = productService.findProductRelativeInfosByStoreType(storeId, storeType,
                    queryProduct);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "产品显示信息列表查询成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}