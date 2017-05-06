//
//  ZkgLoadingHub.h
//  加载图片测试
//
//  Created by ZZCM on 15/2/5.
//  Copyright (c) 2015年 ZZCM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingView.h"
#import <UIKit/UIKit.h>

@interface ZkgLoadingHub : NSObject


-(id)initHubInView:(UIView *)superView
   withLoadingType:(LoadingType)loadingType;

-(id)initHubPartInView:(UIView *)superView
                  withTopgap:(CGFloat)topGap
                   bottonGap:(CGFloat)bottonGap
                     leftGap:(CGFloat)leftGap
                    rightGap:(CGFloat)rightGap
             withLoadingType:(LoadingType)loadingType;

@property (nonatomic,strong)NSString *loadingMessage;

@property (nonatomic,strong)UIColor *loadBGColor;

-(void)endLoading;

@end
