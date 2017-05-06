package com.yilidi.o2o.report.imports.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductBatchSaveDto;

/**
 * 
 * @Description:TODO(商品报表导入)
 * @author: zxs
 * @date: 2015年11月26日 下午7:26:51
 * 
 */
public class SaleProductReportImport extends AbstractImportReport<SaleProductBatchSaveDto> {

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
     * 利用dubbo协议的远程IProductService接口（dubbo协议适用于小数据量，高并发的场景， 长连接） 导入调远程接口数据量小且频繁时使用，尤其适用于字段验证的操作。
     */
    private IProductService productService;

    /**
     * 利用hessian协议的远程IProductService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
     */
    private IProductService productServiceHessian;

    private Set<String> productBarCodeSet;

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, SaleProductBatchSaveDto objs)
            throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
            // 获取该店铺能够导入的产品所有条形码
            productBarCodeSet = productServiceHessian.getProductBarCodeByStoreType(objs.getStoreType());
            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(objs.getStoreType())
                            || SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(objs.getStoreType())) {
                        ReportFiled filedBarCode = rowReportFileds.get(0).paramType(Param.ParamType.STR_NUMBER.getType())
                                .isAllowEmpty(false).maxLength(64);
                        reportFiledList.add(filedBarCode);
                        ReportFiled filedSaleStatus = rowReportFileds.get(1).paramType(Param.ParamType.STR_NORMAL.getType())
                                .isAllowEmpty(false).maxLength(64);
                        reportFiledList.add(filedSaleStatus);
                        ReportFiled filedDisplayOrder = rowReportFileds.get(2)
                                .paramType(Param.ParamType.STR_INTEGER.getType()).isAllowEmpty(false).minValue(0L)
                                .maxLength(11);
                        reportFiledList.add(filedDisplayOrder);
                    }
                    if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(objs.getStoreType())) {
                        ReportFiled filedBarCode = rowReportFileds.get(0).paramType(Param.ParamType.STR_NUMBER.getType())
                                .isAllowEmpty(false).maxLength(64);
                        reportFiledList.add(filedBarCode);
                        ReportFiled filedPerOperCount = rowReportFileds.get(1)
                                .paramType(Param.ParamType.STR_INTEGER.getType()).isAllowEmpty(false).minValue(0L)
                                .maxLength(11);
                        reportFiledList.add(filedPerOperCount);
                    }
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductBatchSaveDto objs)
            throws ReportException {
        validateBarCode(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
    }

    /**
     * 
     * @Description TODO(验证条形码)
     * @param sheetCount
     * @param reportFiled
     * @param headerNameList
     * @param allDataList
     * @param validateTipsList
     */
    private void validateBarCode(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductBatchSaveDto objs) {
        // 根据导入的ECXCEL模版可知，headerNameList.get(0)为“条形码”这个字段名称
        if (reportFiled.getName().equals(headerNameList.get(0))) {
            String barCode = (String) reportFiled.getValue();
            // 验证在标准库中是否存在该条形码的产品
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(objs.getStoreType())
                    || SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(objs.getStoreType())) {
                List<ReportFiled> rowReportFileds = allDataList.get(reportFiled.getSheetNum() - 1).get(
                        reportFiled.getRowNum() - 1);
                String saleStatus = (String) rowReportFileds.get(1).getValue();
                if (!YES.equals(saleStatus) && !NO.equals(saleStatus)) {
                    String validateMsg = "是否上架字段值只能为" + "“" + "是" + "”" + "或者" + "“" + "否" + "”";
                    validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
                }
            }
            Boolean productFlag = false;
            if (!ObjectUtils.isNullOrEmpty(productBarCodeSet)) {
                productFlag = productBarCodeSet.contains(barCode);
            }
            if (!productFlag) {
                String validateMsg = "商品条形码为" + "“" + barCode + "”" + "的商品在标准库中不存在或者该商品类别不符合该店铺能添加的类别，不能通过此路径导入！";
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
                                if (filed.getName().equals(headerNameList.get(0))) {
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
    protected void insertImportData(List<String[]> rowDataList, SaleProductBatchSaveDto objs) throws ReportException {
        try {
            List<ProductDto> productDtoList = new ArrayList<ProductDto>();
            for (String[] strArray : rowDataList) {
                ProductDto productDto = productService
                        .loadProductByBarCodeAndChannelCode(strArray[0], objs.getChannelCode());
                if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(objs.getStoreType())
                        || SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(objs.getStoreType())) {
                    if (YES.equals(strArray[1])) {
                        productDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
                    } else if (NO.equals(strArray[1])) {
                        // 否的话设置为未上架状态
                        productDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_INIT);
                    }
                    ProductProfileDto productProfileDto = productDto.getProductProfileDto();
                    productProfileDto.setDisplayOrder(StringUtils.isEmpty(strArray[2]) ? 0 : new Integer(strArray[2]));
                }
                if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(objs.getStoreType())) {
                    productDto.setPerOperCount(StringUtils.isEmpty(strArray[1]) ? 0 : new Integer(strArray[1]));
                }
                productDtoList.add(productDto);
            }
            saleProductServiceHessian.saveSaleProductBatch(productDtoList, objs);
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

    public IProductService getProductService() {
        return productService;
    }

    public void setProductService(IProductService productService) {
        this.productService = productService;
    }

    public IProductService getProductServiceHessian() {
        return productServiceHessian;
    }

    public void setProductServiceHessian(IProductService productServiceHessian) {
        this.productServiceHessian = productServiceHessian;
    }

}
