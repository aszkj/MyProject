//
//  FollwerContent.h
//  jingGang
//
//  Created by wangying on 15/6/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VApiManager.h"


typedef void(^CommentRereshBlcok)(BOOL success);

@interface FollwerContent : UIViewController
@property(nonatomic,strong)NSNumber *num;

@property BOOL isRepy;

@property (nonatomic,copy)CommentRereshBlcok commentBlcock;




@end
