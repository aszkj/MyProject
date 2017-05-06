package com.yldbkd.www.buyer.android.utils;

import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.db.BrandDao;

import java.util.List;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/12/16 10:18
 * @des 保存品牌
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class OperationToSqlite {
    private static BrandDao brandDao = new BrandDao();
    private static Long cleanTime = 500000l;

    public static void saveBrandData(List<Brand> brands) {
        brandDao.insert(brands);
    }

    public static List<Brand> queryBrandData() {
        return brandDao.query();
    }

    public static void clean() {
        brandDao.cleanrTable();
    }

    public static boolean isClean() {
        return Math.abs(DateUtils.secondsBetweenNow(brandDao.queryCreateTime())) > cleanTime;
    }
}
