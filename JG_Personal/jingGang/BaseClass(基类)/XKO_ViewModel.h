//
//  XKO_ViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//
#import "APIManager+RACClient.h"
#import <ReactiveCocoa.h>
#import "MJExtension.h"
/**
 *  处理UI的数据和界面跳转
 */
@interface XKO_ViewModel : NSObject

/**
 *  提供错误提示信息,每当error更新,对应的viewcontroller应该显示提示给用户
 */
@property (nonatomic) NSError *error;
/**
 *  viewcontroller的title
 */
@property (nonatomic) NSString *title;
/**
 *  是否正在发出网络请求
 */
@property (nonatomic) BOOL isExcuting;
/**
 *  提供网络操作的封装
 */
@property (nonatomic) APIManager *client;

- (NSError *)createError:(NSString *)message;

@end
