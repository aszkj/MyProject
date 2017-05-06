//
//  RateView.h
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickStarBackBlock)(NSInteger startCount);

@interface RateView : UIView

//星星个数
@property (nonatomic,assign)NSInteger startCount;

@property (nonatomic, copy)ClickStarBackBlock clickStarBackBlock;

@end
