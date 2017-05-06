package com.yilidi.o2o.report.export.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.user.service.IWithdrawApplyService;
import com.yilidi.o2o.user.service.dto.WithdrawApplyDto;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * @Description:TODO(用户提现申请记录报表导出) 
 * @author:	llp
 * @date:	2015年11月27日 下午5:15:26 
 *
 */
public class WithdrawApplyReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 利用hessian协议的远程IWithdrawApplyService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IWithdrawApplyService withdrawApplyServiceHessian;
	
	/**
	 * 获取SYSTEM_DICT字典表CODE的名称，工具类
	 */
	private SystemBasicDataInfoUtils systemBasicDataInfoUtils;
	
	public WithdrawApplyReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			WithdrawApplyQuery query = (WithdrawApplyQuery) searchArgument;
			return withdrawApplyServiceHessian.getCountsForExportWithdrawApply(query);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			WithdrawApplyQuery query = (WithdrawApplyQuery) searchArgument;
			return withdrawApplyServiceHessian.listDataForExportWithdrawApply(query, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "门店提现申请记录统计报表";
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
				for (WithdrawApplyDto withdrawApplyDto : (List<WithdrawApplyDto>) dataList) {
					double baseMount = ArithUtils.convertLongTodouble(StringUtils.BASE_AMOUNT);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					addCell(row, 1, withdrawApplyDto.getStoreCode());
					addCell(row, 2, withdrawApplyDto.getCustomerName());
					addCell(row, 3, withdrawApplyDto.getCityCode() + "-" + withdrawApplyDto.getCountyCode());
					addCell(row, 4, withdrawApplyDto.getAddressDetail());
					addCell(row, 5, withdrawApplyDto.getContactName());
					addCell(row, 6, withdrawApplyDto.getTelPhone());
					addCell(row, 7, systemBasicDataInfoUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.ACCOUNTBINDINGTYPE.getValue(),
							withdrawApplyDto.getBankCode())); //绑定账户类型
					addCell(row, 8, withdrawApplyDto.getSubBankName());
					addCell(row, 9, withdrawApplyDto.getBankCardNo());
					addCell(row, 10, ArithUtils.div(ArithUtils.convertLongTodouble(withdrawApplyDto.getCurrentBalance()),
							baseMount, 3));
					addCell(row, 11, ArithUtils.div(ArithUtils.convertLongTodouble(withdrawApplyDto.getHaveWithdraw()),
							baseMount, 3));
					addCell(row, 12, ArithUtils.div(ArithUtils.convertLongTodouble(withdrawApplyDto.getAmount()),
							baseMount, 3));
					addCell(row, 13, withdrawApplyDto.getApplyTime());
					addCell(row, 14, withdrawApplyDto.getAuditTime());
					addCell(row, 15, withdrawApplyDto.getTransferTime());
					addCell(row, 16, systemBasicDataInfoUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.WITHDRAWAPPLYAUDITSTATUS.getValue(),
							withdrawApplyDto.getStatusCode())); // 提现申请状态
					rowIndex++;
				}
			}
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
		}
	}

	public static List<Map<String, String>> withdrawReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();

		map.put("header", "序号");
		map.put("width", "8");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店编号");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店名称");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "所在地区");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店地址");
		map.put("width", "30");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "用户名");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "联系电话");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "提现银行");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "所属支行");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "银行账号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "可提现金额");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "已提现金额");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "提现金额");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "提现申请时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "提现审核时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "确定转账时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "提现状态");
		map.put("width", "15");
		headers.add(map);
		
		return headers;
	}

	public IWithdrawApplyService getWithdrawApplyServiceHessian() {
		return withdrawApplyServiceHessian;
	}

	public void setWithdrawApplyServiceHessian(IWithdrawApplyService withdrawApplyServiceHessian) {
		this.withdrawApplyServiceHessian = withdrawApplyServiceHessian;
	}

	public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
		return systemBasicDataInfoUtils;
	}

	public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
		this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
	}
}
