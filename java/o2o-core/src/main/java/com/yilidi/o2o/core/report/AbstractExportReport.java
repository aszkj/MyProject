package com.yilidi.o2o.core.report;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;

/**
 * 
 * @Description:TODO(导出报表抽象类)
 * @author: chenlian
 * @date: 2015年11月23日 下午3:25:59
 * 
 */
public abstract class AbstractExportReport implements IExportReport {

	/**
	 * Logger日志
	 */
	private static final Logger LOGGER = Logger.getLogger(AbstractExportReport.class);

	/**
	 * 工作薄对象
	 */
	private SXSSFWorkbook workbook;

	/**
	 * 主标题样式
	 */
	private XSSFCellStyle mainTitleStyle;

	/**
	 * 表头样式
	 */
	private XSSFCellStyle headerStyle;

	/**
	 * 统计样式
	 */
	private volatile XSSFCellStyle statisticsStyle;

	/**
	 * 字符串单元格样式
	 */
	private XSSFCellStyle stringCellStyle;

	/**
	 * 日期单元格样式
	 */
	private XSSFCellStyle dateCellStyle;

	/**
	 * 数字(整数)单元格样式
	 */
	private XSSFCellStyle numberIntegerCellStyle;

	/**
	 * 数字(小数)单元格样式
	 */
	private XSSFCellStyle numberDecimalCellStyle;

	/**
	 * 数据刷新到磁盘时，内存中保留的记录数
	 */
	private static final Integer RECORD_COUNT_IN_MEMORY_AT_FLUSHING_DISK = 100;

	/**
	 * 每个Sheet所包含的记录数
	 */
	private static final Integer RECORD_COUNT_PER_SHEET = 30000;

	/**
	 * 本地导出报表存放目录基础路径
	 */
	private static String localDownloadFileBasePath;

	/**
	 * 报表各自的相对路径
	 */
	protected String reportIndividualRelativePath;

