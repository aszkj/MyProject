//
//  WSJShopCategoryViewController.h
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    shopType,//商品
    O2OType  //O2O商户
}CategoryType;

@interface WSJShopCategoryViewController : UIViewController

@property (nonatomic, assign) CategoryType shopType;
/**
 * 商品分类编号
 */
@property (nonatomic, readwrite, copy) NSNumber *api_classId;

@end
