//
//  LeftRightView.h
//  jingGang
//
//  Created by 张康健 on 15/10/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloableEmerator.h"


@interface LeftRightView : UIView

-(instancetype)initWithFenlieID:(NSInteger)fen_lie_ID frame:(CGRect)frame;

@property (nonatomic, assign)BOOL hasShow;

@property (nonatomic, assign)ListType listType;

//开始显示，并且第一次请求网络
-(void)show;

@end
