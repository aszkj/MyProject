package com.yldbkd.www.buyer.android.utils;

import android.content.Context;
import android.os.Handler;
import android.text.TextUtils;
import android.view.View;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.viewCustomer.StoreOffDialog;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import java.util.ArrayList;
import java.util.List;

/**
 * 变换小区信息工具类
 * <p/>
 * Created by linghuxj on 16/7/12.
 */
public class ChangeCommunityUtils {

    private static boolean isAutoLocation = true;

    private static final long AUTO_TIME_INTERVAL = 15 * 60 * 1000L;
    private static final long MANUAL_TIME_INTERVAL = 30 * 60 * 1000L;

    private static CommonDialog changeStoreDialog;
    private static StoreOffDialog storeDialog;

    public static void changeCommunity(final Context context, final Community community, final Handler handler) {
        if (isSameCommunity(community) || isSameStore(community)) {
            CommunityUtils.isTokeByMyself(false);
            CommunityUtils.setCurrentCommunity(community);
            handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_NORMAL).sendToTarget();
            return;
        }
        if (changeStoreDialog != null && changeStoreDialog.isShowing()) {
            return;
        }
        changeStoreDialog = new CommonDialog(context, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                CommunityUtils.isTokeByMyself(false);
                changeStoreDialog.dismiss();
                CommunityUtils.setCurrentCommunity(community);
                if (community == null || community.getStoreInfo() == null) {
                    handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_EMPTY).sendToTarget();
                } else {
                    handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_STORE_DIFF).sendToTarget();
                }
                CartUtils.clearCart();
                CartUtils.clearCartDao();
            }
        });
        Integer count = CartUtils.getCartCount();
        boolean isEmptyStore = community == null || community.getStoreInfo() == null;
        String notification = context.getString(count > 0 ? (isEmptyStore ? R.string.home_dialog_location_no_store_clear_cart :
                R.string.home_dialog_location_clear_cart) : (isEmptyStore ? R.string.home_dialog_location_no_store :
                R.string.home_dialog_location_change));
        changeStoreDialog.setData(notification, context.getString(R.string.home_dialog_confirm));
        changeStoreDialog.show();
    }

    public static void changeStore(final Context context, final Store store, final Handler handler) {
        if (isSameStore(store)) {
            CommunityUtils.isTokeByMyself(true);
            CommunityUtils.setCurrentStore(store);
            BuyerApp.getInstance().community = null;

            handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_NORMAL).sendToTarget();
            return;
        }
        if (changeStoreDialog != null && changeStoreDialog.isShowing()) {
            return;
        }
        changeStoreDialog = new CommonDialog(context, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                CommunityUtils.isTokeByMyself(true);
                BuyerApp.getInstance().community = null;

                changeStoreDialog.dismiss();
                CommunityUtils.setCurrentStore(store);
                if (store == null) {
                    handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_EMPTY).sendToTarget();
                } else {
                    handler.obtainMessage(Constants.HandlerCode.CHANGE_COMMUNITY_STORE_DIFF).sendToTarget();
                }
                CartUtils.clearCart();
                CartUtils.clearCartDao();
            }
        });
        Integer count = CartUtils.getCartCount();
        String notification = context.getString(count > 0 ? (R.string.home_dialog_location_toke_clear_cart) : (R.string.home_dialog_location_toke_change));
        changeStoreDialog.setData(notification, context.getString(R.string.home_dialog_confirm));
        changeStoreDialog.show();
    }

    public static boolean isSameStore(Community community) {
        if (community == null) {
            return false;
        }
        final Store newStore = community.getStoreInfo();
        Integer oldStoreId = CommunityUtils.getCurrentStoreId();
        return newStore != null && oldStoreId != null && newStore.getStoreId() == oldStoreId.intValue();
    }

    public static boolean isSameStore(Store store) {
        final Store newStore = store;
        Integer oldStoreId = CommunityUtils.getCurrentStoreId();
        return newStore != null && oldStoreId != null && newStore.getStoreId() == oldStoreId.intValue();
    }

    private static boolean isSameCommunity(Community community) {
        Integer oldCommunityId = CommunityUtils.getCurrentCommunityId();
        return community != null && oldCommunityId != null && community.getCommunityId().intValue() == oldCommunityId;
    }

    public static void notifyStoreBusiness(Context context, Store store) {
        if (store == null) {
            return;
        }
        if (CommunityUtils.isStoreOn(store)) {
            return;
        }
        boolean isPause = store.getStoreStatus() == null || Constants.StoreStatus.PAUSE.equals(store.getStoreStatus());
        if (storeDialog != null && storeDialog.isShowing()) {
            return;
        }
        storeDialog = new StoreOffDialog(context);
        if (isPause) {
            storeDialog.setData(context.getString(R.string.store_status_pause));
        } else {
            String sendTime = CommunityUtils.notifyStoreBusinessSendTime(store);
            if (TextUtils.isEmpty(sendTime)) {
                return;
            }
            List<Integer> timeStyles = new ArrayList<>();
            timeStyles.add(R.style.TextAppearance_Large_Yellow);
            if (CommunityUtils.getIsTokeByMyself()) {
                storeDialog.setData(context.getString(R.string.store_notice_toke_show));
            } else {
                storeDialog.setData(context, R.string.store_notice_show, sendTime);
            }
        }
        storeDialog.show();
    }

    private static void saveChangeTime() {
        BuyerApp.getInstance().changeTime = System.currentTimeMillis();
    }

    public static boolean isTimeToChange() {
        Long oldTime = BuyerApp.getInstance().changeTime;
        if (oldTime == null) {
            return true;
        }
        long now = System.currentTimeMillis();
        return now - oldTime > (isAutoLocation ? AUTO_TIME_INTERVAL : MANUAL_TIME_INTERVAL);
    }

    public static void setAutoLocation(boolean isAuto) {
        isAutoLocation = isAuto;
        saveChangeTime();
    }

}
