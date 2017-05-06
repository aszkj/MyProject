package com.yilidi.o2o.core.report;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.FutureTask;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidator;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;

/**
 * 导入报表抽象类
 * 
 * @param <T>
 *            泛型T
 * @author: chenlian
 * @date: 2015年11月23日 下午3:25:44
 */
public abstract class AbstractImportReport<T> implements IImportReport<T> {

    /**
     * Logger日志
     */
    private static final Logger LOGGER = Logger.getLogger(AbstractImportReport.class);

    /**
     * "General"数据格式
     */
    private static final String GENERAL_DATA_FORMAT = "General";

    /**
     * 时间单元格的格式ID（yyyy-MM-dd）
     */
    private static final Integer DATA_FORMAT_ID_ONE = 14;

    /**
     * 时间单元格的格式ID（yyyy年m月d日）
     */
    private static final Integer DATA_FORMAT_ID_TWO = 31;

    /**
     * 时间单元格的格式ID（yyyy年m月）
     */
    private static final Integer DATA_FORMAT_ID_THREE = 57;

    /**
     * 时间单元格的格式ID（m月d日）
     */
    private static final Integer DATA_FORMAT_ID_FOUR = 58;

    /**
     * 时间单元格的格式ID（HH:mm）
     */
    private static final Integer DATA_FORMAT_ID_FIVE = 20;

    /**
     * 时间单元格的格式ID（h时mm分）
     */
    private static final Integer DATA_FORMAT_ID_SIX = 32;

    /**
     * 验证单个Sheet时，每个线程验证的行数
     */
    private static final Integer RECORD_COUNT_PER_THREAD_FOR_SINGLE_SHEET = 100;

