package com.yilidi.o2o.report.imports.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.report.AbstractImportReport;
import com.yilidi.o2o.core.report.ReportFiled;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserNameAndTypeInfoDto;

/**
 * 
 * @Description:TODO(用户报表导入)
 * @author: chenlian
 * @date: 2015年11月23日 下午7:26:51
 * 
 */
public class UserReportImport extends AbstractImportReport<Object> {

	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 利用dubbo协议的远程IUserService接口（dubbo协议适用于小数据量，高并发的场景， 长连接） 导入调远程接口数据量小且频繁时使用，尤其适用于字段验证的操作。
	 */
	private IUserService userService;

	/**
	 * 利用hessian协议的远程IUserService接口（适用于大数据量，传输文件等的场景， 短连接） 导入调远程接口数据量大时使用，尤其适用于传输批量数据进行导入到数据库的操作。
	 */
	private IUserService userServiceHessian;

	private SystemBasicDataInfoUtils systemBasicDataInfoUtils;

	private List<Map<String, String>> mapList;

	private Set<UserNameAndTypeInfoDto> userNameAndTypeInfoDtoSet;

	@Override
	protected List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
			List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, Object objs)
			throws ReportException {
		List<String> validateTipsList = new ArrayList<String>();
		if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
			mapList = systemBasicDataInfoUtils.getSystemDictInfoList(SystemContext.UserDomain.DictType.CUSTOMERTYPE
					.getValue());
			userNameAndTypeInfoDtoSet = userServiceHessian.getUserNameAndTypeInfos();
			for (List<ReportFiled> rowReportFileds : sheetDataList) {
				if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
					List<ReportFiled> reportFiledList = new ArrayList<ReportFiled>();
					ReportFiled filedCustomerId = rowReportFileds.get(0).paramType(Param.ParamType.STR_INTEGER.getType())
							.isAllowEmpty(false);
					ReportFiled filedUserName = rowReportFileds.get(1).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false).maxLength(128);
					ReportFiled filedRealName = rowReportFileds.get(2).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false).maxLength(128);
					ReportFiled filedEmail = rowReportFileds.get(3).paramType(Param.ParamType.STR_EMAIL.getType())
							.isAllowEmpty(false).maxLength(128);
					ReportFiled filedPhone = rowReportFileds.get(4).paramType(Param.ParamType.STR_MOBILE.getType())
							.isAllowEmpty(false);
					ReportFiled filedPassword = rowReportFileds.get(5).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false);
					ReportFiled filedMasterFlag = rowReportFileds.get(6).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false);
					ReportFiled filedCustomerType = rowReportFileds.get(7).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false);
					ReportFiled filedStatusCode = rowReportFileds.get(8).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(false);
					ReportFiled filedAuditStatusCode = rowReportFileds.get(9)
							.paramType(Param.ParamType.STR_NORMAL.getType()).isAllowEmpty(false);
					ReportFiled filedCreateUserId = rowReportFileds.get(10).paramType(Param.ParamType.STR_INTEGER.getType())
							.isAllowEmpty(false);
					ReportFiled filedCreateTime = rowReportFileds.get(11).paramType(Param.ParamType.STR_DATE.getType())
							.isAllowEmpty(false);
					ReportFiled filedAuditUserId = rowReportFileds.get(12).paramType(Param.ParamType.STR_INTEGER.getType())
							.isAllowEmpty(true);
					ReportFiled filedAuditTime = rowReportFileds.get(13).paramType(Param.ParamType.STR_DATE.getType())
							.isAllowEmpty(true);
					ReportFiled filedAuditNote = rowReportFileds.get(14).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(true);
					ReportFiled filedModifyTime = rowReportFileds.get(15).paramType(Param.ParamType.STR_DATE.getType())
							.isAllowEmpty(true);
					ReportFiled filedModifyUserId = rowReportFileds.get(16).paramType(Param.ParamType.STR_INTEGER.getType())
							.isAllowEmpty(true);
					ReportFiled filedNote = rowReportFileds.get(17).paramType(Param.ParamType.STR_NORMAL.getType())
							.isAllowEmpty(true);
					reportFiledList.add(filedCustomerId);
					reportFiledList.add(filedUserName);
					reportFiledList.add(filedRealName);
					reportFiledList.add(filedEmail);
					reportFiledList.add(filedPhone);
					reportFiledList.add(filedPassword);
					reportFiledList.add(filedMasterFlag);
					reportFiledList.add(filedCustomerType);
					reportFiledList.add(filedStatusCode);
					reportFiledList.add(filedAuditStatusCode);
					reportFiledList.add(filedCreateUserId);
					reportFiledList.add(filedCreateTime);
					reportFiledList.add(filedAuditUserId);
					reportFiledList.add(filedAuditTime);
					reportFiledList.add(filedAuditNote);
					reportFiledList.add(filedModifyTime);
					reportFiledList.add(filedModifyUserId);
					reportFiledList.add(filedNote);
					super.validateParams(sheetCount, headerNameList, allDataList, validateTipsList, reportFiledList, objs);
				}
			}
		}
		return validateTipsList;
	}

	@Override
	protected void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
			List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, Object objs) throws ReportException {
		// 验证同一种用户类型的用户名不能重复
		validateUserNameNotRepeat(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList);
		// 验证客户类型只能为CUSTOMERTYPE_OPERATOR、CUSTOMERTYPE_SELLER，CUSTOMERTYPE_BUYER这三种在字典表里存在的类型
		validateCustomerTypeIsExist(sheetCount, reportFiled, headerNameList, validateTipsList);
	}

	/**
	 * 
	 * @Description TODO(验证同一种用户类型的用户名不能重复)
	 * @param sheetCount
	 * @param reportFiled
	 * @param headerNameList
	 * @param allDataList
	 * @param validateTipsList
	 */
	private void validateUserNameNotRepeat(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
			List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList) {
		// 根据导入的ECXCEL模版可知，headerNameList.get(1)为“用户名”这个字段名称
		if (reportFiled.getName().equals(headerNameList.get(1))) {
			String userName = (String) reportFiled.getValue();
			List<ReportFiled> rowReportFileds = allDataList.get(reportFiled.getSheetNum() - 1).get(
					reportFiled.getRowNum() - 1);
			String customerType = (String) rowReportFileds.get(7).getValue();
			// 验证在数据库中是否已存在相同用户名的同一种客户类型的用户
			Boolean flag = false;
			if (!ObjectUtils.isNullOrEmpty(userNameAndTypeInfoDtoSet)) {
				UserNameAndTypeInfoDto userNameAndTypeInfoDto = new UserNameAndTypeInfoDto();
				userNameAndTypeInfoDto.setUserName(userName);
				userNameAndTypeInfoDto.setCustomerType(customerType);
				flag = userNameAndTypeInfoDtoSet.contains(userNameAndTypeInfoDto);
			}
			if (flag) {
				String validateMsg = "“" + reportFiled.getName() + "”" + "在数据库中已存在同一种客户类型的用户";
				validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
			} else {
				// 验证在此次导入的EXCEL中是否已存在相同用户名的同一种客户类型的用户
				for (int i = 0; i < allDataList.size(); i++) {
					for (int j = 0; j < allDataList.get(i).size(); j++) {
						if (((i == (reportFiled.getSheetNum().intValue() - 1) && (j != (reportFiled.getRowNum().intValue() - 1))))
								|| (i != (reportFiled.getSheetNum().intValue() - 1))) {
							String userNameWithOtherFiled = "";
							String customerTypeWithOtherFiled = "";
							for (int k = 0; k < allDataList.get(i).get(j).size(); k++) {
								ReportFiled filed = allDataList.get(i).get(j).get(k);
								if (filed.getName().equals(headerNameList.get(1))) {
									userNameWithOtherFiled = (String) filed.getValue();
								}
								if (filed.getName().equals(headerNameList.get(7))) {
									customerTypeWithOtherFiled = (String) filed.getValue();
								}
							}
							if (!StringUtils.isEmpty(userName) && !StringUtils.isEmpty(customerType)) {
								if (userName.equals(userNameWithOtherFiled)
										&& customerType.equals(customerTypeWithOtherFiled)) {
									String validateMsg = "";
									if (1 == sheetCount.intValue()) {
										validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (j + 1) + "行"
												+ "存在同一种客户类型的用户";
										validateTipsList.add("第" + reportFiled.getRowNum() + "行，" + "字段：" + validateMsg);
									} else {
										validateMsg = "“" + reportFiled.getName() + "”" + "与第" + (i + 1) + "页Sheet里的第"
												+ (j + 1) + "行" + "存在同一种客户类型的用户";
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
	 * @Description TODO(验证客户类型是否存在)
	 * @param sheetCount
	 * @param reportFiled
	 * @param headerNameList
	 * @param validateTipsList
	 */
	private void validateCustomerTypeIsExist(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
			List<String> validateTipsList) {
		// 根据导入的ECXCEL模版可知，headerNameList.get(7)为“客户类型”这个字段名称
		if (reportFiled.getName().equals(headerNameList.get(7))) {
			Boolean flag = false;
			String strCustomertypes = "";
			if (!ObjectUtils.isNullOrEmpty(mapList)) {
				int index = 0;
				for (Map<String, String> map : mapList) {
					if (index == mapList.size() - 1) {
						strCustomertypes += map.get("id");
					} else {
						strCustomertypes += map.get("id") + "，";
					}
					if (map.get("id").equals((String) reportFiled.getValue())) {
						flag = true;
					}
					index++;
				}
			}
			if (!flag && !StringUtils.isEmpty(strCustomertypes)) {
				String validateMsg = "“" + reportFiled.getName() + "”" + "只能为" + strCustomertypes + "这几种类型";
				validateTipsList.add(super.getValidateTips(sheetCount, reportFiled, validateMsg));
			}
		}
	}

	@Override
	protected void insertImportData(List<String[]> rowDataList, Object objs) throws ReportException {
		try {
			List<UserDto> userDtoList = new ArrayList<UserDto>();
			for (String[] strArray : rowDataList) {
				UserDto userDto = new UserDto();
				userDto.setCustomerId(StringUtils.isEmpty(strArray[0]) ? null : new Integer(strArray[0]));
				userDto.setUserName(strArray[1]);
				userDto.setRealName(strArray[2]);
				userDto.setEmail(strArray[3]);
				userDto.setPhone(strArray[4]);
				userDto.setPassword(strArray[5]);
				userDto.setMasterFlag(strArray[6]);
				userDto.setCustomerType(strArray[7]);
				userDto.setStatusCode(strArray[8]);
				userDto.setAuditStatusCode(strArray[9]);
				userDto.setCreateUserId(StringUtils.isEmpty(strArray[10]) ? null : new Integer(strArray[10]));
				userDto.setCreateTime(StringUtils.isEmpty(strArray[11]) ? null : DateUtils.parseDate(strArray[11],
						CommonConstants.DATE_FORMAT_DAY));
				userDto.setAuditUserId(StringUtils.isEmpty(strArray[12]) ? null : new Integer(strArray[12]));
				userDto.setAuditTime(StringUtils.isEmpty(strArray[13]) ? null : DateUtils.parseDate(strArray[13],
						CommonConstants.DATE_FORMAT_DAY));
				userDto.setAuditNote(strArray[14]);
				userDto.setModifyTime(StringUtils.isEmpty(strArray[15]) ? null : DateUtils.parseDate(strArray[15],
						CommonConstants.DATE_FORMAT_DAY));
				userDto.setModifyUserId(StringUtils.isEmpty(strArray[16]) ? null : new Integer(strArray[16]));
				userDto.setNote(strArray[17]);
				userDtoList.add(userDto);
			}
			userServiceHessian.saveUserBatch(userDtoList);
		} catch (Exception e) {
			logger.error("导入报表出现系统异常", e);
			throw new IllegalStateException("导入报表出现系统异常", e);
		}
	}

	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	public IUserService getUserServiceHessian() {
		return userServiceHessian;
	}

	public void setUserServiceHessian(IUserService userServiceHessian) {
		this.userServiceHessian = userServiceHessian;
	}

	public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
		return systemBasicDataInfoUtils;
	}

	public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
		this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
	}

}
