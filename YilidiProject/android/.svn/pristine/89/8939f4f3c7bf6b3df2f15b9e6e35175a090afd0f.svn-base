package com.yldbkd.www.buyer.android.utils;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专区信息相关工具类
 * <p/>
 * Created by linghuxj on 16/7/11.
 */
public class ZoneUtils {

    private static boolean isVipSuccess = false;
    private static boolean isFenSuccess = false;

    public static List<Integer> getZoneVipIds() {
        List<SaleProduct> list = getZoneVip();
        if (list == null) {
            return null;
        }
        List<Integer> productIds = new ArrayList<>();
        for (SaleProduct product : list) {
            productIds.add(product.getSaleProductId());
        }
        return productIds;
    }

    public static List<SaleProduct> getZoneVip() {
        return BuyerApp.getInstance().zoneVipProducts;
    }

    public static List<Integer> getZone1FenIds() {
        List<SaleProduct> list = getZoneFen();
        if (list == null) {
            return null;
        }
        List<Integer> productIds = new ArrayList<>();
        for (SaleProduct product : list) {
            productIds.add(product.getSaleProductId());
        }
        return productIds;
    }

    public static List<SaleProduct> getZoneFen() {
        return BuyerApp.getInstance().zone1FenProducts;
    }

    public static void getZoneProducts() {
        requestZoneVipProducts();
        requestZone1FenProducts();
    }

    public static void requestZoneVipProducts() {
        Integer storeId = CommunityUtils.getCurrentStoreId();
        if (storeId == null) {
            return;
        }
        final BuyerApp app = BuyerApp.getInstance();
        Map<String, Object> map = new HashMap<>();
        map.put("zoneType", Constants.ZoneType.ZONE_VIP_TYPE);
        map.put("storeId", storeId);
        RetrofitUtils.getInstance().zoneProduct(ParamUtils.getParam(map), new HttpBack<List<SaleProduct>>() {
            @Override
            public void onSuccess(List<SaleProduct> list) {
                isVipSuccess = true;
                app.zoneVipProducts = list;
            }

            @Override
            public void onFailure(String msg) {
                isVipSuccess = false;
            }

            @Override
            public void onTimeOut() {
                isVipSuccess = false;
            }
        });
    }

    public static void requestZone1FenProducts() {
        Integer storeId = CommunityUtils.getCurrentStoreId();
        if (storeId == null) {
            return;
        }
        final BuyerApp app = BuyerApp.getInstance();
        Map<String, Object> map = new HashMap<>();
        map.put("zoneType", Constants.ZoneType.ZONE_1_FEN);
        map.put("storeId", storeId);
        RetrofitUtils.getInstance().zoneProduct(ParamUtils.getParam(map), new HttpBack<List<SaleProduct>>() {
            @Override
            public void onSuccess(List<SaleProduct> list) {
                isFenSuccess = true;
                app.zone1FenProducts = list;
            }

            @Override
            public void onFailure(String msg) {
                isFenSuccess = false;
            }

            @Override
            public void onTimeOut() {
                isFenSuccess = false;
            }
        });
    }

    public static boolean isSuccess() {
        return isVipSuccess && isFenSuccess;
    }
}
