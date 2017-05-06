//
//  MerchantListViewController.h
//  JingGangIB
//
//  Created by thinker on 15/9/10.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SearchClass = 0,
    SearchKeyword = 1,
} SearchMerchantType;

@interface MerchantListViewController : UIViewController
/**
 *  分类ID
 */
@property (nonatomic) NSNumber *classId;
/**
 *  分类字符
 */
@property (nonatomic) NSString *classString;
@property (nonatomic) NSArray *parentClassId;
@property (nonatomic) NSArray *subClassId;
@property (nonatomic) NSInteger mainIndex;
@property (nonatomic) NSInteger secondIndex;
@property (nonatomic) NSString *keyword;
@property (nonatomic) SearchMerchantType searchType;
@end
