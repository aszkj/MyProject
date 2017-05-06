package com.yldbkd.www.buyer.android.db;

public interface ProductDetailKinds {

    /**
     * 数据库名称
     */
    String DB_NAME = "product.db";

    /**
     * 数据库的版本号
     */
    int OLD_DB_VERSION = 1;
    int DB_VERSION = 2;//增加活动ActId列
    int DB_VERSION_ADD_CLASSITY = 3;//增加分类和品牌表

    //商品表
    public interface TABLE_BLACKLIST {
        /**
         * saleProductId  商品id
         * COLUMN_BRAND_NAME  品牌名称
         * COLUMN_PRODUCT_NAME  商品名称
         * COLUMN_PRODUCT_IMAGE  商品图片url
         * COLUMN_PRODUCT_RETAIL_PRICE  零售价
         * COLUMN_PRODUCT_PROMOTIONAL_PRICE  促销价
         * COLUMN_PRODUCT_STOCK_NUM  库存
         * COLUMN_PRODUCT_CART_NUM  购物车数量
         * COLUMN_PRODUCT_PRODUCT_SPEC  规格
         * COLUMN_ACT_ID  活动场次
         */

        String TABLE_BALCKLIST = "product_list";

        String COLUMN_PRODUCT_ID = "saleProductId";
        String COLUMN_BRAND_NAME = "brandName";
        String COLUMN_PRODUCT_NAME = "saleProductName";
        String COLUMN_PRODUCT_IMAGE = "saleProductImageUrl";
        String COLUMN_PRODUCT_RETAIL_PRICE = "retailPrice";
        String COLUMN_PRODUCT_PROMOTIONAL_PRICE = "promotionalPrice";
        String COLUMN_PRODUCT_ORDER_PRICE = "orderPrice";
        String COLUMN_PRODUCT_STOCK_NUM = "stockNum";
        String COLUMN_PRODUCT_CART_NUM = "cartNum";
        String COLUMN_PRODUCT_PRODUCT_SPEC = "saleProductSpec";
        String COLUMN_ACT_ID = "actId";


        String TABLE_SQL = "CREATE TABLE " + TABLE_BALCKLIST +
                " ( " + COLUMN_PRODUCT_ID + " INTEGER UNIQUE ," +
                COLUMN_BRAND_NAME + " VARCHAR  ," +
                COLUMN_PRODUCT_NAME + " VARCHAR  ," +
                COLUMN_PRODUCT_IMAGE + " VARCHAR  ," +
                COLUMN_PRODUCT_RETAIL_PRICE + " LONG  ," +
                COLUMN_PRODUCT_PROMOTIONAL_PRICE + " LONG  ," +
                COLUMN_PRODUCT_ORDER_PRICE + " LONG  ," +
                COLUMN_PRODUCT_STOCK_NUM + " INTEGER  ," +
                COLUMN_PRODUCT_CART_NUM + " INTEGER  ," +
                COLUMN_PRODUCT_PRODUCT_SPEC + " VARCHAR ," +
                COLUMN_ACT_ID + " INTEGER )";
    }
    //品牌表
    public interface TABLE_BRANDLIST {
        /**
         * brandCode  品牌编码
         * brandImageUrl  品牌图片URL
         * brandName  商品名称
         * brandLogoImageUrl  品牌LOGO图片URL
         * brandDesc  品牌描述
         * pinYinName  品牌首字母对应拼音
         */

        String TABLE_BRANDLIST = "brand_list";

        String COLUMN_BRAND_CODE = "brandCode";
        String COLUMN_BRAND_IMAGE_URL = "brandImageUrl";
        String COLUMN_brand_NAME = "brandName";
        String COLUMN_BRAND_LOGO_IMAGE_URL = "brandLogoImageUrl";
        String COLUMN_BRAND_DESC = "brandDesc";
        String COLUMN_PINYIN_NAME = "pinYinName";
        String COLUMN_CREATE_TIME = "createTime";

        String TABLE_SQL = "CREATE TABLE " + TABLE_BRANDLIST +
                " ( " + COLUMN_BRAND_CODE + " VARCHAR ," +
                COLUMN_BRAND_IMAGE_URL + " VARCHAR  ," +
                COLUMN_brand_NAME + " VARCHAR  ," +
                COLUMN_BRAND_LOGO_IMAGE_URL + " VARCHAR  ," +
                COLUMN_BRAND_DESC + " VARCHAR  ," +
                COLUMN_PINYIN_NAME + " VARCHAR  ," +
                COLUMN_CREATE_TIME + " VARCHAR )";
    }
}
