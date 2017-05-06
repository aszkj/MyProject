package com.yilidi.o2o.report.export.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

public class UserReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 利用hessian协议的远程IUserService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IUserService userServiceHessian;

	public UserReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			UserDto userDto = (UserDto) searchArgument;
			return userServiceHessian.getCountsForExportUser(userDto);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			UserDto userDto = (UserDto) searchArgument;
			return userServiceHessian.listDataForExportUser(userDto, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = userReportHeader();
			String mainTitle = "用户报表";
			rowIndex = super.writeMainTitle(sheet, rowIndex, mainTitle, headers.size() - 1);
			rowIndex = super.writeHeader(sheet, headers, rowIndex);
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel头部信息出现异常：" + e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	protected int generateBody(Sheet sheet, int rowIndex, List<?> dataList) throws ReportException {
		try {
			if (!ObjectUtils.isNullOrEmpty(dataList)) {
				for (UserDto uDto : (List<UserDto>) dataList) {
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, uDto.getCustomerId());
					addCell(row, 1, uDto.getUserName());
					addCell(row, 2, uDto.getRealName());
					addCell(row, 3, uDto.getEmail());
					addCell(row, 4, uDto.getPhone());
					addCell(row, 5, uDto.getPassword());
					addCell(row, 6, uDto.getMasterFlag());
					addCell(row, 7, uDto.getCustomerType());
					addCell(row, 8, uDto.getStatusCode());
					addCell(row, 9, uDto.getAuditStatusCode());
					addCell(row, 10, uDto.getCreateUserId());
					addCell(row, 11, uDto.getCreateTime());
					addCell(row, 12, uDto.getAuditUserId());
					addCell(row, 13, uDto.getAuditTime());
					addCell(row, 14, uDto.getAuditNote());
					addCell(row, 15, uDto.getModifyTime());
					addCell(row, 16, uDto.getModifyUserId());
					addCell(row, 17, uDto.getNote());
					rowIndex++;
				}
			}
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
		}
	}

	public static List<Map<String, String>> userReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();

		map.put("header", "客户ID");
		map.put("width", "8");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "用户名");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "真实姓名");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "电子邮箱");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "电话号码");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "密码");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "主帐号标识");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "客户类型");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "用户状态编码");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "审核状态编码");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "创建人ID");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "创建时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "审核人ID");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "审核时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "审核意见");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "修改时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "修改人ID");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "备注信息");
		map.put("width", "25");
		headers.add(map);

		return headers;
	}

	public IUserService getUserServiceHessian() {
		return userServiceHessian;
	}

	public void setUserServiceHessian(IUserService userServiceHessian) {
		this.userServiceHessian = userServiceHessian;
	}

}
