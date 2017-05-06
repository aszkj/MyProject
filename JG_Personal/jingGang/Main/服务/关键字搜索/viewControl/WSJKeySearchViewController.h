//
//  WSJKeySearchViewController.h
//  jingGang
//
//  Created by thinker on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    searchShopType,//商品
    searchO2Oype  //O2O商户
}SearchType;

typedef void(^SearchKeyBlock)(NSString *key);

@interface WSJKeySearchViewController : UIViewController

/**
 *  shoptype  控制器类型
 */
@property (nonatomic, assign) SearchType shopType;

//如果block有值是pop，block无值是pup
@property (nonatomic, copy) SearchKeyBlock searchKey;

@end
