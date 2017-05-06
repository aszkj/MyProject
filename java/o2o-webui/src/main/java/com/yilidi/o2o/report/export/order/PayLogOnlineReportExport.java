package com.yilidi.o2o.report.export.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.query.PayLogQueryDto;

/**
 * @Description:TODO(买家用户在线支付日志管理导出报表) 
 * @author:	xiasl
 * @date:	2016年12月14日09:46:51 
 *
 */
public class PayLogOnlineReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 利用hessian协议的远程payLogServiceHessian接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IPayLogService payLogServiceHessian;

	/**
	 * 获取SYSTEM_DICT字典表CODE的名称，工具类
	 */
	private SystemBasicDataInfoUtils systemBasicDataInfoUtils;
	
	public PayLogOnlineReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			PayLogQueryDto payLogQueryDto   = (PayLogQueryDto) searchArgument;
			return payLogServiceHessian.getCountsForExportPayLog(payLogQueryDto);
		} catch (OrderServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			PayLogQueryDto payLogQueryDto   = (PayLogQueryDto) searchArgument;
			return payLogServiceHessian.listDataForExportPayLog(payLogQueryDto, startLineNum, pageSize);
		} catch (OrderServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "用户在线交易日志报表";
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
				for (PayLogDto payLogDto : (List<PayLogDto>) dataList) {
					double baseMount = ArithUtils.convertLongTodouble(StringUtils.BASE_AMOUNT);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					addCell(row, 1, payLogDto.getUserName());
					addCell(row, 2, payLogDto.getSaleOrderNo());
					
					addCell(row, 3, payLogDto.getPayPlatformCodeName());
					addCell(row, 4, payLogDto.getPayLogOrderNo()==null?"---":payLogDto.getPayLogOrderNo());
					addCell(row, 5, payLogDto.getPaySequence()==null?"---":payLogDto.getPaySequence());
					addCell(row, 6,	ArithUtils.div(ArithUtils.convertLongTodouble(payLogDto.getPayPrice()),
									baseMount, 3));
					addCell(row, 7,payLogDto.getPayLogStatusName());
					addCell(row, 8, payLogDto.getContent());
					addCell(row, 9, payLogDto.getCreateTime());
					addCell(row, 10,payLogDto.getUpdateTime()==null?"---":payLogDto.getUpdateTime());
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
		map.put("header", "用户登录账号");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "订单编号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "支付平台");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "商户订单号");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "支付订单号");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "支付金额(元)");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "支付状态");
		map.put("width", "15");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "支付内容");
		map.put("width", "40");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "创建时间");
		map.put("width", "25");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "更新时间");
		map.put("width", "25");
		headers.add(map);


		
		return headers;
	}

	public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
		return systemBasicDataInfoUtils;
	}

	public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
		this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
	}
	
	public IPayLogService getPayLogServiceHessian() {
		return payLogServiceHessian;
	}

	public void setPayLogServiceHessian(IPayLogService payLogServiceHessian) {
		this.payLogServiceHessian = payLogServiceHessian;
	}

}
