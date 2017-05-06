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
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.dto.OnlinePayDetailDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;

/**
 * @Description:TODO(门店在线支付日志导出报表) 
 * @author:	llp
 * @date:	2015年11月30日 下午5:16:38 
 *
 */
public class SellerOnlinePayLogReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 利用hessian协议的远程IAccountService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IAccountService accountServiceHessian;
	
	/**
	 * 获取SYSTEM_DICT字典表CODE的名称，工具类
	 */
	private SystemBasicDataInfoUtils systemBasicDataInfoUtils;
	
	public SellerOnlinePayLogReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			AccountDetailQuery  accountDetailQuery = (AccountDetailQuery) searchArgument;
			return accountServiceHessian.getCountsForExportOnlinePayDetails(accountDetailQuery);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			AccountDetailQuery  accountDetailQuery = (AccountDetailQuery) searchArgument;
			return accountServiceHessian.listDataForExportOnlinePayDetails(accountDetailQuery, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "门店线上交易日志报表";
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
				for (OnlinePayDetailDto onlinePayDetailDto : (List<OnlinePayDetailDto>) dataList) {
					double baseMount = ArithUtils.convertLongTodouble(StringUtils.BASE_AMOUNT);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					addCell(row, 1, onlinePayDetailDto.getStoreCode());
					addCell(row, 2, onlinePayDetailDto.getStoreName());
					addCell(row, 3, onlinePayDetailDto.getSerialNo());
					addCell(row, 4, systemBasicDataInfoUtils.getSystemDictName(
									SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
									onlinePayDetailDto.getPayPlatform()));
					addCell(row, 5, ArithUtils.div(ArithUtils.convertLongTodouble(onlinePayDetailDto.getPayAmount()),
									baseMount, 3));
					addCell(row, 6, systemBasicDataInfoUtils.getSystemDictName(
									SystemContext.UserDomain.DictType.PAYSTATUSCODE.getValue(),
									onlinePayDetailDto.getPayStatus()));
					addCell(row, 7, onlinePayDetailDto.getCreateTime());
					addCell(row, 8, onlinePayDetailDto.getUseDesc());
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
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店名称");
		map.put("width", "30");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "订单号");
		map.put("width", "30");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "支付平台");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "支付金额(元)");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "支付状态");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "创建时间");
		map.put("width", "25");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "支付内容");
		map.put("width", "25");
		headers.add(map);
		
		return headers;
	}

	public IAccountService getAccountServiceHessian() {
		return accountServiceHessian;
	}

	public void setAccountServiceHessian(IAccountService accountServiceHessian) {
		this.accountServiceHessian = accountServiceHessian;
	}

	public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
		return systemBasicDataInfoUtils;
	}

	public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
		this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
	}
}
