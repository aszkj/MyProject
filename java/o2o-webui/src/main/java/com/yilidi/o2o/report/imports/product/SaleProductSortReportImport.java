package com.yilidi.o2o.report.imports.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductSortBatchSaveDto;

/**
 * 
 * 商品报表导入
 * 
 * @author: zxs
 * @date: 2015年11月26日 下午7:26:51
 * 
 */
public class SaleProductSortReportImport extends AbstractImportReport<SaleProductSortBatchSaveDto> {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     * 利用hessian协议的远程ISaleProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private ISaleProductService saleProductServiceHessian;

    private IProductClassService productClassService;

    private Set<String> saleProductBarCodeSet;

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList,
            SaleProductSortBatchSaveDto objs) throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
            // 获取店铺中商品的所有条形码
            saleProductBarCodeSet = saleProductServiceHessian.getSaleProductBarCode(objs.getStoreId());

            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    ReportFiled filedBarCode = rowReportFileds.get(1).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedDisplayOrder = rowReportFileds.get(2).paramType(Param.ParamType.STR_INTEGER.getType())
                            .isAllowEmpty(false).maxLength(11);
                    reportFiledList.add(filedBarCode);
                    reportFiledList.add(filedDisplayOrder);
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductSortBatchSaveDto objs)
            throws ReportException {
        // 验证同一种商品的条形码不能重复
        validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
    }

    /**
     * 
     * 验证同一种条形码不能重复
     * 
     * @param sheetCount
     * @param reportFiled
     * @param headerNameList
     * @param allDataList
     * @param validateTipsList
     */
    private void validateBarCodeNotRepeat(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductSortBatchSaveDto objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(1)为“条形码”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(1))) {
            String barCode = (String) reportFiled.getValue();
            // 验证在数据库中是否已存在相同用户名的同一种条形码的商品
            Boolean saleProductFlag = false;
            if (!ObjectUtils.isNullOrEmpty(saleProductBarCodeSet)) {
                saleProductFlag = saleProductBarCodeSet.contains(barCode);
            }
            if (!saleProductFlag) {
                String validateMsg = "条形码为" + "“" + barCode + "”" + "的商品在该店铺中不存在,不能修改顺序！";
                validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
            } else {
                // 验证在此次导入的EXCEL中是否已存在相同条形码的同一种商品
                for (int i = 0; i < allDataList.size(); i++) {
                    for (int j = 0; j < allDataList.get(i).size(); j++) {
                        if (((i == (reportFiled.getSheetNum().intValue() - 1) && (j != (reportFiled.getRowNum().intValue() - 1))))
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
                                    validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (j + 1) + "行" + "存在相同条形码的商品";
                                    validateTipsList.add("第" + reportFiled.getRowNum() + "行，字段：" + validateMsg);
                                } else {
                                    validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (i + 1) + "页Sheet里的第" + (j + 1)
                                            + "行" + "存在相同条形码的商品";
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

    @Override
    protected void insertImportData(List<String[]> rowDataList, SaleProductSortBatchSaveDto objs) throws ReportException {
        try {
            List<HashMap<String, Object>> displayOrderList = new ArrayList<HashMap<String, Object>>();
            for (String[] strArray : rowDataList) {
                HashMap<String, Object> displayOrderMap = new HashMap<String, Object>();
                displayOrderMap.put("barCode", strArray[1]);
                displayOrderMap.put("displayOrder", StringUtils.isEmpty(strArray[2]) ? null : new Integer(strArray[2]));
                displayOrderList.add(displayOrderMap);
            }
            saleProductServiceHessian.updateSaleProductDisplayOrderBatch(displayOrderList, objs);
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

}
