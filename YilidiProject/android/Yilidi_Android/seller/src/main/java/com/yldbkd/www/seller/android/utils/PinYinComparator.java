package com.yldbkd.www.seller.android.utils;


import com.yldbkd.www.seller.android.bean.Brand;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/12/12 16:07
 * @des 品牌通过拼音排序
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes ${TODO}
 */
public class PinYinComparator implements Comparator<Brand> {
    private HanyuPinyinOutputFormat format;

    public PinYinComparator() {
        format = new HanyuPinyinOutputFormat();
        // UPPERCASE：大写  (ZHONG)
        // LOWERCASE：小写  (zhong)
        format.setCaseType(HanyuPinyinCaseType.UPPERCASE);
        // WITHOUT_TONE：无音标  (zhong)
        // WITH_TONE_NUMBER：1-4数字表示英标  (zhong4)
        // WITH_TONE_MARK：直接用音标符（必须WITH_U_UNICODE否则异常）  (zhòng)
        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        // WITH_V：用v表示ü  (nv)
        // WITH_U_AND_COLON：用"u:"表示ü  (nu:)
        // WITH_U_UNICODE：直接用ü (nü)
        format.setVCharType(HanyuPinyinVCharType.WITH_V);
    }

    //根据拼音字母进行比较
    public int compare(Brand o1, Brand o2) {
        if (o1.getPinYinName().equals("@")
                || o2.getPinYinName().equals("#")) {
            return -1;
        } else if (o1.getPinYinName().equals("#")
                || o2.getPinYinName().equals("@")) {
            return 1;
        } else {
            return o1.getPinYinName().compareTo(o2.getPinYinName());
        }
    }

    //品牌关联拼音字母
    public List<Brand> getResourceData(List<Brand> brands) {//关联拼音
        List<Brand> listarray = new ArrayList<>();
        for (int i = 0; i < brands.size(); i++) {
            String pinYin;
            Brand brand = new Brand();
            brand.setBrandCode(brands.get(i).getBrandCode());
            brand.setBrandImageUrl(brands.get(i).getBrandImageUrl());
            brand.setBrandName(brands.get(i).getBrandName());
            brand.setBrandLogoImageUrl(brands.get(i).getBrandLogoImageUrl());
            brand.setBrandDesc(brands.get(i).getBrandDesc());
            try {
                pinYin = PinyinHelper.toHanyuPinyinString(brands.get(i).getBrandName(), format, "");
                pinYin = pinYin.length() >= 1 ? pinYin.substring(0, 1).toUpperCase() : "#";
                if (!pinYin.matches("[A-Z]*")) {
                    pinYin = "#";
                }
            } catch (BadHanyuPinyinOutputFormatCombination badHanyuPinyinOutputFormatCombination) {
                pinYin = "#";
            }
            brand.setPinYinName(pinYin);
            listarray.add(brand);
        }
        return listarray;
    }
}
