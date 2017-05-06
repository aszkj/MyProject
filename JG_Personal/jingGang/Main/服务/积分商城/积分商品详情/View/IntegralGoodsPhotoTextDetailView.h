//
//  IntegralGoodsPhotoTextDetailView.h
//  jingGang
//
//  Created by 张康健 on 15/11/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^IntegralUpBlock)();

@interface IntegralGoodsPhotoTextDetailView : UIView

//图文详情webUrlStr
@property (nonatomic, copy)NSString *ptPhotoDetailWebUrlStr;

//下拉时弹上去了回调block
@property (nonatomic, copy)IntegralUpBlock upBlock;


@end
