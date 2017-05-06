var SPLIT = "&";
var SPLIT_VALUE = "=";

var NO_LINK = 0; // 没有链接跳转
var PRODUCT_CLASS_LINK = 1; // 商品分类
var CLASS_CODE = "classCode";

var H5_LINK = 2; // H5页面
var H5_PAGE_TYPE = "h5PageType";

var HOME_CLASS_ZONE_LINK = 3; // 首页分类专区页面 (废弃)
var HOME_CLASS_ZONE_IMAGE = "zoneImage";
var HOME_CLASS_ZONE_CODE = "zoneCode";
var HOME_CLASS_ZONE_TITLE = "zoneTitle";
var HOME_CLASS_ZONE_COLOR = "zoneColor";

var THEME_LINK = 4; // 专题分类
var THEME_TYPE = "themeType";

var ACTIVITY_LINK = 5; // 活动
var ACTIVITY_TYPE = "activityType";
var VALUE_TYPE_SECKILL = "ACTIVITYTYPE_SECKILL";

var PRODUCT_DETAIL_LINK = 6; // 商品详情页
var BAR_CODE = "barCode";

var NEWS_LINK = 7; // 网站资讯、公告
var LINK_URL = "linkUrl";

/** 图片/广告跳转 */
function normalRedirect(linkType, linkData) {
	var mapData = getDataMap(linkData);
	if (!linkType || linkType == NO_LINK) {
		return;
	} else if (linkType == PRODUCT_CLASS_LINK) {
		var classCode = mapData[MORE_CLASS_CODE];
		if (!classCode)
			return;
		redirect("allCate/allCate.html?code=" + classCode);
	} else if (linkType == H5_LINK) {
		var h5PageType = mapData[MORE_H5_PAGE_TYPE];
		if (!h5PageType)
			return;
		var params = new Object();
		params.typeCode = h5PageType;
		ajax("/system/gettypeurl", params, function(data) {
			redirect(data.value);
		}, function(msg) {
		});
	} else if (linkType == THEME_LINK) {
		var themeType = mapData[THEME_TYPE];
		if (!themeType)
			return;
		redirect("floor-detail/floor-detail.html?zoneCode=" + themeType);
	} else if (linkType == ACTIVITY_LINK) {
		var activityType = mapData[ACTIVITY_TYPE];
		if (!activityType)
			return;
		if (VALUE_TYPE_SECKILL == activityType) {
			// 秒杀活动页面

		}
	} else if (linkType == PRODUCT_DETAIL_LINK) {
		var barCode = mapData[BAR_CODE];
		if (!barCode)
			return;
	} else if (linkType == NEWS_LINK) {
		// 暂无页面支持
	}
}

var MORE_PRODUCT_CLASS_LINK = 1; // 商品分类
var MORE_CLASS_CODE = "classCode";

var MORE_H5_LINK = 2; // H5页面
var MORE_H5_PAGE_TYPE = "h5PageType";

var MORE_FLOOR_LINK = 3; // 楼层页面
var FLOOR_ID = "floorId";

/** 楼层更多跳转 */
function moreRedirect(moreLinkType, moreLinkData, otherData) {
	if (!moreLinkType)
		return;
	var mapData = getDataMap(moreLinkData);
	if (moreLinkType == MORE_PRODUCT_CLASS_LINK) {
		var classCode = mapData[MORE_CLASS_CODE];
		if (classCode == null)
			return;
		redirect("javascript:void(0)");
	} else if (moreLinkType == MORE_H5_LINK) {
		var h5PageType = mapData[MORE_H5_PAGE_TYPE];
		if (!h5PageType)
			return;
		var params = new Object();
		params.typeCode = h5PageType;
		ajax("/system/gettypeurl", params, function(data) {
			redirect(data.value);
		}, function(msg) {
		});
	} else if (moreLinkType == MORE_FLOOR_LINK) {
		var floorId = mapData[FLOOR_ID];
		if (!floorId)
			return;
		redirect("floor-detail/floor-detail.html?floorId=" + floorId
				+ "&floorName=" + otherData);
	}
}

function redirect(url) {
	window.location.href = url;
}

function getDataMap(linkData) {
	var map = {};
	if (!linkData) {
		return map;
	}
	var datas = linkData.split(SPLIT);
	for ( var index in datas) {
		var keyValue = datas[index].split(SPLIT_VALUE);
		if (!keyValue || keyValue.length != 2) {
			continue;
		}
		map[keyValue[0]] = keyValue[1];
	}
	return map;
}