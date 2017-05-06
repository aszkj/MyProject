package com.yldbkd.www.buyer.android.utils;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Message;
import android.preference.PreferenceManager;
import android.text.TextUtils;
import android.view.View;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.CartInfo;
import com.yldbkd.www.buyer.android.bean.OrderCouponInfo;
import com.yldbkd.www.buyer.android.bean.ProductBase;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.SecKillProduct;
import com.yldbkd.www.buyer.android.db.ProductInfoDao;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.PreferenceUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 购物车工具类
 * <p/>
 * Created by linghuxj on 15/10/19.
 */
public class CartUtils {

    private static final int PLUS_CART = 1, MINUS_CART = 0;

    private static Gson gson = new Gson();

    private static CommonDialog vipAddDialog;

    private static ProductInfoDao productDao = new ProductInfoDao();

    private static HttpBack<BaseModel> cartHttpBack = new HttpBack<BaseModel>() {
        @Override
        public void onSuccess(BaseModel baseModel) {
        }

        @Override
        public void onFailure(String msg) {
        }

        @Override
        public void onTimeOut() {
        }
    };

    /**
     * 加入购物车之前进行数据校验，判断库存，限购以及商品类型冲突
     *
     * @param context 上下文
     * @param product 商品信息
     * @param handler 发送加入操作购物车的handler
     * @param obj     点击所需动画的开始xy坐标系等相关数据
     */
    public static void validateOperationCart(Context context, final SaleProduct product, final Handler handler, Object obj) {
        validateOperationCart(context, product, handler, obj, 0);
    }

    public static void validateOperationCart(Context context, SecKillProduct secKillProduct, final Handler handler, Object obj) {
        validateOperationCart(context, secKillProduct, handler, obj, 0);
    }

    public static void validateOperationCart(Context context, SecKillProduct secKillProduct, final Handler handler, Object obj, int arg2) {
        if (secKillProduct == null) {
            return;
        }
        SaleProduct saleProduct = getSaleProduct(secKillProduct);
        validateOperationCart(context, saleProduct, handler, obj, arg2);
    }

