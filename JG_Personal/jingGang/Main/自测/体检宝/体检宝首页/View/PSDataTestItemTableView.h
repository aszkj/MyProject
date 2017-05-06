//
//  PSDataTestItemTableView.h
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DoutfulType,    //疑似
    NormalType,     //正常
}SightTestResultType;

typedef void(^TestTypeEditBlock)(NSInteger typeNum);
typedef void(^ComIntoDiffentTestPageBlock)(NSInteger testTypeNum);
typedef void(^NormalOrDoutfulTypeBlock)(SightTestResultType sightTestResultType,NSInteger sightTestNum);

@interface PSDataTestItemTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

//类型文字
@property (nonatomic, strong)NSArray *testTypeArr;
//类型num
@property (nonatomic, strong)NSArray *typeNumArr;

@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, copy)TestTypeEditBlock testTypeEditBlock;

@property (nonatomic, copy)ComIntoDiffentTestPageBlock comIntoDiffentTestPageBlock;

@property (nonatomic, copy)NormalOrDoutfulTypeBlock normalOrDoutfulTypeBlock;

@end
