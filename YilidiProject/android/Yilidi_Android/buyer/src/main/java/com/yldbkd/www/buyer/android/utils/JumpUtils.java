package com.yldbkd.www.buyer.android.utils;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;

import com.yldbkd.www.buyer.android.activity.AccountActivity;
import com.yldbkd.www.buyer.android.activity.ClassActivity;
import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.RedEnvelopActivity;
import com.yldbkd.www.buyer.android.activity.RefundActivity;
import com.yldbkd.www.buyer.android.activity.SecKillActivity;
import com.yldbkd.www.buyer.android.activity.ZoneActivity;
import com.yldbkd.www.buyer.android.fragment.ClassFragment;
import com.yldbkd.www.buyer.android.fragment.RedEnvelopEntranceFragment;
import com.yldbkd.www.buyer.android.fragment.RefundFragment;
import com.yldbkd.www.buyer.android.fragment.WeeklyProductFragment;
import com.yldbkd.www.buyer.android.fragment.ZoneProductFragment;

import java.util.HashMap;
import java.util.Map;

/**
 * 广告，信息等跳转工具类
 * <p/>
 * Created by linghuxj on 16/7/18.
 */
public class JumpUtils {

    private static final String SPLIT = "&";
    private static final String SPLIT_VALUE = "=";

    private static final int NO_LINK = 0; // 没有链接跳转
    private static final int PRODUCT_CLASS_LINK = 1; // 商品分类
    private static final String CLASS_CODE = "classCode";

    private static final int H5_LINK = 2; // H5页面
    private static final String H5_PAGE_TYPE = "h5PageType";

    private static final int HOME_CLASS_ZONE_LINK = 3; // 首页分类专区页面 (废弃)
    private static final String HOME_CLASS_ZONE_IMAGE = "zoneImage";
    private static final String HOME_CLASS_ZONE_CODE = "zoneCode";
    private static final String HOME_CLASS_ZONE_TITLE = "zoneTitle";
    private static final String HOME_CLASS_ZONE_COLOR = "zoneColor";

    private static final int THEME_LINK = 4; // 专题分类
    private static final String THEME_TYPE = "themeType";

    private static final int ACTIVITY_LINK = 5; // 活动
    private static final String ACTIVITY_TYPE = "activityType";
    private static final String VALUE_TYPE_SECKILL = "ACTIVITYTYPE_SECKILL";//秒杀
    private static final String VALUE_TYPE_RED = "ACTIVITYTYPE_REDENVELOPE";//红包

    private static final int PRODUCT_DETAIL_LINK = 6; // 商品详情页
    private static final String BAR_CODE = "barCode";

    private static final int NEWS_LINK = 7; // 网站资讯、公告
    private static final String LINK_URL = "linkUrl";

    public static void jump(Activity activity, Integer linkType, String linkData) {
        Intent intent = null;
        Map<String, Object> mapData = getDataMap(linkData);
        if (linkType == null || linkType == NO_LINK) {
            return;
        } else if (linkType == PRODUCT_CLASS_LINK) {
            intent = new Intent(activity, ClassActivity.class);
            intent.setAction(ClassFragment.class.getSimpleName());
            Object classCode = mapData.get(CLASS_CODE);
            if (classCode == null) {
                return;
            }
            intent.putExtra(Constants.BundleName.CLASS_CODE, classCode.toString());
        } else if (linkType == H5_LINK) {
            Object h5Page = mapData.get(H5_PAGE_TYPE);
            if (h5Page == null) {
                return;
            }
            String h5PageType = h5Page.toString();
            if (Constants.RuleAgreementType.VIP_ZONE.equals(h5PageType) ||
                    Constants.RuleAgreementType.FEN_ZONE.equals(h5PageType)) {
                intent = new Intent(activity, H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, h5PageType);
            } else {
                intent = new Intent(activity, H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, h5PageType);
            }
        } else if (linkType == HOME_CLASS_ZONE_LINK) {
            Object zone = mapData.get(HOME_CLASS_ZONE_CODE);
            if (zone == null) {
                return;
            }
            String zoneCode = zone.toString(); // 分类专区CODE
            String imageUrl = String.valueOf(mapData.get(HOME_CLASS_ZONE_IMAGE));
            String zoneTitle = String.valueOf(mapData.get(HOME_CLASS_ZONE_TITLE));
            String zoneColor = String.valueOf(mapData.get(HOME_CLASS_ZONE_COLOR));
            intent = new Intent(activity, ZoneActivity.class);
            intent.putExtra(Constants.BundleName.ZONE_CODE, zoneCode);
            intent.putExtra(Constants.BundleName.ZONE_IMAGE, imageUrl);
            intent.putExtra(Constants.BundleName.ZONE_TITLE, zoneTitle);
            intent.putExtra(Constants.BundleName.ZONE_COLOR, zoneColor);
            intent.setAction(ZoneProductFragment.class.getSimpleName());
        } else if (linkType == THEME_LINK) {
            Object theme = mapData.get(THEME_TYPE);
            if (theme == null) {
                return;
            }
            String themeType = theme.toString(); // 专题类型
            intent = new Intent(activity, ZoneActivity.class);
            intent.putExtra(Constants.BundleName.ZONE_CODE, themeType);
            intent.setAction(ZoneProductFragment.class.getSimpleName());
        } else if (linkType == ACTIVITY_LINK) {
            Object activityTypeObj = mapData.get(ACTIVITY_TYPE);
            if (activityTypeObj == null) {
                return;
            }
            String activityType = activityTypeObj.toString(); // 活动类型
            if (VALUE_TYPE_SECKILL.equals(activityType)) {
                // 秒杀活动页面
                intent = new Intent(activity, SecKillActivity.class);
            }
            if (VALUE_TYPE_RED.equals(activityType)) {
                // 红包活动页面
                intent = new Intent(activity, RedEnvelopActivity.class);
                intent.setAction(RedEnvelopEntranceFragment.class.getSimpleName());
            }
        } else if (linkType == PRODUCT_DETAIL_LINK) {
            Object barCodeObj = mapData.get(BAR_CODE);
            if (barCodeObj == null) {
                return;
            }
            String barCode = barCodeObj.toString(); // 专题类型
            intent = new Intent(activity, ProductActivity.class);
            intent.putExtra(Constants.BundleName.BAR_CODE, barCode);
            intent.setAction(ZoneProductFragment.class.getSimpleName());
        } else if (linkType == NEWS_LINK) {
            // 暂无页面支持
        }
        activity.startActivity(intent);
    }

