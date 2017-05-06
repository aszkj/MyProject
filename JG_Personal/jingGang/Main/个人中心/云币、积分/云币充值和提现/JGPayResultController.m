//
//  JGPayResultController.m
//  jingGang
//
//  Created by dengxf on 16/1/7.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGPayResultController.h"
#import "GlobeObject.h"
#import "CloudBuyerCashSaveResponse.h"

typedef NS_ENUM(NSUInteger, SuccessInterfaceType) {
    PaySuccessInterfaceType = 0,  // 充值成功
    CashSuccessInterfaceType      // 提现成功
};

@interface JGPayResultController ()

@property (strong,nonatomic) id response;

/**
 *  充值、提现成功界面类型 */
@property (assign, nonatomic) SuccessInterfaceType successType;

@end

@implementation JGPayResultController

- (instancetype)initWithResposeObj:(id)response {
    if (self = [super init]) {
        // 提现成功 CloudBuyerCashSaveResponse class
        self.response = response;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化界面
    [self setupContentInterface];
}

- (SuccessInterfaceType)successType {
    if ([self.response isKindOfClass:[CloudBuyerCashSaveResponse class]]) {
        return CashSuccessInterfaceType;
    }else if([self.response isKindOfClass:[CloudBuyerStatusResponse class]]) {
        return PaySuccessInterfaceType;
    }
    return 0;
}


- (void)setupContentInterface {
    // 添加返回键
    //    [self setupNavBarPopButton];
    self.view.backgroundColor = JGColor(245, 245, 245, 1);
    [self hiddenNavBarPopButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat imageWidth = 194 / 2;
    CGFloat imageHeight  = imageWidth;
    UIImageView *succImage = [[UIImageView alloc] init];
    succImage.x = (ScreenWidth - imageWidth) / 2;
    succImage.y = 90.0 / 2 ;
    succImage.width = imageWidth;
    succImage.height = imageHeight;
    [self.view addSubview:succImage];
    
    UILabel *textLab = [[UILabel alloc] init];
    textLab.x = 0 ;
    textLab.y = CGRectGetMaxY(succImage.frame) + 5;
    textLab.width = ScreenWidth;
    textLab.height = 30;
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.backgroundColor = [UIColor clearColor];
    textLab.font = JGFont(22);
    [self.view addSubview:textLab];
    
    // 内容容器
    UIView *contentView = [[UIView alloc] init];
    contentView.x = -10;
    contentView.y = CGRectGetMaxY(textLab.frame) + 15;
    contentView.width = ScreenWidth + fabs(contentView.x);
    contentView.height = 60;
    [self.view addSubview:contentView];
    contentView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.23].CGColor;
    contentView.layer.borderWidth = 0.5;
    contentView.backgroundColor = [UIColor whiteColor];
    
    NSString *actionType = [[NSString alloc] init]; //  银行卡 、支付宝、 微信支付、银行卡支付
    NSString *actionInfo = [[NSString alloc] init]; // 充值为时间信息 提现是提现账号信息
    NSString *actionIndentifier = [[NSString alloc] init];  //  充值金额、提现金额
    NSString *actionAmount = [[NSString alloc] init];
    
    switch (self.successType) {
        case CashSuccessInterfaceType:
        {
            // 提现界面初始化
            [self setupNavBarTitleViewWithText:@"提现详情"];
            succImage.image = [UIImage imageNamed:@"jg_cashDetail"];
            [textLab setText:@"提现申请已提交"];
            actionIndentifier = @"提现金额";
            
            CloudBuyerCashSaveResponse *response = (CloudBuyerCashSaveResponse *)self.response;
            actionAmount = TNSString(response.pdAmount);
            if ([response.paymetType isEqualToString:@"chinabank"]) {
                // 银行卡提现
                actionType  = @"银行卡";
                actionInfo = response.cashBank;
                NSString *endNumber = [self intercepteBankCardNumberOfFourTail:response.cashAccount];
                if (endNumber) {
                    actionInfo = [actionInfo stringByAppendingString:[NSString stringWithFormat:@" %@",endNumber]];
                }
            }else {
                // 支付宝提现
                actionType = @"支付宝";
                actionInfo = response.cashAccount;
            }

        }
            break;
        case PaySuccessInterfaceType:
        {
            // 充值界面初始化
            [self setupNavBarTitleViewWithText:@"充值详情"];
            succImage.image = [UIImage imageNamed:@"jg_paysuccess"];
            [textLab setText:@"充值成功"];
            actionIndentifier = @"充值金额";
            
            CloudBuyerStatusResponse *response = (CloudBuyerStatusResponse *)self.response;
            if ([response.paymetType isEqualToString:@"wx_app"]) {
                // 微信支付
                actionType = @"微信支付";
            }else {
                // 支付宝支付
                actionType = @"支付宝支付";
            }
            actionInfo = TNSString(response.addTime);
            actionAmount = TNSString(response.pdAmount);
        }
            break;
        default:
            break;
    }


    UILabel *payTypeLab = [self createLabWithFrame:CGRectMake(fabs(contentView.x) + 10, 9, 100, 21) backgroundColor:[UIColor clearColor] text:actionType font:JGFont(13) textColor:JGColor(177, 177, 177, 1) alignment:NSTextAlignmentLeft];
    [contentView addSubview:payTypeLab];
    
    UILabel *payTimeLab = [self createLabWithFrame:CGRectMake(CGRectGetMaxX(payTypeLab.frame), 9, contentView.width - CGRectGetMaxX(payTypeLab.frame) - fabs(contentView.x) * 2, 21) backgroundColor:[UIColor clearColor] text:actionInfo font:JGFont(13) textColor:JGColor(177, 177, 177, 1) alignment:NSTextAlignmentRight];
    [contentView addSubview:payTimeLab];
    
    // labY坐标空隙
    CGFloat labMarginY = 6;
    
    UILabel *payValueTextLab = [self createLabWithFrame:CGRectMake(payTypeLab.x, CGRectGetMaxY(payTypeLab.frame) + labMarginY, payTypeLab.width, payTypeLab.height) backgroundColor:[UIColor clearColor] text:actionIndentifier font:JGFont(13) textColor:JGColor(177, 177, 177, 1) alignment:NSTextAlignmentLeft];
    [contentView addSubview:payValueTextLab];
    
    UILabel *payValueLab = [self createLabWithFrame:CGRectMake(payTimeLab.x, CGRectGetMaxY(payTimeLab.frame) + labMarginY, payTimeLab.width, payTimeLab.height) backgroundColor:[UIColor clearColor] text:[NSString stringWithFormat:@"￥%.2f",[actionAmount floatValue]] font:JGFont(13) textColor:JGColor(83, 83, 83, 1) alignment:NSTextAlignmentRight];
    [contentView addSubview:payValueLab];
    
    UIButton *completeButton = [[UIButton alloc] init];
    completeButton.x = 15;
    completeButton.y = CGRectGetMaxY(contentView.frame) + 15;
    completeButton.width = ScreenWidth - 2 * completeButton.x;
    completeButton.height = 40;
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTintColor:[UIColor whiteColor]];
    [completeButton setBackgroundColor:status_color];
    [completeButton addTarget:self action:@selector(completedAction:) forControlEvents:UIControlEventTouchUpInside];
    completeButton.layer.cornerRadius = 4;
    [self.view addSubview:completeButton];
}

- (void)completedAction:(UIButton *)btn {
    JGLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**
 *  截取银行卡号尾数四位 */
- (NSString *)intercepteBankCardNumberOfFourTail:(NSString *)text{
    NSUInteger length = text.length;
    if (length <4) {
        return nil;
    }else {
        NSRange range = NSMakeRange(length - 4, 4);
        NSString *subString = [text substringWithRange:range];
        subString = [NSString stringWithFormat:@"尾号 %@",subString];
        return subString;
    }
}

@end
