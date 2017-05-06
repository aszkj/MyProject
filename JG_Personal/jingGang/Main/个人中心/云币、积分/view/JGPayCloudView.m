//
//  JGPayCloudView.m
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGPayCloudView.h"
#import "JGCloudAndValueManager.h"
#import "WXPayRequestModel.h"
#import "WXApi.h"
#import "GlobeObject.h"
#import "AppDelegate.h"
#import "UIAlertView+Extension.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WSProgressHUD.h"
#import "KJShoppingAlertView.h"

#define ImageEdgeInsetsTop  (-(ScreenWidth / 2) - 108)

typedef void(^PayResultBlock)(BOOL payResult,id response);

@interface JGPayCloudView ()

@property (copy , nonatomic) PayResultBlock payResultBlock;

@property (weak, nonatomic) IBOutlet UITextField *payValueTextField;

@property (strong,nonatomic) UINavigationController *superController;

@property (strong,nonatomic) KJOrderStatusQuery *orderStatusQuery;//订单状态查询类

@end

@implementation JGPayCloudView

- (instancetype)initWithPaySuccess:(void (^)(BOOL, id))succ superController:(UINavigationController *)superController
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.payResultBlock = succ;
        self.superController = superController;
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.wxPayButton setImage:[[UIImage imageNamed:@"jg_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.wxPayButton setImage:[[UIImage imageNamed:@"jg_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    self.wxPayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,ImageEdgeInsetsTop);
    self.wxPayButton.selected = YES;
    
    [self.alPayButton setImage:[[UIImage imageNamed:@"jg_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.alPayButton setImage:[[UIImage imageNamed:@"jg_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    self.alPayButton.imageEdgeInsets = self.wxPayButton.imageEdgeInsets;
    
}

- (IBAction)selectedWXPayAction:(UIButton *)sender {
    // 选中状态取反
    self.wxPayButton.selected = !self.wxPayButton.selected;
    self.alPayButton.selected = NO;
    [self endEditing:YES];
}

- (IBAction)selectedALiPayAction:(UIButton *)sender {
    // 选中状态取反
    self.alPayButton.selected = !self.alPayButton.selected;
    self.wxPayButton.selected = NO;
    [self endEditing:YES];
}

- (IBAction)payNextAction:(UIButton *)sender {
    
    [self endEditing:YES];
    if (self.payValueTextField.text.length <= 0 ) {
        // 字符串为空
        JGLog(@"-------------------------------");
        JGLog(@"未输入金额");
        JGLog(@"-------------------------------");
        [UIAlertView xf_showWithTitle:@"请输入充值金额" message:nil delay:1.5 onDismiss:^{
        }];
        return;
    }
    
    if (!self.wxPayButton.isSelected && !self.alPayButton.isSelected ) {
        // 没选中支付方式
        JGLog(@"-------------------------------");
        JGLog(@"未选择支付方式");
        JGLog(@"-------------------------------");
        [UIAlertView xf_showWithTitle:@"请选择支付方式" message:nil delay:1.5 onDismiss:^{
        }];

        return;
    }
    if (self.wxPayButton.isSelected) {
        // 选择微信支付
        WeakSelf;
//        BLOCK_EXEC(self.payResultBlock,PayValueWithWXType,payValue);
        [JGCloudAndValueManager payCloudValueWithAmount:self.payValueTextField.text andPayType:JGPayCloudValueWithWXType success:^(CloudBuyerPaymetResponse *response) {
            AppDelegate *appDelegat = kAppDelegate;
            appDelegat.payCommepletedTransitionNav = self.superController;
            appDelegat.orderID = response.predepositId;
            appDelegat.jingGangPay = ClouldPay;
            [bself _wxPayWithParamDic:(NSDictionary *)response.weiXinPaymet];
        } error:^(NSError *error) {
            [UIAlertView xf_showWithTitle:error.domain message:nil delay:0.5 onDismiss:^{
                
            }];
        }];
    }else if (self.alPayButton.isSelected) {
        WeakSelf;
        [JGCloudAndValueManager payCloudValueWithAmount:self.payValueTextField.text andPayType:JGPayCloudValueWithAliType success:^(CloudBuyerPaymetResponse *response) {
            JGLog(@"res:%@",response);
            self.orderStatusQuery = [[KJOrderStatusQuery alloc] initWithQueryOrderID:response.predepositId];
            [bself _alipayTestWithSignedStr:response.paySignature];
        } error:^(NSError *error) {
            
            [UIAlertView xf_showWithTitle:error.domain message:nil delay:0.75 onDismiss:^{
                
            }];
            JGLog(@"error:%@",error);
            
        }];
//        BLOCK_EXEC(self.payResultBlock,PayValueWithAliType,payValue);
    }
}

#pragma mark - 支付宝支付
-(void)_alipayTestWithSignedStr:(NSString *)signedStr{
    [[AlipaySDK defaultService] payOrder:signedStr fromScheme:@"jingGangAlipay" callback:^(NSDictionary *resultDic) {
        NSLog(@"支付宝 reslut = %@",resultDic);
        NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
        if (resultStatus == 9000) {//支付宝支付成功查询服务器
            //查询服务器订单状态
            [WSProgressHUD showShimmeringString:@"正在查询订单状态.." maskType:WSProgressHUDMaskTypeBlack];
            //开启订单查询
            WeakSelf;
            [self.orderStatusQuery beginRollingQueryCloudPayResultIntervalTime:2.0 rollingResult:^(BOOL success, id response) {
                [bself queryDealResult:success response:response];
            }];
            
        }else{//支付宝支付失败
            NSString *alertErrorStr = @"支付失败";
            switch (resultStatus) {
                case 8000:
                    alertErrorStr = @"支付宝订单正在处理中";
                    break;
                case 4000:
                    alertErrorStr = @"订单支付失败";
                    break;
                case 6002:
                    alertErrorStr = @"网络连接出错，支付失败";
                    break;
                case 6001:
                    alertErrorStr = @"支付中途取消";
                    break;
                default:
                    break;
            }
            if (resultStatus != 6001 ) {//取消
                [Util ShowAlertWithOnlyMessage:alertErrorStr];
//                [self performSelector:@selector(_commintoOrderDetail) withObject:nil afterDelay:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    BLOCK_EXEC(self.payResultBlock,NO,nil);
                });
            }else {
                [UIAlertView xf_showWithTitle:alertErrorStr message:nil delay:2 onDismiss:^{
                    
                }];
            }
        }
    }];
}

#pragma mark ---查询订单状况--
- (void)queryDealResult:(BOOL)success response:(id)response {
    if (success) {
        [WSProgressHUD dismiss];
        [KJShoppingAlertView showAlertTitle:@"支付成功" inContentView:self];
        BLOCK_EXEC(self.payResultBlock,success,response);
    }
}

#pragma mark - 微信支付
-(void)_wxPayWithParamDic:(NSDictionary *)requestDic{
    WXPayRequestModel *model = [[WXPayRequestModel alloc] initWithJSONDic:requestDic];
    //发起微信支付，设置参数
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = model.partnerid;
    request.prepayId = model.prepayid;
    request.package = model.package1;
    request.nonceStr = model.noncestr;
    request.timeStamp = (UInt32)model.timestamp.longLongValue;
    request.sign = model.sign;
    
    //调用微信
    [WXApi sendReq:request];
}
@end
