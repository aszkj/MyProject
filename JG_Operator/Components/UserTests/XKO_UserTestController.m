//
//  XKO_UserTestController.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/30.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_UserTestController.h"
#import "XKO_TakeMoneyResponseInfo.h"
#import "XKO_BaseInfoResponseInfo.h"
#import "XKO_MembersManagerResponseInfo.h"
#import "XKO_TakeDetailResponseInfo.h"
#import "XKO_EarningDetailResponseInfo.h"
#import "XKO_OperatorInvitationCodeResponseInfo.h"


#define      KOperatorInfoMethordName      @"OperatorInfoMethordName"
#define      KOperatorMemberListMethordName @"OperatorMemberListMethordName"
#define      KOperatorMoneyCashMethordName      @"OperatorMoneyCashMethordName"
#define      KOperatorCashmoneyDetailsMethordName      @"OperatorCashmoneyDetailsMethordName"
#define      KOperatorProfitListMethordName      @"OperatorProfitListMethordName"
#define      KOperatorInvitationCodeMethordName      @"OperatorInvitationCodeMethordName"

#define      KButtonWidth       150
#define      KButtonHeight      40

@interface XKO_UserTestController ()

@end

@implementation XKO_UserTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *backView = [self createUIViewWithBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backView];
    
    UIButton *btn1 = [self createUIButtonWithFrame:CGRectMake(10, 0, KButtonWidth, KButtonHeight) title:@"营运商基本信息" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorInfoFromModel) target:self];
    
    [backView addSubview:btn1];
    
    UIButton *btn2 = [self createUIButtonWithFrame:CGRectMake(10, 50, KButtonWidth, KButtonHeight) title:@"营运商隶属会员" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorMemberListFromModel) target:self];
    [backView addSubview:btn2];
    
    UIButton *btn3 = [self createUIButtonWithFrame:CGRectMake(10, 100, KButtonWidth, KButtonHeight) title:@"营运商提现" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorMoneyCashFromModel) target:self];
    [backView addSubview:btn3];
    
    UIButton *btn4 = [self createUIButtonWithFrame:CGRectMake(10, 150, KButtonWidth, KButtonHeight) title:@"营运商提现明细" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorCashmoneyDetailsFromModel) target:self];
    [backView addSubview:btn4];
    
    UIButton *btn5 = [self createUIButtonWithFrame:CGRectMake(10, 200, KButtonWidth, KButtonHeight) title:@"营运商收益明细" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorProfitListFromModel) target:self];
    [backView addSubview:btn5];
    
    UIButton *btn6 = [self createUIButtonWithFrame:CGRectMake(10, 250, KButtonWidth, KButtonHeight) title:@"营运商邀请码" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(requestOperatorInvitationCodeFromModel) target:self];
    [backView addSubview:btn6];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@300);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methord
#pragma mark - 接口请求

/**
 *  营运商基本信息(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInfoFromModel {
    
    XKO_BaseInfoRequestInfo *requestModel = [[XKO_BaseInfoRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorInfoMethordName;
    
    [self.dataCenter requestOperatorInfoFromModel:requestModel];
}

/**
 *  营运商隶属会员(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorMemberListFromModel {
    
    XKO_MembersManagerRequestInfo *requestModel = [[XKO_MembersManagerRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorMemberListMethordName;
    requestModel.api_pageNum = @1;
    requestModel.api_pageSize = @5;
    
    [self.dataCenter requestOperatorMemberListFromModel:requestModel];
}

/**
 *  营运商提现(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorMoneyCashFromModel {
    
    XKO_TakeMoneyRequestInfo *requestModel = [[XKO_TakeMoneyRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorMoneyCashMethordName;
    requestModel.api_money = @1;
    requestModel.api_password = @"123456";
    
    [self.dataCenter requestOperatorMoneyCashFromModel:requestModel];
}

/**
 *  营运商提现明细(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorCashmoneyDetailsFromModel {
    
    XKO_TakeDetailRequestInfo *requestModel = [[XKO_TakeDetailRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorCashmoneyDetailsMethordName;
    requestModel.api_pageNum = @1;
    requestModel.api_pageSize = @5;
    
    [self.dataCenter requestOperatorCashmoneyDetailsFromModel:requestModel];
}

/**
 *  营运商收益明细(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorProfitListFromModel {
    
    XKO_EarningDetailRequestInfo *requestModel = [[XKO_EarningDetailRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorProfitListMethordName;
    requestModel.api_pageNum = @1;
    requestModel.api_pageSize = @5;
    
    [self.dataCenter requestOperatorProfitListFromModel:requestModel];
}

/**
 *  营运商邀请码(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInvitationCodeFromModel {
    
    XKO_OperatorInvitationCodeRequestInfo *requestModel = [[XKO_OperatorInvitationCodeRequestInfo alloc] init];
    requestModel.requestMethordName = KOperatorInvitationCodeMethordName;
    
    [self.dataCenter requestOperatorInvitationCodeFromModel:requestModel];
}

#pragma mark - DataCenterDelegate

// 读取数据成功
- (void)loadingFinishedWithDataArray:(NSArray *)dataArray methordName:(NSString *)methordName {
    
    NSLog(@"%@",dataArray);
    
    if ([methordName isEqualToString:KOperatorInfoMethordName]) {
        
        
    } else if ([methordName isEqualToString:KOperatorMemberListMethordName]) {
        
        
    } else if ([methordName isEqualToString:KOperatorMoneyCashMethordName]) {
        
        XKO_TakeMoneyResponseInfo *info = [[XKO_TakeMoneyResponseInfo alloc] init];
        if (info.isSuccessed) {
            [Util ShowAlertWithOnlyMessage:@"提现成功!"];
        } else {
            [Util ShowAlertWithOnlyMessage:@"提现失败!"];
        }

    } else if ([methordName isEqualToString:KOperatorCashmoneyDetailsMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorProfitListMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorInvitationCodeMethordName]) {
        
        XKO_OperatorInvitationCodeResponseInfo * responseInfo = (XKO_OperatorInvitationCodeResponseInfo *)dataArray[0];
        
        [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"运营商邀请码:%@",responseInfo.invitationCode]];
    }
}

// 读取数据失败
- (void)loadingFailedWithErrorString:(NSError *)error methordName:(NSString *)methordName {

    if ([methordName isEqualToString:KOperatorInfoMethordName]) {
        
        
    } else if ([methordName isEqualToString:KOperatorMemberListMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorMoneyCashMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorCashmoneyDetailsMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorProfitListMethordName]) {
        
    } else if ([methordName isEqualToString:KOperatorInvitationCodeMethordName]) {
        
    }
    
    [Util ShowAlertWithOnlyMessage:error.localizedDescription];
}


@end
