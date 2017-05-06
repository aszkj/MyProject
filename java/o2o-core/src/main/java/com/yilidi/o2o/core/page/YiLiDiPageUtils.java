package com.yilidi.o2o.core.page;

import java.util.List;

import org.apache.log4j.Logger;

import com.github.pagehelper.Page;
import com.github.pagehelper.SqlUtil;
import com.yilidi.o2o.core.model.BaseDto;
import com.yilidi.o2o.core.model.BaseVO;

/**
 * 
 * @Description:TODO(封装分页返回信息工具类，将返回来的Page分页对象封装为YiLiDiPage对象)
 * @author: chenlian
 * @date: 2015年11月11日 下午4:39:08
 * 
 */
public class YiLiDiPageUtils {

    private static Logger logger = Logger.getLogger(YiLiDiPageUtils.class);

    /**
     * @Description TODO(封装分页返回信息)
     * @param result
     * @return YiLiDiPage<T>
     */
    public static <T extends BaseDto> YiLiDiPage<T> encapsulatePageResult(Page<T> result) {
        YiLiDiPage<T> yiLiDiPage = null;
        try {
            if (null != result) {
                yiLiDiPage = new YiLiDiPage<T>();
                yiLiDiPage.setResultList(result.getResult());
                yiLiDiPage.setCurrentPage(result.getPageNum());
                yiLiDiPage.setPageSize(result.getPageSize());
                yiLiDiPage.setRecordCount(result.getTotal());
                yiLiDiPage.setPageCount(result.getPages());
            }
            return yiLiDiPage;
        } catch (Exception e) {
            logger.error("封装分页返回信息出现系统异常", e);
            throw new IllegalStateException("封装分页返回信息出现系统异常");
        } finally {
            SqlUtil.setLocalPage(null);
        }
    }

    /**
     * @Description TODO(封装APP分页返回信息)
     * @param yiLiDiPage
     * @param resultVOList
     * @return YiLiDiAppPage
     */
    public static <E extends BaseVO> YiLiDiAppPage<E> encapsulatePageResultForApp(YiLiDiPage<?> yiLiDiPage,
            List<E> resultVOList) {
        YiLiDiAppPage<E> yiLiDiAppPage = null;
        try {
            if (null != yiLiDiPage) {
                yiLiDiAppPage = new YiLiDiAppPage<E>();
                yiLiDiAppPage.setList(resultVOList);
                yiLiDiAppPage.setPageNum(yiLiDiPage.getCurrentPage());
                yiLiDiAppPage.setPageSize(yiLiDiPage.getPageSize());
                yiLiDiAppPage.setTotalRecords(yiLiDiPage.getRecordCount());
                yiLiDiAppPage.setTotalPages(yiLiDiPage.getPageCount());
            }
            return yiLiDiAppPage;
        } catch (Exception e) {
            logger.error("封装分页返回信息出现系统异常", e);
            throw new IllegalStateException("封装分页返回信息出现系统异常");
        }
    }

}
