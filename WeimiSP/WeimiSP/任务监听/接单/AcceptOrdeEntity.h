//
//  AcceptOrdeEntity.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface AcceptOrdeEntity : JSONModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSNumber<Optional> *message_id;
@property (nonatomic, copy) NSString *message_time;
@property (nonatomic, assign) NSInteger message_type;
@property (nonatomic, copy) NSString *message_content;

@end
