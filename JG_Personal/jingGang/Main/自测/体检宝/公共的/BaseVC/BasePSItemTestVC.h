//
//  BasePSItemTestVC.h
//  jingGang
//
//  Created by 张康健 on 15/7/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePSItemTestVC : UIViewController

//title,标题，需要子类给
@property (nonatomic, strong) NSString        *navTitle;

//tobbar titles，topbbar 上的按钮标题，需要子类给
@property (nonatomic, strong) NSArray         *tabbarTitles;

//contentView arrs
@property (nonatomic, strong) NSMutableArray  *contentViewArrs;

//第一个视图
@property (nonatomic, strong) UIView          *firstContentView;

//第二个视图
@property (nonatomic, strong) UIView          *secondContentView;


@end
