package com.yilidi.o2o.report.imports.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.IProductTempService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductTempBatchSaveDto;
import com.yilidi.o2o.product.service.dto.ProductTempDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;

/**
 * 
 * @Description:TODO(产品报表导入)
 * @author: zxs
 * @date: 2015年11月26日 下午7:26:51
 * 
 */
public class ProductReportImport extends AbstractImportReport<ProductTempBatchSaveDto> {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     * 判断字段是
     */
    private static final String YES = "是";
    /**
     * 判断字段否
     */
    private static final String NO = "否";

    /**
     * 利用dubbo协议的远程IProductTempService接口（dubbo协议适用于小数据量，高并发的场景， 长连接） 导入调远程接口数据量小且频繁时使用，尤其适用于字段验证的操作。
     */
    private IProductTempService productTempService;

    /**
     * 利用hessian协议的远程IProductTempService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private IProductTempService productTempServiceHessian;
    /**
     * 利用hessian协议的远程IProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private IProductService productServiceHessian;

    private IProductClassService productClassService;

    private Set<String> productTempBarCodeSet;

    private Set<String> productBarCodeSet;

    private List<Map<String, String>> mapList;

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, ProductTempBatchSaveDto objs)
            throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
            // 获取临时产品所有条形码
            productTempBarCodeSet = productTempService.getProductTempBarCode();
            // 获取产品所有条形码
            productBarCodeSet = productServiceHessian.getProductBarCode();
            // 获取产品基础分类
            mapList = productClassService.getBasicProductClassInfoList(new ProductClassQuery(
                    SystemContext.SystemParams.TOP_LEVEL_CLASS, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON));
            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    ReportFiled filedProductName = rowReportFileds.get(0).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedBarCode = rowReportFileds.get(1).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedProductClass = rowReportFileds.get(2).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedProductSpec = rowReportFileds.get(3).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedCostPrice = rowReportFileds.get(4).paramType(Param.ParamType.STR_DOUBLE.getType())
                            .isAllowEmpty(false).maxLength(20);
                    ReportFiled filedRetailPrice = rowReportFileds.get(5).paramType(Param.ParamType.STR_DOUBLE.getType())
                            .isAllowEmpty(false).maxLength(20);
                    ReportFiled filedPromotionalPrice = rowReportFileds.get(6)
                            .paramType(Param.ParamType.STR_DOUBLE.getType()).isAllowEmpty(false).maxLength(20);
                    ReportFiled filedCommissionPrice = rowReportFileds.get(7).paramType(Param.ParamType.STR_DOUBLE.getType())
                            .isAllowEmpty(true).maxLength(20);
                    ReportFiled filedVipCommissionPrice = rowReportFileds.get(8)
                            .paramType(Param.ParamType.STR_DOUBLE.getType()).isAllowEmpty(true).maxLength(20);
                    ReportFiled filedSaleStatus = rowReportFileds.get(9).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedDisplayOrder = rowReportFileds.get(10).paramType(Param.ParamType.STR_INTEGER.getType())
                            .isAllowEmpty(false).maxLength(11);
                    reportFiledList.add(filedProductName);
                    reportFiledList.add(filedBarCode);
                    reportFiledList.add(filedProductClass);
                    reportFiledList.add(filedProductSpec);
                    reportFiledList.add(filedCostPrice);
                    reportFiledList.add(filedRetailPrice);
                    reportFiledList.add(filedPromotionalPrice);
                    reportFiledList.add(filedCommissionPrice);
                    reportFiledList.add(filedVipCommissionPrice);
                    reportFiledList.add(filedSaleStatus);
                    reportFiledList.add(filedDisplayOrder);
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, ProductTempBatchSaveDto objs)
            throws ReportException {
        // 验证同一种产品的条形码不能重复
        //validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
        // 验证产品类型必须是只能为产品类型表里存在的类型
        //validateProductClassCodeIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
    }

    /**
     * 
     * @Description TODO(验证同一种条形码不能重复)
     * @param sheetCount
     * @param reportFiled
     * @param headerNameList
     * @param allDataList
     * @param validateTipsList
     */
    private void validateBarCodeNotRepeat(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(1)为“条形码”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(1))) {
            String barCode = (String) reportFiled.getValue();
            // 验证在标准库中是否存在该条形码的产品
            List<ReportFiled> rowReportFileds = allDataList.get(reportFiled.getSheetNum() - 1)
                    .get(reportFiled.getRowNum() - 1);
            String saleStatus = (String) rowReportFileds.get(9).getValue();
            if (!YES.equals(saleStatus) && !NO.equals(saleStatus)) {
                String validateMsg = "是否上架字段值只能为" + "“" + "是" + "”" + "或者" + "“" + "否" + "”";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
            // 验证临时产品中是否存在同一种条形码的产品
            Boolean productTempFlag = false;
            if (!ObjectUtils.isNullOrEmpty(productTempBarCodeSet)) {
                productTempFlag = productTempBarCodeSet.contains(barCode);
            }
            // 验证标准库中是否存在同一种条形码的产品
            if (productTempFlag) {
                String validateMsg = "产品条形码为" + "“" + barCode + "”" + "的产品在列表中已存在,请不要重复添加！";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            } else {
                Boolean productFlag = false;
                if (!ObjectUtils.isNullOrEmpty(productBarCodeSet)) {
                    productFlag = productBarCodeSet.contains(barCode);
                }
                if (productFlag) {
                    String validateMsg = "产品条形码为" + "“" + barCode + "”" + "的产品在标准库中已存在,请不要重复添加！";
                    validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                } else {
                    // 验证在此次导入的EXCEL中是否已存在相同条形码的同一种产品
                    for (int i = 0; i < allDataList.size(); i++) {
                        for (int j = 0; j < allDataList.get(i).size(); j++) {
                            if (((i == (reportFiled.getSheetNum().intValue() - 1)
                                    && (j != (reportFiled.getRowNum().intValue() - 1))))
                                    || (i != (reportFiled.getSheetNum().intValue() - 1))) {
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

    /**
     * 
     * @Description TODO(验证产品类型是否存在)
     * @param sheetCount
     * @param reportFiled
     * @param headerNameList
     * @param validateTipsList
     */
    private void validateProductClassCodeIsExist(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<String> validateTipsList, Object... objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(2)为“产品分类”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(2))) {
            Boolean flag = false;
            String strProductClassNames = "";
            if (!ObjectUtils.isNullOrEmpty(mapList)) {
                int index = 0;
                for (Map<String, String> map : mapList) {
                    if (index == mapList.size() - 1) {
                        strProductClassNames += map.get("className");
                    } else {
                        strProductClassNames += map.get("className") + "，";
                    }
                    if (map.get("className").equals((String) reportFiled.getValue())) {
                        flag = true;
                    }
                    index++;
                }
            }
            if (!flag) {
                String validateMsg = "";
                if (!StringUtils.isEmpty(strProductClassNames)) {
                    validateMsg = "“" + reportFiled.getName() + "”" + ":" + reportFiled.getValue() + "不存在或者被冻结失效，只能为" + "“"
                            + strProductClassNames + "”" + "这几种产品类别";
                } else {
                    validateMsg = "“" + reportFiled.getName() + "”" + ":" + reportFiled.getValue() + "不存在或者被冻结失效。";
                }
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
        }
    }

    @Override
    protected void insertImportData(List<String[]> rowDataList, ProductTempBatchSaveDto objs) throws ReportException {
        try {
            List<ProductTempDto> productTempDtoList = new ArrayList<ProductTempDto>();
            for (String[] strArray : rowDataList) {
                ProductTempDto productTempDto = new ProductTempDto();
                productTempDto.setProductName(strArray[0]);
                productTempDto.setBarCode(strArray[1]);
                ProductClassDto productClassDto = productClassService.loadProductClassByClassName(strArray[2]);
                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                    productTempDto.setProductClassCode(productClassDto.getClassCode());
                }
                productTempDto.setProductSpec(strArray[3]);
                productTempDto.setCostPrice(StringUtils.isEmpty(strArray[4]) ? null
                        : ArithUtils.convertsToLongWithRound((new Double(strArray[4])) * 1000));
                productTempDto.setRetailPrice(StringUtils.isEmpty(strArray[5]) ? null
                        : ArithUtils.convertsToLongWithRound((new Double(strArray[5])) * 1000));
                productTempDto.setPromotionalPrice(StringUtils.isEmpty(strArray[6]) ? null
                        : ArithUtils.convertsToLongWithRound((new Double(strArray[6])) * 1000));
                productTempDto.setCommissionPrice(StringUtils.isEmpty(strArray[7]) ? null
                        : ArithUtils.convertsToLongWithRound((new Double(strArray[7])) * 1000));
                productTempDto.setVipCommissionPrice(StringUtils.isEmpty(strArray[8]) ? null
                        : ArithUtils.convertsToLongWithRound((new Double(strArray[8])) * 1000));
                if (YES.equals(strArray[9])) {
                    productTempDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE);
                } else if (NO.equals(strArray[9])) {
                    // 否的话设置为未上架状态
                    productTempDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_INIT);
                }
                productTempDto.setDisplayOrder(StringUtils.isEmpty(strArray[10]) ? null : new Integer(strArray[10]));
                productTempDtoList.add(productTempDto);
            }
            productTempServiceHessian.saveProductTempDtoBatch(productTempDtoList, objs);
        } catch (Exception e) {
            logger.error("导入报表出现系统异常", e);
            throw new IllegalStateException("导入报表出现系统异常", e);
        }
    }

    public IProductClassService getProductClassService() {
        return productClassService;
    }

    public void setProductClassService(IProductClassService productClassService) {
        this.productClassService = productClassService;
    }

    public IProductTempService getProductTempService() {
        return productTempService;
    }

    public void setProductTempService(IProductTempService productTempService) {
        this.productTempService = productTempService;
    }

    public IProductTempService getProductTempServiceHessian() {
        return productTempServiceHessian;
    }

    public void setProductTempServiceHessian(IProductTempService productTempServiceHessian) {
        this.productTempServiceHessian = productTempServiceHessian;
    }

    public IProductService getProductServiceHessian() {
        return productServiceHessian;
    }

    public void setProductServiceHessian(IProductService productServiceHessian) {
        this.productServiceHessian = productServiceHessian;
    }

}
