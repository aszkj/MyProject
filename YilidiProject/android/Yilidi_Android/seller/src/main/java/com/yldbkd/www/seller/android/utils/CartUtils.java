package com.yldbkd.www.seller.android.utils;

import android.content.Context;

import com.yldbkd.www.library.android.common.PreferenceUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductAllot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 调货单购物车数据工具类
 * <p/>
 * Created by linghuxj on 16/6/4.
 */
public class CartUtils {

    public static Map<Integer, Integer> carts = new HashMap<>();

    public static Integer addCart(Context context, Integer productId, Integer warehouseCount,
                                  Integer perAllotCount) {
        Integer cartNum = carts.get(productId);
        cartNum = cartNum == null ? 0 : cartNum;
        if (warehouseCount == 0 || cartNum > warehouseCount - perAllotCount || perAllotCount > warehouseCount) {
            ToastUtils.showShort(context, R.string.product_has_enough_stock);
        } else {
            cartNum += perAllotCount;
            carts.put(productId, cartNum);
        }
        return getCartCount();
    }

    public static Integer removeCart(Integer productId, Integer perAllotCount) {
        Integer cartNum = carts.get(productId);
        cartNum = cartNum == null ? 0 : cartNum;
        cartNum -= perAllotCount;
        if (cartNum <= 0) {
            carts.remove(productId);
        } else {
            carts.put(productId, cartNum);
        }
        return getCartCount();
    }

    public static Integer getCartCount() {
        Integer count = 0;
        if (carts == null) {
            return 0;
        }
        for (Map.Entry<Integer, Integer> entry : carts.entrySet()) {
            count += entry.getValue();
        }
        return count;
    }

    public static List<CartInfo> getCartInfo() {
        return getCartInfo(carts);
    }

    public static List<CartInfo> getCartInfo(Map<Integer, Integer> map) {
        List<CartInfo> cartInfos = null;
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            if (cartInfos == null) {
                cartInfos = new ArrayList<>();
            }
            CartInfo cartInfo = new CartInfo();
            cartInfo.setSaleProductId(entry.getKey());
            cartInfo.setAllotNum(entry.getValue());
            cartInfos.add(cartInfo);
        }
        return cartInfos;
    }

    public static void clearCartProduct(List<Integer> productIds) {
        for (Integer productId : productIds) {
            carts.remove(productId);
        }
    }

    public static void clearCart(Context context) {
        PreferenceUtils.removePref(context, PreferenceName.Cart.CART_INFO);
    }

    public static void calculateProductNum(List<ProductAllot> saleProducts) {
        if (saleProducts == null) {
            return;
        }
        for (ProductAllot product : saleProducts) {
            Integer cartNum = carts.get(product.getSaleProductId());
            product.setCartNum(cartNum == null ? 0 : cartNum);
        }
    }

    public static void calculateProductNum(ProductAllot saleProduct) {
        if (saleProduct == null) {
            return;
        }
        Integer cartNum = carts.get(saleProduct.getSaleProductId());
        saleProduct.setCartNum(cartNum == null ? 0 : cartNum);
    }

    /**
     * 购物车实体
     */
    public static class CartInfo {
        /**
         * 商品ID
         */
        private Integer saleProductId;
        /**
         * 购物车数量
         */
        private Integer allotNum;

        public Integer getSaleProductId() {
            return saleProductId;
        }

        public void setSaleProductId(Integer saleProductId) {
            this.saleProductId = saleProductId;
        }

        public Integer getAllotNum() {
            return allotNum;
        }

        public void setAllotNum(Integer allotNum) {
            this.allotNum = allotNum;
        }
    }
}
