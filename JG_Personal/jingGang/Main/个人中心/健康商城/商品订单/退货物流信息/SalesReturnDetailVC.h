//
//  SalesReturnDetailVC.h
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesReturnDetailVC : UIViewController

@property (nonatomic) NSNumber *returnGoodsLogId;

- (void)setGoodsName:(NSString *)goodsName;
- (void)setReturnReason:(NSString *)reason;
- (void)setRecieveAddress:(NSString *)address;
- (void)setCompanyList:(NSArray *)companyList;

@end
