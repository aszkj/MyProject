package com.yilidi.o2o.core.utils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.model.ProbabilityItemModel;

/**
 * 概率工具类
 * 
 * @author: chenlian
 * @date: 2016年11月8日 上午10:57:55
 */
public final class ProbabilityUtils {

    private static Logger logger = Logger.getLogger(ProbabilityUtils.class);

    public static final String STR_ZERO = "0";

    private ProbabilityUtils() {
    }

    /**
     * 获取概率随机数字符串，当通过概率(精确到亿分之一)算出的一个随机数在该概率随机数字符串范围内，则表示命中，反之则未命中
     * 
     * @param probabilityList
     *            概率List，每个概率的单位为：%，概率总和不能超过100%
     * @return 概率随机数（以逗号相连）字符串List
     */
    public static List<String> getProbabilityNums(List<BigDecimal> probabilityList) {
        String msg = "";
        List<String> probabilityNums = new ArrayList<String>();
        if (ObjectUtils.isNullOrEmpty(probabilityList)) {
            msg = "参数：probabilityList不能为空！";
            logger.error(msg);
            throw new IllegalArgumentException(msg);
        }
        BigDecimal total = new BigDecimal(0);
        for (BigDecimal probability : probabilityList) {
            if (probability.compareTo(new BigDecimal(0)) == -1) {
                msg = "任何几率不能小于零！";
                logger.error(msg);
                throw new IllegalArgumentException(msg);
            }
            total = total.add(probability);
        }
        if (total.compareTo(new BigDecimal(100)) == 1) {
            msg = "所有几率总和不能超过100%！";
            logger.error(msg);
            throw new IllegalArgumentException(msg);
        }
        Random random = new Random();
        List<Integer> originalList = new ArrayList<Integer>();
        for (int i = 0; i < 100; i++) {
            originalList.add(i);
        }
        for (BigDecimal probability : probabilityList) {
            if (probability.compareTo(new BigDecimal(0)) == 0) {
                probabilityNums.add(null);
            }
            if (probability.compareTo(new BigDecimal(1)) == -1) {
                String strProbability = probability.toString();
                for (int i = 2; i < strProbability.length(); i++) {
                    String str1 = String.valueOf(strProbability.charAt(i));
                    if (!str1.equals(STR_ZERO)) {
                        if (i + 1 < strProbability.length()) {
                            String str2 = String.valueOf(strProbability.charAt(i + 1));
                            if (Integer.valueOf(str2).intValue() >= 5) {
                                int str3 = Integer.valueOf(str1).intValue() + 1;
                                if (str3 > 9) {
                                    if (i - 3 < 0) {
                                        probabilityNums.add(Integer.toString(random.nextInt(100)));
                                    } else {
                                        probabilityNums.add(Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(
                                                10, i - 2)).intValue())));
                                    }
                                } else {
                                    String probabilityNum = "";
                                    for (int j = 0; j < str3; j++) {
                                        if (j == str3 - 1) {
                                            probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(
                                                    10, i - 1)).intValue()));
                                        } else {
                                            probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(
                                                    10, i - 1)).intValue())) + ",";
                                        }
                                    }
                                    probabilityNums.add(probabilityNum);
                                }
                            } else {
                                String probabilityNum = "";
                                for (int j = 0; j < Integer.valueOf(str1).intValue(); j++) {
                                    if (j == Integer.valueOf(str1).intValue() - 1) {
                                        probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(10,
                                                i - 1)).intValue()));
                                    } else {
                                        probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(10,
                                                i - 1)).intValue())) + ",";
                                    }
                                }
                                probabilityNums.add(probabilityNum);
                            }
                        } else {
                            String probabilityNum = "";
                            for (int j = 0; j < Integer.valueOf(str1).intValue(); j++) {
                                if (j == Integer.valueOf(str1).intValue() - 1) {
                                    probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(10,
                                            i - 1)).intValue()));
                                } else {
                                    probabilityNum += Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(10,
                                            i - 1)).intValue())) + ",";
                                }
                            }
                            probabilityNums.add(probabilityNum);
                        }
                        break;
                    }
                }
            }
            if (probability.compareTo(new BigDecimal(1)) == 0 || probability.compareTo(new BigDecimal(1)) == 1) {
                Set<Integer> proNumSet = new TreeSet<Integer>();
                for (int i = 0; i < probability.setScale(0, BigDecimal.ROUND_HALF_UP).intValue(); i++) {
                    if (originalList.size() > 0) {
                        int index = random.nextInt(originalList.size());
                        int num = originalList.get(index);
                        proNumSet.add(num);
                        originalList.remove(new Integer(num));
                    }
                }
                String probabilityNum = "";
                Iterator<Integer> iterator = proNumSet.iterator();
                int i = 0;
                while (iterator.hasNext()) {
                    if (i == proNumSet.size() - 1) {
                        probabilityNum += iterator.next();
                    } else {
                        probabilityNum += iterator.next() + ",";
                    }
                    i++;
                }
                probabilityNums.add(probabilityNum);
            }
        }
        return probabilityNums;
    }

    public static ProbabilityItemModel hit(List<ProbabilityItemModel> items) {
        String msg = "";
        Random random = new Random();
        ProbabilityItemModel probabilityItemModel = null;
        if (ObjectUtils.isNullOrEmpty(items)) {
            msg = "参数：items不能为空！";
            logger.error(msg);
            throw new IllegalArgumentException(msg);
        }
        BigDecimal total = new BigDecimal(0);
        for (ProbabilityItemModel item : items) {
            if (item.getProbability().compareTo(new BigDecimal(0)) == -1) {
                msg = "任何几率不能小于零！";
                logger.error(msg);
                throw new IllegalArgumentException(msg);
            }
            total = total.add(item.getProbability());
        }
        if (total.compareTo(new BigDecimal(100)) == 1) {
            msg = "所有几率总和不能超过100%！";
            logger.error(msg);
            throw new IllegalArgumentException(msg);
        }
        List<ProbabilityItemModel> list1 = new ArrayList<ProbabilityItemModel>();
        List<ProbabilityItemModel> list2 = new ArrayList<ProbabilityItemModel>();
        for (ProbabilityItemModel item : items) {
            if (item.getProbability().compareTo(new BigDecimal(1)) == -1) {
                list1.add(item);
            } else {
                list2.add(item);
            }
        }
        if (!list2.isEmpty()) {
            String randomStr = Integer.toString(random.nextInt(100));
            for (ProbabilityItemModel item : list2) {
                String probabilityRandomNum = item.getProbabilityRandomNum();
                List<String> probabilityNums = new ArrayList<String>();
                if (!StringUtils.isEmpty(probabilityRandomNum)
                        && probabilityRandomNum.contains(CommonConstants.DELIMITER_COMMA)) {
                    StringTokenizer st = new StringTokenizer(probabilityRandomNum, CommonConstants.DELIMITER_COMMA);
                    while (st.hasMoreTokens()) {
                        probabilityNums.add(st.nextToken());
                    }
                } else {
                    probabilityNums.add(probabilityRandomNum);
                }
                if (probabilityNums.contains(randomStr)) {
                    probabilityItemModel = item;
                    break;
                }
            }
            if (!ObjectUtils.isNullOrEmpty(probabilityItemModel)) {
                return probabilityItemModel;
            }
        }
        if (!list1.isEmpty()) {
            for (ProbabilityItemModel item : list1) {
                BigDecimal probability = item.getProbability();
                if (probability.compareTo(new BigDecimal(0)) == 0) {
                    continue;
                } else {
                    String strProbability = probability.toString();
                    String probabilityRandomNum = item.getProbabilityRandomNum();
                    List<String> probabilityNums = new ArrayList<String>();
                    if (!StringUtils.isEmpty(probabilityRandomNum)
                            && probabilityRandomNum.contains(CommonConstants.DELIMITER_COMMA)) {
                        StringTokenizer st = new StringTokenizer(probabilityRandomNum, CommonConstants.DELIMITER_COMMA);
                        while (st.hasMoreTokens()) {
                            probabilityNums.add(st.nextToken());
                        }
                    } else {
                        probabilityNums.add(probabilityRandomNum);
                    }
                    for (int i = 2; i < strProbability.length(); i++) {
                        String str1 = String.valueOf(strProbability.charAt(i));
                        if (!str1.equals(STR_ZERO)) {
                            if (i + 1 < strProbability.length()) {
                                String str2 = String.valueOf(strProbability.charAt(i + 1));
                                if (Integer.valueOf(str2).intValue() >= 5) {
                                    int str3 = Integer.valueOf(str1).intValue() + 1;
                                    if (str3 > 9) {
                                        if (i - 3 < 0) {
                                            if (probabilityNums.contains(Integer.toString(random.nextInt(100)))) {
                                                probabilityItemModel = item;
                                            }
                                        } else {
                                            if (probabilityNums.contains(Integer.toString(random.nextInt(new BigDecimal(
                                                    100 * Math.pow(10, i - 2)).intValue())))) {
                                                probabilityItemModel = item;
                                            }
                                        }
                                    } else {
                                        if (probabilityNums.contains(Integer.toString(random.nextInt(new BigDecimal(
                                                100 * Math.pow(10, i - 1)).intValue())))) {
                                            probabilityItemModel = item;
                                        }
                                    }
                                } else {
                                    if (probabilityNums.contains(Integer.toString(random.nextInt(new BigDecimal(100 * Math
                                            .pow(10, i - 1)).intValue())))) {
                                        probabilityItemModel = item;
                                    }
                                }
                            } else {
                                if (probabilityNums.contains(Integer.toString(random.nextInt(new BigDecimal(100 * Math.pow(
                                        10, i - 1)).intValue())))) {
                                    probabilityItemModel = item;
                                }
                            }
                            break;
                        }
                    }
                }
            }
        }
        return probabilityItemModel;
    }

}
