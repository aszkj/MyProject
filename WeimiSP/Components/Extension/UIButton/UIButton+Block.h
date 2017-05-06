//
//  UIButton+Block.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (Block)
-(void)addActionHandler:(TouchedBlock)touchHandler;
@end

typedef NS_ENUM(NSInteger, TQEasyIconDirection)
{
    TQEasyIconInUnknown = 0,
    TQEasyIconInLeft,
    TQEasyIconInRight,
    TQEasyIconInTop,
    TQEasyIconInBottom,
};

@interface TQEasyIconInfo : NSObject

@property (nonatomic,assign) TQEasyIconDirection iconDirection;
@property (nonatomic,assign) CGFloat iconWithTitleSpacing;

@end

@interface UIButton (TQEasyIcon)

@property (nonatomic,strong,readonly) TQEasyIconInfo *iconInfo;

- (void)setIconInLeft;
- (void)setIconInRight;
- (void)setIconInTop;
- (void)setIconInBottom;
- (void)setIconInLeftWithSpacing:(CGFloat)Spacing;
- (void)setIconInRightWithSpacing:(CGFloat)Spacing;
- (void)setIconInTopWithSpacing:(CGFloat)Spacing;
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing;

@end

@interface UIButton (Design)

/**
 *  扩大响应区域
 *
 *  @param size 想要扩大的边界
 */
- (void)setEnlargeEdge:(CGFloat)size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end