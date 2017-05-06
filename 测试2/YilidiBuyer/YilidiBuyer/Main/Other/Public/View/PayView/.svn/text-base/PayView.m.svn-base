//
//  PayView.m
//  YilidiBuyer
//
//  Created by yld on 16/7/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "PayView.h"
#import "PayRequestModel.h"
#import "ZFActionSheet.h"
#import "PayManager.h"
#import "PayManager+requestPayNeedInfo.h"

@interface PayView()

@property (nonatomic, strong)PayRequestModel *payRequestModel;
@property (nonatomic, strong)PayResponseBlock payResponseBlock;
@property (nonatomic, strong)PayManager *payManager;

@end

@implementation PayView

- (void)showPayViewWithRequestModel:(PayRequestModel *)payRequestModel
                      responseBlock:(PayResponseBlock)payResponseBlock
{
    self.hidden = NO;
    self.payRequestModel = payRequestModel;
    self.payResponseBlock = payResponseBlock;
    [self _showPayWayView];
}

- (void)_showPayWayView {
    WEAK_SELF
    ZFActionSheet *actionSheet = [ZFActionSheet actionSheetWithTitle:@"请选择支付方式" confirms:@[@"支付宝支付",@"微信支付"] cancel:@"取消" style:ZFActionSheetStyleCancel];
    actionSheet.sheetBlock = ^(NSUInteger index){
        [weak_self hidePayView];
        if (index==0) {
            [self _requestAlipay];
        }else{
            [self _requestWXpay];
        }
    };
    actionSheet.hideSheeBlock = ^{
        [weak_self hidePayView];
    };
    
    [actionSheet showInView:self];
}

- (void)hidePayView {
    [self performSelector:@selector(setPayViewHidden) withObject:nil afterDelay:0.4];
}

- (void)setPayViewHidden {
    self.hidden = YES;
}

- (void)_requestAlipay{
    WEAK_SELF
    [self.payManager requestAliPayInfoWithPayRequestModel:self.payRequestModel payRequesBack:^(NSDictionary *dic, NSError *error) {
        if (error.code == 1) {
            NSString *alipaySignStr = dic[EntityKey];
            if (isEmpty(alipaySignStr)) {
                [Util ShowAlertWithOnlyMessage:@"获取支付宝支付信息失败"];
                return ;
            }
            
            [weak_self.payManager startAlipayWithPaySignature:alipaySignStr responseBlock:^(AliPayResponseModel *payResponseModel) {
                emptyBlock(weak_self.payResponseBlock,weak_self.payRequestModel,payResponseModel,nil);
            }];
        }else {
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        }
    }];
}

- (void)_requestWXpay{
    WEAK_SELF
    [self.payManager requestWxPayInfoWithPayRequestModel:self.payRequestModel payRequesBack:^(NSDictionary *dic, NSError *error) {
        if (error.code == 1) {
            NSDictionary *winXinPayDic = dic[EntityKey];
            if (isEmpty(winXinPayDic)) {
                [Util ShowAlertWithOnlyMessage:@"获取微信支付信息失败"];
                return ;
            }
            WXPayRequestModel *wxPayRequestModel = [[WXPayRequestModel alloc] initWithDefaultDataDic:winXinPayDic];
            [weak_self.payManager startWXinpayWithWxinPreparePayModel:wxPayRequestModel responseBlock:^(WXinPayResponseModel *payResponseModel) {
                emptyBlock(weak_self.payResponseBlock,weak_self.payRequestModel,payResponseModel,nil);
            }];
        }else {
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        }
    }];
}

- (PayManager *)payManager {
    if (!_payManager) {
        _payManager = [PayManager sharedInstance];
    }
    return _payManager;
}



@end
