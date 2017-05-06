package com.yilidi.o2o.report.imports.user;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;

/**
 * 
 * @Description:
 * @author: xsl
 * @date: 2017年1月19日10:15:05
 * 
 */
public class SaleProductEvaluateImport extends AbstractImportReport<SaleProductEvaluationDto> {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
	 * 利用hessian协议的远程ISaleProductEvaluationService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private ISaleProductEvaluationService saleProductEvaluationServiceHessian;
	/**
	 * 利用hessian协议的远程IStoreEvaluationService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IStoreEvaluationService storeEvaluationServiceHessian;
	
    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, SaleProductEvaluationDto objs)
            throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
        	int i = 0;
            for (List<ReportFiled> rowReportFileds : sheetDataList) {
            	i++;
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    int j=1;
                    //1
                    ReportFiled filedBarCode = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    if(ObjectUtils.isNullOrEmpty(filedBarCode.getValue())){
                    	break;
                    }
                    //2
                    ReportFiled filedSaleProductName = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    if(ObjectUtils.isNullOrEmpty(filedSaleProductName.getValue())){
                    	break;
                    }
                    
                    //3
                    ReportFiled filedStoreCode = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    if(ObjectUtils.isNullOrEmpty(filedStoreCode.getValue())){
                    	break;
                    }
                    String storeCode = filedStoreCode.getValue().toString();
                    //4
                    ReportFiled filedStoreName = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    String storeName = filedStoreName.getValue().toString();
                    boolean isExist = false;
                    if(!StringUtils.isEmpty(storeName)&&!StringUtils.isEmpty(storeCode)){
                    	isExist = storeEvaluationServiceHessian.checkStoreInfoByStoreCode(storeCode,storeName);
                    }
                    if(!isExist){
                    	String validateMsg = "第"+i+"行 店铺编码"+":"+storeCode+"对应店铺不存在 或 与"
                    						+filedStoreName.getName()+"不对应";
                    	validateTipsList.add(super.getValidateTips(sheetCount, filedStoreCode, validateMsg));
                    }
                    //5
                    ReportFiled filedUserName = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    if(ObjectUtils.isNullOrEmpty(filedUserName.getValue())){
                    	break;
                    }
                    //6
                    ReportFiled filedProductStar = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(1);
                    //7
                    ReportFiled filedContent = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    //8
                    ReportFiled filedSaleOrderNo = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    //9
                    ReportFiled filedIsAnonymity = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(2);
                    if(!("是".equals(filedIsAnonymity.getValue())||"否".equals(filedIsAnonymity.getValue()))){
						String validateMsg = "第" + i + "行 是否匿名 栏内容不符合约束规定";
						validateTipsList.add(super.getValidateTips(sheetCount, filedIsAnonymity, validateMsg));
                    }
                    //10
                    ReportFiled filedIsSystem = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(2);
                    if(!("是".equals(filedIsSystem.getValue())||"否".equals(filedIsSystem.getValue()))){
						String validateMsg = "第" + i + "行 是否系统评价 栏内容不符合约束规定";
						validateTipsList.add(super.getValidateTips(sheetCount, filedIsSystem, validateMsg));
                    }
                    //11
                    ReportFiled filedIsShow = rowReportFileds.get(j++).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(2);
                    if(!("是".equals(filedIsShow.getValue())||"否".equals(filedIsShow.getValue()))){
						String validateMsg = "第" + i + "行 是否显示 栏内容不符合约束规定";
						validateTipsList.add(super.getValidateTips(sheetCount, filedIsShow, validateMsg));
                    }
                    reportFiledList.add(filedBarCode);
                    reportFiledList.add(filedSaleProductName);
                    reportFiledList.add(filedStoreCode);
                    reportFiledList.add(filedStoreName);
                    reportFiledList.add(filedUserName);
                    reportFiledList.add(filedProductStar);
                    reportFiledList.add(filedContent);
                    reportFiledList.add(filedSaleOrderNo);
                    reportFiledList.add(filedIsAnonymity);
                    reportFiledList.add(filedIsSystem);
                    reportFiledList.add(filedIsShow);
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, SaleProductEvaluationDto objs)
            throws ReportException {
        // 验证同一种产品的条形码不能重复
        //validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
        // 验证店铺属性
        //validateStoreIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
    }

    @Override
    protected void insertImportData(List<String[]> rowDataList,SaleProductEvaluationDto o) throws ReportException {
        try {
            List<SaleProductEvaluationDto> saleProductEvaluationDtoList = new ArrayList<SaleProductEvaluationDto>();
            for (String[] strArray : rowDataList) {
            	SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
            	if(StringUtils.isEmpty(strArray[1])){
            		break;
            	}
            	int j=1;
            	saleProductEvaluationDto.setBarCode(strArray[j++]);
            	saleProductEvaluationDto.setSaleProductName(strArray[j++]);
            	saleProductEvaluationDto.setStoreCode(strArray[j++]);
            	saleProductEvaluationDto.setStoreName(strArray[j++]);
            	saleProductEvaluationDto.setUserName(strArray[j++]);
            	Integer productStar = ArithUtils.converStringToInt(strArray[j++],5);
            	saleProductEvaluationDto.setProductStar(productStar>5?5:productStar);
            	saleProductEvaluationDto.setContent(strArray[j++]);
            	saleProductEvaluationDto.setSaleOrderNo(strArray[j++]);
            	saleProductEvaluationDto.setAnonymityEvaluate(strArray[j++]);
            	saleProductEvaluationDto.setSystemEvaluate(strArray[j++]);
            	saleProductEvaluationDto.setShowStatus(strArray[j++]);
            	saleProductEvaluationDto.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_NO);
            	
            	if("否".equals(saleProductEvaluationDto.getAnonymityEvaluate())){
            		saleProductEvaluationDto.setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_NO);
            	}else{
            		saleProductEvaluationDto.setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES);
            	}
            	if("否".equals(saleProductEvaluationDto.getSystemEvaluate())){
            		saleProductEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_NO);
            	}else{
            		saleProductEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_YES);
            		saleProductEvaluationDto.setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES);
            	}
            	if("否".equals(saleProductEvaluationDto.getShowStatus())){
            		saleProductEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_NO);
            	}else{
            		saleProductEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
            	}
            	
            	saleProductEvaluationDtoList.add(saleProductEvaluationDto);
            }
            saleProductEvaluationServiceHessian.saveSaleProductEvaluationDtosBatch(saleProductEvaluationDtoList);
        } catch (Exception e) {
            logger.error("导入报表出现系统异常", e);
            throw new IllegalStateException("导入报表出现系统异常", e);
        }
    }

	public ISaleProductEvaluationService getSaleProductEvaluationServiceHessian() {
		return saleProductEvaluationServiceHessian;
	}

	public void setSaleProductEvaluationServiceHessian(ISaleProductEvaluationService saleProductEvaluationServiceHessian) {
		this.saleProductEvaluationServiceHessian = saleProductEvaluationServiceHessian;
	}

	public IStoreEvaluationService getStoreEvaluationServiceHessian() {
		return storeEvaluationServiceHessian;
	}

	public void setStoreEvaluationServiceHessian(IStoreEvaluationService storeEvaluationServiceHessian) {
		this.storeEvaluationServiceHessian = storeEvaluationServiceHessian;
	}
    
}
