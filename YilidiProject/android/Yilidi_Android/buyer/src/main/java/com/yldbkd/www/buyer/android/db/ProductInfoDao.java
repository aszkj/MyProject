package com.yldbkd.www.buyer.android.db;


import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.support.annotation.NonNull;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Logger;

import java.util.ArrayList;
import java.util.List;


public class ProductInfoDao {

    private ProductOpenHelper mHelper;

    public ProductInfoDao() {
        mHelper = new ProductOpenHelper(BuyerApp.getInstance().getApplicationContext());
    }

    public long insert(SaleProduct saleProduct, int cartNum) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;

        ContentValues values = getContentValues(saleProduct, cartNum);
        long result = db.insert(table, null, values);
        Logger.d("数据插入成功" + result);

        db.close();
        return result;
    }

    public long insert(List<SaleProduct> saleProducts) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        ContentValues values = null;
        long result = 0;
        for (SaleProduct saleProduct : saleProducts) {
            values = getContentValues(saleProduct, saleProduct.getCartNum());
            result = db.insert(table, null, values);
        }

        db.close();
        return result;
    }

    @NonNull
    private ContentValues getContentValues(SaleProduct saleProduct, int cartNum) {
        ContentValues values = new ContentValues();
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID, saleProduct.getSaleProductId());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_BRAND_NAME, saleProduct.getBrandName());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_NAME, saleProduct.getSaleProductName());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_IMAGE, saleProduct.getSaleProductImageUrl());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_RETAIL_PRICE, saleProduct.getRetailPrice());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_PROMOTIONAL_PRICE, saleProduct.getPromotionalPrice());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ORDER_PRICE, saleProduct.getOrderPrice());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_STOCK_NUM, saleProduct.getStockNum());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_CART_NUM, cartNum);
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_PRODUCT_SPEC, saleProduct.getSaleProductSpec());
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_ACT_ID, saleProduct.getActId());
        return values;
    }

    public int delete(int productId) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String whereClause = ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID + "= ?";
        int result = db.delete(table, whereClause, new String[]{String.valueOf(productId)});

        db.close();
        return result;
    }

    public int delete(List<Integer> productIds) {
        int result = -1;
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String whereClause = ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID + "= ?";
        for (Integer prductId : productIds) {
            result = db.delete(table, whereClause, new String[]{String.valueOf(prductId)});
        }

        db.close();
        return result;
    }

    public int update(String mId, int num) {

        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String whereClause = ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID + "= ?";
        ContentValues values = new ContentValues();
        values.put(ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_CART_NUM, num);
        int result = db.update(table, values, whereClause, new String[]{mId});

        db.close();
        return result;
    }

    public int update(SaleProduct saleProduct, int cartNum) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String whereClause = ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID + "= ?";
        ContentValues values = getContentValues(saleProduct, cartNum);
        int result = db.update(table, values, whereClause, new String[]{String.valueOf(saleProduct.getSaleProductId())});
        Logger.d("数据修改成功" + result);

        db.close();
        return result;
    }

    /*
     * 查询所有
     */
    public List<SaleProduct> query() {
        List<SaleProduct> shoppingLists = new ArrayList<SaleProduct>();
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String[] columns = new String[]{
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_CART_NUM,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_NAME,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ORDER_PRICE,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_PROMOTIONAL_PRICE,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_RETAIL_PRICE,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_ACT_ID,
        };
        Cursor cursor = db.query(table, columns, null, null, null, null, null);
        while (cursor.moveToNext()) {
            int productId = cursor.getInt(0);
            int cartNum = cursor.getInt(1);
            String productName = cursor.getString(2);
            Long orderPrice = cursor.getLong(3);
            Long promotionalPrice = cursor.getLong(4);
            Long retailPrice = cursor.getLong(5);
            int actId = cursor.getInt(6);

            Logger.d("productId = " + productId + ";cartNum =" + cartNum + ";productName = " + productName +
                    ";orderPrice" + orderPrice + ";promotionalPrice = " + promotionalPrice + ";retailPrice = " + retailPrice + ";actId = " + actId);
            shoppingLists.add(new SaleProduct(productId, cartNum, productName, orderPrice, promotionalPrice, retailPrice, actId));
        }

        cursor.close();
        db.close();
        return shoppingLists;
    }

    /*
     * 查询根据产品类型查询
     */
    public int queryType(Integer productType) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String[] columns = new String[]{
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_CART_NUM,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_NAME,
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ORDER_PRICE,
        };
        Cursor cursor = db.query(table, columns, ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_CART_NUM + " > 0 ", null, null, null, null);
        int count = cursor.getCount();

        cursor.close();
        db.close();
        return count;
    }

    public int query(int productId) {
        int num = -1;
        List<SaleProduct> infos = new ArrayList<SaleProduct>();
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        String[] columns = new String[]{
                ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_STOCK_NUM,
        };

        Cursor cursor = db.query(table, columns, ProductDetailKinds.TABLE_BLACKLIST.COLUMN_PRODUCT_ID + "= ?",
                new String[]{String.valueOf(productId)}, null, null, null);
        if (cursor.moveToNext()) {
            num = cursor.getInt(0);
        }

        cursor.close();
        db.close();
        return num;
    }

    public void saveDataToSqlite(SaleProduct product) {
        saveDataToSqlite(product, product.getCartNum());
    }

    public void saveDataToSqlite(SaleProduct product, int cartNum) {
        //加入数据库
        if (query(product.getSaleProductId()) > 0) {
            if (cartNum > 0) {//修改数量
                update(product, cartNum);
            } else {//商品被移除
                delete(product.getSaleProductId());
            }
        } else {
            insert(product, cartNum);
        }
    }

    public void cleanrTable() {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        String table = ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST;
        db.delete(table, null, null);
        db.close();
    }

}
