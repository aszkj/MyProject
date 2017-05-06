//
//  WSJBabyCategoryViewController.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJBabyCategoryViewController : UIViewController

@property (nonatomic, copy) NSArray *data;
/**
 * 店铺id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_storeId;

//点击宝贝分类回调该方法
@property (nonatomic, copy) void(^siftAction)(NSNumber *storeId);

@end
