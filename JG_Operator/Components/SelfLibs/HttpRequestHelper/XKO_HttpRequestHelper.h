//
//  XKO_HttpRequestHelper.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class XKO_TakeMoneyRequestInfo;
//@class XKO_BaseInfoRequestInfo;
//@class XKO_MembersManagerRequestInfo;
//@class XKO_TakeDetailRequestInfo;
//@class XKO_EarningDetailRequestInfo;
//@class XKO_OperatorInvitationCodeRequestInfo;

#import "XKO_TakeMoneyRequestInfo.h"
#import "XKO_BaseInfoRequestInfo.h"
#import "XKO_MembersManagerRequestInfo.h"
#import "XKO_TakeDetailRequestInfo.h"
#import "XKO_EarningDetailRequestInfo.h"
#import "XKO_OperatorInvitationCodeRequestInfo.h"

typedef void(^DataCenterBlock)(NSArray *responseData);
typedef void(^FailDataCenterBlock)(NSError *error);

//typedef NS_ENUM(NSInteger, HttpErrorCode) {
//    InvalidTokenErrorCode = 2
//};

@protocol DataCenterDelegate;

@interface XKO_HttpRequestHelper : NSObject

@property (nonatomic, copy) DataCenterBlock finishBlk;
@property (nonatomic, copy) FailDataCenterBlock failBlk;
@property (nonatomic, weak) id <DataCenterDelegate> delegate;


/**
 *  取消请求
 */
- (void)cancelRequest;

/**
 *  营运商基本信息(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInfoFromModel:(XKO_BaseInfoRequestInfo *)requestModel;

/**
 *  营运商基本信息(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorInfoFromModel:(XKO_BaseInfoRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商隶属会员(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorMemberListFromModel:(XKO_MembersManagerRequestInfo *)requestModel;

/**
 *  营运商隶属会员(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorMemberListFromModel:(XKO_MembersManagerRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商提现(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorMoneyCashFromModel:(XKO_TakeMoneyRequestInfo *)requestModel;

/**
 *  营运商提现(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorMoneyCashFromModel:(XKO_TakeMoneyRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商提现明细(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorCashmoneyDetailsFromModel:(XKO_TakeDetailRequestInfo *)requestModel;

/**
 *  营运商预期收益(从服务器读取数据(block方式)) OperatorExpectProfitListResponse
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block  OperatorExpectProfitListResponse
 *  @param failBlk      失败block
 */
- (void)requestOperatorExpectProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商提现明细(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorCashmoneyDetailsFromModel:(XKO_TakeDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商收益明细(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel;

/**
 *  营运商收益明细(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商预期收益(从服务器读取数据(block方式)) OperatorExpectProfitListResponse
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block  OperatorExpectProfitListResponse
 *  @param failBlk      失败block
 */
- (void)requestOperatorExpectProfitListFromModel:(XKO_EarningDetailRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

/**
 *  营运商邀请码(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInvitationCodeFromModel:(XKO_OperatorInvitationCodeRequestInfo *)requestModel;

/**
 *  营运商邀请码(从服务器读取数据(block方式))
 *
 *  @param requestModel 请求信息
 *  @param finishBlk    成功block
 *  @param failBlk      失败block
 */
- (void)requestOperatorInvitationCodeFromModel:(XKO_OperatorInvitationCodeRequestInfo *)requestModel successBlk:(DataCenterBlock)finishBlk failBlk:(FailDataCenterBlock)failBlk;

@end

@protocol DataCenterDelegate<NSObject>

@optional

/**
 *  读取数据成功
 *
 *  @param dataArray   返回数组
 *  @param methordName 请求方法名称
 */
- (void)loadingFinishedWithDataArray:(NSArray *)dataArray methordName:(NSString *)methordName;

/**
 *  读取数据失败
 *
 *  @param errorString 返回失败信息
 *  @param methordName  请求方法名称
 */
- (void)loadingFailedWithErrorString:(NSError *)error methordName:(NSString *)methordName;

@end
