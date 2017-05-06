/** 小区信息存储 */
var sessionStorageCommunityKey = "LOCALSTORAGE_COMMUNITY";
/** 店铺信息存储 */
var sessionStorageStoreKey = "LOCALSTORAGE_STOREINFO";
/** 1分钱商品信息列表 */
var sessionStorageFenKey = "LOCALSTORAGE_FEN";
/** VIP商品信息列表 */
var sessionStorageVIPKey = "LOCALSTORAGE_VIP";
/** 购物车结算信息记录 */
var sessionStorageSettlementKey = "LOCALSTORAGE_SETTLEMENT";
/** 微信登录后保存的Code信息 */
var sessionStorageWXCodeKey = "LOCALSTORAGE_WXCODE";
/** 选择的是否为自提店铺 */
var sessionStorageTokeBySelfKey = "LOCALSTORAGE_TOKEBYSELF";
/** 保存编辑的收货地址信息 */
var sessionEditAddressInfoKey = "LOCALSTORAGE_EDITADDRESSINFO";
/** 保存编辑的小区信息 */
var sessionEditCommunityInfoKey = "LOCALSTORAGE_EDITCOMMUNITYINFO";
/** 保存用户选择的购物车地址信息 */
var sessionStorageAddressOfCartKey = "LOCALSTORAGE_ADDRESSOFCART";
/** 保存当前广告信息 */
var sessionStorageBannerInfoKey = "LOCALSTORAGE_BANNERINFOS";
/** 保存秒殺广告信息 */
var sessionStorageSecImgKey = "LOCALSTORAGE_SECIMG";
/** 保存多位置广告信息 */
var sessionStorageSeminarKey = "LOCALSTORAGE_SEMINAR";
/** 保存第三方登录时回退栈的信息 */
var sessionStorageReferrerKey = "LOCALSTORAGE_REFERRER";

/** 用户信息 */
var localStorageUserInfoKey = "LOCALSTORAGE_USERINFO";
/** 用户的登录Session信息 */
var localStorageSessionInfo = "LOCALSTORAGE_SESSIONINFO";
/** 用户购物车信息 */
var localStorageCartInfoKey = "LOCALSTORAGE_CARTINFO"
/** 小区搜索历史记录列表 */
var localStorageCommunityHistoryKey = "LOCALSTORAGE_COMMUNITY_HISTORY";
/** 商品搜索历史记录列表 */
var localStorageProductHistoryKey = "LOCALSTORAGE_PRODUCT_HISTORY";
/** 设备唯一标识码 */
var localStorageUUIDKey = "LOCALSTORAGE_DATA";
/** 二级分类和三级分类信息 */
var sessionStorageClassDataKey = "LOCALSTORAGE_CLASSDATA";
/** 商品详情信息 */
var sessionStorageProductDetailKey = "LOCALSTORAGE_PRODUCTDETAIL";
/** 商品搜索和品牌搜索关键字 */
var sessionStorageKeywordsKey = "LOCALSTORAGE_KEYWORDS";
/** 商品和品牌切换标识 */
var sessionStorageShowBrandKey = "LOCALSTORAGE_SHOWBRAND";
/** 首页图标 */
var sessionStorageAppiconsKey = "LOCALSTORAGE_APPICONS";