    public static void validateOperationCart(Context context, final SaleProduct product, final Handler handler, Object obj, int arg2) {
        // 新建消息传递到所需的数据类中去
        final Message message = new Message();
        message.obj = obj;
        message.arg2 = arg2;

        message.what = Constants.HandlerCode.CART_SUCCESS;
        Integer productId = product.getSaleProductId();
        Integer stockNum = product.getStockNum();
        Integer actId = product.getActId();
        //Integer limitCount = null;
        // 存在库存数量限制
        Map<Integer, CartInfo> map = getCartMap();
        Integer cartNum = map.get(productId) == null ? null : map.get(productId).getCartNum();
        Integer cartActId = map.get(productId) == null ? null : map.get(productId).getActId();
        if (stockNum != null) {
            if ((cartNum == null && stockNum == 0) || (cartNum != null && cartNum >= stockNum && isSameActId(cartActId, actId))) {
                ToastUtils.show(context, R.string.product_has_enough_stock);
                return;
            }
        }
        //        if (limitCount != null && limitCount >= 0) {
        //            if ((cartNum == null && limitCount == 0) || (cartNum != null && cartNum >= limitCount)) {
        //                ToastUtils.show(context, String.format(context.getString(R.string.product_has_limit_count),
        //                        limitCount));
        //                return;
        //            }
        //        }
        // 1分钱专区商品有数量限制，只能购买1个
        List<Integer> fenIds = ZoneUtils.getZone1FenIds();
        if (fenIds != null) {
            for (Integer fenId : fenIds) {
                if (product.getSaleProductId().intValue() != fenId) {
                    continue;
                }
                Integer count = map.get(fenId) == null ? null : map.get(fenId).getCartNum();
                if (count != null && count > 0) {
                    ToastUtils.show(context, String.format(context.getString(R.string.product_has_limit_count),
                            String.valueOf(1)));
                    return;
                }
            }
        }

        // 版本需求：存在VIP商品将无法与其他商品共存在购物车
        List<Integer> vipIds = ZoneUtils.getZoneVipIds();
        boolean isVip = false;
        boolean hasVip = false;
        if (vipIds != null && getCartCount() > 0) {
            for (Integer id : vipIds) {
                if (!isVip && productId.intValue() == id)
                    isVip = true;
                if (!hasVip && map.get(id) != null)
                    hasVip = true;
            }
        }
        if (isVip != hasVip) {
            vipAddDialog = new CommonDialog(context, new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    vipAddDialog.dismiss();
                    clearCart();
                    if (addCart(product)) {
                        handler.sendEmptyMessage(Constants.HandlerCode.CLEANPRODUCTFORVIP);
                        handler.sendMessage(message);
                    }
                }
            });
            vipAddDialog.setData(context.getResources().getString(R.string.home_dialog_upgrade),
                    context.getResources().getString(R.string.home_dialog_store_confirm));
            vipAddDialog.show();
            return;
        }
        if (Constants.StoreStatus.PAUSE.equals(CommunityUtils.getCurrentStoreStatus())) {
            ToastUtils.show(context, context.getString(R.string.store_status_pause));
            return;
        }
        if (addCart(product)) {
            handler.sendMessage(message);
        }
    }

    /**
     * 增加购物车商品数量1
     *
     * @param product
     * @return
     */
    public static boolean addCart(SaleProduct product) {
        Map<Integer, CartInfo> map = new HashMap<>();
        Integer productId = product.getSaleProductId();
        Integer actId = product.getActId();
        map.put(productId, getCartInfoBean(1, product.getActId()));
        if (UserUtils.isLogin()) {
            requestCart(productId, actId, PLUS_CART);
        }
        productDao.saveDataToSqlite(product, product.getCartNum() + 1);
        return addCartMap(map);
    }

    /**
     * 减少购物车商品数量1
     *
     * @param product
     * @return
     */
    public static boolean removeCart(SaleProduct product) {
        Map<Integer, CartInfo> map = new HashMap<>();
        Integer productId = product.getSaleProductId();
        Integer actId = product.getActId();
        map.put(productId, getCartInfoBean(-1, product.getActId()));
        if (UserUtils.isLogin()) {
            requestCart(productId, actId, MINUS_CART);
        }
        productDao.saveDataToSqlite(product);
        return addCartMap(map);
    }

    /**
     * 根据商品ID清除购物车数据
     *
     * @param productIds
     * @return
     */
    public static void removeCartProducts(List<Integer> productIds) {
        if (productIds == null) {
            return;
        }
        Map<Integer, CartInfo> cartMap = getCartMap();
        for (Integer productId : productIds) {
            cartMap.remove(productId);
        }
        if (UserUtils.isLogin()) {
            clearCart(productIds);
        }
        saveCartMap(cartMap);
        productDao.delete(productIds);
    }

    public static void removeCartProducts(Integer productId) {
        if (productId == null) {
            return;
        }
        List<Integer> list = new ArrayList<>();
        list.add(productId);
        removeCartProducts(list);
    }

    /**
     * 操作商品数量Map信息到购物车Map中，并保存
     *
     * @param map
     * @return
     */
    private static boolean addCartMap(Map<Integer, CartInfo> map) {
        Map<Integer, CartInfo> carts = getCartMap();
        if (carts == null) {
            carts = new HashMap<>();
        }
        List<Integer> removeIds = new ArrayList<>();
        for (Map.Entry<Integer, CartInfo> entry : map.entrySet()) {
            CartInfo cartInfo = carts.get(entry.getKey());
            CartInfo tempCartInfo = entry.getValue();
            Integer actId;
            Integer tempActId;
            Integer cartNum;

            if (cartInfo == null) {
                if (tempCartInfo != null && tempCartInfo.getCartNum() > 0) {
                    carts.put(entry.getKey(), entry.getValue());
                }
            } else {
                actId = cartInfo.getActId();
                tempActId = tempCartInfo.getActId();
                cartNum = cartInfo.getCartNum() == null ? 0 : cartInfo.getCartNum();
                if ((actId == null && tempActId == null) ||
                        (actId != null && tempActId != null && actId.intValue() == tempActId.intValue())) {
                    cartNum += tempCartInfo.getCartNum();
                } else {
                    cartNum = tempCartInfo.getCartNum();
                }
                cartInfo.setActId(tempCartInfo.getActId());
                cartInfo.setCartNum(cartNum);
                if (cartNum <= 0) {
                    removeIds.add(entry.getKey());
                    continue;
                }
                carts.put(entry.getKey(), cartInfo);
            }
        }
        for (Integer proId : removeIds) {
            carts.remove(proId);
        }
        saveCartMap(carts);
        return true;
    }

    /**
     * 获取当前购物车总数量
     *
     * @return
     */
    public static Integer getCartCount() {
        return getCartCount(getCartMap());
    }

    public static Integer getCartCount(Map<Integer, CartInfo> map) {
        Integer count = 0;
        if (map == null) {
            return 0;
        }
        for (Map.Entry<Integer, CartInfo> entry : map.entrySet()) {
            count += entry.getValue().getCartNum();
        }
        return count;
    }

    /**
     * 获取购物车信息数据列表
     *
     * @return
     */
    public static List<CartInfo> getCartInfo() {
        return getCartInfo(getCartMap());
    }

    /**
     * 根据Map信息获取购物车数据列表
     *
     * @param map
     * @return
     */
    public static List<CartInfo> getCartInfo(Map<Integer, CartInfo> map) {
        List<CartInfo> cartInfos = null;
        for (Map.Entry<Integer, CartInfo> entry : map.entrySet()) {
            if (cartInfos == null) {
                cartInfos = new ArrayList<>();
            }
            CartInfo cartInfo = new CartInfo();
            cartInfo.setSaleProductId(entry.getKey());
            cartInfo.setCartNum(entry.getValue().getCartNum());
            cartInfo.setActId(entry.getValue().getActId());
            cartInfos.add(cartInfo);
        }
        return cartInfos;
    }

    /**
     * 保存购物车信息
     *
     * @param cartInfoList
     * @return
     */
    public static void setCartInfo(List<SaleProduct> cartInfoList) {
        if (cartInfoList == null) {
            saveCartMap(null);
            return;
        }
        Map<Integer, CartInfo> map = new HashMap<>();
        for (SaleProduct cartInfo : cartInfoList) {
            map.put(cartInfo.getSaleProductId(), getCartInfoBean(cartInfo.getCartNum(), cartInfo.getActId()));
        }
        productDao.cleanrTable();
        productDao.insert(cartInfoList);
        saveCartMap(map);
    }

    public static void calculateProductNum(List<? extends ProductBase> saleProducts) {
        if (saleProducts == null) {
            return;
        }
        for (ProductBase product : saleProducts) {
            calculateProductNum(product);
        }
    }

    public static void calculateProductNum(ProductBase saleProduct) {
        if (saleProduct == null) {
            return;
        }
        Map<Integer, CartInfo> cartMap = getCartMap();
        CartInfo cartInfo = cartMap.get(saleProduct.getSaleProductId());
        saleProduct.setCartNum(getLocationCartNum(cartInfo, saleProduct));
    }

    private static void requestCart(Integer productId, Integer actId, int type) {
        Map<String, Object> map = new HashMap<>();
        map.put("saleProductId", productId);
        map.put("actId", actId);
        map.put("type", type);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().modifyCart(ParamUtils.getParam(map), cartHttpBack);
    }

    private static void clearCart(List<Integer> productIds) {
        Map<String, Object> map = new HashMap<>();
        map.put("products", productIds);
        RetrofitUtils.getInstance().clearCartProduct(ParamUtils.getParam(map), cartHttpBack);
    }

    public static Map<Integer, CartInfo> getCartMap() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.cartMap == null || app.cartMap.size() == 0) {
            String cartInfo = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.Cart.CART_INFO, "");
            if (TextUtils.isEmpty(cartInfo)) {
                app.cartMap = new HashMap<>();
            } else {
                Type type = new TypeToken<Map<Integer, CartInfo>>() {
                }.getType();
                app.cartMap = gson.fromJson(cartInfo, type);
            }
        }
        return app.cartMap;
    }

    private static void saveCartMap(Map<Integer, CartInfo> carts) {
        BuyerApp app = BuyerApp.getInstance();
        app.cartMap = carts;
        String cartInfo = gson.toJson(carts);
        PreferenceUtils.setStringPref(app.getApplicationContext(), PreferenceName.Cart.CART_INFO, cartInfo);
    }

    public static void clearCart() {
        BuyerApp app = BuyerApp.getInstance();
        app.cartMap = null;
        PreferenceUtils.removePref(app.getApplicationContext(), PreferenceName.Cart.CART_INFO);
    }

    public static void clearCartDao() {
        productDao.cleanrTable();
    }

    /**
     * 保存用户同步购物车信息
     *
     * @param synchronizeFlag 同步状态
     */
    public static void synchronizeCartFlag(boolean synchronizeFlag) {
        BuyerApp app = BuyerApp.getInstance();
        app.synchronizeCartFlag = synchronizeFlag;
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        editor.putBoolean(PreferenceName.Cart.IS_SYNCHRONIZE, synchronizeFlag);
        editor.apply();
    }

    /**
     * 获取同步购物车状态
     */
    public static boolean getSynchronizeCartFlag() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.synchronizeCartFlag == null) {
            app.synchronizeCartFlag = PreferenceUtils.getBooleanPref(app.getApplicationContext(),
                    PreferenceName.Cart.IS_SYNCHRONIZE, false);
        }
        return app.synchronizeCartFlag;
    }

    /**
     * 获取购物车商品总价格
     */
    public static Long getCartTotalPrice() {
        Long totalPrice = 0L;
        if (getCartCount() == 0) {
            return 0L;
        }
        Map<Integer, CartInfo> cartMap = getCartMap();
        List<SaleProduct> query = productDao.query();
        for (SaleProduct product : query) {
            Integer count = cartMap.get(product.getSaleProductId()) == null ? null : cartMap.get(product.getSaleProductId()).getCartNum();
            if (count != null) {
                totalPrice += product.getOrderPrice() * count;
            }
        }
        return totalPrice;
    }

    /**
     * 商品商品状态 0 --正常  1--下架  2--已经购买
     */
    public static int checkedProductType(SaleProduct saleProduct) {
        if (saleProduct == null) {
            return Constants.CartProductStatus.NORMAL;
        }
        boolean isAct = saleProduct.getActId() != null && saleProduct.getActId() > 0;
        if (saleProduct.getProductStatus() == Constants.ProductStatus.OFF_LINE
                || saleProduct.getProductStatus() == Constants.ProductStatus.DELETE) {
            return Constants.CartProductStatus.SHADOW;
        } else if (saleProduct.getLimitCount() == 0) {
            return isAct ? Constants.CartProductStatus.SECKILL : Constants.CartProductStatus.BOUGHT;
        } else if (saleProduct.getStockNum() == 0) {
            return isAct ? Constants.CartProductStatus.SECKILL : Constants.CartProductStatus.STOCK;
        }

        return Constants.CartProductStatus.NORMAL;
    }

    public static CartInfo getCartInfoBean(Integer cartNum, Integer actId) {
        CartInfo cartInfo = new CartInfo();
        cartInfo.setCartNum(cartNum);
        cartInfo.setActId(actId);
        return cartInfo;
    }

    public static Integer getLocationCartNum(CartInfo cartInfo, ProductBase productBase) {
        if (cartInfo == null || cartInfo.getCartNum() == null) {
            return 0;
        }
        Integer cartActId = cartInfo.getActId();
        Integer productActId = productBase.getActId();
        if ((cartActId == null && productActId == null) ||
                (cartActId != null && productActId != null && cartActId.intValue() == productActId.intValue())) {
            return cartInfo.getCartNum();
        }
        return 0;
    }

    private static SaleProduct getSaleProduct(SecKillProduct secKillProduct) {
        SaleProduct saleProduct = new SaleProduct();
        saleProduct.setSaleProductId(secKillProduct.getSaleProductId());
        saleProduct.setBrandName(secKillProduct.getBrandName());
        saleProduct.setSaleProductName(secKillProduct.getSaleProductName());
        saleProduct.setSaleProductImageUrl(secKillProduct.getSaleProductImageUrl());
        saleProduct.setStockNum(secKillProduct.getStockNum());
        saleProduct.setSaleProductSpec(secKillProduct.getSaleProductSpec());
        saleProduct.setOrderPrice(secKillProduct.getSeckillPrice());
        saleProduct.setRetailPrice(secKillProduct.getSeckillPrice());
        saleProduct.setPromotionalPrice(secKillProduct.getSeckillPrice());
        saleProduct.setProductDetail(secKillProduct.getProductDetail());
        saleProduct.setProductStatus(secKillProduct.getProductStatus());
        saleProduct.setCartNum(secKillProduct.getCartNum());
        saleProduct.setActId(secKillProduct.getActId());
        saleProduct.setLimitCount(secKillProduct.getLimitCount());
        saleProduct.setActId(secKillProduct.getActId());
        return saleProduct;
    }

    private static Boolean isSameActId(Integer oldActId, Integer actId) {
        if ((oldActId == null && actId == null) ||
                (oldActId != null && actId != null && oldActId.intValue() == actId.intValue())) {
            return true;
        }
        return false;
    }

    /**
     * 根据Map信息获取优惠券数据列表
     *
     * @param map
     * @return
     */
    public static List<OrderCouponInfo> getCouponInfo(Map<Integer, Integer> map) {
        List<OrderCouponInfo> orderCouponInfos = null;
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            if (orderCouponInfos == null) {
                orderCouponInfos = new ArrayList<>();
            }

            OrderCouponInfo orderCouponInfo = new OrderCouponInfo();
            orderCouponInfo.setTicketId(entry.getKey());
            orderCouponInfo.setTicketType(entry.getValue());
            orderCouponInfos.add(orderCouponInfo);
        }
        return orderCouponInfos;
    }
}
