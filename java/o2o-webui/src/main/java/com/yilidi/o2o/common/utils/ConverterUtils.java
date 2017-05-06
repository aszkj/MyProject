package com.yilidi.o2o.common.utils;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 转换工具类,前后端编码转换等
 * 
 * @author: chenb
 * @date: 2016年6月13日 上午11:44:29
 */
public final class ConverterUtils {
    private ConverterUtils() {
    }

    /**
     * 将服务器端产品编码转换成前端编码
     * 
     * @param productSaleStatus
     * @param statusCode
     * @return
     */
    public static int toClientProductSaleStatus(String productSaleStatus, String statusCode) {
        if (SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_OFF.equals(statusCode)) {
            return WebConstants.PRODUCT_STATUS_OFF;
        }
        if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(productSaleStatus)) {
            return WebConstants.PRODUCT_STATUS_OFF_SALE;
        }
        return WebConstants.PRODUCT_STATUS_ON_SALE;
    }

    /**
     * 转换成后端的渠道编码
     * 
     * @param intfCallChannel
     *            前端渠道类型
     * @return 后端渠道编码
     */
    public static String toServerChannelCode(String intfCallChannel) {
        if (WebConstants.CALL_CHANNEL_TYPE_ANDROID.equals(intfCallChannel)) {
            return SystemContext.UserDomain.CHANNELTYPE_ANDROID;
        }
        if (WebConstants.CALL_CHANNEL_TYPE_IOS.equals(intfCallChannel)) {
            return SystemContext.UserDomain.CHANNELTYPE_IOS;
        }
        if (WebConstants.CALL_CHANNEL_TYPE_WEIXIN.equals(intfCallChannel)) {
            return SystemContext.UserDomain.CHANNELTYPE_WEIXIN;
        }
        return null;
    }

    /**
     * 将后端链接类型编码转换成前端识别链接类型
     * 
     * @param linkType
     *            后端链接类型编码
     * @return 前端链接类型
     */
    public static int toClienLinkType(String linkType) {
        if (StringUtils.isEmpty(linkType)) {
            return WebConstants.ADVERTISEMENT_LINK_TYPE_NONE;
        }
        switch (linkType) {
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_NONE:
            return WebConstants.ADVERTISEMENT_LINK_TYPE_NONE;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_PRODUCTCLASS:
            return WebConstants.ADVERTISEMENTLINKTYPE_PRODUCT_CLASS;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_H5PAGE:
            return WebConstants.ADVERTISEMENTLINKTYPE_H5PAGE;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_HOMECLASSZONE:
            return WebConstants.ADVERTISEMENTLINKTYPE_HOMECLASSZONE;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_THEME:
            return WebConstants.ADVERTISEMENTLINKTYPE_THEME;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_ACTIVITY:
            return WebConstants.ADVERTISEMENTLINKTYPE_ACTIVITY;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL:
            return WebConstants.ADVERTISEMENTLINKTYPE_PRODUCT_DETAIL;
        case SystemContext.ProductDomain.ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT:
            return WebConstants.ADVERTISEMENTLINKTYPE_INFORMATION_ANNOUNCEMENT;
        default:
            return WebConstants.ADVERTISEMENT_LINK_TYPE_NONE;
        }
    }

    /**
     * 将后端链接类型编码转换成前端识别链接类型
     * 
     * @param floorLinkType
     *            后端链接类型编码
     * @return 前端链接类型
     */
    public static int toClientFloorLinkType(String floorLinkType) {
        if (StringUtils.isEmpty(floorLinkType)) {
            return WebConstants.FLOORLINKTYPE_PRODUCT_CLASS;
        }
        switch (floorLinkType) {
        case SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT_CLASS:
            return WebConstants.FLOORLINKTYPE_PRODUCT_CLASS;
        case SystemContext.ProductDomain.FLOORLINKTYPE_ZONE:
            return WebConstants.FLOORLINKTYPE_ZONE;
        case SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT:
            return WebConstants.FLOORLINKTYPE_PRODUCT;
        default:
            return WebConstants.FLOORLINKTYPE_PRODUCT_CLASS;
        }
    }

    /**
     * 将后端店营业状态转换成前端状态
     * 
     * @param storeStatus
     *            后端店铺状态编码
     * @return 前端店铺状态F
     */
    public static String toClientStoreStatus(String storeStatus) {
        if (SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeStatus)) {
            return WebConstants.STORE_STATUS_OPEN;
        }
        if (SystemContext.UserDomain.STORESTATUS_CLOSED.equals(storeStatus)) {
            return WebConstants.STORE_STATUS_CLOSE;
        }
        return null;
    }

    /**
     * 将后端会员类型编码转换成前端类型编码
     * 
     * @param buyerLevel
     *            后端会员类型编码
     * @return 前端会员类型
     */
    public static int toClienMemberType(String buyerLevel) {
        if (SystemContext.UserDomain.BUYERLEVEL_B.equals(buyerLevel)) {
            return WebConstants.MEMBER_TYPE_PT;
        }
        return WebConstants.MEMBER_TYPE_ORDINARY;
    }

    /**
     * 将前端传的订单状态转换为后台订单状态
     * 
     * @param statusCode
     *            前端订单状态
     * @return 后台订单状态列表
     */
    public static List<String> toServerOrderStatusCode(String statusCode) {
        int status = Integer.parseInt(statusCode);
        List<String> statusCodes = new ArrayList<String>();
        switch (status) {
        case WebConstants.ORDERLIST_FORPAY:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY);
            return statusCodes;
        case WebConstants.ORDERLIST_FORRECEIVE:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            return statusCodes;
        case WebConstants.ORDERLIST_FINISHED:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            return statusCodes;
        case WebConstants.ORDERLIST_REFUND:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE);
            return statusCodes;
        case WebConstants.ORDERLIST_ALL:
            return null;
        default:
            return null;
        }
    }

    /**
     * 将前端传的订单状态转换为后台订单状态(卖家)
     * 
     * @param statusCode
     *            前端订单状态
     * @return 后台订单状态列表
     */
    public static List<String> toServerOrderStatusCodeForSeller(String statusCode) {
        int status = Integer.parseInt(statusCode);
        List<String> statusCodes = new ArrayList<String>();
        switch (status) {
        case WebConstants.SELLER_ORDERLIST_PAID:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_PAID);
            break;
        case WebConstants.SELLER_ORDERLIST_FORSEND:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND);
            break;
        case WebConstants.SELLER_ORDERLIST_FORRECEIVE:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE);
            break;
        case WebConstants.SELLER_ORDERLIST_FINISHED:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            break;
        case WebConstants.SELLER_ORDERLIST_CANCEL:
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE);
            break;
        case WebConstants.ORDERLIST_ALL:
            break;
        default:
            break;
        }
        return statusCodes;
    }

    /**
     * 将后端订单评价状态类型编码转换成前端类型编码
     * 
     * @param appraiseFlag
     *            后端订单评价状态类型编码
     * @return 前端会员类型
     */
    public static int toClientAppraiseFlag(String appraiseFlag) {
        if (SystemContext.OrderDomain.APPRAISEFLAG_YES.equals(appraiseFlag)) {
            return WebConstants.APPRAISE_YES;
        }
        return WebConstants.APPRAISE_NO;
    }

    /**
     * 将前端订单类型转换成后端订单类型编码List
     * 
     * @param orderType
     *            前端订单类型
     * @return 后端订单类型编码List
     */
    public static List<String> toServerOrderType(Integer orderType) {
        List<String> saleOrderTypeList = new ArrayList<String>();
        if (WebConstants.SALE_ORDER_TYPE_ORDINARY == orderType.intValue()) {
            String saleOrderTypeOrdinary = SystemContext.OrderDomain.SALEORDERTYPE_ORDINARY;
            saleOrderTypeList.add(saleOrderTypeOrdinary);
        }
        if (WebConstants.SALE_ORDER_TYPE_OTHER == orderType.intValue()) {
            String saleOrderTypeVip = SystemContext.OrderDomain.SALEORDERTYPE_VIP;
            saleOrderTypeList.add(saleOrderTypeVip);
            String saleOrderTypeSecKill = SystemContext.OrderDomain.SALEORDERTYPE_SECKILL;
            saleOrderTypeList.add(saleOrderTypeSecKill);
        }
        return saleOrderTypeList;
    }

    /**
     * 将后端调拨单状态编码转换成前端识别的调拨单状态
     * 
     * @param flittingOrderStatus
     *            后端调拨单状态编码
     * @return 前端识别的调拨单状态
     */
    public static int toFlittingOrderStatus(String flittingOrderStatus) {
        switch (flittingOrderStatus) {
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_APPLY:
            return WebConstants.FLITTING_ORDER_STATUS_APPLY;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTED:
            return WebConstants.FLITTING_ORDER_STATUS_ACCEPTED;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_ACCEPTREJECTED:
            return WebConstants.FLITTING_ORDER_STATUS_ACCEPTREJECTED;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_SEND:
            return WebConstants.FLITTING_ORDER_STATUS_SEND;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKING:
            return WebConstants.FLITTING_ORDER_STATUS_CHECKING;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_CHECKED:
            return WebConstants.FLITTING_ORDER_STATUS_CHECKED;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHED:
            return WebConstants.FLITTING_ORDER_STATUS_FINISHED;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_FINISHREJECTED:
            return WebConstants.FLITTING_ORDER_STATUS_FINISHREJECTED;
        case SystemContext.OrderDomain.FLITTINGORDERSTATUS_ARBITRATE:
            return WebConstants.FLITTING_ORDER_STATUS_ARBITRATE;
        default:
            return 0;
        }
    }

    /**
     * 将前端配送方式转换成后端配送方式编码
     * 
     * @param deliveryType
     *            前端配送方式
     * @return 后端配送方式编码
     */
    public static String toServerDeliveryType(Integer deliveryType) {
        if (ObjectUtils.isNullOrEmpty(deliveryType)) {
            return SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION;
        }
        if (WebConstants.SALE_ORDER_DELIVERY_MODE_PICKUP == deliveryType.intValue()) {
            return SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP;
        }
        return SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION;
    }

    /**
     * 将后端配送方式编码转换成前端识别配送方式
     * 
     * @param deliveryTypeCode
     *            后端配送方式编码
     * @return 前端配送方式
     */
    public static int toClientDeliveryType(String deliveryTypeCode) {
        if (StringUtils.isEmpty(deliveryTypeCode)) {
            return WebConstants.SALE_ORDER_DELIVERY_MODE_DISTRIBUTION;
        }
        switch (deliveryTypeCode) {
        case SystemContext.OrderDomain.SALEORDERDELIVERYMODE_DISTRIBUTION:
            return WebConstants.SALE_ORDER_DELIVERY_MODE_DISTRIBUTION;
        case SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP:
            return WebConstants.SALE_ORDER_DELIVERY_MODE_PICKUP;
        default:
            return WebConstants.SALE_ORDER_DELIVERY_MODE_DISTRIBUTION;
        }
    }

    /**
     * 将后端专题背景颜色编码转换成前端识别的专题背景颜色
     * 
     * @param baseColor
     *            后端专题背景颜色编码
     * @return 前端识别的专题背景颜色
     */
    public static String toBaseColor(String baseColor) {
        if (StringUtils.isEmpty(baseColor)) {
            return WebConstants.THEMEBASECOLOR_RED;
        }
        switch (baseColor) {
        case SystemContext.ProductDomain.THEMEBASECOLOR_RED:
            return WebConstants.THEMEBASECOLOR_RED;
        case SystemContext.ProductDomain.THEMEBASECOLOR_YELLOW:
            return WebConstants.THEMEBASECOLOR_YELLOW;
        case SystemContext.ProductDomain.THEMEBASECOLOR_LIGHTBLUE:
            return WebConstants.THEMEBASECOLOR_LIGHTBLUE;
        case SystemContext.ProductDomain.THEMEBASECOLOR_NAVYBLUE:
            return WebConstants.THEMEBASECOLOR_NAVYBLUE;
        case SystemContext.ProductDomain.THEMEBASECOLOR_LAKEBLUE:
            return WebConstants.THEMEBASECOLOR_LAKEBLUE;
        case SystemContext.ProductDomain.THEMEBASECOLOR_GREEN:
            return WebConstants.THEMEBASECOLOR_GREEN;
        default:
            return WebConstants.THEMEBASECOLOR_RED;
        }
    }

    /**
     * 将后端券类类型转换成前端识别券类类型
     * 
     * @param ticketType
     *            后端券类类型
     * @return 前端识别券类类型
     */
    public static int toClientTicketType(String ticketType) {
        if (StringUtils.isEmpty(ticketType)) {
            return WebConstants.TICKET_TYPE_COUPON;
        }
        switch (ticketType) {
        case SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON:
            return WebConstants.TICKET_TYPE_COUPON;
        case SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER:
            return WebConstants.TICKET_TYPE_VOUCHER;
        default:
            return WebConstants.TICKET_TYPE_COUPON;
        }
    }

    /**
     * 将后端共享库存转换成前共享库存类型
     * 
     * @param stockShare
     *            后端共享库存
     * @return 前端共享库存
     */
    public static int toClientShareFlag(String stockShare) {
        if (StringUtils.isEmpty(stockShare)) {
            return WebConstants.SHAREFLAG_NO;
        }
        switch (stockShare) {
        case SystemContext.UserDomain.STORESTOCKSHARE_NO:
            return WebConstants.SHAREFLAG_NO;
        case SystemContext.UserDomain.STORESTOCKSHARE_YES:
            return WebConstants.SHAREFLAG_YES;
        default:
            return WebConstants.SHAREFLAG_NO;
        }
    }

    /**
     * 将后端用户性别转换成前端用户性别,默认男
     * 
     * @param gender
     *            后端用户性别编码
     * @return 前端用户性别
     */
    public static Integer toClientGender(String gender) {
        if (ObjectUtils.isNullOrEmpty(gender)) {
            return CommonConstants.GENDER_MALE;
        }
        switch (gender) {
        case SystemContext.UserDomain.USERGENDER_MALE:
            return CommonConstants.GENDER_MALE;
        case SystemContext.UserDomain.USERGENDER_FEMALE:
            return CommonConstants.GENDER_FEMALE;
        default:
            return CommonConstants.GENDER_FEMALE;
        }
    }

    /**
     * 将前端用户性别转换成后端用户性别
     * 
     * @param gender
     *            后端用户性别编码
     * @return 前端用户性别
     */
    public static String toServerGender(Integer gender) {
        if (ObjectUtils.isNullOrEmpty(gender)) {
            return SystemContext.UserDomain.USERGENDER_MALE;
        }
        switch (gender) {
        case CommonConstants.GENDER_MALE:
            return SystemContext.UserDomain.USERGENDER_MALE;
        case CommonConstants.GENDER_FEMALE:
            return SystemContext.UserDomain.USERGENDER_FEMALE;
        default:
            return SystemContext.UserDomain.USERGENDER_FEMALE;
        }
    }
    
    /**
     * 将消息类型code转成对应的编码
     * @param dictCode
     * @return
     */
    public static int getMessageTypeValue(String dictCode) {
		int num = 0;
		if(StringUtils.isEmpty(dictCode)){
			return num;
		}
		switch (dictCode) {
		case SystemContext.SystemDomain.USERMESSAGETYPE_PREFERENCE_MESSAGE:
			num = WebConstants.MESSAGETYPEONE;
			break;
		case SystemContext.SystemDomain.USERMESSAGETYPE_REFUND_MESSAGE:
			num = WebConstants.MESSAGETYPETWO;
			break;
		case SystemContext.SystemDomain.SYSTEMMESSAGETYPE_ACTIVE_MESSAGE:
			num = WebConstants.MESSAGETYPETHREE;
			break;
		}
		return num;
	}
    
    /**
     * 将消息类编码转成code
     * @param typeValue
     * @return
     */
    public static String getMessageType(Integer typeValue) {
    	String messageType = "";
		if(ObjectUtils.isNullOrEmpty(typeValue)){
			return messageType;
		}
		switch (typeValue) {
		case WebConstants.MESSAGETYPEONE:
			messageType = SystemContext.SystemDomain.USERMESSAGETYPE_PREFERENCE_MESSAGE;
			break;
		case WebConstants.MESSAGETYPETWO:
			messageType = SystemContext.SystemDomain.USERMESSAGETYPE_REFUND_MESSAGE;
			break;
		case WebConstants.MESSAGETYPETHREE:
			messageType = SystemContext.SystemDomain.SYSTEMMESSAGETYPE_ACTIVE_MESSAGE;
			break;
		}
		return messageType;
	}
    
    public static int getSkipTypeValue(String skipType) {
		int num = 0;
		if(StringUtils.isEmpty(skipType)){
			return num;
		}
		switch (skipType) {
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_COUPON:
			num = WebConstants.SKIPTYPEONE;
			break;
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_REFUND:
			num = WebConstants.SKIPTYPETWO;
			break;
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_THEME:
			num = WebConstants.SKIPTYPETHREE;
			break;
		}
		return num;
	}
}
