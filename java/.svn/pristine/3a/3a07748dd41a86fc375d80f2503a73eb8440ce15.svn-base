/**
 * Created by simpson on 15/12/21.
 */

function addAppCar(){
    $(document).off('click','#buy_cart_add').on('click','#buy_cart_add',function(){
        var that = this;
        var leftPos=$(this).offset().left;
        var topPos=$(this).offset().top;
        var scrollTopPos=$(document).scrollTop();
        var shopSelId=$(this).attr('val');
        var limitCount=$(this).attr('limit-count');
        alert(shopSelId);
        var operNum=1;
        var params = [shopSelId, operNum, limitCount, leftPos+$(this).width()/2, topPos-scrollTopPos];
        cordova.exec(function(result){
            if(result){
                var cartInput=$(that).siblings('#buy_cart_input');
                if (cartInput.length > 0) {
                    $(that).parent('.buy_num').find('em').addClass('hide');
                    $(that).siblings('#buy_cart_remove,#buy_cart_input').removeClass('hide');
                    $(that).parents('li').find('.s-price').removeClass('hide');
                    cartInput.val(Number(cartInput.val()) + operNum);
                }
                if ($(that).attr('limit-count') == 1) {
                    $(that).hide();
                }
            }
        }, null, "AddCartPlugin", "addCart", params);
    });
}

function minusAppCar(){
    $(document).off('click','#buy_cart_remove').on('click','#buy_cart_remove',function(){
        var that = this;
        var shopSelId=$(this).attr('val');
        alert(shopSelId);
        var operNum=1;
        var params = [shopSelId, operNum];
        cordova.exec(function(result){
            if(result){
                var cartInput=$(that).siblings('#buy_cart_input');
                if (cartInput.length > 0) {
                    cartInput.val(Number(cartInput.val()) - operNum);
                    if (cartInput.val() <= 0) {
                        $(that).parent('.buy_num').find('em').removeClass('hide');
                        cartInput.addClass('hide');
                        $(that).addClass('hide');
                        if ($(that).attr('isdouble')!='yes') {
                            $(that).parents('li').find('.s-price').addClass('hide');
                        }
                        if ($(that).attr('limit-count') == 1) {
                            $(that).siblings('#buy_cart_add').show();
                        }
                    }
                }
            }
        }, null, "AddCartPlugin", "removeCart", params);
    });
}

function clearAppLoading(){
    cordova.exec(null, null, "ParamPlugin", "cancelLoading", []);
}
