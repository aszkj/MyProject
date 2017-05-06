//
//  ComplainDetailController.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseViewController.h"

@protocol ComplainDetailControllerDelegate <NSObject>

/**
 *  提交完成后代理通知投诉列表页面重新请求刷新数据
 */
- (void)nofitiCationComplainMainListRefreshData;

@end

@interface ComplainDetailController : XKO_BaseViewController

/**
 *  投诉ID
 */
@property (nonatomic,copy) NSString *apiID;
/**
 *  投诉状态   YES 待处理    NO已处理
 */
@property (nonatomic,assign) BOOL  isHandled;


@property (nonatomic,assign) id<ComplainDetailControllerDelegate>delegate;
@end
