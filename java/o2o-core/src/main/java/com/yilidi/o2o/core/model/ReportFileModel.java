package com.yilidi.o2o.core.model;

import java.io.Serializable;

/**
 * 
 * @Description:TODO(报表文件Model)
 * @author: chenlian
 * @date: 2015年10月19日 下午4:20:56
 * 
 */
public class ReportFileModel implements Serializable {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = -2059691300797209041L;

	private String reportFileName;

	private String reportFilePath;

	public String getReportFileName() {
		return reportFileName;
	}

	public void setReportFileName(String reportFileName) {
		this.reportFileName = reportFileName;
	}

	public String getReportFilePath() {
		return reportFilePath;
	}

	public void setReportFilePath(String reportFilePath) {
		this.reportFilePath = reportFilePath;
	}

}
