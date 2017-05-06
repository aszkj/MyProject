//
//  TimerLoopView.h
//  TestPaomadeng
//  根据文字展示上下跑马灯
//  Created by opp_cat on 13-12-3.
//  Copyright (c) 2013年 opp_cat. All rights reserved.
//

#import <UIKit/UIKit.h>


//loop Object
@interface LoopObj : NSObject

@property (nonatomic,strong)NSString              *titleName;

@end

typedef void(^ClickItemBlock)(NSInteger clickeIndex,NSString *clickTitle);

@interface TimerLoopView : UIView
//展示的count
 /*teams 里面包含的是 LoopObj
     请自行组装LoopOb*/
- (id)initWithFrame:(CGRect)frame withitemArray:(NSArray*)teams;

@property (nonatomic,copy)NSArray *arr;

@property (nonatomic,strong)UIFont *titleFont;

@property (nonatomic,strong)UIColor *titleColor;

@property(nonatomic,copy) ClickItemBlock   clickItemBlock;


@property(nonatomic,readwrite) NSArray   *itemarray;

@property (nonatomic,assign)CGFloat timeInterValEach;


//startTimer
- (void)startTimer;

//releaseTimer
-(void)releaseTimer;
@end
