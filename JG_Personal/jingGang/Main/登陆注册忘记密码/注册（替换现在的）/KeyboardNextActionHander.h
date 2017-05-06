//
//  KeyboardNextActionHander.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/10/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GoNextBySubviews, //通过子视图顺序
    GoNextByPosition, //通过子视图位置
    GoNextByTag       //通过子视图tag
} GoNextByType;

typedef void(^LastNextBlock)(void);

@interface KeyboardNextActionHander : NSObject

-(id)initWithBodyView:(UIView *)bodyView goNextByType:(GoNextByType)goNextByType;

//点击最后一个回调
@property (nonatomic, copy)LastNextBlock lastNextBlock;


@end
