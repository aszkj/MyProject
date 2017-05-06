//
//  WSJSelectCityTableHeaderView.h
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RetunHeaderAction)(NSString *city,NSNumber *cityID);

@interface WSJSelectCityTableHeaderView : UIView

/**
 *  热门城市
 */
@property (nonatomic, strong) NSArray *dataArray;
/**
 *  通过block返回选中的城市，（定位和热门）
 */
@property (nonatomic, copy) RetunHeaderAction headerAction;

@property (nonatomic, copy) void (^locationCity)(NSString *city);

@end
