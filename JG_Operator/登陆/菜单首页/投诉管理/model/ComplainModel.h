//
//  ComplainModel.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplainModel : NSObject

/**
 *  投诉人
 */
@property (copy , nonatomic) NSString *nickname;
/**
 *  投诉ID号
 */
@property (copy , nonatomic) NSString *id;
/**
 *  被投诉的商户
 */
@property (copy , nonatomic) NSString *storeName;

/**
 *  投诉时间
 */
@property (copy , nonatomic) NSString *addTime;


@end
