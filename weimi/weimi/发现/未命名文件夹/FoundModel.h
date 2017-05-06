//
//  FoundModel.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonDistributeContentModel.h"
@interface FoundModel : NSObject

@property (nonatomic, copy)NSString *channnel;

@property (nonatomic, copy)NSString *avartUrl;

@property (nonatomic, copy)NSString *nickName;

@property (nonatomic, strong)NSString *fromWhereTypeStr;

@property (nonatomic, copy)NSDate *time;

@property (nonatomic, strong)PersonDistributeContentModel *personDistributeContentModel;

@property (nonatomic, copy)NSString *distributePersonID;

@end
