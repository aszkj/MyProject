package com.yilidi.o2o.core.connect.wechat.utils;

import org.apache.log4j.Logger;

/**
 * 异常重试工具类
 * 
 */
public class RetryUtils {
    private static Logger logger = Logger.getLogger(RetryUtils.class);

    /**
     * 回调结果检查
     */
    public interface ResultCheck {
        boolean matching();

        String getJson();
    }

    /**
     * 在遇到异常时尝试重试
     * 
     * @param retryLimit
     *            重试次数
     * @param retryCallable
     *            重试回调
     * @return V
     */
    public static <V extends ResultCheck> V retryOnException(int retryLimit,
            java.util.concurrent.Callable<V> retryCallable) {

        V v = null;
        for (int i = 0; i < retryLimit; i++) {
            try {
                v = retryCallable.call();
            } catch (Exception e) {
                logger.warn("retry on " + (i + 1) + " times v = " + (v == null ? null : v.getJson()), e);
            }
            if (v.matching())
                break;
            logger.error("retry on " + (i + 1) + " times but not matching v = " + (v == null ? null : v.getJson()));
        }
        return v;
    }

    /**
     * 在遇到异常时尝试重试
     * 
     * @param retryLimit
     *            重试次数
     * @param sleepMillis
     *            每次重试之后休眠的时间
     * @param retryCallable
     *            重试回调
     * @return V
     * @throws java.lang.InterruptedException
     */
    public static <V extends ResultCheck> V retryOnException(int retryLimit, long sleepMillis,
            java.util.concurrent.Callable<V> retryCallable) throws java.lang.InterruptedException {

        V v = null;
        for (int i = 0; i < retryLimit; i++) {
            try {
                v = retryCallable.call();
            } catch (Exception e) {
                logger.warn("retry on " + (i + 1) + " times v = " + (v == null ? null : v.getJson()), e);
            }
            if (v.matching())
                break;
            logger.error("retry on " + (i + 1) + " times but not matching v = " + (v == null ? null : v.getJson()));
        }
        return v;
    }

}
