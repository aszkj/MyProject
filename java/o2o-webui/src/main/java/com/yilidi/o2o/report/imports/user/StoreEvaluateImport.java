package com.yilidi.o2o.report.imports.user;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;

/**
 * 
 * @Description:TODO(产品报表导入)
 * @author: zxs
 * @date: 2015年11月26日 下午7:26:51
 * 
 */
public class StoreEvaluateImport extends AbstractImportReport<StoreEvaluationDto> {

    private Logger logger = Logger.getLogger(this.getClass());

    /**
	 * 利用hessian协议的远程IStoreEvaluationService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IStoreEvaluationService storeEvaluationServiceHessian;
	
    public IStoreEvaluationService getStoreEvaluationServiceHessian() {
		return storeEvaluationServiceHessian;
	}

	public void setStoreEvaluationServiceHessian(IStoreEvaluationService storeEvaluationServiceHessian) {
		this.storeEvaluationServiceHessian = storeEvaluationServiceHessian;
	}

    @Override
    protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, StoreEvaluationDto objs)
            throws ReportException {
        List<String> validateTipsList = new ArrayList<String>();
        if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
        	int i = 0;
            for (List<ReportFiled> rowReportFileds : sheetDataList) {
            	i++;
                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                    List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
                    ReportFiled filedStoreCode = rowReportFileds.get(1).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    if(ObjectUtils.isNullOrEmpty(filedStoreCode.getValue())){
                    	break;
                    }
                    String storeCode = filedStoreCode.getValue().toString();
                    ReportFiled filedStoreName = rowReportFileds.get(2).paramType(Param.ParamType.STR_NORMAL.getType())
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
                    ReportFiled filedContent = rowReportFileds.get(3).paramType(Param.ParamType.STR_NORMAL.getType())
                            .isAllowEmpty(false).maxLength(64);
                    ReportFiled filedAttitudeStar = rowReportFileds.get(4).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(1);
                    ReportFiled filedSendStar = rowReportFileds.get(5).paramType(Param.ParamType.STR_NUMBER.getType())
                            .isAllowEmpty(false).maxLength(1);
                    reportFiledList.add(filedStoreCode);
                    reportFiledList.add(filedStoreName);
                    reportFiledList.add(filedContent);
                    reportFiledList.add(filedAttitudeStar);
                    reportFiledList.add(filedSendStar);
                    super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
                }
            }
        }
        return validateTipsList;
    }

    @Override
    protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, StoreEvaluationDto objs)
            throws ReportException {
        // 验证同一种产品的条形码不能重复
        //validateBarCodeNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
        // 验证店铺属性
        //validateStoreIsExist(sheetCount, reportFiled, headerNameList, validateTipsList, objs);
    }

    @Override
    protected void insertImportData(List<String[]> rowDataList,StoreEvaluationDto o) throws ReportException {
        try {
            List<StoreEvaluationDto> storeEvaluationDtoList = new ArrayList<StoreEvaluationDto>();
            for (String[] strArray : rowDataList) {
            	StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
            	if(StringUtils.isEmpty(strArray[1])){
            		break;
            	}
            	storeEvaluationDto.setStoreCode(strArray[1]);
            	storeEvaluationDto.setStoreName(strArray[2]);
            	storeEvaluationDto.setContent(null==strArray[3]?"":strArray[3]);
            	
            	storeEvaluationDto.setAttitudeStar(ArithUtils.converStringToInt(strArray[4], 5)>5?5:ArithUtils.converStringToInt(strArray[4], 5));
            	storeEvaluationDto.setSendStar(ArithUtils.converStringToInt(strArray[5], 5)>5?5:ArithUtils.converStringToInt(strArray[5], 5));
            	storeEvaluationDto.setUserId(o.getUserId());
            	storeEvaluationDtoList.add(storeEvaluationDto);
            }
            storeEvaluationServiceHessian.saveStoreEvaluationDtoBatch(storeEvaluationDtoList);
        } catch (Exception e) {
            logger.error("导入报表出现系统异常", e);
            throw new IllegalStateException("导入报表出现系统异常", e);
        }
    }

}