    /**
     * 
     * <p>
     * Title: importExcel
     * </p>
     * <p>
     * Description: 导入报表
     * </p>
     * 
     * @param reportPath
     *            报表路径
     * @param objs
     *            T泛型对象
     * @return List<String> 错误信息提示列表
     * @throws ReportException
     *             报表异常
     * @see com.yilidi.o2o.core.report.IImportReport#importExcel(java.lang.String, java.lang.Object[])
     */
    public List<String> importExcel(String reportPath, T objs) throws ReportException {
        Workbook workbook = null;
        FileInputStream fileInputStream = null;
        long startImportTime = 0;
        long endImportTime = 0;
        try {
            startImportTime = System.currentTimeMillis();
            // 获得文件输入流
            LOGGER.info("获得文件输入流........");
            fileInputStream = getInputStream(reportPath);
            // 初始化工作薄
            LOGGER.info("初始化工作薄........");
            workbook = initWork(reportPath, fileInputStream);
            final int sheetCount = workbook.getNumberOfSheets();
            // 多线程解析导入的Excel报表，封装报表数据
            LOGGER.info("开始解析数据........");
            List<List<List<ReportFiled>>> allDataList = parseExcel(workbook, sheetCount);
            LOGGER.info("解析数据完毕........");
            final List<List<List<ReportFiled>>> allReportFileds = allDataList;
            if (!ObjectUtils.isNullOrEmpty(allReportFileds)) {
                // 多线程验证导入的Excel报表，返回验证信息
                LOGGER.info("开始验证数据........");
                List<String> validateTipsList = validateExcel(sheetCount, allReportFileds, objs);
                LOGGER.info("验证数据完毕........");
                if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                    return validateTipsList;
                }
                // 验证全部通过后，封装需导入的数据
                List<String[]> rowDataList = encapsulateImportData(allDataList);
                // 导入的报表信息插入数据库
                if (!ObjectUtils.isNullOrEmpty(rowDataList)) {
                    LOGGER.info("开始导入数据........");
                    insertImportData(rowDataList, objs);
                    LOGGER.info("导入数据完毕........");
                }
                return null;
            } else {
                LOGGER.error("导入的报表无数据信息，无法导入");
                throw new IllegalStateException("导入的报表无数据信息，无法导入");
            }
        } catch (Exception e) {
            if (!StringUtils.isEmpty(e.getMessage())) {
                LOGGER.error(e.getMessage(), e);
                throw new ReportException(e.getMessage(), e);
            } else {
                LOGGER.error("导入报表出现系统异常", e);
                throw new IllegalStateException("导入报表出现系统异常", e);
            }
        } finally {
            // 关闭工作区
            if (null != workbook) {
                try {
                    workbook.close();
                    workbook = null;
                } catch (Exception e) {
                    throw new ReportException("导入报表出现系统异常：" + e.getMessage());
                }
            }
            // 关闭输入流
            if (null != fileInputStream) {
                try {
                    fileInputStream.close();
                } catch (IOException e) {
                    throw new ReportException("导入报表出现系统异常：" + e.getMessage());
                }
            }
            endImportTime = System.currentTimeMillis();
            LOGGER.info("导入过程耗时：" + (endImportTime - startImportTime) + "毫秒。");
        }
    }

    /**
     * 
     * @Description TODO(获得文件输入流)
     * @param reportPath
     * @return FileInputStream
     * @throws FileNotFoundException
     */
    private FileInputStream getInputStream(String reportPath) throws FileNotFoundException {
        FileInputStream fileInputStream;
        String localUploadFileBasePath = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH);
        if (StringUtils.isEmpty(localUploadFileBasePath)) {
            throw new IllegalStateException(
                    "本地服务器存放上传文件的基础路径LOCAL_UPLOAD_FILE_BASE_PATH在缓存中不存在，请配置该路径，并启动o2o-system-service工程");
        }
        File reportFile = new File(localUploadFileBasePath + reportPath);
        fileInputStream = new FileInputStream(reportFile);
        return fileInputStream;
    }

    /**
     * 
     * @Description TODO(初始化工作薄)
     * @param reportPath
     * @param fileInputStream
     * @return Workbook
     * @throws IOException
     */
    private Workbook initWork(String reportPath, FileInputStream fileInputStream) throws IOException {
        Workbook workbook = null;
        if (".xls".equalsIgnoreCase(getExtensionName(reportPath))) {
            workbook = new HSSFWorkbook(fileInputStream);
        } else if (".xlsx".equalsIgnoreCase(getExtensionName(reportPath))) {
            workbook = new XSSFWorkbook(fileInputStream);
        }
        return workbook;
    }

    /**
     * 
     * @Description TODO(获取文件的后缀名)
     * @param filename
     * @return String
     */
    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    /**
     * 
     * @Description TODO(多线程解析导入的Excel报表，封装报表数据)
     * @param workbook
     * @param sheetCount
     * @return List<List<List<ReportFiled>>>
     * @throws InterruptedException
     * @throws ExecutionException
     */
    private List<List<List<ReportFiled>>> parseExcel(Workbook workbook, final int sheetCount) throws InterruptedException,
            ExecutionException {
        LOGGER.info("CPU Processors : " + Runtime.getRuntime().availableProcessors());
        List<FutureTask<List<List<ReportFiled>>>> futureTaskList = new ArrayList<FutureTask<List<List<ReportFiled>>>>();
        final ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors() + 1);
        for (int i = 1; i <= sheetCount; i++) {
            final Sheet sheet = workbook.getSheetAt(i - 1);
            final int sheetIndex = i;
            FutureTask<List<List<ReportFiled>>> futureTask = new FutureTask<List<List<ReportFiled>>>(
                    new Callable<List<List<ReportFiled>>>() {
                        public List<List<ReportFiled>> call() {
                            try {
                                List<List<ReportFiled>> sheetDataList = new ArrayList<List<ReportFiled>>();
                                int startRowNum = sheet.getFirstRowNum();
                                int lastRowNum = sheet.getLastRowNum();
                                String[] headerNames = null;
                                short cellNumEachRow = 0;
                                for (int rowNum = startRowNum; rowNum <= lastRowNum; rowNum++) {
                                    if (sheet.getRow(rowNum) != null) {
                                        Row row = sheet.getRow(rowNum);
                                        short firstCellNum = row.getFirstCellNum();
                                        short lastCellNum = row.getLastCellNum();
                                        if (rowNum == startRowNum) {
                                            cellNumEachRow = lastCellNum;
                                        }
                                        if (firstCellNum != lastCellNum) {
                                            String[] rowDataValues = new String[cellNumEachRow];
                                            for (int cellNum = firstCellNum; cellNum < cellNumEachRow; cellNum++) {
                                                Cell cell = row.getCell(cellNum);
                                                boolean isMerge = isMergedRegion(sheet, rowNum, cellNum);
                                                if(isMerge){
                                                	rowDataValues[cellNum] = getMergedRegionValue(sheet, rowNum, cellNum);
                                                }else{
                                                	rowDataValues[cellNum] = parseCellData(cell);
                                                }
                                                /*if (cell == null) {
                                                    rowDataValues[cellNum] = "";
                                                } else {
                                                    rowDataValues[cellNum] = parseCellData(cell);
                                                }*/
                                            }
                                            if (rowNum == startRowNum) {
                                                headerNames = rowDataValues;
                                            } else {
                                                int index = 0;
                                                List<ReportFiled> rowDataList = new ArrayList<ReportFiled>();
                                                for (String value : rowDataValues) {
                                                    if (index < headerNames.length) {
                                                        ReportFiled reportFiled = new ReportFiled(sheetIndex, rowNum,
                                                                headerNames[index], null == value ? "" : value.trim());
                                                        rowDataList.add(reportFiled);
                                                        index++;
                                                    }
                                                }
                                                sheetDataList.add(rowDataList);
                                            }
                                            rowDataValues = null;
                                        }
                                    }
                                }
                                return sheetDataList;
                            } catch (Exception e) {
                                LOGGER.error("导入报表出现系统异常", e);
                                // 立即停止所有的线程
                                executorService.shutdownNow();
                                throw new IllegalStateException("导入报表出现系统异常", e);
                            }
                        };
                    });
            executorService.submit(futureTask);
            futureTaskList.add(futureTask);
        }
        // 不接受新的线程，已经运行了线程继续执行
        executorService.shutdown();
        List<List<List<ReportFiled>>> allDataList = null;
        if (!ObjectUtils.isNullOrEmpty(futureTaskList)) {
            allDataList = new ArrayList<List<List<ReportFiled>>>();
            for (FutureTask<List<List<ReportFiled>>> futureTask : futureTaskList) {
                List<List<ReportFiled>> sheetDataList = futureTask.get();
                if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
                    allDataList.add(sheetDataList);
                }
            }
        }
        return allDataList;
    }

    /**
     * 
     * @Description TODO(解析单元格数据)
     * @param cell
     * @return String
     */
    private String parseCellData(Cell cell) {
        try {
        	if (cell == null)
    			return "";
            String result = "";
            switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_NUMERIC:// 数字类型
                if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式
                    SimpleDateFormat sdf = null;
                    if (cell.getCellStyle().getDataFormat() == HSSFDataFormat.getBuiltinFormat("h:mm")) {
                        sdf = new SimpleDateFormat("HH:mm");
                    } else {// 日期
                        sdf = new SimpleDateFormat("yyyy-MM-dd");
                    }
                    Date date = cell.getDateCellValue();
                    result = sdf.format(date);
                } else if (cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_ONE.intValue()
                        || cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_TWO.intValue()
                        || cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_THREE.intValue()
                        || cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_FOUR.intValue()) {
                    // 日期格式
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    double value = cell.getNumericCellValue();
                    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);
                    result = sdf.format(date);
                } else if (cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_FIVE.intValue()
                        || cell.getCellStyle().getDataFormat() == DATA_FORMAT_ID_SIX.intValue()) {
                    // 时间格式
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                    double value = cell.getNumericCellValue();
                    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);
                    result = sdf.format(date);
                } else {
                    double value = cell.getNumericCellValue();
                    DecimalFormat df = new DecimalFormat("#.00");
                    String strValue = df.format(value);
                    CellStyle style = cell.getCellStyle();
                    DecimalFormat decimalFormat = new DecimalFormat();
                    String temp = style.getDataFormatString();
                    if (GENERAL_DATA_FORMAT.equals(temp)) {
                        if (strValue.contains(".00")) {
                            decimalFormat.applyPattern("#");
                        }
                    }
                    decimalFormat.setGroupingUsed(false);
                    result = decimalFormat.format(value);
                }
                break;
            case HSSFCell.CELL_TYPE_STRING:// String类型
                result = cell.getRichStringCellValue().toString();
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                result = "";
            default:
                result = "";
                break;
            }
            return result;
        } catch (Exception e) {
            LOGGER.error("解析单元格数据出现系统异常", e);
            throw new IllegalStateException("解析单元格数据出现系统异常", e);
        }
    }

    /**
     * 
     * @Description TODO(多线程验证导入的Excel报表，返回验证信息)
     * @param sheetCount
     * @param allReportFileds
     * @param objs
     * @return List<String>
     * @throws InterruptedException
     * @throws ExecutionException
     */
    private List<String> validateExcel(final int sheetCount, final List<List<List<ReportFiled>>> allReportFileds,
            final T objs) throws InterruptedException, ExecutionException {
        List<FutureTask<List<String>>> validateFutureTaskList = new ArrayList<FutureTask<List<String>>>();
        final ExecutorService validateExecutorService = Executors.newFixedThreadPool(Runtime.getRuntime()
                .availableProcessors() + 1);
        if (allReportFileds.size() > 1) {
            for (final List<List<ReportFiled>> sheetDataList : allReportFileds) {
                FutureTask<List<String>> futureTask = new FutureTask<List<String>>(new Callable<List<String>>() {
                    public List<String> call() {
                        try {
                            List<String> headerNameList = new ArrayList<String>();
                            for (List<ReportFiled> rowReportFileds : sheetDataList) {
                                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                                    for (ReportFiled reportFiled : rowReportFileds) {
                                        headerNameList.add(reportFiled.getName());
                                    }
                                    break;
                                }
                            }
                            return validateSheetData(sheetCount, headerNameList, sheetDataList, allReportFileds, objs);
                        } catch (Exception e) {
                            LOGGER.error("导入报表出现系统异常", e);
                            // 立即停止所有的线程
                            validateExecutorService.shutdownNow();
                            throw new IllegalStateException("导入报表出现系统异常", e);
                        }
                    };
                });
                validateExecutorService.submit(futureTask);
                validateFutureTaskList.add(futureTask);
            }
        } else {
            final List<List<ReportFiled>> sheetDataList = allReportFileds.get(0);
            final int validateCount = (int) Math.ceil((double) sheetDataList.size()
                    / (double) RECORD_COUNT_PER_THREAD_FOR_SINGLE_SHEET);
            for (int i = 0; i < validateCount; i++) {
                final int index = i;
                FutureTask<List<String>> futureTask = new FutureTask<List<String>>(new Callable<List<String>>() {
                    public List<String> call() {
                        try {
                            List<String> headerNameList = new ArrayList<String>();
                            int fromIndex = index * RECORD_COUNT_PER_THREAD_FOR_SINGLE_SHEET;
                            int toIndex = ((index + 1) * RECORD_COUNT_PER_THREAD_FOR_SINGLE_SHEET) > sheetDataList.size() ? sheetDataList
                                    .size() : ((index + 1) * RECORD_COUNT_PER_THREAD_FOR_SINGLE_SHEET);
                            for (List<ReportFiled> rowReportFileds : sheetDataList.subList(fromIndex, toIndex)) {
                                if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                                    for (ReportFiled reportFiled : rowReportFileds) {
                                        headerNameList.add(reportFiled.getName());
                                    }
                                    break;
                                }
                            }
                            return validateSheetData(1, headerNameList, sheetDataList.subList(fromIndex, toIndex),
                                    allReportFileds, objs);
                        } catch (Exception e) {
                            LOGGER.error("导入报表出现系统异常", e);
                            // 立即停止所有的线程
                            validateExecutorService.shutdownNow();
                            throw new IllegalStateException("导入报表出现系统异常", e);
                        }
                    };
                });
                validateExecutorService.submit(futureTask);
                validateFutureTaskList.add(futureTask);
            }
        }
        // 不接受新的线程，已经运行了线程继续执行
        validateExecutorService.shutdown();
        List<String> validateTipsList = null;
        if (!ObjectUtils.isNullOrEmpty(validateFutureTaskList)) {
            validateTipsList = new ArrayList<String>();
            for (FutureTask<List<String>> validateFutureTask : validateFutureTaskList) {
                List<String> validateTips = validateFutureTask.get();
                if (!ObjectUtils.isNullOrEmpty(validateTips)) {
                    validateTipsList.addAll(validateTips);
                }
            }
        }
        return validateTipsList;
    }

    /**
     * 
     * @Description TODO(验证全部通过后，封装需导入的数据)
     * @param allDataList
     * @return List<String[]>
     */
    private List<String[]> encapsulateImportData(List<List<List<ReportFiled>>> allDataList) {
        List<String[]> rowDataList = new LinkedList<String[]>();
        for (final List<List<ReportFiled>> sheetDataList : allDataList) {
            if (!ObjectUtils.isNullOrEmpty(sheetDataList)) {
                for (List<ReportFiled> rowReportFileds : sheetDataList) {
                    if (!ObjectUtils.isNullOrEmpty(rowReportFileds)) {
                        String[] array = new String[rowReportFileds.size()];
                        for (int i = 0; i < rowReportFileds.size(); i++) {
                            array[i] = (String) rowReportFileds.get(i).getValue();
                        }
                        rowDataList.add(array);
                    }
                }
            }
        }
        allDataList = null;
        return rowDataList;
    }

    /**
     * 
     * @Description TODO(导入时，验证Sheet页的数据)
     * @param sheetCount
     * @param headerNameList
     * @param sheetDataList
     * @param allDataList
     * @param objs
     * @return List<String>
     * @throws ReportException
     */
    protected abstract List<String> validateSheetData(Integer sheetCount, List<String> headerNameList,
            List<List<ReportFiled>> sheetDataList, List<List<List<ReportFiled>>> allDataList, T objs) throws ReportException;

    /**
     * 
     * @Description TODO(验证导入参数)
     * @param sheetCount
     * @param headerNameList
     * @param allDataList
     * @param validateTipsList
     * @param reportFiledList
     * @param objs
     * @return List<String>
     */
    protected List<String> validateParams(Integer sheetCount, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, List<ReportFiled> reportFiledList,
            T objs) {
        if (!ObjectUtils.isNullOrEmpty(reportFiledList)) {
            for (ReportFiled reportFiled : reportFiledList) {
                ParamValidateMessageBean mb = ParamValidator.validate(reportFiled);
                if (null != mb && mb.getMsgCode() == ParamValidateMessageBean.MsgCode.FAILURE.getValue().intValue()) {
                    validateTipsList.add(getValidateTips(sheetCount, reportFiled, mb.getMsg()));
                }
                validateBusinessRule(sheetCount, reportFiled, headerNameList, allDataList, validateTipsList, objs);
            }
        }
        return validateTipsList;
    }

    /**
     * 
     * @Description TODO(获取单个字段验证的提示信息)
     * @param sheetCount
     * @param reportFiled
     * @param validateMsg
     * @return String
     */
    protected String getValidateTips(Integer sheetCount, ReportFiled reportFiled, String validateMsg) {
        if (1 == sheetCount.intValue()) {
            return "第" + reportFiled.getRowNum() + "行，" + "字段：" + validateMsg;
        } else {
            return "第" + reportFiled.getSheetNum() + "页Sheet中，" + "第" + reportFiled.getRowNum() + "行，" + "字段：" + validateMsg;
        }
    }

    /**
     * 
     * @Description TODO(验证导入参数的业务规则)
     * @param sheetCount
     * @param reportFiled
     * @param headerNameList
     * @param allDataList
     * @param validateTipsList
     * @param objs
     * @throws ReportException
     */
    protected abstract void validateBusinessRule(Integer sheetCount, ReportFiled reportFiled, List<String> headerNameList,
            List<List<List<ReportFiled>>> allDataList, List<String> validateTipsList, T objs) throws ReportException;

    /**
     * 
     * @Description TODO(导入的报表信息插入数据库)
     * @param rowDataList
     * @param objs
     * @throws ReportException
     */
    protected abstract void insertImportData(List<String[]> rowDataList, T objs) throws ReportException;

    /**
	 * 判断指定的单元格是否是合并单元格
	 * 
	 * @param sheet
	 * @param row
	 *            行下标
	 * @param column
	 *            列下标
	 * @return
	 */
	private boolean isMergedRegion(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();
		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress range = sheet.getMergedRegion(i);
			int firstColumn = range.getFirstColumn();
			int lastColumn = range.getLastColumn();
			int firstRow = range.getFirstRow();
			int lastRow = range.getLastRow();
			if (row >= firstRow && row <= lastRow) {
				if (column >= firstColumn && column <= lastColumn) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 获取合并单元格的值
	 * 
	 * @param sheet
	 * @param row
	 * @param column
	 * @return
	 */
	public  String getMergedRegionValue(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();

		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();

			if (row >= firstRow && row <= lastRow) {

				if (column >= firstColumn && column <= lastColumn) {
					Row fRow = sheet.getRow(firstRow);
					Cell fCell = fRow.getCell(firstColumn);
					return parseCellData(fCell);
				}
			}
		}

		return null;
	}
	/**
	 * 获取单元格的值
	 * 
	 * @param cell
	 * @return
	 */
	public  String getCellValue(Cell cell) {

		if (cell == null)
			return "";

		if (cell.getCellType() == Cell.CELL_TYPE_STRING) {

			return cell.getStringCellValue();

		} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {

			return String.valueOf(cell.getBooleanCellValue());

		} else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {

			return cell.getCellFormula();

		} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {

			return String.valueOf(cell.getNumericCellValue());

		}
		return "";
	}
}