	/**
	 * 初始化导出所需的系统参数
	 */
	static {
		localDownloadFileBasePath = SystemBasicDataUtils
				.getSystemParamValue(SystemContext.SystemParams.LOCAL_DOWNLOAD_FILE_BASE_PATH);
		if (StringUtils.isEmpty(localDownloadFileBasePath)) {
			throw new IllegalStateException(
					"本地服务器存放下载文件的基础路径LOCAL_DOWNLOAD_FILE_BASE_PATH在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
		}
	}

	/**
	 * 
	 * <p>
	 * Title: reportExcel
	 * </p>
	 * <p>
	 * Description: 导出报表
	 * </p>
	 * 
	 * @param searchArgument
	 * @param reportName
	 * @return ReportFileModel
	 * @throws ReportException
	 * @see com.yilidi.o2o.core.report.IImportReport#reportExcel(java.lang.Object, java.lang.String)
	 */
	public ReportFileModel exportExcel(Object searchArgument, String reportName) throws ReportException {
		OutputStream out = null;
		ReportFileModel reportFileModel = null;
		long startExportTime = 0;
		long endExportTime = 0;
		try {
			startExportTime = System.currentTimeMillis();
			// 获得输出流
			Map<String, Object> map = this.getOutputStream(reportName);
			if (null != map.get("outputStream")) {
				out = (OutputStream) map.get("outputStream");
				// 初始化工作区
				initWork();
				// 生成Excel报表数据
				generateExcelReport(reportName, workbook, searchArgument, obtainDataCount(searchArgument));
				// 生成报表
				workbook.write(out);
				reportFileModel = new ReportFileModel();
				reportFileModel.setReportFileName((String) map.get("exportReportFileFullName"));
				reportFileModel.setReportFilePath((String) map.get("exportReportFileRelativePath"));
			}
			return reportFileModel;
		} catch (Exception e) {
			if (StringUtils.isEmpty(e.getMessage())) {
				LOGGER.error(e.getMessage(), e);
				throw new ReportException(e.getMessage(), e);
			} else {
				LOGGER.error("导出报表出现系统异常", e);
				throw new ReportException("导出报表出现系统异常", e);
			}
		} finally {
			this.mainTitleStyle = null;
			this.headerStyle = null;
			this.statisticsStyle = null;
			this.stringCellStyle = null;
			this.dateCellStyle = null;
			this.numberIntegerCellStyle = null;
			this.numberDecimalCellStyle = null;
			// 关闭工作区
			if (null != workbook) {
				try {
					workbook.close();
					this.workbook = null;
				} catch (Exception e) {
					throw new ReportException("导出报表出现系统异常：" + e.getMessage());
				}
			}
			// 关闭输出流
			if (null != out) {
				try {
					out.flush();
					out.close();
				} catch (IOException e) {
					throw new ReportException("导出报表出现系统异常：" + e.getMessage());
				}
			}
			endExportTime = System.currentTimeMillis();
			LOGGER.info("导出过程耗时：" + (endExportTime - startExportTime) + "毫秒。");
		}
	}

	/**
	 * 
	 * @Description TODO(生成Excel报表数据)
	 * @param reportName
	 * @param workbook
	 * @param searchArgument
	 * @param dataCount
	 * @throws InterruptedException
	 */
	private void generateExcelReport(String reportName, SXSSFWorkbook workbook, final Object searchArgument, Long dataCount)
			throws InterruptedException {
		int sheetCount = (int) Math.ceil((double) dataCount / (double) RECORD_COUNT_PER_SHEET);
		if (sheetCount > 0) {
			final CountDownLatch countDownLatch = new CountDownLatch(sheetCount);
			final ExecutorService executorService = Executors
					.newFixedThreadPool(Runtime.getRuntime().availableProcessors() + 1);
			for (int i = 1; i <= sheetCount; i++) {
				final Sheet sheet = workbook.createSheet(reportName + i);
				final int startPage = i;
				executorService.submit(new Runnable() {
					public void run() {
						try {
							int rowIndex = 0;
							// 生成Excel头部信息
							rowIndex = generateHead(sheet, rowIndex);
							// 获取该Sheet所需的导出数据
							List<?> dataList = obtainDataList(searchArgument,
									Long.valueOf((startPage - 1) * RECORD_COUNT_PER_SHEET), RECORD_COUNT_PER_SHEET);
							// 生成Excel主体数据信息
							rowIndex = generateBody(sheet, rowIndex, dataList);
							dataList = null;
							// 完成一个线程就将countDownLatch进行countDown，当减为0时，表示所有的生成各sheet报表数据的线程执行完毕
							countDownLatch.countDown();
						} catch (Exception e) {
							LOGGER.error("导出报表出现系统异常", e);
							// 立即停止所有的线程
							executorService.shutdownNow();
							throw new IllegalStateException("导出报表出现系统异常", e);
						}
					};
				});
			}
			// 不接受新的线程，已经运行了线程继续执行
			executorService.shutdown();
			countDownLatch.await(30, TimeUnit.MINUTES);
		} else {
			int rowIndex = 0;
			// 生成Excel头部信息
			Sheet sheet = workbook.createSheet(reportName);
			generateHead(sheet, rowIndex);
		}
	}

	/**
	 * 
	 * @Description TODO(获得输出流)
	 * @param exportFileName
	 * @return Map<String, Object>
	 * @throws IOException
	 */
	private Map<String, Object> getOutputStream(String exportFileName) throws IOException {
		Date createTime = new Date();
		String filePrefix = exportFileName + DateUtils.formatDate(createTime, "yyyy-MM-dd-HH-mm");
		String fileSuffix = "xlsx";
		String exportReportFileFullName = filePrefix + "." + fileSuffix;
		String exportReportFileFullPath = localDownloadFileBasePath + reportIndividualRelativePath + "/"
				+ exportReportFileFullName;
		File file = new File(exportReportFileFullPath);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		FileOutputStream outputStream = new FileOutputStream(file);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("exportReportFileFullName", exportReportFileFullName);
		map.put("exportReportFileRelativePath", reportIndividualRelativePath + "/" + exportReportFileFullName);
		map.put("outputStream", outputStream);
		return map;
	}

	/**
	 * 
	 * @Description TODO(初始化工作区)
	 * @return SXSSFWorkbook
	 * @throws ReportException
	 */
	private SXSSFWorkbook initWork() throws ReportException {
		try {
			// 创建基于stream流的工作薄对象,当第101条数据进入内存时，第一条记录会被刷新到硬盘，以此类推
			workbook = new SXSSFWorkbook(RECORD_COUNT_IN_MEMORY_AT_FLUSHING_DISK);
			return workbook;
		} catch (Exception e) {
			throw new ReportException("初始化工作区出现系统异常：" + e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取需导出的总记录数)
	 * @param searchArgument
	 * @return Long
	 * @throws ReportException
	 */
	protected abstract Long obtainDataCount(Object searchArgument) throws ReportException;

	/**
	 * 
	 * @Description TODO(获取导出数据的List)
	 * @param searchArgument
	 * @param startLineNum
	 * @param pageSize
	 * @return List<?>
	 * @throws ReportException
	 */
	protected abstract List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize)
			throws ReportException;

	/**
	 * 
	 * @Description TODO(生成Excel头部信息)
	 * @param sheet
	 * @param rowIndex
	 * @return int
	 * @throws ReportException
	 */
	protected abstract int generateHead(Sheet sheet, int rowIndex) throws ReportException;

	/**
	 * 
	 * @Description TODO(生成Excel主体数据信息)
	 * @param sheet
	 * @param rowIndex
	 * @param dataList
	 * @return int
	 * @throws ReportException
	 */
	protected abstract int generateBody(Sheet sheet, int rowIndex, List<?> dataList) throws ReportException;

	/**
	 * 
	 * @Description TODO(获取字体样式)
	 * @param workbook
	 * @param fontName
	 * @param fontSize
	 * @param isBold
	 * @return XSSFCellStyle
	 */
	private XSSFCellStyle getFontStyle(SXSSFWorkbook workbook, String fontName, short fontSize, Boolean isBold) {
		Font font = workbook.createFont();
		font.setFontName(fontName);
		font.setFontHeightInPoints(fontSize);
		font.setBold(isBold);
		font.setCharSet(Font.DEFAULT_CHARSET);
		XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
		cellStyle.setFont(font);
		return cellStyle;
	}

	/**
	 * 
	 * @Description TODO(初始化单元格样式)
	 * @param workbook
	 * @param fontSize
	 * @param isBold
	 * @param colour
	 * @param format
	 * @return XSSFCellStyle
	 */
	private XSSFCellStyle initCellStyle(SXSSFWorkbook workbook, short fontSize, Boolean isBold, short colour, String format) {
		XSSFCellStyle style = this.getFontStyle(workbook, "宋体", fontSize, isBold);
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setFillBackgroundColor(colour);
		style.setFillForegroundColor(colour);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		if (!StringUtils.isEmpty(format)) {
			DataFormat dataFormat = workbook.createDataFormat();
			style.setDataFormat(dataFormat.getFormat(format));
		}
		return style;
	}

	/**
	 * 
	 * @Description TODO(写入主标题信息)
	 * @param sheet
	 * @param rowIndex
	 * @param mainTitle
	 * @param columnCount
	 * @return int
	 */
	protected int writeMainTitle(Sheet sheet, int rowIndex, String mainTitle, int columnCount) {
		Row row = sheet.createRow(rowIndex);
		Cell cell = row.createCell(0);
		cell.setCellValue(mainTitle);
		cell.setCellStyle(getMainTitleStyle());
		CellRangeAddress cellRangeAddress = new CellRangeAddress(0, rowIndex, 0, columnCount);
		sheet.addMergedRegion(cellRangeAddress);
		rowIndex++;
		return rowIndex;
	}

	/**
	 * 
	 * @Description TODO(写入头部信息)
	 * @param sheet
	 * @param headers
	 * @param rowIndex
	 * @return int
	 */
	protected int writeHeader(Sheet sheet, List<Map<String, String>> headers, int rowIndex) {
		Row row = sheet.createRow(rowIndex);
		for (int i = 0; i < headers.size(); i++) {
			Map<String, String> map = headers.get(i);
			Cell cell = row.createCell(i);
			cell.setCellValue(map.get("header").toString());
			cell.setCellStyle(getHeaderStyle());
			sheet.setColumnWidth(i, Integer.parseInt(map.get("width")) * 256);
		}
		rowIndex++;
		return rowIndex;
	}

	/**
	 * 
	 * @Description TODO(加入单元格)
	 * @param row
	 * @param columnIndex
	 * @param cellData
	 */
	protected void addCell(Row row, int columnIndex, Object cellData) {
		Cell cell = row.createCell(columnIndex);
		if (null != cellData) {
			if (cellData instanceof Date) {
				cell.setCellValue((Date) cellData);
				cell.setCellStyle(getDateCellStyle());
			} else if (cellData instanceof String) {
				cell.setCellValue((String) cellData);
				cell.setCellStyle(getStringCellStyle());
			} else {
				if (cellData instanceof Integer) {
					cell.setCellValue((Integer) cellData);
					cell.setCellStyle(getNumberIntegerCellStyle());
				} else if (cellData instanceof Long) {
					cell.setCellValue((Long) cellData);
					cell.setCellStyle(getNumberIntegerCellStyle());
				} else {
					cell.setCellValue((Double) cellData);
					cell.setCellStyle(getNumberDecimalCellStyle());
				}
			}
		} else {
			cell.setCellValue("");
			cell.setCellStyle(getStringCellStyle());
		}
	}

	protected XSSFCellStyle getMainTitleStyle() {
		if (null == mainTitleStyle) {
			mainTitleStyle = initCellStyle(workbook, (short) 16, true, IndexedColors.WHITE.getIndex(), null);
		}
		return mainTitleStyle;
	}

	protected XSSFCellStyle getHeaderStyle() {
		if (null == headerStyle) {
			headerStyle = initCellStyle(workbook, (short) 13, true, IndexedColors.GREY_25_PERCENT.getIndex(), null);
		}
		return headerStyle;
	}

	protected XSSFCellStyle getStatisticsStyle() {
		if (null == statisticsStyle) {
			statisticsStyle = initCellStyle(workbook, (short) 12, true, IndexedColors.GREY_25_PERCENT.getIndex(), null);
		}
		return statisticsStyle;
	}

	protected XSSFCellStyle getStringCellStyle() {
		if (null == stringCellStyle) {
			stringCellStyle = initCellStyle(workbook, (short) 11, false, IndexedColors.WHITE.getIndex(), null);
		}
		return stringCellStyle;
	}

	protected XSSFCellStyle getDateCellStyle() {
		if (null == dateCellStyle) {
			dateCellStyle = initCellStyle(workbook, (short) 11, false, IndexedColors.WHITE.getIndex(), "yyyy-MM-dd HH:mm:ss");
		}
		return dateCellStyle;
	}

	protected XSSFCellStyle getNumberIntegerCellStyle() {
		if (null == numberIntegerCellStyle) {
			numberIntegerCellStyle = initCellStyle(workbook, (short) 11, false, IndexedColors.WHITE.getIndex(), "0");
		}
		return numberIntegerCellStyle;
	}

	protected XSSFCellStyle getNumberDecimalCellStyle() {
		if (null == numberDecimalCellStyle) {
			numberDecimalCellStyle = initCellStyle(workbook, (short) 11, false, IndexedColors.WHITE.getIndex(), "0.00");
		}
		return numberDecimalCellStyle;
	}

}
