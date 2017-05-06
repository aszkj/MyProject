package com.yilidi.o2o.report.imports.product;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IAuditProductService;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.AuditProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.AuditProductDto;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;

/**
 * 数据包产品导入
 * 
 * @author: chenlian
 * @date: 2016年12月14日 上午11:37:42
 */
public class AuditProductReportImport extends AbstractImportReport<AuditProductBatchSaveDto> {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     * 数据包产品详情图片HTML标签正则表达式
     */
    private static final String PACKET_PRODUCT_IMAGE_HTML_TAG_REGEX = "(?i)<img (.*?)src=\"(.*?)/contentPic(.*?)\"";

    /**
     * 数据包产品主副图片分割符正则表达式
     */
    private static final String PACKET_PRODUCT_IMAGE_REGEX = "(.*?)\\|;(.*?)";

    /**
     * 利用hessian协议的远程IAuditProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作
     */
    private IAuditProductService auditProductServiceHessian;
    /**
     * 利用hessian协议的远程IProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作
     */
    private IProductService productServiceHessian;
    /**
     * 利用hessian协议的远程IProductClassService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作
     */
    private IProductClassService productClassServiceHessian;
    /**
     * 利用hessian协议的远程IProductClassService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作
     */
    private IProductBrandService productBrandServiceHessian;

    private IProductBrandService productBrandService;

    private SystemBasicDataInfoUtils systemBasicDataInfoUtils;

    private Set<String> auditProductBarCodeSet;

    private Set<String> productBarCodeSet;

    private List<Map<String, String>> classMapList;

    private List<ProductBrandDto> productBrandDtoList;

    private String localUploadFileBasePath = "";

    private String uploadFileTempUrl = "";