function setLocalStorage(key, value) {
	localStorage.setItem(key, JSON.stringify(value));
}
function getLocalStorage(key) {
	return eval('(' + localStorage.getItem(key) + ')');
}
function removeLocalStorage(key) {
	localStorage.removeItem(key);
}
function setSessionStorage(key, value) {
	sessionStorage.setItem(key, JSON.stringify(value));
}
function getSessionStorage(key) {
	return eval('(' + sessionStorage.getItem(key) + ')');
}
function removeSessionStorage(key) {
	sessionStorage.removeItem(key);
}
/** 系统本地存储信息 */
/** 保存小区信息 */
function saveCommunity(communityInfo) {
	setSessionStorage(sessionStorageCommunityKey, communityInfo);
	saveStore(communityInfo.storeInfo);
}
/** 保存店铺信息 */
function saveStore(storeInfo) {
	setSessionStorage(sessionStorageStoreKey, storeInfo);
}
/** 加入小区搜索历史记录 */
function addCommunityHisStorage(data) {
	if (!data) {
		return;
	}
	var arrayInfo = getLocalStorage(localStorageCommunityHistoryKey);
	if (!arrayInfo) {
		arrayInfo = new Array();
		arrayInfo.unshift(data);
	} else {
		for ( var index in arrayInfo) {
			if (arrayInfo[index].communityId == data.communityId) {
				arrayInfo.splice(index, 1);
				break;
			}
		}
		arrayInfo.unshift(data);
	}
	for (var i = arrayInfo.length; i > 10; i--) {
		arrayInfo.splice(i - 1, 1);
	}
	setLocalStorage(localStorageCommunityHistoryKey, arrayInfo);
}
/** 获取小区搜索历史记录 */
function getCommunityHisStorage() {
	return getLocalStorage(localStorageCommunityHistoryKey) || [];
}
/** 加入商品搜索历史记录 */
function addProductHisStorage(data) {
	if (!data) {
		return;
	}
	var arrayInfo = getLocalStorage(localStorageProductHistoryKey);
	if (!arrayInfo) {
		arrayInfo = new Array();
		arrayInfo.unshift(data);
	} else {
		for ( var index in arrayInfo) {
			if (arrayInfo[index] == data) {
				arrayInfo.splice(index, 1);
				break;
			}
		}
		arrayInfo.unshift(data);
	}
	for (var i = arrayInfo.length; i > 15; i--) {
		arrayInfo.splice(i - 1, 1);
	}
	setLocalStorage(localStorageProductHistoryKey, arrayInfo);
}
/** 获取商品搜索历史记录 */
function getProductHisStorage() {
	return getLocalStorage(localStorageProductHistoryKey) || [];
}
/** 本地用户信息获取方法 */
function isLogin() {
	return !isUserUnvalid();
}
function isUserUnbinding() {
	var userInfo = getSessionStorage(localStorageUserInfoKey);
	return !userInfo || userInfo.binding != 1;
}
function isUserUnvalid() {
	var userInfo = getSessionStorage(localStorageUserInfoKey);
	return !userInfo || !userInfo.userId;
}
/** 获取用户名称 */
function getUserName() {
	var userInfo = getSessionStorage(localStorageUserInfoKey);
	if (userInfo)
		return userInfo.userName;
	return "";
}
/** 保存用户信息 */
function saveUserInfo(userInfo) {
	setSessionStorage(localStorageUserInfoKey, userInfo);
	var userId = userInfo.userId;
	var sessionId = getCookie("YiLiDiSessionID");
	setSessionStorage(localStorageSessionInfo, userId + sessionId);
}
/** 获取用户Session信息 */
function getSessionId() {
	var sessionStr = getSessionStorage(localStorageSessionInfo);
	if (!sessionStr)
		return "";
	var userId = getSessionStorage(localStorageUserInfoKey).userId;
	var length = (userId + "").length;
	return sessionStr.substring(length, sessionStr.length);
}
function clearUserInfo() {
	removeSessionStorage(localStorageCartInfoKey);
	removeSessionStorage(localStorageUserInfoKey);
	removeSessionStorage(localStorageSessionInfo);
	removeSessionStorage(sessionStorageWXCodeKey);
}

