package com.yilidi.o2o.report.imports.product;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductOtherBatchSaveDto;

/**
 * 
 * @Description:TODO(商品报表导入)
 * @author: zxs
 * @date: 2015年11月26日 下午7:26:51
 * 
 */
public class SaleProductOtherReportImport extends AbstractImportReport<SaleProductOtherBatchSaveDto> {

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
     * 利用hessian协议的远程ISaleProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private ISaleProductService saleProductServiceHessian;

    /**
     * 利用hessian协议的远程IProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private IProductService productServiceHessian;

    private IProductClassService productClassService;

    private Set<String> productBarCodeSet;

    private Set<String> saleProductBarCodeSet;

    private List<HashMap<String, String>> mapList;

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList,
            SaleProductOtherBatchSaveDto objs) throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
            // 获取产品所有条形码
            productBarCodeSet = productServiceHessian.getProductBarCodeByStoreType(objs.getStoreType());
            // 获取店铺中商品的所有条形码
            saleProductBarCodeSet = saleProductServiceHessian.getSaleProductBarCode(objs.getStoreId());
            // 获取该店铺的有效的产品基础分类
            mapList = productClassService.listProductClassByStoreType(objs.getStoreType(),
                    SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);

            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    ReportFiled filedSaleProductName = rowReportFileds.get(1)
                            .paramType(Param.ParamType.STR_NORMAL.getType()).isAllowEmpty(false).maxLength(64);
                    ReportFiled filedBarCode = rowReportFileds.get(2).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedSaleProductClass = rowReportFileds.get(3)
                            .paramType(Param.ParamType.STR_NORMAL.getType()).isAllowEmpty(false).maxLength(64);
                    ReportFiled filedSaleProductSpec = rowReportFileds.get(4)
                            .paramType(Param.ParamType.STR_NORMAL.getType()).isAllowEmpty(false).maxLength(64);
                    ReportFiled filedRetailPrice = rowReportFileds.get(5).paramType(Param.ParamType.STR_LONG.getType())
                            .isAllowEmpty(false).maxLength(20);
                    ReportFiled filedHotSaleFlag = rowReportFileds.get(6).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedSaleStatus = rowReportFileds.get(7).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedDisplayOrder = rowReportFileds.get(8).paramType(Param.ParamType.STR_INTEGER.getType())
                            .isAllowEmpty(false).maxLength(11);
                    reportFiledList.add(filedSaleProductName);
                    reportFiledList.add(filedBarCode);
                    reportFiledList.add(filedSaleProductClass);
                    reportFiledList.add(filedSaleProductSpec);
                    reportFiledList.add(filedRetailPrice);
                    reportFiledList.add(filedHotSaleFlag);
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
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductOtherBatchSaveDto objs)
            throws ReportException {
        // 验证同一种商品的条形码不能重复
        validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
        // 验证商品类型必须是只能为产品类型表里存在的类型
        validateProductClassCodeIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
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
        if (reportFiled.getName().equals(headerNameList.get(2))) {
            String barCode = (String) reportFiled.getValue();
            // 验证在标准库中是否存在该条形码的产品
            List<ReportFiled> rowReportFileds = allDataList.get(reportFiled.getSheetNum() - 1).get(
                    reportFiled.getRowNum() - 1);
            String hotSaleFlag = (String) rowReportFileds.get(6).getValue();
            String saleStatus = (String) rowReportFileds.get(7).getValue();
            if (!YES.equals(saleStatus) && !NO.equals(saleStatus)) {
                String validateMsg = "是否上架字段值只能为" + "“" + "是" + "”" + "或者" + "“" + "否" + "”";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
            if (!YES.equals(hotSaleFlag) && !NO.equals(hotSaleFlag)) {
                String validateMsg = "是否热卖字段值只能为" + "“" + "是" + "”" + "或者" + "“" + "否" + "”";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
            // 依据条形码验证标准库中是否已经存在该产品
            Boolean productFlag = false;
            if (!ObjectUtils.isNullOrEmpty(productBarCodeSet)) {
                productFlag = productBarCodeSet.contains(barCode);
            }
            if (productFlag) {
                String validateMsg = "商品条形码为" + "“" + barCode + "”" + "的商品在标准库中存在，请选择从标准库导入！";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            } else {
                // 验证在店铺中是否已存在相同同一种条形码的商品
                Boolean saleProductFlag = false;
                if (!ObjectUtils.isNullOrEmpty(saleProductBarCodeSet)) {
                    saleProductFlag = saleProductBarCodeSet.contains(barCode);
                }
                if (saleProductFlag) {
                    String validateMsg = "商品条形码为" + "“" + barCode + "”" + "的商品在该店铺中已存在,请不要重复添加！";
                    validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                } else {
                    // 验证在此次导入的EXCEL中是否已存在相同条形码的同一种商品
                    for (int i = 0; i < allDataList.size(); i++) {
                        for (int j = 0; j < allDataList.get(i).size(); j++) {
                            if (((i == (reportFiled.getSheetNum().intValue() - 1) && (j != (reportFiled.getRowNum()
                                    .intValue() - 1)))) || (i != (reportFiled.getSheetNum().intValue() - 1))) {
                                String barCodeWithOtherFiled = "";
                                for (int k = 0; k < allDataList.get(i).get(j).size(); k++) {
                                    ReportFiled filed = allDataList.get(i).get(j).get(k);
                                    if (filed.getName().equals(headerNameList.get(2))) {
                                        barCodeWithOtherFiled = (String) filed.getValue();
                                    }
                                }
                                if (!StringUtils.isEmpty(barCode) && barCode.equals(barCodeWithOtherFiled)) {
                                    String validateMsg = "";
                                    if (1 == sheetCount.intValue()) {
                                        validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (j + 1) + "行"
                                                + "存在相同条形码的商品";
                                        validateTipsList.add("第" + reportFiled.getRowNum() + "行，字段：" + validateMsg);
                                    } else {
                                        validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (i + 1) + "页Sheet里的第"
                                                + (j + 1) + "行" + "存在相同条形码的商品";
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
        // 根据导入的ECXCEL模版可知，headerNameList.get(3)为“产品分类”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(3))) {
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
            if (!flag && !StringUtils.isEmpty(strProductClassNames)) {
                String validateMsg = "“" + reportFiled.getName() + "”" + ":" + reportFiled.getValue() + "不存在或者被冻结失效，只能为"
                        + "“" + strProductClassNames + "”" + "这几种商品类型";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            }
        }
    }

    @Override
    protected void insertImportData(List<String[]> rowDataList, SaleProductOtherBatchSaveDto objs) throws ReportException {
        try {
            List<SaleProductDto> saleProductDtoList = new ArrayList<SaleProductDto>();
            for (String[] strArray : rowDataList) {
                SaleProductDto saleProductDto = new SaleProductDto();
                saleProductDto.setSaleProductName(strArray[1]);
                saleProductDto.setBarCode(strArray[2]);
                ProductClassDto productClassDto = productClassService.loadProductClassByClassName(strArray[3]);
                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                    saleProductDto.setProductClassCode(productClassDto.getClassCode());
                }
                saleProductDto.setSaleProductSpec(strArray[4]);
                saleProductDto.setRetailPrice(StringUtils.isEmpty(strArray[5]) ? null : (new Long(strArray[5])) * 100);
                if (YES.equals(strArray[6])) {
                    saleProductDto.setHotSaleFlag(SystemContext.ProductDomain.HOTSALEFLAG_YES);
                } else if (NO.equals(strArray[6])) {
                    // 否的话设置为非热卖状态
                    saleProductDto.setHotSaleFlag(SystemContext.ProductDomain.HOTSALEFLAG_NO);
                }
                if (YES.equals(strArray[7])) {
                    saleProductDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
                } else if (NO.equals(strArray[7])) {
                    // 否的话设置为未上架状态
                    saleProductDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_INIT);
                }
                saleProductDto.setDisplayOrder(StringUtils.isEmpty(strArray[8]) ? null : new Integer(strArray[8]));
                saleProductDtoList.add(saleProductDto);
            }
            saleProductServiceHessian.saveOtherSaleProductBatch(saleProductDtoList, objs);
        } catch (Exception e) {
            logger.error("导入报表出现系统异常", e);
            throw new IllegalStateException("导入报表出现系统异常", e);
        }
    }

    public ISaleProductService getSaleProductServiceHessian() {
        return saleProductServiceHessian;
    }

    public void setSaleProductServiceHessian(ISaleProductService saleProductServiceHessian) {
        this.saleProductServiceHessian = saleProductServiceHessian;
    }

    public IProductClassService getProductClassService() {
        return productClassService;
    }

    public void setProductClassService(IProductClassService productClassService) {
        this.productClassService = productClassService;
    }

    public IProductService getProductServiceHessian() {
        return productServiceHessian;
    }

    public void setProductServiceHessian(IProductService productServiceHessian) {
        this.productServiceHessian = productServiceHessian;
    }

}