    private String packetName = "";

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, AuditProductBatchSaveDto objs)
            throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
            // 获取临时产品所有条形码
            auditProductBarCodeSet = auditProductServiceHessian.getAuditProductBarCode();
            // 获取产品所有条形码
            productBarCodeSet = productServiceHessian.getProductBarCode();
            // 获取产品基础分类
            classMapList = productClassServiceHessian.getBasicProductClassInfoList(new ProductClassQuery(
                    SystemContext.SystemParams.TOP_LEVEL_CLASS, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON));
            productBrandDtoList = productBrandServiceHessian.listProductBrands();
            localUploadFileBasePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH);
            uploadFileTempUrl = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    ReportFiled filedProductName = rowReportFileds.get(0).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedBarCode = rowReportFileds.get(1).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedProductClass = rowReportFileds.get(2).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedBrandName = rowReportFileds.get(3).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedProductSpec = rowReportFileds.get(4).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedCostPrice = rowReportFileds.get(5).paramType(Param.ParamType.STR_DOUBLE.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedRetailPrice = rowReportFileds.get(6).paramType(Param.ParamType.STR_DOUBLE.getType())
                            .isAllowEmpty(false).maxLength(20);
                    ReportFiled filedPromotionalPrice = rowReportFileds.get(7)
                            .paramType(Param.ParamType.STR_DOUBLE.getType()).isAllowEmpty(false).maxLength(20);
                    ReportFiled filedDisplayOrder = rowReportFileds.get(8).paramType(Param.ParamType.STR_INTEGER.getType())
                            .isAllowEmpty(false).maxLength(11);
                    ReportFiled filedContent = rowReportFileds.get(9).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(true);
                    ReportFiled filedImages = rowReportFileds.get(10).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(true);
                    reportFiledList.add(filedProductName);
                    reportFiledList.add(filedBarCode);
                    reportFiledList.add(filedProductClass);
                    reportFiledList.add(filedBrandName);
                    reportFiledList.add(filedProductSpec);
                    reportFiledList.add(filedCostPrice);
                    reportFiledList.add(filedRetailPrice);
                    reportFiledList.add(filedPromotionalPrice);
                    reportFiledList.add(filedDisplayOrder);
                    reportFiledList.add(filedContent);
                    reportFiledList.add(filedImages);
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, AuditProductBatchSaveDto objs)
            throws ReportException {
        // 验证同一种产品的条形码不能重复
        validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
        // 验证产品类型必须是只能为产品类型表里存在的类型
        validateProductClassCodeIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
        // 验证产品品牌必须是只能为产品品牌表里存在的品牌
        validateBrandCodeIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
        // 验证产品详情的合法性
        validateProductContent(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
        // 验证产品主副图片的合法性
        validateProductImages(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
    }

    private void validateBarCodeNotRepeat(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(1)为“条形码”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(1))) {
            String barCode = (String) reportFiled.getValue();
            // 验证临时产品中是否存在同一种条形码的产品
            Boolean auditProductFlag = false;
            if (!ObjectUtils.isNullOrEmpty(auditProductBarCodeSet)) {
                auditProductFlag = auditProductBarCodeSet.contains(barCode);
            }
            // 验证标准库中是否存在同一种条形码的产品
            if (auditProductFlag) {
                String validateMsg = "产品条形码为" + "“" + barCode + "”" + "的产品在导入的数据包产品中已存在,请不要重复添加";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            } else {
                Boolean productFlag = false;
                if (!ObjectUtils.isNullOrEmpty(productBarCodeSet)) {
                    productFlag = productBarCodeSet.contains(barCode);
                }
                if (productFlag) {
                    String validateMsg = "产品条形码为" + "“" + barCode + "”" + "的产品在标准库中已存在,请不要重复添加";
                    validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                } else {
                    // 验证在此次导入的EXCEL中是否已存在相同条形码的同一种产品
                    for (int i = 0; i < allDataList.size(); i++) {
                        for (int j = 0; j < allDataList.get(i).size(); j++) {
                            if (((i == (reportFiled.getSheetNum().intValue() - 1) && (j != (reportFiled.getRowNum()
                                    .intValue() - 1)))) || (i != (reportFiled.getSheetNum().intValue() - 1))) {
                                String barCodeWithOtherFiled = "";
                                for (int k = 0; k < allDataList.get(i).get(j).size(); k++) {
                                    ReportFiled filed = allDataList.get(i).get(j).get(k);
                                    if (filed.getName().equals(headerNameList.get(1))) {
                                        barCodeWithOtherFiled = (String) filed.getValue();
                                    }
                                }
                                if (!StringUtils.isEmpty(barCode) && barCode.equals(barCodeWithOtherFiled)) {
                                    String validateMsg = "";
                                    if (1 == sheetCount.intValue()) {
                                        validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (j + 1) + "行"
                                                + "存在相同条形码的产品";
                                        validateTipsList.add("第" + reportFiled.getRowNum() + "行，字段：" + validateMsg);
                                    } else {
                                        validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (i + 1) + "页Sheet里的第"
                                                + (j + 1) + "行" + "存在相同条形码的产品";
                                        validateTipsList.add("第" + reportFiled.getSheetNum() + "页Sheet中，" + "第"
                                                + reportFiled.getRowNum() + "行，" + "字段：" + validateMsg);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private void validateProductClassCodeIsExist(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(2)为“产品分类”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(2))) {
            Boolean flag = false;
            if (!ObjectUtils.isNullOrEmpty(classMapList)) {
                for (Map<String, String> map : classMapList) {
                    if (map.get("className").equals((String) reportFiled.getValue())) {
                        flag = true;
                    }
                }
            }
            if (!flag) {
                String validateMsg = "";
                validateMsg = "“" + reportFiled.getName() + "”" + ": " + reportFiled.getValue() + " 不存在或者被冻结失效";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
        }
    }

    private void validateBrandCodeIsExist(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(3)为“产品品牌”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(3))) {
            Boolean flag = false;
            if (!ObjectUtils.isNullOrEmpty(productBrandDtoList)) {
                for (ProductBrandDto productBrandDto : productBrandDtoList) {
                    if (productBrandDto.getBrandName().equals((String) reportFiled.getValue())) {
                        flag = true;
                    }
                }
            }
            if (!flag) {
                String validateMsg = "";
                validateMsg = "“" + reportFiled.getName() + "”" + ": " + reportFiled.getValue() + " 不存在";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
        }
    }

    private void validateProductContent(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(8)为“产品详情”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(8))) {
            if (null != reportFiled.getValue()) {
                String content = (String) reportFiled.getValue();
                if (!StringUtils.isEmpty(content)) {
                    Pattern pattern = Pattern.compile(PACKET_PRODUCT_IMAGE_HTML_TAG_REGEX);
                    Matcher matcher1 = pattern.matcher(content);
                    while (matcher1.find()) {
                        packetName = matcher1.group(2).substring(
                                matcher1.group(2).lastIndexOf(CommonConstants.BACKSLASH) + 1);
                        if (!StringUtils.isEmpty(packetName)) {
                            break;
                        }
                    }
                    String validateMsg = "";
                    Matcher matcher2 = pattern.matcher(content);
                    while (matcher2.find()) {
                        String importContentImageUrl = localUploadFileBasePath + CommonConstants.BACKSLASH + packetName
                                + CommonConstants.BACKSLASH + "contentPic" + matcher2.group(3);
                        File file = new File(importContentImageUrl);
                        if (!file.exists()) {
                            validateMsg = "“" + reportFiled.getName() + "”" + ":详情图片" + importContentImageUrl + "不存在";
                            validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                        }
                    }
                }
            }
        }
    }

    private void validateProductImages(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(9)为“产品主副图片”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(9))) {
            if (null != reportFiled.getValue()) {
                String images = (String) reportFiled.getValue();
                if (!StringUtils.isEmpty(images)) {
                    String validateMsg = "";
                    Pattern pattern = Pattern.compile(PACKET_PRODUCT_IMAGE_REGEX);
                    Matcher matcher1 = pattern.matcher(images);
                    if (!matcher1.matches()) {
                        validateMsg = "“" + reportFiled.getName() + "”" + ":格式非法，请按淘宝助手导出数据包中的新图片格式填写该内容";
                        validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                        return;
                    }
                    Matcher matcher2 = pattern.matcher(images);
                    while (matcher2.find()) {
                        String importProductImageUrl = localUploadFileBasePath + CommonConstants.BACKSLASH + packetName
                                + CommonConstants.BACKSLASH + matcher2.group(1).split(":")[0] + ".jpg";
                        File file = new File(importProductImageUrl);
                        if (!file.exists()) {
                            validateMsg = "“" + reportFiled.getName() + "”" + ":图片" + importProductImageUrl + "不存在";
                            validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                        }
                    }
                }
            }
        }
    }

    @Override
    protected void insertImportData(List<String[]> rowDataList, AuditProductBatchSaveDto objs) throws ReportException {
        try {
            List<AuditProductDto> auditProductDtoList = new ArrayList<AuditProductDto>();
            for (String[] strArray : rowDataList) {
                AuditProductDto auditProductDto = new AuditProductDto();
                auditProductDto.setProductName(strArray[0].trim());
                auditProductDto.setBarCode(strArray[1].trim());
                ProductClassDto productClassDto = productClassServiceHessian.loadProductClassByClassName(strArray[2].trim());
                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                    auditProductDto.setProductClassCode(productClassDto.getClassCode());
                }
                ProductBrandDto productBrandDto = productBrandService.getBrandByName(StringUtils.isEmpty(strArray[3]) ? null
                        : strArray[3].trim());
                if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
                    auditProductDto.setBrandCode(productBrandDto.getBrandCode());
                }
                auditProductDto.setProductSpec(strArray[4].trim());
                auditProductDto.setCostPrice(StringUtils.isEmpty(strArray[5]) ? null : ArithUtils
                        .convertsToLongWithRound((new Double(strArray[5])) * 1000));
                auditProductDto.setRetailPrice(StringUtils.isEmpty(strArray[6]) ? null : ArithUtils
                        .convertsToLongWithRound((new Double(strArray[6])) * 1000));
                auditProductDto.setPromotionalPrice(StringUtils.isEmpty(strArray[7]) ? null : ArithUtils
                        .convertsToLongWithRound((new Double(strArray[7])) * 1000));
                auditProductDto.setDisplayOrder(StringUtils.isEmpty(strArray[8]) ? null : new Integer(strArray[8]));
                String content = StringUtils.isEmpty(strArray[9]) ? null : strArray[9].trim();
                if (!StringUtils.isEmpty(content)) {
                    Pattern pattern = Pattern.compile(PACKET_PRODUCT_IMAGE_HTML_TAG_REGEX);
                    Matcher matcher = pattern.matcher(content);
                    String currentContent = "";
                    while (matcher.find()) {
                        currentContent = content.replaceAll(
                                matcher.group(2).substring(0, matcher.group(2).lastIndexOf(CommonConstants.BACKSLASH)),
                                uploadFileTempUrl);
                        break;
                    }
                    if (!StringUtils.isEmpty(currentContent)) {
                        auditProductDto.setContent(currentContent);
                    }
                }
                String images = StringUtils.isEmpty(strArray[10]) ? null : strArray[10].trim();
                List<String> currentImageList = null;
                if (!StringUtils.isEmpty(images)) {
                    Pattern pattern = Pattern.compile(PACKET_PRODUCT_IMAGE_REGEX);
                    Matcher matcher = pattern.matcher(images);
                    while (matcher.find()) {
                        if (ObjectUtils.isNullOrEmpty(currentImageList)) {
                            currentImageList = new ArrayList<String>();
                        }
                        if (!StringUtils.isEmpty(packetName)) {
                            currentImageList.add(CommonConstants.BACKSLASH + packetName + CommonConstants.BACKSLASH
                                    + matcher.group(1).split(":")[0] + ".jpg");
                        }
                    }
                    if (!ObjectUtils.isNullOrEmpty(currentImageList)) {
                        auditProductDto.setProductImageUrls(currentImageList);
                    }
                }
                auditProductDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
                auditProductDtoList.add(auditProductDto);
            }
            auditProductServiceHessian.saveAuditProductBatch(auditProductDtoList, objs);
        } catch (Exception e) {
            logger.error("导入报表出现系统异常", e);
            throw new IllegalStateException("导入报表出现系统异常", e);
        }
    }

    public IAuditProductService getAuditProductServiceHessian() {
        return auditProductServiceHessian;
    }

    public void setAuditProductServiceHessian(IAuditProductService auditProductServiceHessian) {
        this.auditProductServiceHessian = auditProductServiceHessian;
    }

    public IProductService getProductServiceHessian() {
        return productServiceHessian;
    }

    public void setProductServiceHessian(IProductService productServiceHessian) {
        this.productServiceHessian = productServiceHessian;
    }

    public IProductClassService getProductClassServiceHessian() {
        return productClassServiceHessian;
    }

    public void setProductClassServiceHessian(IProductClassService productClassServiceHessian) {
        this.productClassServiceHessian = productClassServiceHessian;
    }

    public IProductBrandService getProductBrandServiceHessian() {
        return productBrandServiceHessian;
    }

    public void setProductBrandServiceHessian(IProductBrandService productBrandServiceHessian) {
        this.productBrandServiceHessian = productBrandServiceHessian;
    }

    public IProductBrandService getProductBrandService() {
        return productBrandService;
    }

    public void setProductBrandService(IProductBrandService productBrandService) {
        this.productBrandService = productBrandService;
    }

    public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
        return systemBasicDataInfoUtils;
    }

    public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
        this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
    }

}
