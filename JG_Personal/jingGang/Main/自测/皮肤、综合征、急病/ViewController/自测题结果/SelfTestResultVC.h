//
//  SelfTestResultVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击知道，返回自测题列表页block
typedef void(^IknowBlock)();

//点击再测一次，返回到测试页面重新测试
typedef void(^RetestBlock)(long groupID);

@interface SelfTestResultVC : UIViewController<UIWebViewDelegate>

@property (nonatomic,copy)IknowBlock iknowBlock;

@property (nonatomic,copy)RetestBlock retestBlock;

@property (nonatomic,copy)NSString *testUrl;


//从自测历史中进来
@property BOOL comminFromHistory;

@property (nonatomic,copy)NSString *testResultDec;

//自测结果得分
@property long test_Mark;

//自测题ID
@property long test_GroupID;

@end