    private static final int MORE_PRODUCT_CLASS_LINK = 1; // 商品分类
    private static final String MORE_CLASS_CODE = "classCode";

    private static final int MORE_H5_LINK = 2; // H5页面
    private static final String MORE_H5_PAGE_TYPE = "h5PageType";

    private static final int MORE_FLOOR_LINK = 3; // 楼层页面
    private static final String FLOOR_ID = "floorId";

    public static void moreJump(Activity activity, Integer moreLinkType, String moreLinkData) {
        moreJump(activity, moreLinkType, moreLinkData, null);
    }

    public static void moreJump(Activity activity, Integer moreLinkType, String moreLinkData, Object otherData) {
        if (moreLinkType == null) {
            return;
        }
        Intent intent = null;
        Map<String, Object> mapData = getDataMap(moreLinkData);
        if (moreLinkType == MORE_PRODUCT_CLASS_LINK) {
            intent = new Intent(activity, ClassActivity.class);
            intent.setAction(ClassFragment.class.getSimpleName());
            Object classCode = mapData.get(MORE_CLASS_CODE);
            if (classCode == null) {
                return;
            }
            intent.putExtra(Constants.BundleName.CLASS_CODE, classCode.toString());
        } else if (moreLinkType == MORE_H5_LINK) {
            Object h5Page = mapData.get(MORE_H5_PAGE_TYPE);
            if (h5Page == null) {
                return;
            }
            String h5PageType = h5Page.toString();
            if (Constants.RuleAgreementType.VIP_ZONE.equals(h5PageType) ||
                    Constants.RuleAgreementType.FEN_ZONE.equals(h5PageType)) {
                intent = new Intent(activity, H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, h5PageType);
            } else {
                intent = new Intent(activity, H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, h5PageType);
            }
        } else if (moreLinkType == MORE_FLOOR_LINK) {
            Object floor = mapData.get(FLOOR_ID);
            if (floor == null) {
                return;
            }
            Integer floorId = Integer.valueOf(floor.toString()); // 楼层ID
            intent = new Intent(activity, ZoneActivity.class);
            intent.putExtra(Constants.BundleName.FLOOR_ID, floorId.toString());
            intent.putExtra(Constants.BundleName.FLOOR_NAME, otherData.toString());
            intent.setAction(WeeklyProductFragment.class.getSimpleName());
        }
        activity.startActivity(intent);
    }

    private static final int NO_JUMP = 0;
    private static final int MESSAGE_COUPON_TYPE = 1; //优惠券
    private static final int MESSAGE_REFUND_TYPE = 2; //退款
    private static final int MESSAGE_ACTIVITY_TYPE = 3; //专题活动
    public static void messageJump(Activity activity, Integer directType, String directCode) {
        Intent intent = null;
        if (directType == NO_JUMP) {
            return;
        } else if (directType == MESSAGE_COUPON_TYPE) {
            intent = new Intent(activity, AccountActivity.class);
        } else if (directType == MESSAGE_REFUND_TYPE) {
            intent = new Intent(activity, RefundActivity.class);
            intent.setAction(RefundFragment.class.getSimpleName());
            intent.putExtra(Constants.BundleName.ORDER_CODE, directCode);
        } else if (directType == MESSAGE_ACTIVITY_TYPE) {
            intent = new Intent(activity, ZoneActivity.class);
            intent.putExtra(Constants.BundleName.ZONE_CODE, directCode);
            intent.setAction(ZoneProductFragment.class.getSimpleName());
        }
        activity.startActivity(intent);
    }

    private static Map<String, Object> getDataMap(String linkData) {
        Map<String, Object> map = new HashMap<>();
        if (TextUtils.isEmpty(linkData)) {
            return map;
        }
        String[] datas = linkData.split(SPLIT);
        for (String data : datas) {
            String[] keyValue = data.split(SPLIT_VALUE);
            if (keyValue.length != 2) {
                continue;
            }
            map.put(keyValue[0], keyValue[1]);
        }
        return map;
    }
}