/** 购物车相关方法 */
/** 加入购物车之前的校验，该方法加入到购物车成功以后会进行回调，回调到callback函数，其中回调包含了其他所有参数，可进行接下来的业务操作 */
function validCartToAdd(productInfo, callback, startLocation, doc) {
	var saleProductId = productInfo.saleProductId;
	var stockNum = productInfo.stockNum; // 库存
	var limitCount = productInfo.limitCount; // 限制数量
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	var cartNum = getCartNum(saleProductId); // 购物车数量
	var storeInfo = getSessionStorage(sessionStorageStoreKey);
	if (!storeInfo || storeInfo.storeStatus == 0) {
		alert("亲，该店铺已经暂停营业了\n已经无法购买商品了");
		return;
	}
	// 判断库存数量
	if (stockNum == 0 || cartNum >= stockNum) {
		alert("亲，该产品没有足够的库存了，店家正在积极备货当中，请耐心等待");
		return;
	}
	if (limitCount == 0) {
		alert("亲，该产品已经限制了购买，请查看您的购物车");
		return;
	}
	if (limitCount > 0 && cartNum >= limitCount) {
		alert("亲，该产品已经限制了购买" + limitCount + "件，请查看您的购物车");
		return;
	}
	if (is1FenProduct(saleProductId) && cartNum >= 1) {
		alert("亲，该产品已经限制了购买1件，请查看您的购物车");
		return;
	}
	if ((!isEmptyObj(cartInfo) && !existVIPInCart(cartInfo) && isVIPProduct(saleProductId))
			|| (!isEmptyObj(cartInfo) && existVIPInCart(cartInfo) && !isVIPProduct(saleProductId))) {
		if (confirm("VIP商品需要单独购买,不能与其它商品同时购买,是否继续购买？")) {
			removeSessionStorage(localStorageCartInfoKey);
			addCart(productInfo);
			if (typeof callback == "function")
				callback(productInfo, startLocation, doc);
		}
		return;
	}
	addCart(productInfo);
	if (typeof callback == "function")
		callback(productInfo, startLocation, doc);
}
/** 根据商品ID判断其是否是1分钱类型商品 */
function is1FenProduct(saleProductId) {
	if (!saleProductId)
		return false;
	var fenProducts = getSessionStorage(sessionStorageFenKey);
	if (!fenProducts)
		return false;
	return isIncludes(fenProducts, saleProductId);
}
/** 根据商品ID判断其是否是VIP类型商品 */
function isVIPProduct(saleProductId) {
	if (!saleProductId)
		return false;
	var vipProducts = getSessionStorage(sessionStorageVIPKey);
	if (!vipProducts)
		return false;
	return isIncludes(vipProducts, saleProductId);
}
function isIncludes(products, saleProductId) {
	if (!products)
		return false;
	for ( var index in products) {
		if (products[index].saleProductId == saleProductId)
			return true;
	}
	return false;
}
/** 购物车信息中是否存在VIP商品信息 */
function existVIPInCart(cartInfo) {
	if (!cartInfo)
		return false;
	var vipProducts = getSessionStorage(sessionStorageVIPKey);
	if (!vipProducts)
		return false;
	for ( var index in vipProducts) {
		var saleProductId = vipProducts[index].saleProductId;
		if (!cartInfo[saleProductId] || !cartInfo[saleProductId].saleProductId)
			continue;
		return true;
	}
	return false;
}
/** 加入商品到购物车的方法，数量为1 */
function addCart(productInfo) {
	var saleProductId = productInfo.saleProductId;
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	cartInfo = !cartInfo ? {} : cartInfo;
	if (!cartInfo[saleProductId] || !cartInfo[saleProductId].saleProductId) {
		productInfo.cartNum = 1;
		cartInfo[productInfo.saleProductId] = productInfo;
	} else {
		if (cartInfo[saleProductId].actId == productInfo.actId) {
			cartInfo[saleProductId].cartNum += 1;
		} else {
			_removeCart(productInfo.saleProductId);
			productInfo.cartNum = 1;
			cartInfo[productInfo.saleProductId] = productInfo;
		}
	}
	setSessionStorage(localStorageCartInfoKey, cartInfo);
	_adjustCart(saleProductId, 1);
}
/** 减掉商品到购物车的方法，数量为1 */
function reduceCart(saleProductId) {
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo || !cartInfo[saleProductId]
			|| !cartInfo[saleProductId].saleProductId) {
		return false;
	}
	cartInfo[saleProductId].cartNum -= 1;
	if (cartInfo[saleProductId].cartNum <= 0) {
		delete cartInfo[saleProductId];
	}
	setSessionStorage(localStorageCartInfoKey, cartInfo);
	_adjustCart(saleProductId, 0);
	return true;
}
function _adjustCart(saleProductId, type) {
	if (!isLogin())
		return;
	var param = new Object();
	param.saleProductId = saleProductId;
	param.type = type;
	param.storeId = getSessionStorage(sessionStorageStoreKey).storeId;
	ajax("/cart/adjustmentcartcount", param, function(data) {
		console.log(data);
	}, function(msg) {
		console.log(msg);
	});
}
/** 根据商品ID数组删除购物车该数组ID的商品信息 */
function removeCartByIdArray(saleProductIdArray) {
	var products = [];
	if (isArrayFunc(saleProductIdArray)) {
		products = saleProductIdArray;
		for ( var index in saleProductIdArray) {
			_removeCart(saleProductIdArray[index]);
		}
	} else {
		products.push(saleProductIdArray);
		_removeCart(saleProductIdArray);
	}
	var param = new Object();
	param.products = products;
	ajax("/cart/clearcart", param, function(data) {
		console.log(data);
	}, function(msg) {
		console.log(msg);
	});
	return true;
}
/** 从购物车中删除该商品ID信息 */
function _removeCart(saleProductId) {
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo || !cartInfo[saleProductId]
			|| !cartInfo[saleProductId].saleProductId) {
		return false;
	}
	delete cartInfo[saleProductId];
	setSessionStorage(localStorageCartInfoKey, cartInfo);
	return true;
}
/** 根据商品列表信息设置本地的购物车信息 */
function setCartInfo(productInfos) {
	var cartInfo = {};
	if (isArrayFunc(productInfos)) {
		for ( var index in productInfos) {
			var productInfo = productInfos[index];
			cartInfo[productInfo.saleProductId] = productInfo;
		}
	} else if (productInfos) {
		cartInfo[productInfos.saleProductId] = productInfos;
	}
	setSessionStorage(localStorageCartInfoKey, cartInfo);
}
/** 获取到购物车的所有数量 */
function getCartCount() {
	var count = 0;
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo) {
		return count;
	}
	for ( var index in cartInfo) {
		count += cartInfo[index].cartNum;
	}
	return count;
}
/** 根据选择的商品ID数组获取到购物车所选择的总数量 */
function getCartCountBySelected(saleProductIdArray) {
	var count = 0;
	for ( var index in saleProductIdArray) {
		count += getCartNum(saleProductIdArray[index]);
	}
	return count;
}
/** 获取该商品ID在购物车中的数量 */
function getCartNum(saleProductId) {
	var count = 0;
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo) {
		return count;
	}
	count = !cartInfo[saleProductId] ? 0 : cartInfo[saleProductId].cartNum;
	return count;
}
/** 根据商品ID数组信息获取到这些商品的总价格 */
function getCartPriceBySelected(saleProductIdArray) {
	var price = 0;
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo) {
		return price;
	}
	for ( var index in saleProductIdArray) {
		var product = cartInfo[saleProductIdArray[index]];
		price += !product ? 0 : product.orderPrice * product.cartNum;
	}
	return price;
}
/** 获取到购物车商品的总价格 */
function getCartPrice() {
	var price = 0;
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	if (!cartInfo) {
		return price;
	}
	for ( var index in cartInfo) {
		var product = cartInfo[index];
		price += !product ? 0 : product.orderPrice * product.cartNum;
	}
	return price;
}
/** 计算当前商品列表中的商品的购物车数量 */
function calculateProductCart(productInfoArray) {
	for ( var index in productInfoArray) {
		productInfoArray[index].cartNum = getCartNum(productInfoArray[index].saleProductId);
	}
}
/** 根据商品信息列表获取请求接口的购物车信息数据 */
function getCartParam(productInfoArray) {
	var cartInfoParam = [];
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	for ( var productId in cartInfo) {
		var cartParam = new Object();
		if (!productInfoArray) {
			cartParam.saleProductId = productId;
			cartParam.cartNum = cartInfo[productId].cartNum;
			cartParam.actId = cartInfo[productId].actId;
			cartInfoParam.push(cartParam);
		} else {
			for ( var index in productInfoArray) {
				if (productId == productInfoArray[index]) {
					cartParam.saleProductId = productId;
					cartParam.cartNum = cartInfo[productId].cartNum;
					cartParam.actId = cartInfo[productId].actId;
					cartInfoParam.push(cartParam);
				}
			}
		}
	}
	return cartInfoParam;
}
/** 根据所选择的小区进行切换店铺操作 */
function changeStoreByCommunity(community, callback) {
	var isEmptyStore = !community || !community.storeInfo;
	if (!getSessionStorage(sessionStorageCommunityKey)
			&& !getSessionStorage(sessionStorageTokeBySelfKey)) {
		saveCommunity(community);
		if (typeof callback == "function")
			callback();
		if (!isEmptyStore) {
			console.log("!isEmptyStore");
			zoneVIPProductList(community.storeInfo.storeId);
			zoneFenProductList(community.storeInfo.storeId);
		}
		return;
	}
	if (isSameCommunity(community) || isSameStoreByCommunity(community)) {
		saveCommunity(community);
		removeSessionStorage(sessionStorageTokeBySelfKey);
		if (typeof callback == "function")
			callback();
		return;
	}
	var isEmptyCart = getCartCount() <= 0;
	if (confirm(isEmptyStore ? (isEmptyCart ? "此区域暂无门店，我们正在加紧开通该区域的店铺，您是否还需要切换店铺？"
			: "此区域暂无门店，我们正在加紧开通该区域的店铺，店铺切换以后购物车数据会被清空，您是否还需要切换店铺？")
			: (isEmptyCart ? "此区域不在当前店铺配送范围，是否切换店铺？"
					: "此区域不在当前店铺配送范围，店铺切换以后购物车数据会被清空，是否切换店铺？"))) {
		if (!isEmptyCart)
			removeSessionStorage(localStorageCartInfoKey);
		saveCommunity(community);
		removeSessionStorage(sessionStorageTokeBySelfKey);
		if (typeof callback == "function")
			callback();
		if (!isEmptyStore) {
			zoneVIPProductList(community.storeInfo.storeId);
			zoneFenProductList(community.storeInfo.storeId);
		}
	}
}
/** 根据所选择的店铺进行切换店铺操作 */
function changeStore(store, callback) {
	if (!store)
		alert("系统发生异常，请刷新页面重试！");
	if (isSameStore(store)) {
		setSessionStorage(sessionStorageTokeBySelfKey, true);
		removeSessionStorage(sessionStorageCommunityKey);
		if (typeof callback == "function")
			callback();
		return;
	}
	if (confirm(getCartCount() > 0 ? "购买此店铺商品需要自提，同时购物车数据会被清空，是否切换店铺？"
			: "购买此店铺商品需要自提，是否切换店铺？")) {
		saveStore(store);
		if (getCartCount() > 0)
			removeSessionStorage(localStorageCartInfoKey);
		removeSessionStorage(sessionStorageCommunityKey);
		setSessionStorage(sessionStorageTokeBySelfKey, true);
		if (typeof callback == "function")
			callback();
		zoneVIPProductList(store.storeId);
		zoneFenProductList(store.storeId);
	}
}
/** 判断是否是同一店铺 */
function isSameStoreByCommunity(community) {
	if (!community)
		return false;
	var newStore = community.storeInfo;
	var oldStore = getSessionStorage(sessionStorageStoreKey);
	return newStore && oldStore && newStore.storeId == oldStore.storeId;
}
/** 判断是否是同一店铺 */
function isSameStore(store) {
	var oldStore = getSessionStorage(sessionStorageStoreKey);
	return store && oldStore && store.storeId == oldStore.storeId;
}
/** 判断是否是同一小区 */
function isSameCommunity(community) {
	var oldCommunity = getSessionStorage(sessionStorageCommunityKey);
	return community && oldCommunity
			&& community.communityId == oldCommunity.communityId;
}
/** 获取VIP专区商品列表 */
function zoneVIPProductList(storeId) {
	// var VIPProducts = getSessionStorage(sessionStorageVIPKey);
	// if (!VIPProducts) {
	var param = new Object();
	param.storeId = storeId;
	param.zoneType = 1;
	ajax("/product/zoneproduct", param, function(data) {
		if (!data)
			return;
		saveZoneProdudcts(sessionStorageVIPKey, data);
	}, function(msg) {
		console.log(msg);
	});
	// }
}
/** 获取1分钱专区商品列表 */
function zoneFenProductList(storeId) {
	// var fenProducts = getSessionStorage(sessionStorageFenKey);
	// if (!fenProducts) {
	var param = new Object();
	param.storeId = storeId;
	param.zoneType = 2;
	ajax("/product/zoneproduct", param, function(data) {
		if (!data)
			return;
		saveZoneProdudcts(sessionStorageFenKey, data);
	}, function(msg) {
		console.log(msg);
	});
	// }
}
function saveZoneProdudcts(key, products) {
	var zoneProducts = {};
	for ( var index in products) {
		var productInfo = products[index];
		zoneProducts[productInfo.barCode] = productInfo;
	}
	setSessionStorage(key, zoneProducts);
}
function getUID() {
	var uID = getLocalStorage(localStorageUUIDKey);
	if (!uID) {
		uID = generateUUID();
		setLocalStorage(localStorageUUIDKey, uID);
	}
	return uID;
}
function generateUUID() {
	var d = new Date().getTime();
	var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g,
			function(c) {
				var r = (d + Math.random() * 16) % 16 | 0;
				d = Math.floor(d / 16);
				return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
			});
	return uuid;
};
/** 返回到首页 */
function returnIndex() {
	window.location.href = '../index.html';
}

