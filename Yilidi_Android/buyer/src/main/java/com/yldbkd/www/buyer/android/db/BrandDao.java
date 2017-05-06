package com.yldbkd.www.buyer.android.db;


import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.support.annotation.NonNull;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.utils.DateUtils;
import com.yldbkd.www.buyer.android.utils.Logger;

import java.util.ArrayList;
import java.util.List;


public class BrandDao {

    private ProductOpenHelper mHelper;

    public BrandDao() {
        mHelper = new ProductOpenHelper(BuyerApp.getInstance().getApplicationContext());
    }

    public long insert(List<Brand> brans) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BRANDLIST.TABLE_BRANDLIST;
        ContentValues values = null;
        long result = 0;
        for (Brand brand : brans) {
            values = getContentValues(brand);
            result = db.insert(table, null, values);
        }
        db.close();
        return result;
    }

    @NonNull
    private ContentValues getContentValues(Brand brand) {
        ContentValues values = new ContentValues();
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_CODE, brand.getBrandCode());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_IMAGE_URL, brand.getBrandImageUrl());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_brand_NAME, brand.getBrandName());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_LOGO_IMAGE_URL, brand.getBrandLogoImageUrl());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_DESC, brand.getBrandDesc());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_PINYIN_NAME, brand.getPinYinName());
        values.put(ProductDetailKinds.TABLE_BRANDLIST.COLUMN_CREATE_TIME, DateUtils.getCurrentTiem());
        return values;
    }

    /*
     * 查询所有
     */
    public List<Brand> query() {
        List<Brand> brands = new ArrayList<>();
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BRANDLIST.TABLE_BRANDLIST;
        String[] columns = new String[]{
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_CODE,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_IMAGE_URL,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_brand_NAME,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_LOGO_IMAGE_URL,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_BRAND_DESC,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_PINYIN_NAME,
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_CREATE_TIME,
        };
        Cursor cursor = db.query(table, columns, null, null, null, null, null);
        while (cursor.moveToNext()) {
            String brandCode = cursor.getString(0);
            String brandImageUrl = cursor.getString(1);
            String brandName = cursor.getString(2);
            String brandLogoImageUrl = cursor.getString(3);
            String brandDesc = cursor.getString(4);
            String pinYinName = cursor.getString(5);
            String createTime = cursor.getString(6);
            Logger.d("brandCode = " + brandCode + ";brandImageUrl =" + brandImageUrl + ";brandName = " + brandName +
                    ";brandLogoImageUrl" + brandLogoImageUrl + ";brandDesc = " + brandDesc + ";pinYinName = " + pinYinName + ";createTime = " + createTime);
            brands.add(new Brand(brandCode, brandImageUrl, brandName, brandLogoImageUrl, brandDesc, pinYinName));
        }
        cursor.close();
        db.close();
        return brands;
    }

    /*
     * 查询保存时间
     */
    public String queryCreateTime() {
        String createTime = "1970-01-01 00:00:00";
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BRANDLIST.TABLE_BRANDLIST;
        String[] columns = new String[]{
                ProductDetailKinds.TABLE_BRANDLIST.COLUMN_CREATE_TIME,
        };
        Cursor cursor = db.query(table, columns, null, null, null, null, null);
        if (cursor.moveToFirst()) {
            createTime = cursor.getString(0);
        }
        cursor.close();
        db.close();
        return createTime;
    }

    public void cleanrTable() {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BRANDLIST.TABLE_BRANDLIST;
        db.delete(table, null, null);
        db.close();
    }
}
