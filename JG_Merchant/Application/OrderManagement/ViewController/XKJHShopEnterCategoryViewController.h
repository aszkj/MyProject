//
//  XKJHShopEnterCategoryViewController.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHShopEnterCategoryViewController : UIViewController

/**
 * 父id
 */
@property (nonatomic, copy) NSNumber *api_parentId;


//标题
@property (nonatomic, strong) NSString *titleString;
//选择结果回调
@property (nonatomic, copy) void(^selectResult)(NSString *result,NSNumber *ID,NSString *resultID);
////已经选过的数据
//@property (nonatomic, strong) NSString *selectString;

@end
