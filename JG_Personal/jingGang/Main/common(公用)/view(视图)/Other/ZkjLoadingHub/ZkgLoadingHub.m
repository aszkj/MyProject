//
//  ZkgLoadingHub.m
//  加载图片测试
//
//  Created by ZZCM on 15/2/5.
//  Copyright (c) 2015年 ZZCM. All rights reserved.
//

#import "ZkgLoadingHub.h"


@interface ZkgLoadingHub(){

    LoadingView *_loadingView;
}

@end

@implementation ZkgLoadingHub


-(id)initHubInView:(UIView *)superView
   withLoadingType:(LoadingType)loadingType
{
    self = [super init];
    if (self) {
        
        [self _init];
        [_loadingView showLoadingFullInView:superView withLoadingType:loadingType];

    }
    return self;
}


-(void)_init{

    NSArray *nibs =  [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:nil options:nil];
    _loadingView = (LoadingView *)[nibs lastObject];

}

-(void)setLoadingMessage:(NSString *)loadingMessage{

    _loadingView.loadingMessage = loadingMessage;

}

-(void)setLoadBGColor:(UIColor *)loadBGColor{
    
    _loadingView.bgColor = loadBGColor;
    
}


-(id)initHubPartInView:(UIView *)superView
              withTopgap:(CGFloat)topGap
               bottonGap:(CGFloat)bottonGap
                 leftGap:(CGFloat)leftGap
                rightGap:(CGFloat)rightGap
         withLoadingType:(LoadingType)loadingType
{
    self = [super init];
    if (self) {
        [self _init];
        [_loadingView showLoadingPartInView:superView withTopgap:topGap bottonGap:bottonGap leftGap:leftGap rightGap:rightGap withLoadingType:loadingType];
    }
    
    return self;
}

-(void)endLoading
{

    [_loadingView performSelector:@selector(endLoading) withObject:nil afterDelay:0.5];
}


@end
