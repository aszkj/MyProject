package com.yldbkd.www.buyer.android.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class ProductOpenHelper extends SQLiteOpenHelper {

    public ProductOpenHelper(Context context) {
        super(context, ProductDetailKinds.DB_NAME, null, ProductDetailKinds.DB_VERSION_ADD_CLASSITY);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String sql = ProductDetailKinds.TABLE_BLACKLIST.TABLE_SQL;
        db.execSQL(sql);
        //品牌表
        String brandSql = ProductDetailKinds.TABLE_BRANDLIST.TABLE_SQL;
        db.execSQL(brandSql);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        switch (oldVersion) {
            case ProductDetailKinds.OLD_DB_VERSION:
                //插入一列actId
                if (newVersion == ProductDetailKinds.DB_VERSION) {
                    db.beginTransaction();
                    try {
                        upgradeDatabaseToVersion1(db);
                        db.setTransactionSuccessful();
                    } catch (Throwable ex) {
                        break;
                    } finally {
                        db.endTransaction();
                    }
                } else if (newVersion == ProductDetailKinds.DB_VERSION_ADD_CLASSITY) {
                    db.beginTransaction();
                    try {
                        upgradeDatabaseToVersion1(db);
                        addClassityTableToVersion2(db);
                        db.setTransactionSuccessful();
                    } catch (Throwable ex) {
                        break;
                    } finally {
                        db.endTransaction();
                    }
                }
                break;
            case ProductDetailKinds.DB_VERSION:
                if (newVersion == ProductDetailKinds.DB_VERSION_ADD_CLASSITY) {
                    db.beginTransaction();
                    try {
                        addClassityTableToVersion2(db);
                        db.setTransactionSuccessful();
                    } catch (Throwable ex) {
                        break;
                    } finally {
                        db.endTransaction();
                    }
                }
                break;
        }
    }

    /**
     * 数据库版本1升级
     * 增加活动Id  actId字段
     *
     * @param db
     */
    private void upgradeDatabaseToVersion1(SQLiteDatabase db) {
        db.execSQL("ALTER TABLE " + ProductDetailKinds.TABLE_BLACKLIST.TABLE_BALCKLIST + " ADD COLUMN "
                + ProductDetailKinds.TABLE_BLACKLIST.COLUMN_ACT_ID + " INTEGER");
    }

    /**
     * 数据库版本2升级
     * 增加分类品牌表
     *
     * @param db
     */
    private void addClassityTableToVersion2(SQLiteDatabase db) {
        //品牌表
        String brandSql = ProductDetailKinds.TABLE_BRANDLIST.TABLE_SQL;
        db.execSQL(brandSql);
    }
}
