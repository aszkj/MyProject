//
//  WSJSearchResultViewController.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commodityListView.h"


@interface WSJSearchResultViewController : UIViewController

@property (nonatomic, assign) WSJShopAndSearchType type;
//关键字搜索
@property (nonatomic, copy) NSString *keyword;
//关键字的ID
@property (nonatomic, copy) NSNumber *ID;


@end
