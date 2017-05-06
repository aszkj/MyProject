package com.yilidi.o2o.core.report;

import java.util.List;

import com.yilidi.o2o.core.exception.ReportException;

/**
 * 
 * @Description:TODO(导入报表接口)
 * @author: chenlian
 * @date: 2015-9-29 下午7:32:17
 * 
 */
/**
 * 导入报表接口
 * 
 * @author chenlian
 * @date: 2015-9-29 下午7:32:17
 * @param <T>
 *            自定义需传入的参数对象
 */
public interface IImportReport<T> {

    /**
     * 
     * 导入报表
     * 
     * @param reportPath
     *            需导入的报表存放的相对路径
     * @param objs
     *            自定义需传入的参数
     * @return List<String> 验证错误提示列表
     * @throws ReportException
     *             报表异常
     */
    public List<String> importExcel(String reportPath, T objs) throws ReportException;

}