/** 工具相关函数 */
function isArrayFunc(o) {
	return Object.prototype.toString.call(o) === '[object Array]';
}
function isEmptyObj(e) {
	var t;
	for (t in e)
		return !1;
	return !0
}
function toCenti(num, len) {
	len = len || 2;
	if (num == null) {
		num = 0
	}
	if (isNaN(parseFloat(num)))
		return num;
	else
		return (num / 1000).toFixed(len);
}
function isWX() {
	var ua = navigator.userAgent.toLowerCase();
	return ua.match(/MicroMessenger/i) == "micromessenger";
}
// 校验手机号码
function checkMobile(str) {
	var re = /^1\d{10}$/g;
	if (!re.test(str)) {
		return false;
	}
	return true;
}
// 校验密码
function checkPassword(str) {
	var re = /^[a-zA-Z0-9]{6,16}$/;
	if (!re.test(str)) {
		return false;
	}
	return true;
}
// 校验特殊字符
function checkStr(str) {
	// str.replaceAll("[\ud800\udc00-\udbff\udfff\ud800-\udfff]"," ");//将表情替换成空格
	var re = /[@#\$%\^&\*￥……<>[]]+/g;
	return re.test(str);
}
// 校验昵称
function checkNickName(str) {
	var re = /^[\u4e00-\u9fa50-9a-zA-Z_\-]{4,20}$/;
	return re.test(str);
}
// 获取url参数
function getUrlParam(sName) {
	var sValue = '';
	var re = new RegExp("\\b" + sName + "\\b=([^&=]+)");
	var st = null;
	st = window.location.search.match(re);
	if (st && st.length == 2) {
		st[1] = st[1].replace(/^\s*|\s*$/g, '');
		sValue = st[1];
	}
	return sValue;
}
function getCookie(name) {
	var start = document.cookie.indexOf(name + "=");
	if (start == -1)
		return null;
	var len = start + name.length + 1;
	var end = document.cookie.indexOf(';', len);
	if (end == -1)
		end = document.cookie.length;
	return decodeURIComponent(document.cookie.substring(len, end));
}
function setCookie(name, value, expires) {
	if (expires) {
		expires = expires * 1000 * 60 * 60 * 24;
		var today = new Date();
		expires = new Date(today.getTime() + (expires));
		expires = 'expires=' + expires.toGMTString();
	} else
		expires = '';
	value = encodeURIComponent(value);
	document.cookie = name + '=' + value + ';path=/;' + expires;
}
function locationHref(url) {
	if (!url)
		return;
	var version = "?d=";
	if (url.indexOf("?") > -1) {
		version = "&d=";
	}
	window.location.href = url + version + new Date().getTime();
}