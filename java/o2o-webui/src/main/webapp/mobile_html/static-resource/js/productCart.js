function getClass(item) {
	return item % 2 == 0 ? "floor-pro-iteml" : "";
}
function getShowClass(saleProductId) {
	var cartInfo = getSessionStorage(localStorageCartInfoKey);
	return !cartInfo || !cartInfo[saleProductId] ? "hide" : "show";
}
/** 操作加减产品数量相关方法 */
function getBtnClass(saleProductId, stockNum, limitCount) {
	var num = getCartNum(saleProductId);
	limitCount = limitCount || -1;
	if (num >= stockNum) {
		return "addNo";
	}
	if (limitCount != -1 && num >= limitCount) {
		return "addNo";
	}
	return "";
}
function reduceOperation(doc, productInfo) {
	var reduceFlag = reduceCart(productInfo.saleProductId);
	flushCartNumByReduce(doc, getCartNum(productInfo.saleProductId));
	$(doc).next().next().removeClass("addNo").addClass(
			getBtnClass(productInfo.saleProductId, productInfo.stockNum,
					productInfo.limitCount));
	return reduceFlag;
}

function flushCartNumByReduce(doc, currentCartNum) {
	var removeTag = currentCartNum <= 0 ? "show" : "hide";
	var addTag = currentCartNum <= 0 ? "hide" : "show";
	$(doc).next().removeClass(removeTag).addClass(addTag);
	$(doc).removeClass(removeTag).addClass(addTag);
	$(doc).next().val(currentCartNum);
}

function addOperation(doc, productInfo) {
	$(doc).removeClass("addNo").addClass(
			getBtnClass(productInfo.saleProductId, productInfo.stockNum,
					productInfo.limitCount));
	flushCartNumByReduce($(doc).prev().prev(),
			getCartNum(productInfo.saleProductId));
}
function getSecBtnClass(saleProductId, stockNum, limitCount) {
	var num = getCartNum(saleProductId);
	limitCount = limitCount || -1;
	if (num >= stockNum) {
		return "secNoPro";
	}
	if (limitCount != -1 && num >= limitCount) {
		return "secNoPro";
	}
	return "";
}
function addOperationInSecKill(doc, productInfo) {
	$(doc).addClass(
		getSecBtnClass(productInfo.saleProductId, productInfo.stockNum,
			productInfo.limitCount));
	flushCartNumByReduce($(doc).prev().prev(),
		getCartNum(productInfo.saleProductId));
}

function showCartNum() {
	var totalCount = getCartCount();
	if (totalCount > 0) {
		$("#cartProNumber").val(totalCount);
		$("#cartProNumber").show();
	} else {
		$("#cartProNumber").hide();
	}
	if (totalCount > 99) {
		$("#cartProNumber").val("99+");
		$("#cartProNumber").show();
		$("#cartProNumber").css("font-size",".12rem");
	}
}
function getReduceToCart(doc, productInfo) {
	if (reduceOperation(doc, productInfo)) {
		showCartNum();
	}
}