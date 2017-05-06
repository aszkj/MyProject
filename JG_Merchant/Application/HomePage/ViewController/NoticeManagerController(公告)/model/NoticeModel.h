//
//  NoticeModel.h
//  Merchants_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeModel : NSObject
/**
 *  标题
 */
@property (copy , nonatomic) NSString *headTitle;


/**
 *  时间
 */
@property (copy , nonatomic) NSString *time;

/**
 *  运营商
 */
@property (copy , nonatomic) NSString *operators;
@end
